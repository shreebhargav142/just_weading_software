import 'package:flutter/material.dart' hide MenuController;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_weding_software/controller/function_controller.dart';
import 'package:just_weding_software/view/screens/pdf_view.dart';
import '../controller/auth_controller.dart';
import '../controller/category_controller.dart';
import '../controller/menu_controller.dart';
import '../controller/order_history_controller.dart';
import '../model/function_model.dart';
import '../utils/date_utils.dart';
import '../widgets/responsive_layout.dart';
import '../widgets/app_drawer.dart';
import '../widgets/cart_bottom.dart';
import '../widgets/category_list.dart';
import '../widgets/item_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey<ScaffoldState>();

  late final FunctionController functionController;
  late final CategoryController categoryController;
  late final EventMenuController eventMenuController;
  late final OrderHistoryController historyController;

  @override
  void initState() {
    super.initState();
    final authController = Get.find<AuthController>();
    final id = authController.user.value?.clientUserId ?? 504;
    final clientId = authController.user.value?.clientId ?? 512;
    functionController = Get.put(FunctionController(clientUserId: id));
    categoryController = Get.put(CategoryController(clientId: clientId));

    final eventId = functionController.selectedFunction.value?.eventId ?? 471194;
    final functionId = functionController.selectedFunction.value?.functionId ?? 23266;

    eventMenuController = Get.put(EventMenuController(
        clientUserId: id,
        eventId: eventId,
        functionId: functionId
    ));
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
            if (eventMenuController.isLoading.value) return const SizedBox.shrink();
            final categories = eventMenuController.menuData.value?.data?.eventMenuPlanDetails ?? [];

            return SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return Obx(() {
                    bool isSelected = eventMenuController.selectedCategoryId.value == category.menuCategoryId;
                    return GestureDetector(
                      onTap: () => eventMenuController.selectCategory(category.menuCategoryId),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected ? Colors.red : Colors.grey.shade300,
                                  width: 2,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  backgroundImage: (category.menuImage != null && category.menuImage!.isNotEmpty)
                                      ? NetworkImage(category.menuImage!)
                                      : null,
                                  child: (category.menuImage == null || category.menuImage!.isEmpty)
                                      ? Icon(Icons.fastfood, color: Colors.grey[400], size: 24)
                                      : null,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              category.menuName ?? "",
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
            child: ResponsiveDiffLayout(
              MobileBody: _buildItemsGrid(),
              TabletBody: _buildItemsList(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Obx(() {
        int totalItems = eventMenuController.quantities.values.fold(0, (sum, qty) => sum + qty);
        return totalItems > 0
            ? SafeArea(child: CartBottomBar(totalItems: totalItems, onTap: () {}))
            : const SizedBox.shrink();
      }),
    );
  }
  Widget _buildItemsGrid() {
    return Obx(() {
      final items = eventMenuController.filteredItems;

      if (items.isEmpty) {
        return const Center(child: Text("No items available"));
      }

      return GridView.builder(
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
    });
  }

  Widget _buildItemsList() {
    return Obx(() {
      final items = eventMenuController.filteredItems;

      if (items.isEmpty) {
        return const Center(child: Text("No items available"));
      }

      return ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, index) {
          final item = items[index];
          return SizedBox(
            height: 140, // Tablet row height
            child: ItemCard(
              quantity: eventMenuController.quantities[item.itemId] ?? 0,
              item: item,
              onQuantityChanged: (change) {
                eventMenuController.updateQuantity(item.itemId!, change);
              },
              onEditToggle: () {},
            ),
          );
        },
      );
    });
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

            // 3. Content - Using Padding instead of just Center],
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
      functionController.selectedFunction.value,
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
                      functionController.functionList.length,
                      itemBuilder: (_, index) {
                        final item =
                        functionController.functionList[index];

                        final isSelected =
                            tempSelected.value?.functionId ==
                                item.functionId;

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
                                        "Event Name : ${item.eventName ?? ''}",
                                        style: GoogleFonts.nunito(
                                            fontWeight:
                                            FontWeight.w600),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "Function Name : ${item.functionName ?? ''}",
                                        style:
                                        GoogleFonts.nunito( fontWeight:
                                        FontWeight.w600),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "Date : ${formatDate(item.startTime)}",
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
                          onPressed: () {
                            if (tempSelected.value != null) {
                              functionController.onFunctionChanged(
                                  tempSelected.value);
                              historyController.fetchHistory(
                                  historyController.selectedTab.value);
                            }
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