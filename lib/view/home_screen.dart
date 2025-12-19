// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../controller/category_controller.dart';
// import '../widgets/responsive_layout.dart';
// import '../widgets/app_drawer.dart';
// import '../model/item.dart';
// import '../widgets/cart_bottom.dart';
// import '../widgets/category_list.dart';
// import '../widgets/item_card.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   final CategoryController categoryController =
//   Get.put(CategoryController());
//
//   final List<String> categories = ["Starter", "Bitings", "Juice", "Desserts", "Mexican", "Drinks"];
//
//   final List<Item> items = [
//     Item(id: 1, name: "Caprese Salad", description: "Cherry tomatoes & mozzarella.", price: 12.0, image: ""),
//     Item(id: 2, name: "Paneer Tikka", description: "Grilled chunks of paneer.", price: 15.0, image: "https://images.unsplash.com/photo-1567188040759-fb8a883dc6d8?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"),
//     Item(id: 3, name: "Spinach Croissants", description: "Flaky croissants with spinach.", price: 8.0, image: "https://images.unsplash.com/photo-1555507036-ab1f4038808a?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"),
//     Item(id: 4, name: "Veg Samosas", description: "Crisp pastry pockets.", price: 5.0, image: "https://images.unsplash.com/photo-1601050690597-df0568f70950?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"),
//     Item(id: 5, name: "Mojito", description: "Fresh mint lime soda.", price: 4.0, image: "https://images.unsplash.com/photo-1513558161293-cdaf765ed2fd?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"),
//     Item(id: 6, name: "Chocolate Cake", description: "Rich dark chocolate.", price: 7.0, image: "https://images.unsplash.com/photo-1578985545062-69928b1d9587?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"),
//   ];
//
//   Map<int, int> cart = {};
//
//   void _updateCart(int productId, int change) {
//     setState(() {
//       int currentQty = cart[productId] ?? 0;
//       int newQty = currentQty + change;
//       if (newQty <= 0) {
//         cart.remove(productId);
//       } else {
//         cart[productId] = newQty;
//       }
//     });
//   }
//
//   OverlayEntry? _overlayEntry;
//
//   void showTopNotification() {
//     _overlayEntry?.remove();
//
//     _overlayEntry = OverlayEntry(
//       builder: (context) => Positioned(
//         top: 60.0,
//         left: 16.0,
//         right: 16.0,
//         child: Material(
//           color: Colors.transparent,
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//             decoration: BoxDecoration(
//               color: const Color(0xFF10C66F),
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.1),
//                   blurRadius: 10,
//                   offset: const Offset(0, 5),
//                 ),
//               ],
//             ),
//             child: Row(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(6),
//                   decoration: const BoxDecoration(
//                     color: Colors.white,
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Icon(Icons.check, color: Color(0xFF10C66F), size: 18),
//                 ),
//                 const SizedBox(width: 12),
//
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         "Your order has been placed successfully!",
//                         style: GoogleFonts.nunito(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14,
//                         ),
//                       ),
//                       const SizedBox(height: 2),
//                       Text(
//                         "Thank you for shopping with us! Your food will arrive soon Enjoy.",
//                         style: GoogleFonts.nunito(
//                           color: Colors.white,
//                           fontSize: 11,
//                         ),
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 GestureDetector(
//                   onTap: () {
//                     _overlayEntry?.remove();
//                     _overlayEntry = null;
//                   },
//                   child: const Icon(Icons.close, color: Colors.white, size: 20),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//
//     Overlay.of(context).insert(_overlayEntry!);
//
//     Future.delayed(const Duration(seconds: 3), () {
//       _overlayEntry?.remove();
//       _overlayEntry = null;
//     });
//   }
//
//   final GlobalKey<ScaffoldState> _drawerKey = GlobalKey<ScaffoldState>();
//   int get totalItemsInCart => cart.values.fold(0, (sum, qty) => sum + qty);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _drawerKey,
//       drawer: const AppDrawer(),
//       backgroundColor: const Color(0xFFF8F9FA),
//       appBar: _buildAppBar(),
//
//       body: ResponsiveDiffLayout(
//         MobileBody: _buildMobileLayout(),
//         TabletBody: _buildTabletLayout(),
//       ),
//
//       bottomNavigationBar: totalItemsInCart > 0
//           ? SafeArea(
//         child: CartBottomBar(
//           totalItems: totalItemsInCart,
//           onTap: () {
//             showTopNotification();
//           },
//         ),
//       )
//           : null,
//     );
//   }
//
//   Widget _buildMobileLayout() {
//     return Column(
//       children: [
//         Obx(
//         (){
//       if (categoryController.isLoading.value) {
//         return const SizedBox(height: 125, child: Center(child: CircularProgressIndicator()));
//       }
//       return CategoryList(
//         isSidebar: true,
//         onCategorySelected: (category) {
//           debugPrint("Selected Category ID: ${category.id}");
//           debugPrint("Selected Category Name: ${category.menuname}");
//         },
//       );
//         }
//         ),
//         Expanded(child: _buildItemsGrid(isTablet: false)),
//       ],
//     );
//   }
//
//   Widget _buildTabletLayout() {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Obx((){
//               if (categoryController.isLoading.value) {
//                 return const SizedBox(height: 125, child: Center(child: CircularProgressIndicator()));
//               }
//               return CategoryList(
//                 onCategorySelected: (category) {
//                   debugPrint("Selected Category ID: ${category.id}");
//                   debugPrint("Selected Category Name: ${category.menuname}");
//                 },
//               );
//             }
//         ),
//         Expanded(child: _buildItemsGrid(isTablet: true)),
//       ],
//     );
//   }
//
//   Widget _buildItemsGrid({required bool isTablet}) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: isTablet ? 16.0 : 12.0),
//       child: GridView.builder(
//         padding: const EdgeInsets.only(top: 16, bottom: 100),
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           childAspectRatio: isTablet ? 0.75 : 0.65,
//           crossAxisSpacing: 12,
//           mainAxisSpacing: 12,
//         ),
//         itemCount: items.length,
//         itemBuilder: (context, index) {
//           final item = items[index];
//           return LayoutBuilder(
//               builder: (context, constraints) {
//                 return ItemCard(
//                   item: item,
//                   quantity: cart[item.id] ?? 0,
//                   onQuantityChanged: (change) => _updateCart(item.id, change),
//                 );
//               }
//           );
//         },
//       ),
//     );
//   }
//
//   PreferredSizeWidget _buildAppBar() {
//     return AppBar(
//       elevation: 0,
//       backgroundColor: Colors.white,
//       leading: IconButton(
//         onPressed: () => _drawerKey.currentState!.openDrawer(),
//         icon: const Icon(Icons.menu, color: Colors.black),
//       ),
//       title: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Quick Order",
//             style: GoogleFonts.nunito(
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//               fontSize: 20,
//             ),
//           ),
//           Text(
//             "A Symphony of Flavors!",
//             style: GoogleFonts.nunito(fontSize: 12, color: Colors.grey),
//           ),
//         ],
//       ),
//       actions: [
//         IconButton(icon: const Icon(Icons.search, color: Colors.black), onPressed: (){}),
//         IconButton(icon: const Icon(Icons.info, color: Colors.black), onPressed: (){}),
//         IconButton(icon: const Icon(Icons.more_vert, color: Colors.black), onPressed: (){}),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/category_controller.dart';
import '../widgets/responsive_layout.dart';
import '../widgets/app_drawer.dart';
import '../model/item.dart';
import '../widgets/cart_bottom.dart';
import '../widgets/category_list.dart';
import '../widgets/item_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CategoryController categoryController = Get.put(CategoryController());
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey<ScaffoldState>();
  Map<int, int> cart = {};

  final List<Item> items = [
    Item(id: 1, name: "Caprese Salad Skewers", description: "Cherry tomatoes, fresh mozzarella.", price: 12.0, image: ""),
    Item(id: 2, name: "Paneer Tikka", description: "Grilled chunks of paneer.", price: 15.0, image: ""),
    Item(id: 3, name: "Spinach and Cheese", description: "Cherry tomatoes, fresh mozzarella.", price: 8.0, image: ""),
    Item(id: 4, name: "Vegetable Samosas", description: "Grilled chunks of paneer.", price: 5.0, image: ""),
  ];

  void _updateCart(int productId, int change) {
    setState(() {
      int currentQty = cart[productId] ?? 0;
      int newQty = currentQty + change;
      if (newQty <= 0) cart.remove(productId);
      else cart[productId] = newQty;
    });
  }

  int get totalItemsInCart => cart.values.fold(0, (sum, qty) => sum + qty);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      drawer: const AppDrawer(),
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: _buildAppBar(),
      body: Row(
        children: [
          SizedBox(
            width: 80,
            child: Obx(() {
              if (categoryController.isLoading.value) return const Center(child: CircularProgressIndicator());
              return CategoryList(
                isSidebar: true, // Fixed vertical sidebar
                onCategorySelected: (category) => debugPrint("Selected: ${category.menuname}"),
              );
            }),
          ),

          Container(width: 1, color: Colors.grey.withOpacity(0.1)),

          Expanded(
            child: ResponsiveDiffLayout(
              MobileBody: _buildItemsGrid(isTablet: false),
              TabletBody: _buildItemsGrid(isTablet: true),
            ),
          ),
        ],
      ),
      bottomNavigationBar: totalItemsInCart > 0
          ? SafeArea(child: CartBottomBar(totalItems: totalItemsInCart, onTap: () {}))
          : null,
    );
  }

  Widget _buildItemsGrid({required bool isTablet}) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isTablet ? 3 : 2,
        childAspectRatio: isTablet ? 0.85 : 0.68,
        crossAxisSpacing: isTablet ? 20 : 12,
        mainAxisSpacing: isTablet ? 20 : 12,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) => ItemCard(
        item: items[index],
        quantity: cart[items[index].id] ?? 0,
        onQuantityChanged: (change) => _updateCart(items[index].id, change),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(onPressed: () => _drawerKey.currentState!.openDrawer(), icon: const Icon(Icons.menu, color: Colors.black)),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Quick Order", style: GoogleFonts.nunito(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18)),
          Text("A Symphony of Flavors!", style: GoogleFonts.nunito(fontSize: 11, color: Colors.grey)),
        ],
      ),
      actions: [
        IconButton(icon: const Icon(Icons.search, color: Colors.black), onPressed: () {}),
        IconButton(icon: const Icon(Icons.info_outline, color: Colors.black), onPressed: () {}),
      ],
    );
  }
}