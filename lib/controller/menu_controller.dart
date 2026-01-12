import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/menuitem_model.dart';
import '../services/api_service.dart';
import '../view/screens/order_history_screen.dart';
import 'auth_controller.dart';
import 'function_controller.dart';

class EventMenuController extends GetxController {
  final ApiService _apiService = ApiService();

  final isMenuLoading = true.obs;
  final isTableLoading = false.obs;
  final errorMessage = ''.obs;

  final tableList = <dynamic>[].obs;
  final selectedTableId = ''.obs;

  final menuData = Rxn<MenuItemModel>();
  final selectedCategoryId = 0.obs;
  final filteredItems = <ItemsDetails>[].obs;

  final quantities = <int, int>{}.obs;
  final isPlacingOrder = false.obs;

  final AuthController authController = Get.find<AuthController>();
  final FunctionController functionController = Get.put(FunctionController());

  @override
  void onInit() {
    super.onInit();
  }
  Future<void> loadEventMenu() async {
    final clientUserId =
    authController.user.value?.clientUserId;
    final eventId =
    functionController.selectedFunction.value?.eventId?.toString();
    final functionId =
    functionController.selectedFunction.value?.functionId?.toString();

    if (clientUserId == null || eventId == null || functionId == null) {
      debugPrint("EventMenu IDs not ready");
      return;
    }
    isMenuLoading(true);

    await Future.wait([
      fetchTables(clientUserId, eventId, functionId),
      _getEventMenu(eventId, functionId),
    ]);
  }

  Future<void> fetchTables(
      int clientUserId,
      String eventId,
      String functionId,
      ) async {
    try {
      final response = await _apiService.getAssignedTables(
        clientUserId,
        eventId,
        functionId,
      );

      if (response != null && response.isNotEmpty) {
        tableList.assignAll(response);
      } else {
        tableList.clear();
      }
    } catch (e) {
      debugPrint("fetchTables Error: $e");
    } finally {
      isTableLoading(false);
    }
  }

  Future<void> _getEventMenu(String eventId, String functionId) async {
    try {

      final response = await _apiService.fetchMenu(eventId, functionId);
      menuData.value = response;
      errorMessage('');

      final categories =
          menuData.value?.data?.eventMenuPlanDetails;
      if (categories != null && categories.isNotEmpty) {
        selectCategory(categories.first.menuCategoryId);
      }
    } catch (e) {
      errorMessage.value = "Failed to load menu: $e";
    } finally {
      isMenuLoading(false);
    }
  }

  void selectCategory(int? categoryId) {
    if (categoryId == null) return;

    selectedCategoryId.value = categoryId;

    final details =
        menuData.value?.data?.eventMenuPlanDetails;

    if (details != null && details.isNotEmpty) {
      final category = details.firstWhere(
            (e) => e.menuCategoryId == categoryId,
        orElse: () => details.first,
      );
      filteredItems.assignAll(category.itemsDetails ?? []);
    }
  }

  void updateQuantity(int itemId, int change) {
    final current = quantities[itemId] ?? 0;
    final updated = current + change;

    if (updated <= 0) {
      quantities.remove(itemId);
    } else {
      quantities[itemId] = updated;
    }
  }
  Future<void> placeOrder() async {
    if (quantities.isEmpty) {
      Get.snackbar("Cart Empty", "Please add items to place an order");
      return;
    }

    if (selectedTableId.value.isEmpty) {
      Get.snackbar("Table Required", "Please select a table before ordering");
      return;
    }

    final authController = Get.find<AuthController>();
    final functionController = Get.find<FunctionController>();

    final String? clientUserId =
    authController.user.value?.clientUserId?.toString();
    final String? eventId =
    functionController.selectedFunction.value?.eventId?.toString();
    final String? functionId =
    functionController.selectedFunction.value?.functionId?.toString();

    if (clientUserId == null || eventId == null || functionId == null) {
      Get.snackbar("Error", "Event / Function not selected");
      return;
    }

    try {
      isPlacingOrder(true);

      final List<Map<String, dynamic>> itemsList = [];

      for (final item in selectedCartItems) {
        int menuCatId = 0;
        String menuCatName = "";

        final categories = menuData.value?.data?.eventMenuPlanDetails;
        if (categories != null) {
          for (final category in categories) {
            final containsItem = category.itemsDetails
                ?.any((i) => i.itemId == item.itemId) ??
                false;

            if (containsItem) {
              menuCatId = category.menuCategoryId ?? 0;
              menuCatName = category.menuName ?? "";
              break;
            }
          }
        }

        itemsList.add({
          "itemId": item.itemId,
          "itemName": item.itemName ?? "",
          "qty": quantities[item.itemId] ?? 0,
          "instruction": "",
          "mealType": "Normal",
          "menuCatId": menuCatId,
          "menuCatName": menuCatName,
        });
      }

      final Map<String, dynamic> orderBody = {
        "clientUserId": clientUserId,
        "eventId": eventId,
        "functionId": functionId,
        "tableId": int.tryParse(selectedTableId.value) ?? 0,
        "itemDetails": itemsList,
      };

      final response = await _apiService.addOrderTable(orderBody);

      if (response != null && response['success'] == true) {
        quantities.clear();

        Get.snackbar(
          "Success",
          response['msg'] ?? "Order placed successfully!",
          snackPosition: SnackPosition.BOTTOM,
        );

        Future.delayed(const Duration(milliseconds: 600), () {
          Get.to(() => const OrderHistoryScreen());
        });
      } else {
        Get.snackbar(
          "Error",
          response?['msg'] ?? "Failed to place order",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
      debugPrint("placeOrder error: $e");
    } finally {
      isPlacingOrder(false);
    }
  }


  void clearCart() {
    quantities.clear();
  }

  List<ItemsDetails> get selectedCartItems {
    final allItems = <ItemsDetails>[];
    menuData.value?.data?.eventMenuPlanDetails?.forEach((c) {
      allItems.addAll(c.itemsDetails ?? []);
    });
    return allItems
        .where((item) => quantities.containsKey(item.itemId))
        .toList();
  }

  int get totalCartItemsCount =>
      quantities.values.fold(0, (sum, qty) => sum + qty);
}
