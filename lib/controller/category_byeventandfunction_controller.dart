import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/category_response_model.dart';
import '../services/api_service.dart';
import 'function_controller.dart';

class CategoryyController extends GetxController {
  final isLoading = true.obs;

  final categories = <MenuCategoryDetails>[].obs;
  final itemsByCategoryId = <int, List<ItemsDetails>>{}.obs;

  final RxInt selectedCategoryId = 0.obs;

  final FunctionController functionController =
  Get.find<FunctionController>();

  Future<void> fetchApiData(String eventId, String functionId) async {
    if (eventId == "0" || functionId == "0") return;

    try {
      isLoading(true);
      final response =
      await ApiService.fetchMenuData(eventId, functionId);

      categories.clear();
      itemsByCategoryId.clear();

      final data = response?.data ?? [];

      for (final entry in data) {
        if (entry.menuDetails != null) {
          final menu = entry.menuDetails!;
          categories.add(menu);
          itemsByCategoryId[menu.id!] =
              entry.itemDetails ?? [];
        }
      }

      if (categories.isNotEmpty) {
        selectedCategoryId.value = categories.first.id ?? 0;
      }
    } catch (e) {
      debugPrint("CategoryController Error: $e");
    } finally {
      isLoading(false);
    }
  }

  List<ItemsDetails> getItemsByCategoryId(int categoryId) {
    return itemsByCategoryId[categoryId] ?? [];
  }
}

