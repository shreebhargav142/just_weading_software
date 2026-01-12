import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_weding_software/view/home_screen.dart';
import 'package:just_weding_software/widgets/responsive_layout.dart';
import '../controller/auth_controller.dart';
import '../controller/function_controller.dart';
import '../controller/menu_controller.dart';
import '../view/screens/cart_screen.dart';
import '../view/screens/order_history_screen.dart';

class CartBottomBar extends StatefulWidget {
  final int totalItems;
  final VoidCallback onTap;

  const CartBottomBar({
    super.key,
    required this.totalItems,
    required this.onTap
  });

  @override
  State<CartBottomBar> createState() => _CartBottomBarState();
}

class _CartBottomBarState extends State<CartBottomBar> {
  bool _isOrderPlaced = false;
  late final FunctionController functionController;


  @override
  void initState() {
    super.initState();

    functionController = Get.find<FunctionController>();
    final authController = Get.find<AuthController>();

  }
  @override
  Widget build(BuildContext context) {
    if (widget.totalItems == 0 && !_isOrderPlaced) {
      return const SizedBox.shrink();
    }

    return ResponsiveDiffLayout(
      MobileBody: _buildContent(context, isTablet: false),
      TabletBody: _buildContent(context, isTablet: true),
    );
  }

  Widget _buildContent(BuildContext context, {required bool isTablet}) {
    if (_isOrderPlaced) {
      return _buildOrderPlacedView(isTablet);
    }

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? 40.0 : 24.0,
        vertical: isTablet ? 20.0 : 16.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "(${widget.totalItems}) Items added",
            style: GoogleFonts.nunito(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: isTablet ? 18 : 16),
          ),

          ElevatedButton(
            onPressed: ()=>_showTableSelectionDialog(context),

            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD62E38),
              elevation: 0,
              // Tablet pe button bada
              minimumSize: Size(isTablet ? 200 : 160, isTablet ? 45 : 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(horizontal: isTablet ? 32 : 24),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "View Cart",
                  style: GoogleFonts.nunito(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: isTablet ? 16 : 14,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: isTablet ? 14 : 12,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
  void _showTableSelectionDialog(BuildContext context) {
    final menuController = Get.find<EventMenuController>();

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            "Select Table",
            textAlign: TextAlign.center,
            style: GoogleFonts.nunito(fontWeight: FontWeight.bold),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: Obx(() {
              if (menuController.isTableLoading.value) {
                return const SizedBox(
                  height: 120,
                  child: Center(
                    child: CircularProgressIndicator(color: Color(0xFFD62E38)),
                  ),
                );
              }

              if (menuController.tableList.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Text(
                    "No tables available",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(color: Colors.grey),
                  ),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: menuController.tableList.length,
                itemBuilder: (_, index) {
                  final table = menuController.tableList[index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: InkWell(
                      onTap: () {
                        menuController.selectedTableId.value =
                            table['tableId'].toString();
                        Get.back();
                        _showSuccessPopup(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFFD62E38)),
                        ),
                        child: Text(
                          table['tableName'] ?? 'N/A',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunito(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        );
      },
    );
  }


  void _showSuccessPopup(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, color: Color(0xFF10C66F), size: 60),
              const SizedBox(height: 16),
              Text(
                "Table created successfully",
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        final eventMenuController = Get.find<EventMenuController>();
                        eventMenuController.clearCart();
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomeScreen()));

                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                      ),
                      child: Text("Cancel", style: GoogleFonts.nunito(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // View Order Button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const CartScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF10C66F),
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                      ),
                      child: Text("View Order", style: GoogleFonts.nunito(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
  Widget _buildOrderPlacedView(bool isTablet) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? 32 : 16,
        vertical: isTablet ? 16 : 12,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "Your food order is being prepared, & your food will be delivered shortly. Just wait a moment..",
              style: GoogleFonts.nunito(
                color: const Color(0xFF10C66F),
                fontWeight: FontWeight.w600,
                fontSize: isTablet ? 14 : 12,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: isTablet ? 20 : 12),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderHistoryScreen()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF10C66F),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 24 : 16, vertical: 0),
              minimumSize: Size(isTablet ? 140 : 100, isTablet ? 42 : 36),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "View Order",
                  style: GoogleFonts.nunito(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: isTablet ? 14 : 12,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: isTablet ? 12 : 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



