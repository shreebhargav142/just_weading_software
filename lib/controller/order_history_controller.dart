import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/order_history_model.dart';
import '../services/api_service.dart';

class OrderHistoryController extends GetxController {
  final dynamic clientId, eventId, functionId;
  final bool isCaptain;
  OrderHistoryController({this.clientId, this.eventId, this.functionId,required this.isCaptain});

  var isLoading = false.obs;
  var tableOrders = <TableData>[].obs;
  var selectedTab = "New".obs;
  var expandedTableIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchHistory("New"); // Pehla load
  }

  void fetchHistory(String tabName) async {
    try {
      isLoading(true);
      selectedTab.value = tabName;
      var result = await ApiService().getOrderHistoryByStatus(
          clientId, eventId, functionId, tabName);

      if (result != null && result.success == true) {
        tableOrders.assignAll(_applyRoleFilter(result.data ?? []));
      } else {
        tableOrders.clear();
      }
    } finally {
      isLoading(false);
    }
  }
  Future<void> updateStatus(int orderTableId, String newStatus) async {
    try {
      var response = await ApiService().changeOrderStatus(orderTableId, newStatus);

      if (response != null && response['success'] == true) {
        Get.snackbar(
          "Success",
          "Status updated to $newStatus",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        fetchHistory(selectedTab.value);
      } else {
        Get.snackbar("Error", "Failed to update status");
      }
    } catch (e) {
      debugPrint("Update Status Error: $e");
    }
  }
  List<TableData> _applyRoleFilter(List<TableData> data) {
    return data;
  }
}

