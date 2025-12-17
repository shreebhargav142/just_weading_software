import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_weding_software/widgets/responsive_layout.dart';
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
  final List<String> categories = ["Starter", "Bitings", "Juice", "Desserts", "Mexican", "Drinks"];
  final List<Item> items = [
    Item(id: 1, name: "Caprese Salad Skewers", description: "Cherry tomatoes, fresh mozzarella, and basil.", price: 12.0, image: ""),
    Item(id: 2, name: "Paneer Tikka", description: "Grilled chunks of paneer marinated in spicy yogurt.", price: 15.0, image: ""),
    Item(id: 3, name: "Spinach Croissants", description: "Flaky croissants stuffed with spinach and cheese.", price: 8.0, image: ""),
    Item(id: 4, name: "Vegetable Samosas", description: "Crisp pastry pockets filled with spiced veggies.", price: 5.0, image: ""),
    Item(id: 5, name: "Mojito", description: "Fresh mint lime soda.", price: 4.0, image: ""),
  ];

  Map<int, int> cart = {};

  void _updateCart(int productId, int change) {
    setState(() {
      int currentQty = cart[productId] ?? 0;
      int newQty = currentQty + change;
      if (newQty <= 0) {
        cart.remove(productId);
      } else {
        cart[productId] = newQty;
      }
    });
  }

  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey<ScaffoldState>();
  int get totalItemsInCart => cart.values.fold(0, (sum, qty) => sum + qty);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      drawer: const AppDrawer(),
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Categories list (Common for both)
            CategoryList(
              categories: categories,
              onCategorySelected: (index) {
                print("Selected Category: $index");
              },
            ),

            // YAHAN CHANGE KIYA HAI 🪄
            Expanded(
              child: ResponsiveDiffLayout(
                // Mobile aur Tablet dono ke liye ab ListView (List) hi use hoga
                MobileBody: _buildList(isTablet: false),
                TabletBody: _buildList(isTablet: true),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        bottom: true,
        child: CartBottomBar(
          totalItems: totalItemsInCart,
          onTap: () {
            showTopNotification();
          },
        ),
      ),
    );
  }

  OverlayEntry? _overlayEntry;

  void showTopNotification() {
    _overlayEntry?.remove();

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 60.0,
        left: 16.0,
        right: 16.0,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF10C66F), // Green Color
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, color: Color(0xFF10C66F), size: 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Your order has been placed successfully!",
                        style: GoogleFonts.nunito(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Thank you for shopping with us! Your food will arrive soon Enjoy.",
                        style: GoogleFonts.nunito(
                          color: Colors.white,
                          fontSize: 11,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _overlayEntry?.remove();
                    _overlayEntry = null;
                  },
                  child: const Icon(Icons.close, color: Colors.white, size: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);

    Future.delayed(const Duration(seconds: 3), () {
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
  }

  Widget _buildList({required bool isTablet}) {
    return ListView.builder(
      padding: EdgeInsets.only(
          top: 0,
          bottom: 55,
          left: isTablet ? 16 : 0,
          right: isTablet ? 16 : 0
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ItemCard(
          item: item,
          quantity: cart[item.id] ?? 0,
          onQuantityChanged: (change) => _updateCart(item.id, change),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: [Color(0xFF9E8D8D), Color(0xFF4E342E)],
          ),
        ),
      ),
      leading: IconButton(
        onPressed: () => _drawerKey.currentState!.openDrawer(),
        icon: const Icon(Icons.menu_open_outlined, color: Colors.white),
      ),
      title: Text(
        "Quick Order",
        style: GoogleFonts.nunito(
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      actions: const [
        Icon(Icons.search, color: Colors.white),
        SizedBox(width: 12),
        Icon(Icons.info_outline, color: Colors.white),
        SizedBox(width: 12),
        Icon(Icons.more_vert, color: Colors.white),
        SizedBox(width: 8),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(160),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icon/icon.png',
                height: 56,
              ),
              const SizedBox(height: 5,),
              Text(
                'A Feast of Flavors Awaits',
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'A Symphony of Flavors in Every Bite!',
                  style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}