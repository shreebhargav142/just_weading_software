import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/category_controller.dart';
import '../model/category_model.dart';

class CategoryList extends StatefulWidget {
  final Function(MenuCategoryDetails) onCategorySelected;
  final bool isSidebar;

  const CategoryList({
    super.key,
    required this.onCategorySelected,
    this.isSidebar = false,
  });

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  final CategoryController controller = Get.put(CategoryController());
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(color: Colors.red),
        );
      }

      if (controller.categories.isEmpty) {
        return const Center(child: Text("No categories found"));
      }

      return widget.isSidebar ? _buildVerticalList() : _buildHorizontalList();
    });
  }

  Widget _buildHorizontalList() {
    return Container(
      height: 125,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        itemCount: controller.categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 20),
        itemBuilder: (context, index) => _buildCategoryItem(index),
      ),
    );
  }

  Widget _buildVerticalList() {
    return Container(
      width: 70,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.separated(
        itemCount: controller.categories.length,
        separatorBuilder: (_, __) => const SizedBox(height: 30),
        itemBuilder: (context, index) => _buildCategoryItem(index),
      ),
    );
  }

  Widget _buildCategoryItem(int index) {
    final category = controller.categories[index];
    final bool isSelected = index == selectedIndex;

    return GestureDetector(
      onTap: () {
        setState(() => selectedIndex = index);
        widget.onCategorySelected(category);
      },
      child: Column(
        children: [
          Container(
            height: 40,
            width: 55,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? Colors.red : Colors.grey.shade300,
                width: 2,
              ),
            ),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: category.menuImage != null && category.menuImage!.isNotEmpty
                  ? NetworkImage(category.menuImage!)
                  : null,
              child: category.menuImage == null || category.menuImage!.isEmpty
                  ? Icon(Icons.fastfood, color: Colors.grey[400], size: 18)
                  : null,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            category.menuname ?? '',
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.nunito(
              fontSize: 9,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.black : Colors.grey[600],
            ),
          ),
          if (isSelected)
            Container(
              margin: const EdgeInsets.only(top: 6),
              height: 4,
              width: 4,
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