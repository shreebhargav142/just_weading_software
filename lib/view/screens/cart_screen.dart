import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_weding_software/controller/menu_controller.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EventMenuController>();
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            onPressed: () => Get.until((route) => route.isFirst),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20)
        ),
        backgroundColor: Colors.white,
        title: Text(
          "My Cart",
          style: GoogleFonts.nunito(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Obx(() {
        final cartItems = controller.selectedCartItems;
        if (cartItems.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey[300]),
                const SizedBox(height: 16),
                Text("Cart is empty", style: GoogleFonts.nunito(fontSize: 18, color: Colors.grey)),
              ],
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: cartItems.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final item = cartItems[index];
            print(item.itemName);
            final qty = controller.quantities[item.itemId] ?? 0;

            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: (item.itemImage != null && item.itemImage!.isNotEmpty)
                          ? Image.network(
                        item.itemImage!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image, color: Colors.grey),
                      )
                          : const Icon(Icons.fastfood, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            item.itemName ?? 'Unknown',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.nunito(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              height: 1.2, // Text line height control
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 32,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F4F6),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                visualDensity: VisualDensity.compact,
                                icon: const Icon(Icons.remove, size: 14, color: Colors.black87),
                                onPressed: () => controller.updateQuantity(item.itemId!, -1),
                              ),
                              Text(
                                "$qty",
                                style: GoogleFonts.nunito(fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                              IconButton(
                                visualDensity: VisualDensity.compact,
                                icon: const Icon(Icons.add, size: 14, color: Colors.black87),
                                onPressed: () => controller.updateQuantity(item.itemId!, 1),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  IconButton(
                    onPressed: () => controller.updateQuantity(item.itemId!, -qty),
                    icon: const Icon(Icons.delete_outline, color: Colors.red, size: 24),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            );
          },
        );
      }),
      bottomNavigationBar: Obx(() {
        int totalItems = controller.totalCartItemsCount; // Using your controller getter
        bool isProcessing = controller.isPlacingOrder.value; // Loading state

        return totalItems > 0
            ? Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, -4),
              )
            ],
          ),
          child: SafeArea(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD32F2F),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              onPressed: isProcessing
                  ? null
                  : () => _showConfirmDialog(context, controller),
              child: isProcessing
                  ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
                  : Text(
                "Order Now ($totalItems Items)",
                style: GoogleFonts.nunito(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                ),
              ),
            ),
          ),
        )
            : const SizedBox.shrink();
      }),
    );
  }

  void _showConfirmDialog(BuildContext context, EventMenuController controller) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text("Confirm Order", style: GoogleFonts.nunito(fontWeight: FontWeight.bold)),
        content: Text("Are you sure you want to place this order?", style: GoogleFonts.nunito()),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text("Cancel", style: GoogleFonts.nunito(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD32F2F),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              controller.placeOrder();
            },
            child: Text("Confirm", style: GoogleFonts.nunito(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}