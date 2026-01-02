import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/category_controller.dart';
import '../model/category_model.dart';

class CategoryList extends StatefulWidget {
  final dynamic clientId;
  final Function(MenuCategoryDetails) onCategorySelected;

  const CategoryList( {
    super.key,
    required this.clientId,
    required this.onCategorySelected,
  });

  @override
  State<CategoryList> createState() => _CategoryListState();
}

// class _CategoryListState extends State<CategoryList> {
//   late final CategoryController controller = Get.put(CategoryController(clientId: widget.clientId));
//   int selectedIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       if (controller.isLoading.value) {
//         return const Center(
//           child: CircularProgressIndicator(color: Colors.red),
//         );
//       }
//
//       if (controller.categories.isEmpty) {
//         return const Center(child: Text("No categories found"));
//       }
//
//       return SizedBox(
//         height: 120,
//         child: ListView.separated(
//           scrollDirection: Axis.horizontal,
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//           itemCount: controller.categories.length,
//           separatorBuilder: (_, __) => const SizedBox(width: 20),
//           itemBuilder: (context, index) => _buildCategoryItem(index),
//         ),
//       );
//     });
//   }
//
//   Widget _buildCategoryItem(int index) {
//     final category = controller.categories[index];
//     final bool isSelected = index == selectedIndex;
//
//     return GestureDetector(
//       onTap: () {
//         setState(() => selectedIndex = index);
//         widget.onCategorySelected(category);
//       },
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             height: 60,
//             width: 60,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               border: Border.all(
//                 color: isSelected ? Colors.red : Colors.grey.shade300,
//                 width: 2,
//               ),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(3.0),
//               child: CircleAvatar(
//                 backgroundColor: Colors.white,
//                 backgroundImage: (category.menuImage != null && category.menuImage!.isNotEmpty)
//                     ? NetworkImage(category.menuImage!)
//                     : null,
//                 child: (category.menuImage == null || category.menuImage!.isEmpty)
//                     ? Icon(Icons.fastfood, color: Colors.grey[400], size: 24)
//                     : null,
//               ),
//             ),
//           ),
//           const SizedBox(height: 8),
//           Expanded(
//             flex: 1,
//             child: Text(
//               category.menuname ?? '',
//               overflow: TextOverflow.ellipsis,
//               textAlign: TextAlign.center,
//               style: GoogleFonts.nunito(
//                 fontSize: 12,
//                 fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
//                 color: isSelected ? Colors.black : Colors.grey[600],
//               ),
//             ),
//           ),
//           if (isSelected)
//             Container(
//               margin: const EdgeInsets.only(top: 4),
//               height: 5,
//               width: 5,
//               decoration: const BoxDecoration(
//                 color: Colors.red,
//                 shape: BoxShape.circle,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
class _CategoryListState extends State<CategoryList> {
  late final CategoryController controller = Get.put(CategoryController(clientId: widget.clientId));
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isTablet = screenWidth >= 600;

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator(color: Colors.red));
      }
      if (controller.categories.isEmpty) {
        return const Center(child: Text("No categories found"));
      }

      return SizedBox(
        height: isTablet ? 160 : 120,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(
              horizontal: isTablet ? 24 : 16,
              vertical: 10
          ),
          itemCount: controller.categories.length,
          separatorBuilder: (_, __) => SizedBox(width: isTablet ? 30 : 20),
          itemBuilder: (context, index) => _buildCategoryItem(index, isTablet),
        ),
      );
    });
  }

  Widget _buildCategoryItem(int index, bool isTablet) {
    final category = controller.categories[index];
    final bool isSelected = index == selectedIndex;

    final double avatarSize = isTablet ? 120 : 60;
    final double fontSize = isTablet ? 16 : 12;

    return GestureDetector(
      onTap: () {
        setState(() => selectedIndex = index);
        widget.onCategorySelected(category);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: avatarSize,
            width: avatarSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? Colors.red : Colors.grey.shade300,
                width: isTablet ? 3 : 2, // Thicker border for tablet
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
                    ? Icon(Icons.fastfood,
                    color: Colors.grey[400],
                    size: isTablet ? 40 : 24) // Larger icon
                    : null,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            category.menuname ?? '',
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: GoogleFonts.nunito(
              fontSize: fontSize,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? Colors.black : Colors.grey[600],
            ),
          ),
          if (isSelected)
            Container(
              margin: const EdgeInsets.only(top: 4),
              height: isTablet ? 8 : 5, // Larger dot indicator
              width: isTablet ? 8 : 5,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}