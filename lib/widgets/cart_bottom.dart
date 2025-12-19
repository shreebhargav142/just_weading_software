import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_weding_software/widgets/responsive_layout.dart';

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
                // Tablet pe text bada
                fontSize: isTablet ? 18 : 16),
          ),

          ElevatedButton(
            onPressed: () {
              widget.onTap();
              setState(() {
                _isOrderPlaced = true;
              });
            },
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
                  "Order Now",
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