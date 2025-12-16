import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/order_history_screen.dart';

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
  // 1. Yeh variable track karega ki order place hua ya nahi
  bool _isOrderPlaced = false;

  @override
  Widget build(BuildContext context) {
    // Logic: Agar items 0 hain AUR order place nahi hua hai tabhi hide karo.
    // Agar order place ho gaya hai (_isOrderPlaced == true), toh bar dikhna chahiye.
    if (widget.totalItems == 0 && !_isOrderPlaced) {
      return const SizedBox.shrink();
    }

    // 2. Agar Order Place ho gaya hai, toh GREEN view dikhao
    if (_isOrderPlaced) {
      return _buildOrderPlacedView();
    }

    // 3. Normal RED View (Order Now)
    return Padding(
      padding: const EdgeInsets.only(left: 38.0),
      child: Row(
        children: [
          Text(
            "(${widget.totalItems}) Items added",
            style: GoogleFonts.nunito(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
          const SizedBox(width: 15,),
          ElevatedButton(
            onPressed: () {
              // Pehle parent ka function call karo (Notification wala)
              widget.onTap();

              // Phir state change karo taaki UI Green ho jaye
              setState(() {
                _isOrderPlaced = true;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD62E38),
              elevation: 0,
              minimumSize: const Size(160, 36),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Order Now",
                  style: GoogleFonts.nunito(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 12,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildOrderPlacedView() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white, // Background white
      child: Row(
        children: [
          // Left Side: Green Text
          Expanded(
            child: Text(
              "Your food order is being prepared, & your food will be delivered shortly. Just wait a moment..",
              style: GoogleFonts.nunito(
                color: const Color(0xFF10C66F), // Green Color
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 12),

          // Right Side: View Order Button
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderHistoryScreen()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF10C66F), // Green Button
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              minimumSize: const Size(100, 36),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "View Order",
                  style: GoogleFonts.nunito(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}