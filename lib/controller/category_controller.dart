import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../model/category_model.dart';
import '../services/api_service.dart';


class CategoryController extends GetxController {
  var isLoading = true.obs;

  var categories = <MenuCategoryDetails>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadCategories();
  }

  void loadCategories() async {
    try {
      isLoading(true);
      final response = await ApiService.getMenuCategory(400);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        print("API Response: $jsonData");

        if (jsonData['data'] != null && jsonData['data']['menuCategoryDetails'] != null) {
          final List list = jsonData['data']['menuCategoryDetails'];

          categories.assignAll(
            list.map((e) => MenuCategoryDetails.fromJson(e)).toList(),
          );

          print("Loaded ${categories.length} categories");
        } else {
          print("JSON structure mismatch: 'data' or 'menuCategoryDetails' not found");
        }
      } else {
        print("Server Error: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error loading categories: $e");
    } finally {
      isLoading(false);
    }
  }}
