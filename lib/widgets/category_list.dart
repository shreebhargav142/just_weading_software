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

    final String? imageUrl = category.menuImage;

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
              color: Colors.white,
              border: Border.all(
                color: isSelected ? Colors.red : Colors.grey.shade300,
                width: isTablet ? 3 : 2,
              ),
            ),
            child: ClipOval(
              child: (imageUrl == null || imageUrl.isEmpty)
                  ? Image.asset(
                'assets/icon/icon.png',
                fit: BoxFit.cover,
              )
                  : Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/icon/icon.png',
                    fit: BoxFit.cover,
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                          : null,
                      strokeWidth: 2,
                      color: Colors.red.withOpacity(0.5),
                    ),
                  );
                },
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
              height: isTablet ? 8 : 5,
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