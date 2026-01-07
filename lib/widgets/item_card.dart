import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_weding_software/controller/auth_controller.dart';
import 'package:just_weding_software/controller/menu_controller.dart';
import 'package:just_weding_software/widgets/responsive_layout.dart';
import 'package:just_weding_software/model/category_response_model.dart';
import 'responsive_screen.dart' as custom;

class ItemCard extends StatefulWidget {
  final ItemsDetails item;
  final Function(int) onQuantityChanged;
  final VoidCallback onEditToggle;
  final int quantity;

  const ItemCard({
    super.key,
    required this.quantity,
    required this.item,
    required this.onQuantityChanged,
    required this.onEditToggle,
  });

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  final EventMenuController eventMenuController =
  Get.find<EventMenuController>();
  final AuthController authController = Get.find<AuthController>();

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
          ),
        ],
      ),
      child: ResponsiveDiffLayout(
        MobileBody: _buildMobileLayout(),
        TabletBody: _buildTabletLayout(),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildImage(isTablet: false),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, // Added this
              children: [
                Text(
                  widget.item.itemName ?? "Unknown Item",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  widget.item.itemSlogan ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.nunito(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
          child: _buildActionSection(isTablet: false),
        ),
      ],
    );
  }
  Widget _buildTabletLayout() {
    return SizedBox(
      height: 140,
      child: Row(
        children: [
          _buildImage(isTablet: true),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.item.itemName ?? "Unknown Item",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.nunito(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  _buildActionSection(isTablet: true),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildImage({required bool isTablet}) {
    return Stack(
      children: [
        Container(
          width: isTablet ? 160 : double.infinity,
          height: isTablet ? double.infinity : 120,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: isTablet
                ? const BorderRadius.horizontal(left: Radius.circular(16))
                : const BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: ClipRRect(
            borderRadius: isTablet
                ? const BorderRadius.horizontal(left: Radius.circular(16))
                : const BorderRadius.vertical(top: Radius.circular(16)),
            child: (widget.item.itemImage != null &&
                widget.item.itemImage!.isNotEmpty)
                ? Image.network(
              widget.item.itemImage!,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                );
              },
              errorBuilder: (_, __, ___) =>
                  Image.asset('assets/images/silverveg.jpg'),
            )
                : Image.asset('assets/images/silverveg.jpg'),
          ),
        ),

        // ✅ ALWAYS SHOW INFO ICON (Mobile + Tablet)
        Positioned(
          top: 8,
          right: 8,
          child: InkWell(
            onTap: _showEditDialog,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.info_outline, size: 20),
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildActionSection({required bool isTablet}) {
    return Obx(() {
      if (authController.isCaptain) {
        return const SizedBox.shrink();
      }

      final int qty =
          eventMenuController.quantities[widget.item.itemId] ?? 0;

      // ---------------- ADD TO CART ----------------
      if (qty == 0) {
        return SizedBox(
          width: isTablet ? 140 : double.infinity,
          height: isTablet ? 50 : 34,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD32F2F),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 0,
              padding: EdgeInsets.zero,
            ),
            onPressed: () => widget.onQuantityChanged(1),
            child: Text(
              "Add to cart",
              style: GoogleFonts.nunito(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: isTablet ? 15 : 13,
              ),
            ),
          ),
        );
      }

      // ---------------- COUNTER ----------------
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // DELETE
          IconButton(
            icon: Icon(
              Icons.delete_outline,
              color: Colors.red,
              size: isTablet ? 26 : 22,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () => widget.onQuantityChanged(-qty),
          ),

          const SizedBox(width: 6),

          // COUNTER BOX
          Container(
            height: isTablet ? 40 : 34,
            width: isTablet ? 96 : 84,
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // MINUS
                IconButton(
                  visualDensity: VisualDensity.compact,
                  icon: Icon(
                    Icons.remove,
                    size: isTablet ? 20 : 18,
                    color: Colors.black87,
                  ),
                  padding: EdgeInsets.zero,
                  constraints:
                  const BoxConstraints(minWidth: 32, minHeight: 32),
                  onPressed: () => widget.onQuantityChanged(-1),
                ),

                // QTY
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    "$qty",
                    style: GoogleFonts.nunito(
                      fontWeight: FontWeight.bold,
                      fontSize: isTablet ? 16 : 14,
                    ),
                  ),
                ),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  icon: Icon(
                    Icons.add,
                    size: isTablet ? 20 : 18,
                    color: Colors.black87,
                  ),
                  padding: EdgeInsets.zero,
                  constraints:
                  const BoxConstraints(minWidth: 32, minHeight: 32),
                  onPressed: () => widget.onQuantityChanged(1),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  void _showEditDialog() {
    final TextEditingController instructionController =
    TextEditingController();
    final RxString selectedType = 'Veg'.obs;

    Get.dialog(
      Material(
        color: Colors.transparent,
        child: custom.ResponsiveScreen(
          maxWidth: 550,
          child: Dialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Food Instruction',
                    style: GoogleFonts.nunito(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: instructionController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Instruction',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Obx(() => DropdownButtonFormField<String>(
                      value: selectedType.value,
                      items: const [
                        DropdownMenuItem(value: 'Veg', child: Text('Veg')),
                        DropdownMenuItem(
                            value: 'Non Veg', child: Text('Non Veg')),
                      ],
                      onChanged: (v) => selectedType.value = v!,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Get.back(),
                          child: const Text("Close"),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red
                          ),
                          onPressed: () => Get.back(),
                          child: const Text("Save"),
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