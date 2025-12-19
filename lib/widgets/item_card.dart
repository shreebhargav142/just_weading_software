import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/item.dart';

class ItemCard extends StatefulWidget {
  final Item item;
  final int quantity;
  final Function(int) onQuantityChanged;

  const ItemCard({
    super.key,
    required this.item,
    required this.quantity,
    required this.onQuantityChanged,
  });

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Stack(
              children: [
                Container(
                  height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    image: widget.item.image.isNotEmpty
                        ? DecorationImage(
                      image: NetworkImage(widget.item.image),
                      fit: BoxFit.cover,
                    )
                        : null,
                  ),
                  child: widget.item.image.isEmpty
                      ? const Icon(Icons.fastfood, color: Colors.grey, size: 40)
                      : null,
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: InkWell(
                    onTap: () => setState(() => widget.item.isFav = !widget.item.isFav),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        widget.item.isFav ? Icons.favorite : Icons.favorite_border,
                        color: widget.item.isFav ? Colors.red : Colors.grey,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.nunito(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: widget.quantity == 0
                ? SizedBox(
              width: double.infinity,
              height: 34,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD32F2F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.zero,
                  elevation: 0,
                ),
                onPressed: () => widget.onQuantityChanged(1),
                child: Text(
                  "Add to cart",
                  style: GoogleFonts.nunito(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            )
                : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,


              children: [
                // InkWell(
                //   onTap: () => widget.onQuantityChanged(-widget.quantity), // Remove all
                //   child: Icon(Icons.delete_outline, color: Color(0xFFD32F2F), size: 18),
                // ),

                Container(
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min, // Yeh Row ko sirf utni jagah lene dega jitni zaroorat hai
                    children: [
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        splashRadius: 18,
                        icon: const Icon(Icons.remove, size: 16, color: Colors.black87),
                        onPressed: () => widget.onQuantityChanged(-1),
                        padding: EdgeInsets.zero,
                        // Constraints ko thoda aur tight karein
                        constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          "${widget.quantity}",
                          style: GoogleFonts.nunito(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        splashRadius: 18,
                        icon: const Icon(Icons.add, size: 16, color: Colors.black87),
                        onPressed: () => widget.onQuantityChanged(1),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}