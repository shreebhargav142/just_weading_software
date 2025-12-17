import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_weding_software/widgets/responsive_layout.dart';

class CategoryList extends StatefulWidget {
  final List<String> categories;
  final Function(int) onCategorySelected;

  const CategoryList({
    super.key,
    required this.categories,
    required this.onCategorySelected,
  });

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ResponsiveDiffLayout(
      MobileBody: _buildCategoryList(isTablet: false),
      TabletBody: _buildCategoryList(isTablet: true),
    );
  }


  Widget _buildCategoryList({required bool isTablet}) {

    double containerHeight = isTablet ? 160 : 125;
    double circleSize = isTablet ? 85 : 65;
    double fontSize = isTablet ? 16 : 11;
    double itemSpacing = isTablet ? 35 : 20;
    double paddingX = isTablet ? 30 : 15;
    double borderWidth = isTablet ? 3 : 2;
    double dotSize = isTablet ? 6 : 4;

    return Container(
      height: containerHeight,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: paddingX),
        itemCount: widget.categories.length,
        separatorBuilder: (_, __) => SizedBox(width: itemSpacing),
        itemBuilder: (context, index) {
          bool isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () {
              setState(() => selectedIndex = index);
              widget.onCategorySelected(index);
            },
            child: Column(
              children: [
                Container(
                  height: circleSize,
                  width: circleSize,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? Colors.red : Colors.grey.shade300,
                      width: borderWidth,
                    ),
                  ),
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                  ),
                ),

                Text(
                  widget.categories[index],
                  style: GoogleFonts.nunito(
                    fontSize: fontSize,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? Colors.black : Colors.grey[600],
                  ),
                ),

                if (isSelected)
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    height: dotSize,
                    width: dotSize,
                    decoration: const BoxDecoration(
                        color: Colors.red, shape: BoxShape.circle),
                  )
                else
                  SizedBox(height: dotSize + 6),
              ],
            ),
          );
        },
      ),
    );
  }
}