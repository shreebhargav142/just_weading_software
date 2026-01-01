import 'package:flutter/material.dart' hide MenuController;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_weding_software/controller/function_controller.dart';
import '../controller/auth_controller.dart';
import '../controller/category_controller.dart';
import '../controller/menu_controller.dart';
import '../model/function_model.dart';
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
  // Controller initialize
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey<ScaffoldState>();

  late final FunctionController functionController;
  late final CategoryController categoryController;
  late final EventMenuController eventMenuController;


  // @override
  // void initState() {
  //   super.initState();
  //   final authController = Get.find<AuthController>();
  //   final id = authController.user.value?.clientUserId ?? 502;
  //   final clientId = authController.user.value?.clientId ?? 512;
  //   final eventId= functionController.selectedFunction.value?.eventId ?? 471194;
  //   final functionId= functionController.selectedFunction.value?.functionId ?? 23266;
  //   functionController = Get.put(FunctionController(clientUserId: id));
  //   categoryController = Get.put(CategoryController(clientId: clientId));
  //
  //   eventMenuController = Get.put(EventMenuController(clientUserId: id,eventId: eventId,functionId:functionId ));
  //
  // }
  @override
  void initState() {
    super.initState();

    final authController = Get.find<AuthController>();
    final id = authController.user.value?.clientUserId ?? 504;
    final clientId = authController.user.value?.clientId ?? 512;

    // 1. Initialize the Controller FIRST
    functionController = Get.put(FunctionController(clientUserId: id));
    categoryController = Get.put(CategoryController(clientId: clientId));

    // 2. NOW you can safely access the variables inside it
    final eventId = functionController.selectedFunction.value?.eventId ?? 471194;
    final functionId = functionController.selectedFunction.value?.functionId ?? 23266;

    // 3. Finally, initialize the Menu Controller
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
      appBar: _buildAppBar(),
      body: Column(
        children: [
          // Function Selection Dropdown
          Obx(() => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Function',
                  style: GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w300),
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton<FunctionManagerAssignDetails>(
                    isExpanded: true,
                    value: functionController.selectedFunction.value,
                    hint: Text('Choose a function', style: GoogleFonts.nunito(fontSize: 16)),
                    icon: const Icon(Icons.keyboard_arrow_down, size: 30, color: Colors.black),
                    items: functionController.functionList.map((item) {
                      return DropdownMenuItem<FunctionManagerAssignDetails>(
                        value: item,
                        child: Text(
                          item.functionName ?? "",
                          style: GoogleFonts.nunito(fontSize: 16),
                        ),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      functionController.onFunctionChanged(newValue);
                    },
                  ),
                ),
              ],
            ),
          )),

          // Category Scroll List
          // Obx(() {
          //   if (categoryController.isLoading.value) return const Center(child: CircularProgressIndicator());
          //   return CategoryList(
          //     clientId: categoryController.clientId,
          //     onCategorySelected: (category) {
          //       // Sahi callback implementation
          //       eventMenuController.selectCategory(category.menuCategoryId);
          //       debugPrint("Selected: ${category.menuname}");
          //     },
          //   );
          // }),
          // HomeScreen ke Column mein Category Section ko aise badlein:
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

          // Main Items Grid
          Expanded(
            child: ResponsiveDiffLayout(
              MobileBody: _buildItemsGrid(isTablet: false),
              TabletBody: _buildItemsGrid(isTablet: true),
            ),
          ),
        ],
      ),
      // Cart Summary Bar
      bottomNavigationBar: Obx(() {
        int totalItems = eventMenuController.quantities.values.fold(0, (sum, qty) => sum + qty);
        return totalItems > 0
            ? SafeArea(child: CartBottomBar(totalItems: totalItems, onTap: () {}))
            : const SizedBox.shrink();
      }),
    );
  }

  Widget _buildItemsGrid({required bool isTablet}) {
    return Obx(() {
      if (eventMenuController.isLoading.value) {
        return const Center(child: CircularProgressIndicator(color: Color(0xFFD32F2F)));
      }

      // Filtered items ka upyog (ItemsDetails list)
      final items = eventMenuController.filteredItems;

      if (items.isEmpty) {
        return const Center(child: Text("No items available in this category"));
      }

      return GridView.builder(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isTablet ? 3 : 2,
          childAspectRatio: isTablet ? 0.82 : 0.65,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final foodItem = items[index];

          return ItemCard(
            // ItemId dwara unique tracking
            quantity: eventMenuController.quantities[foodItem.itemId] ?? 0,
            item: foodItem,
            onQuantityChanged: (change) {
              if (foodItem.itemId != null) {
                eventMenuController.updateQuantity(foodItem.itemId!, change);
              }
            },
            onEditToggle: () {
              // Info ya instructions ke liye logic
            },
          );
        },
      );
    });
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(250), // Image ki height ke liye
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () => _drawerKey.currentState!.openDrawer(),
            icon: const Icon(Icons.menu, color: Colors.black)),

        titleSpacing: 0,
        title: Text(
          "Quick Order",
          style: GoogleFonts.nunito(
              fontWeight: FontWeight.w500, color: Colors.black, fontSize: 18),
        ),


        flexibleSpace: Stack(
          children: [
            const SizedBox(height: 15,),
            // Background Image (Full Width/Height)
            Positioned.fill(
              child: Image.asset(
                'assets/images/appbar_img.png',
                fit: BoxFit.cover,
              ),
            ),
            // Logo aur Tagline (Center mein)
            SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    Text(
                      "A Symphony of Flavors!",
                      style: GoogleFonts.nunito(fontSize: 12, color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 10),

                  ],
                ),
              ),
            ),
          ],
        ),

        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(1),
                ),
                child: Text(
                  "Today's Exclusive Menu",
                  style: GoogleFonts.nunito(
                      fontSize: 12,
                      color: Colors.green,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }}