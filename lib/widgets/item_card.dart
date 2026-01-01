// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'responsive_screen.dart' as custom;
// import 'package:google_fonts/google_fonts.dart';
// import '../model/menuitem_model.dart';
// import '../controller/menu_controller.dart';
//
// class ItemCard extends StatefulWidget {
//   final ItemsDetails item;
//   final Function(int) onQuantityChanged;
//   final VoidCallback onEditToggle;
//   final int quantity;
//
//   const ItemCard({
//     super.key,
//     required this.quantity,
//     required this.item,
//     required this.onQuantityChanged,
//     required this.onEditToggle,
//   });
//
//   @override
//   State<ItemCard> createState() => _ItemCardState();
// }
//
// class _ItemCardState extends State<ItemCard> {
//   @override
//   Widget build(BuildContext context) {
//     final EventMenuController eventMenuController = Get.find<EventMenuController>();
//     double screenWidth = MediaQuery.of(context).size.width;
//     bool isTablet = screenWidth > 600;
//
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           )
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             flex: 5,
//             child: Stack(
//               children: [
//                 Container(
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[200],
//                     borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
//                   ),
//                   child: ClipRRect(
//                     borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
//                     child: widget.item.itemImage!=null
//                         ? Image.network(
//                       widget.item.imageUrl,
//                       fit: BoxFit.cover,
//                       loadingBuilder: (context, child, loadingProgress) {
//                         if (loadingProgress == null) return child;
//                         return const Center(child: CircularProgressIndicator(strokeWidth: 2));
//                       },
//                       errorBuilder: (context, error, stackTrace) =>
//                       const Icon(Icons.broken_image, color: Colors.grey, size: 30),
//                     )
//                         : const Icon(Icons.fastfood, color: Colors.grey, size: 40),
//                   ),
//                 ),
//                 Positioned(
//                   top: isTablet ? 12:8,
//                   right: isTablet? 12:8,
//                   child: InkWell(
//                     onTap: _showEditDialog,
//                     child: Container(
//                       padding: EdgeInsets.all(isTablet ? 8:6),
//                       decoration: const BoxDecoration(
//                         color: Colors.white,
//                         shape: BoxShape.circle,
//                       ),
//                       child: Icon(
//                         Icons.info_outline,
//                         size: isTablet? 26:22,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             flex: 4,
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
//               child: Text(
//                 widget.item.name,
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//                 style: GoogleFonts.nunito(
//                   fontSize: isTablet? 18:15,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black87,
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
//             child: Obx(() {
//               final liveQuantity = eventMenuController.quantities[widget.item.id] ?? 0;
//
//               return liveQuantity == 0
//                   ? SizedBox(
//                 width: double.infinity,
//                 height:isTablet?44: 34,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFFD32F2F),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//                     padding: EdgeInsets.zero,
//                     elevation: 0,
//                   ),
//                   onPressed: () => widget.onQuantityChanged(1),
//                   child: Text(
//                     "Add to cart",
//                     style: GoogleFonts.nunito(
//                       color: Colors.white,
//                       fontWeight: FontWeight.w600,
//                       fontSize:isTablet? 15: 13,
//                     ),
//                   ),
//                 ),
//               )
//                   : Row(
//                 children: [
//                   IconButton(
//                       onPressed: () {
//                         widget.onQuantityChanged(-liveQuantity);
//                       },
//                       icon: const Icon(Icons.delete_outline, color: Colors.red, size: 25)),
//                   FittedBox(
//                     child: Container(
//                       height: 40,
//                       width: 84,
//                       decoration: BoxDecoration(
//                         color: const Color(0xFFF3F4F6),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           IconButton(
//                             visualDensity: VisualDensity.compact,
//                             icon: const Icon(Icons.remove, size: 18, color: Colors.black87),
//                             onPressed: () => widget.onQuantityChanged(-1),
//                             padding: EdgeInsets.zero,
//                             constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 4),
//                             child: Text(
//                               "$liveQuantity",
//                               style: GoogleFonts.nunito(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: isTablet?16:14,
//                               ),
//                             ),
//                           ),
//                           IconButton(
//                             visualDensity: VisualDensity.compact,
//                             icon: const Icon(Icons.add, size: 16, color: Colors.black87),
//                             onPressed: () => widget.onQuantityChanged(1),
//                             padding: EdgeInsets.zero,
//                             constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             }),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showEditDialog() {
//     final TextEditingController instructionController = TextEditingController();
//     final RxString selectedType = 'Veg'.obs;
//
//     Get.dialog(
//       Material(
//         color: Colors.transparent,
//         child: custom.ResponsiveScreen(
//
//           maxWidth: 550,
//           child: Dialog(
//             insetPadding: EdgeInsets.zero,
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Your Food Instruction',
//                       style: GoogleFonts.nunito(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.black
//                       ),
//                     ),
//                     const SizedBox(height: 15),
//                     TextField(
//                       cursorColor: Colors.black,
//                       controller: instructionController,
//                       maxLines: 4,
//                       decoration: InputDecoration(
//                         hintText: 'Instruction',
//                         hintStyle: GoogleFonts.nunito(fontSize: 16, color: Colors.black45),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(16),
//                             borderSide: const BorderSide(color: Colors.black45)),
//                         enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(16),
//                             borderSide: const BorderSide(color: Colors.black45)),
//                         focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(16),
//                             borderSide: const BorderSide(color: Colors.black)),
//                       ),
//                     ),
//                     const SizedBox(height: 15),
//                     Obx(() => Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 12),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.grey.shade400),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: DropdownButtonHideUnderline(
//                         child: DropdownButton<String>(
//                           value: selectedType.value,
//                           isExpanded: true,
//                           items: ['Veg', 'Non Veg'].map((String value) {
//                             return DropdownMenuItem<String>(
//                               value: value,
//                               child: Text(value, style: GoogleFonts.nunito()),
//                             );
//                           }).toList(),
//                           onChanged: (newValue) {
//                             selectedType.value = newValue!;
//                           },
//                         ),
//                       ),
//                     )),
//                     const SizedBox(height: 24),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: OutlinedButton(
//                             style: OutlinedButton.styleFrom(
//                               minimumSize: const Size(0, 48),
//                               side: const BorderSide(color: Colors.black26),
//                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                             ),
//                             onPressed: () => Get.back(),
//                             child: Text("Close", style: GoogleFonts.nunito(color: Colors.black, fontWeight: FontWeight.bold)),
//                           ),
//                         ),
//                         const SizedBox(width: 12),
//                         Expanded(
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               minimumSize: const Size(0, 48),
//                               backgroundColor: const Color(0xFFD32F2F),
//                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                               elevation: 0,
//                             ),
//                             onPressed: () {
//                               Get.back();
//                             },
//                             child: Text("Save", style: GoogleFonts.nunito(color: Colors.white, fontWeight: FontWeight.bold)),
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_weding_software/controller/auth_controller.dart';
import '../view/screens/cart_screen.dart';
import 'responsive_screen.dart' as custom;
import 'package:google_fonts/google_fonts.dart';
import '../model/menuitem_model.dart';
import '../controller/menu_controller.dart';

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
  final EventMenuController eventMenuController = Get.find<EventMenuController>();
  final AuthController authController=Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;

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
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    child: (widget.item.itemImage != null && widget.item.itemImage!.isNotEmpty)
                        ? Image.network(
                      widget.item.itemImage!, // Naya field name
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(child: CircularProgressIndicator(strokeWidth: 2));
                      },
                      errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, color: Colors.grey, size: 30),
                    )
                        : const Icon(Icons.fastfood, color: Colors.grey, size: 40),
                  ),
                ),
                Positioned(
                  top: isTablet ? 12 : 8,
                  right: isTablet ? 12 : 8,
                  child: InkWell(
                    onTap: _showEditDialog,
                    child: Container(
                      padding: EdgeInsets.all(isTablet ? 8 : 6),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.info_outline,
                        size: isTablet ? 26 : 22,
                        color: Colors.black,
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
              child: Text(
                widget.item.itemName ?? "Unknown Item", // Naya field name
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.nunito(
                  fontSize: isTablet ? 18 : 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: Obx(() {
              final authcontroller=Get.find<AuthController>();
              if(authcontroller.isCaptain){
                return const SizedBox.shrink();
              }
              final liveQuantity = eventMenuController.quantities[widget.item.itemId] ?? 0;
              return liveQuantity == 0
                  ? SizedBox(
                width: double.infinity,
                height: isTablet ? 44 : 34,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD32F2F),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    padding: EdgeInsets.zero,
                    elevation: 0,
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
              )
                  : Row(
                children: [
                  IconButton(
                      onPressed: () {
                        widget.onQuantityChanged(-liveQuantity);
                      },
                      icon: const Icon(Icons.delete_outline, color: Colors.red, size: 25)),
                  FittedBox(
                    child: Container(
                      height: 40,
                      width: 84,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            visualDensity: VisualDensity.compact,
                            icon: const Icon(Icons.remove, size: 18, color: Colors.black87),
                            onPressed: () => widget.onQuantityChanged(-1),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              "$liveQuantity",
                              style: GoogleFonts.nunito(
                                fontWeight: FontWeight.bold,
                                fontSize: isTablet ? 16 : 14,
                              ),
                            ),
                          ),
                          IconButton(
                            visualDensity: VisualDensity.compact,
                            icon: const Icon(Icons.add, size: 16, color: Colors.black87),
                            onPressed: () => widget.onQuantityChanged(1),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
  void _showEditDialog() {
    final TextEditingController instructionController = TextEditingController();
    final RxString selectedType = 'Veg'.obs;
    Get.dialog(
      Material(
        color: Colors.transparent,
        child: custom.ResponsiveScreen(
          maxWidth: 550,
          child: Dialog(
            insetPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Food Instruction',
                      style: GoogleFonts.nunito(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      cursorColor: Colors.black,
                      controller: instructionController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Instruction',
                        hintStyle: GoogleFonts.nunito(fontSize: 16, color: Colors.black45),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.black45)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.black45)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.black)),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Obx(() => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedType.value,
                          isExpanded: true,
                          items: ['Veg', 'Non Veg'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style: GoogleFonts.nunito()),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            selectedType.value = newValue!;
                          },
                        ),
                      ),
                    )),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size(0, 48),
                              side: const BorderSide(color: Colors.black26),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            onPressed: () => Get.back(),
                            child: Text("Close", style: GoogleFonts.nunito(color: Colors.black, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(0, 48),
                              backgroundColor: const Color(0xFFD32F2F),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              elevation: 0,
                            ),
                            onPressed: () {
                              Get.back();
                            },
                            child: Text("Save", style: GoogleFonts.nunito(color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  void _showOrderSuccessDialog(){
    Get.dialog(
      AlertDialog(
        title: const Icon(Icons.check_circle, color: Colors.green, size: 50),
        content: const Text("Order Table created successfully", textAlign: TextAlign.center),
        actions: [
          TextButton(
            onPressed: () {
              eventMenuController.clearCart(); // Clear local state
              Get.back();
            },
            child: const Text("Cancel", style: TextStyle(color: Colors.red)),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              Get.to(() => const CartScreen()); // Go to Cart
            },
            child: const Text("View Order"),
          ),
        ],
      ),
      barrierDismissible: false,

    );
  }
}