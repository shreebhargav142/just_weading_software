import 'package:flutter/material.dart' hide MenuController;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_weding_software/controller/function_controller.dart';
import 'package:just_weding_software/view/screens/pdf_view.dart';
import '../controller/auth_controller.dart';
import '../controller/category_byeventandfunction_controller.dart';
import '../controller/menu_controller.dart';
import '../controller/order_history_controller.dart';
import '../model/category_response_model.dart';
import '../model/function_model.dart';
import '../utils/date_utils.dart';
import '../widgets/responsive_layout.dart';
import '../widgets/app_drawer.dart';
import '../widgets/cart_bottom.dart';
import '../widgets/item_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey<ScaffoldState>();

  final FunctionController functionController = Get.put(FunctionController());
  final EventMenuController eventMenuController = Get.put(EventMenuController());
  final CategoryyController categoryyController = Get.put(CategoryyController());
  OrderHistoryController get orderHistoryController => Get.find<OrderHistoryController>();

  @override
  void initState() {
    super.initState();
    _setupListeners();

  }
  void _setupListeners() {
    ever(functionController.selectedFunction, (selectedFunction) {
      if (selectedFunction == null) return;

      final auth = Get.find<AuthController>();
      final clientuserId = auth.user.value?.clientUserId ?? 504;

      final String eventId = selectedFunction.eventId?.toString() ?? "0";
      final String functionId = selectedFunction.functionId?.toString() ?? "0";

      if (eventId == "0" || functionId == "0") return;
      categoryyController.fetchApiData(eventId, functionId);
      eventMenuController.fetchTables(clientuserId, eventId, functionId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      drawer: const AppDrawer(),
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Select Function',),
                const SizedBox(height: 6),
                GestureDetector(
                  onTap: () => _openFunctionSelectorDialog(),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() {
                          final f = functionController.selectedFunction.value;
                          return Text(
                            f == null ? 'Choose a function' : f.functionName ?? '',
                            style: GoogleFonts.nunito(fontSize: 16),
                          );
                        }),
                        const Icon(Icons.keyboard_arrow_down),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          Obx(() {
            final categories = categoryyController.categories;
            if (categoryyController.isLoading.value) {
              return const SizedBox(height: 100,
                  child: Center(child: CircularProgressIndicator()));
            }

            return SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return Obx(() {
                    bool isSelected = categoryyController.selectedCategoryId.value == category?.id;
                    return GestureDetector(
                      onTap: () => categoryyController.selectedCategoryId.value = category?.id ?? 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(
                                  color: isSelected ? Colors.red : Colors.grey.shade300,
                                  width: 2,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: ClipOval(
                                  child: (category?.menuImage != null &&
                                      category!.menuImage!.isNotEmpty)
                                      ? Image.network(
                                    category.menuImage!,
                                    fit: BoxFit.cover,
                                    loadingBuilder: (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return const Center(
                                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.red),
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        'assets/icon/icon.png',
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  )
                                      : Image.asset(
                                    'assets/icon/icon.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              category?.menuname ?? "",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                color: Colors.black,
                              ),
                            ),
                            if (isSelected)
                              Container(
                                margin: const EdgeInsets.only(top: 4),
                                height: 5,
                                width: 5,
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  });

                },
              ),
            );
          }),

          Container(height: 1, color: Colors.grey.withOpacity(0.1)),
          Expanded(
            child: Obx(() {
              final items = categoryyController.itemsByCategoryId[categoryyController.selectedCategoryId.value] ?? [];
              if (categoryyController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              return ResponsiveDiffLayout(
                MobileBody: _buildItemsGrid(items),
                TabletBody: _buildItemsList(items),
              );
            }),
          ),
        ],
      ),
      bottomNavigationBar: Obx(() {
        final _ = functionController.selectedFunction.value;
        if (!Get.isRegistered<EventMenuController>()) {
          return const SizedBox.shrink();
        }

        final menuCtrl = Get.find<EventMenuController>();

        final quantitiesMap = menuCtrl.quantities;

        final totalItems = quantitiesMap.values.fold(0, (sum, qty) => sum + qty);

        if (totalItems <= 0) {
          return const SizedBox.shrink();
        }

        return SafeArea(
          child: CartBottomBar(
            totalItems: totalItems,
            onTap: () {},
          ),
        );
      }),    );
  }
  Widget _buildItemsGrid(List<ItemsDetails> items) {
    if (items.isEmpty) {
      return const Center(child: Text("No items available"));
    }

    return GridView.builder(
      key: ValueKey(categoryyController.selectedCategoryId.value),
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
      ),
      itemCount: items.length,
      itemBuilder: (_, index) {
        final item = items[index];
        return ItemCard(
          quantity: eventMenuController.quantities[item.itemId] ?? 0,
          item: item,
          onQuantityChanged: (change) {
            eventMenuController.updateQuantity(item.itemId!, change);
          },
          onEditToggle: () {},
        );
      },
    );
  }

  Widget _buildItemsList(List<ItemsDetails> items) {
    if (items.isEmpty) {
      return const Center(child: Text("No items available"));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, index) {
        final item = items[index];
        return ItemCard(
          quantity: eventMenuController.quantities[item.itemId] ?? 0,
          item: item,
          onQuantityChanged: (change) {
            eventMenuController.updateQuantity(item.itemId!, change);
          },
          onEditToggle: () {},
        );
      },
    );
  }


  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isTablet = width >= 600;

    final double appBarHeight = isTablet ? 450 : 250;

    return PreferredSize(
      preferredSize: Size.fromHeight(appBarHeight),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => _drawerKey.currentState!.openDrawer(),
          icon: Icon(Icons.menu, color: Colors.black, size: isTablet ? 32 : 24),
        ),
        centerTitle: false,
        titleSpacing: 0,
        title: Text(
          "Quick Order",
          style: GoogleFonts.nunito(
            fontWeight: FontWeight.w700,
            color: Colors.black,
            fontSize: isTablet ? 26 : 20,
          ),
        ),
        flexibleSpace: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/images/appbar_img.png',
                  fit: BoxFit.cover, // Ensure it fills the height
                ),
              ),

              // 2. Overlay for readability
              Positioned.fill(
                child: Container(
                  color: Colors.white.withOpacity(0.2), // Light tint
                ),
              ),
            ]),
        actions: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(right: 15),
              child: InkWell(
                onTap: () {
                  final authController = Get.find<AuthController>();
                  final pdfUrl = authController.user.value?.pdfUrl;

                  if (pdfUrl != null && pdfUrl.isNotEmpty) {
                    Get.to(() => PdfViewerScreen(
                      pdfUrl: pdfUrl,
                      title: "Exclusive Menu",
                    ));
                  } else {
                    Get.snackbar("Not Available", "Menu PDF not found");
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.green, width: 1)
                  ),
                  child: Text(
                    "Today's Exclusive Menu",
                    style: GoogleFonts.nunito(
                      fontSize: isTablet ? 14 : 10,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  void _openFunctionSelectorDialog() {
    final tempSelected =
    Rx<FunctionManagerAssignDetails?>(
      functionController?.selectedFunction.value,
    );
    Get.dialog(
      Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width >= 600 ? 600 : 360,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Select Function",
                    style: GoogleFonts.nunito(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(),
                  Flexible(
                    child: Obx(() => ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                      functionController?.functionList.length,
                      itemBuilder: (_, index) {
                        final item =
                        functionController?.functionList[index];

                        final isSelected =
                            tempSelected.value?.functionId ==
                                item?.functionId;

                        return InkWell(
                          onTap: () => tempSelected.value = item,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            margin:
                            const EdgeInsets.symmetric(vertical: 6),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: Colors.grey.shade200
                              ),
                              borderRadius:
                              BorderRadius.circular(12),
                              color:  Colors.white,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Event Name : ${item?.eventName ?? ''}",
                                        style: GoogleFonts.nunito(
                                            fontWeight:
                                            FontWeight.w600),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "Function Name : ${item?.functionName ?? ''}",
                                        style:
                                        GoogleFonts.nunito( fontWeight:
                                        FontWeight.w600),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "Date : ${formatDate(item?.startTime)}",
                                        style: GoogleFonts.nunito(
                                            fontWeight: FontWeight.w600                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (isSelected)
                                  const Icon(Icons.check_circle,
                                      color: Colors.green),
                              ],
                            ),
                          ),
                        );
                      },
                    )),
                  ),
                  const Divider(),
                  const SizedBox(height: 8,),
                  Row(
                    children: [
                      Expanded(
                        child:
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(8),
                                side:  BorderSide(
                                  color: Colors.grey.shade200,
                                  width: 1,)
                            ),
                          ),
                          onPressed: () {
                            Get.back();
                          },
                          child: Text(
                            "Close",
                            style: TextStyle(fontWeight: FontWeight.w400,color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: (){
                            Get.back();
                          },
                          child: const Text("Done"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
