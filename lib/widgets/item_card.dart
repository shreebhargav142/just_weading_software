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
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;

    double imageSize = isTablet ? 110 : 80; // Tablet pe image badi
    double titleSize = isTablet ? 18 : 16;
    double descSize = isTablet ? 14 : 12;
    double iconSize = isTablet ? 20 : 16;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Content ke hisaab se height lega
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: imageSize,
                    height: imageSize,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                      image: widget.item.image.isNotEmpty
                          ? DecorationImage(
                          image: NetworkImage(widget.item.image),
                          fit: BoxFit.cover)
                          : null,
                    ),
                    child: widget.item.image.isEmpty
                        ? Icon(Icons.fastfood, color: Colors.grey, size: imageSize * 0.4)
                        : null,
                  ),

                  Positioned(
                    top: 6,
                    right: 6,
                    child: InkWell(
                      onTap: () => setState(() => widget.item.isFav = !widget.item.isFav),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          widget.item.isFav ? Icons.favorite : Icons.favorite_border,
                          color: widget.item.isFav ? Colors.red : Colors.grey,
                          size: iconSize,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.item.name,
                      style: GoogleFonts.nunito(
                          fontSize: titleSize, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.item.description,
                      style: GoogleFonts.nunito(
                          fontSize: descSize, color: Colors.grey[600]),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Align(
            alignment: Alignment.centerRight,
            child: widget.quantity == 0
                ? ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                // Tablet pe button thoda bada
                padding: EdgeInsets.symmetric(
                    horizontal: isTablet ? 32 : 24,
                    vertical: isTablet ? 12 : 8
                ),
              ),
              onPressed: () => widget.onQuantityChanged(1),
              child: Text(
                "Add to cart",
                style: GoogleFonts.nunito(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: isTablet ? 15 : 14),
              ),
            )
                : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.delete_outline, color: Colors.red, size: isTablet ? 28 : 24),
                  onPressed: () => widget.onQuantityChanged(-widget.quantity),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 35, minHeight: 35),
                ),

                const SizedBox(width: 8),

                Container(
                  height: isTablet ? 42 : 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove, color: Colors.black87, size: isTablet ? 20 : 18),
                        onPressed: () => widget.onQuantityChanged(-1),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(minWidth: 35, minHeight: 35),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "${widget.quantity}",
                          style: GoogleFonts.nunito(
                              fontWeight: FontWeight.bold,
                              fontSize: isTablet ? 18 : 16),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add, color: Colors.black87, size: isTablet ? 20 : 18),
                        onPressed: () => widget.onQuantityChanged(1),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(minWidth: 35, minHeight: 35),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}