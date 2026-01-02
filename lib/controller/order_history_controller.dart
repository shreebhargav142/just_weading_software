// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../model/order_history_model.dart';
// import '../services/api_service.dart';
//
// class OrderHistoryController extends GetxController {
//   final dynamic clientId, eventId, functionId;
//   final bool isCaptain;
//   OrderHistoryController({this.clientId, this.eventId, this.functionId,required this.isCaptain});
//
//   var isLoading = false.obs;
//   var tableOrders = <TableData>[].obs;
//   var selectedTab = "New".obs;
//   var expandedTableIndex = 0.obs;
//
//
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchHistory("New"); // Pehla load
//   }
//
//
//   void fetchHistory(String tabName) async {
//     try {
//       isLoading(true);
//       selectedTab.value = tabName;
//
//       // Mapping UI names to API names
//       String apiStatus = tabName;
//       if (tabName == "New") apiStatus = "Create";
//       if (tabName == "In Progress") apiStatus = "InProgress"; // Backend often hates spaces
//
//       var result = await ApiService().getOrderHistoryByStatus(
//           clientId, eventId, functionId, apiStatus);
//
//       if (result != null && result.success == true) {
//         tableOrders.assignAll(_applyRoleFilter(result.data ?? []));
//       } else {
//         tableOrders.clear();
//       }
//     } catch (e) {
//       debugPrint("Fetch Error: $e");
//     } finally {
//       isLoading(false);
//     }
//   }
//   // void fetchHistory(String tabName) async {
//   //   try {
//   //     isLoading(true);
//   //     selectedTab.value = tabName;
//   //
//   //     var result = await ApiService().getOrderHistoryByStatus(
//   //         clientId, eventId, functionId, tabName);
//   //
//   //     if (result != null && result.success == true) {
//   //       tableOrders.assignAll(_applyRoleFilter(result.data ?? []));
//   //     } else {
//   //       tableOrders.clear();
//   //     }
//   //   } finally {
//   //     isLoading(false);
//   //   }
//   // }
//   Future<void> updateStatus(int orderTableId, String newStatus) async {
//     try {
//       var response = await ApiService().changeOrderStatus(orderTableId, newStatus);
//
//       if (response != null && response['success'] == true) {
//         Get.snackbar(
//           "Success",
//           "Status updated to $newStatus",
//           backgroundColor: Colors.green,
//           colorText: Colors.white,
//         );
//
//         fetchHistory(selectedTab.value);
//       } else {
//         Get.snackbar("Error", "Failed to update status");
//       }
//     } catch (e) {
//       debugPrint("Update Status Error: $e");
//     }
//   }
//   List<TableData> _applyRoleFilter(List<TableData> data) {
//     return data;
//   }
// }
//
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/order_history_model.dart';
import '../services/api_service.dart';

class OrderHistoryController extends GetxController {
  final dynamic clientId, eventId, functionId;
  final bool isCaptain;

  OrderHistoryController({
    this.clientId,
    this.eventId,
    this.functionId,
    required this.isCaptain,
  });

  final isLoading = false.obs;
  final tableOrders = <TableData>[].obs;
  final selectedTab = "New".obs;
  final expandedTableIndex = (-1).obs;

  @override
  void onInit() {
    super.onInit();
    fetchHistory("New");
  }

  Future<void> fetchHistory(String tabName) async {
    try {
      isLoading.value = true;
      selectedTab.value = tabName;

      final apiStatus = _mapUiStatusToApi(tabName);

      final result = await ApiService().getOrderHistoryByStatus(
        clientId,
        eventId,
        functionId,
        apiStatus,
      );

      if (result?.success == true) {
        tableOrders.assignAll(
          _applyRoleFilter(result?.data ?? []),
        );
      } else {
        tableOrders.clear();
      }
    } catch (e) {
      debugPrint("OrderHistory fetch error: $e");
      tableOrders.clear();
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> updateStatus(int orderTableId, String newStatus) async {
    try {
      final response =
      await ApiService().changeOrderStatus(orderTableId, newStatus);

      if (response != null && response['success'] == true) {
        Get.snackbar(
          "Success",
          "Status updated to $newStatus",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Refresh current tab
        fetchHistory(selectedTab.value);
      } else {
        Get.snackbar("Error", "Failed to update status");
      }
    } catch (e) {
      debugPrint("Update Status Error: $e");
    }
  }

  String _mapUiStatusToApi(String tab) {
    switch (tab) {
      case "New":
        return "Create";
      case "In Progress":
        return "InProgress";
      case "Delivered":
        return "Delivered";
      case "All":
        return "All";
      default:
        return tab;
    }
  }

  List<TableData> _applyRoleFilter(List<TableData> data) {
    return data;
  }
}
