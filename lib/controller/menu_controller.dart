import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/menuitem_model.dart';
import '../services/api_service.dart';
import '../view/screens/order_history_screen.dart';

class EventMenuController extends GetxController {
  final dynamic clientUserId;
  final dynamic eventId;
  final dynamic functionId;

  EventMenuController({
    required this.clientUserId,
    required this.eventId,
    required this.functionId,});
  final ApiService _apiService = ApiService();
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  var tableList = <dynamic>[].obs;
  var selectedTableId = ''.obs;
  var menuData = Rxn<MenuItemModel>();
  var selectedCategoryId = 0.obs;
  var filteredItems = <ItemsDetails>[].obs;

  var quantities = <int, int>{}.obs;


  @override
  void onInit() {
    super.onInit();
    getEventMenu();
    fetchTables();
  }
  var isPlacingOrder = false.obs;

  void fetchTables() async {
    try {
      isLoading(true);
      print("Fetching tables for User: $clientUserId, Event: $eventId, Function: $functionId");
      var response = await _apiService.getAssignedTables(
        clientUserId,
        eventId,
        functionId,
      );

      if (response != null ) {
        tableList.assignAll(response);
      } else {
        Get.snackbar("Error", "Could not find tables");
      }
    } catch (e) {
      debugPrint("Controller Error: $e");
    } finally {
      isLoading(false);
    }
  }

  // void placeOrder() async {
  //   if (quantities.isEmpty) {
  //     Get.snackbar("Cart Empty", "Please add items to place an order");
  //     return;
  //   }
  //
  //   try {
  //     isPlacingOrder(true);
  //
  //     List<Map<String, dynamic>> itemsList = [];
  //
  //     for (var item in selectedCartItems) {
  //       itemsList.add({
  //         "itemId": item.itemId,
  //         "itemName": item.itemName,
  //         "qty": quantities[item.itemId] ?? 0,
  //         "instruction": "",
  //         "mealType": "Normal",
  //         "menuCatId": "",
  //         "menuCatName": ""
  //       });
  //     }
  //
  //     Map<String, dynamic> orderBody = {
  //       "clientUserId": 472,
  //       "eventId": 471189,
  //       "functionId": 23265,
  //       "tableId": 74,
  //       "itemDetails": itemsList
  //     };
  //
  //     var response = await _apiService.addOrderTable(orderBody);
  //
  //     if (response['success'] == true) {
  //       quantities.clear();
  //       Get.snackbar("Success", response['msg'] ?? "Order placed successfully!",
  //           snackPosition: SnackPosition.BOTTOM);
  //     } else {
  //       Get.snackbar("Error", response['msg'] ?? "Failed to place order",
  //           backgroundColor: Colors.red, colorText: Colors.white);
  //     }
  //   } catch (e) {
  //     Get.snackbar("Error", "Something went wrong: $e");
  //   } finally {
  //     isPlacingOrder(false);
  //   }
  // }
  void placeOrder() async {
    if (quantities.isEmpty) {
      Get.snackbar("Cart Empty", "Please add items to place an order");
      return;
    }

    if (selectedTableId.value.isEmpty) {
      Get.snackbar("Table Required", "Please select a table before ordering");
      return;
    }

    try {
      isPlacingOrder(true);

      List<Map<String, dynamic>> itemsList = [];
      for (var item in selectedCartItems) {
        int dynamicCatId = 0;
        String dynamicCatName = "";

        final allCategories = menuData.value?.data?.eventMenuPlanDetails;
        if (allCategories != null) {
          for (var category in allCategories) {
            bool containsItem = category.itemsDetails?.any((i) => i.itemId == item.itemId) ?? false;
            if (containsItem) {
              dynamicCatId = category.menuCategoryId ?? 0;
              dynamicCatName = category.menuName ?? "";
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
          "menuCatId": dynamicCatId,
          "menuCatName": dynamicCatName
        });
      }

      Map<String, dynamic> orderBody = {
        "clientUserId": clientUserId,
        "eventId": eventId,
        "functionId": functionId,
        "tableId": int.tryParse(selectedTableId.value) ?? 0,
        "itemDetails": itemsList
      };

      // 4. API Call
      var response = await _apiService.addOrderTable(orderBody);

      if (response['success'] == true) {
        quantities.clear(); // Success par cart clear karein
        Get.snackbar("Success", response['msg'] ?? "Order placed successfully!",
            snackPosition: SnackPosition.BOTTOM);

        Future.delayed(const Duration(seconds: 1), () {
          Get.to(() => OrderHistoryScreen(

          ));
        });
      } else {
        Get.snackbar("Error", response['msg'] ?? "Failed to place order",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isPlacingOrder(false);
    }
  }
  void clearCart() {
    quantities.clear();
    print("Order Cancelled");
  }

  void selectCategory(int? categoryId) {
    if (categoryId == null) return;

    selectedCategoryId.value = categoryId;

    final details = menuData.value?.data?.eventMenuPlanDetails;

    if (details != null && details.isNotEmpty) {
      final category = details.firstWhere(
            (cat) => cat.menuCategoryId == categoryId,
        orElse: () => details[0],
      );
      filteredItems.assignAll(category.itemsDetails ?? []);
    }
  }

  void updateQuantity(int itemId, int change) {
    int currentQty = quantities[itemId] ?? 0;
    int newQty = currentQty + change;

    if (newQty <= 0) {
      quantities.remove(itemId);
    } else {
      quantities[itemId] = newQty;
    }

    print("Item $itemId quantity: ${quantities[itemId]}");
  }

  void getEventMenu() async {
    try {
      isLoading(true);
      var response = await _apiService.fetchMenu("471194", "23266");
      errorMessage('');
      menuData.value = response;

      if (menuData.value?.data?.eventMenuPlanDetails?.isNotEmpty ?? false) {
        selectCategory(menuData.value!.data!.eventMenuPlanDetails![0].menuCategoryId);
      }
    } catch (e) {
      errorMessage.value = "Failed to load menu: $e";
      print("Error: $e");
    } finally {
      isLoading(false);
    }
  }

  void toggleFavorite(int itemId) {
    menuData.refresh();
  }

 List<ItemsDetails> get selectedCartItems {
   List<ItemsDetails> allItems = [];

   menuData.value?.data?.eventMenuPlanDetails?.forEach((category) {
     if(category.itemsDetails!=null){
       allItems.addAll(category.itemsDetails!);

     }
   });
   return allItems.where((item)=>quantities.containsKey(item.itemId)).toList();
 }
 int get totalCartItemsCount =>quantities.values.fold(0, (sum, qty) => sum + qty);
}