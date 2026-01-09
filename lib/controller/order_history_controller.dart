import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/authModel.dart';
import '../services/api_service.dart';

class OrderHistoryController extends GetxController {
  String? clientUserId;
  String? eventId;
  String? functionId;
  final bool isCaptain;

  OrderHistoryController({
    required this.isCaptain,
  });

  final isLoading = false.obs;
  final tableOrders = <Data>[].obs;
  final selectedTab = "New".obs;
  final expandedTableIndex = (-1).obs;

  /// 🔁 IDs baad me set honge
  void updateContext({
    required String clientUserId,
    required String eventId,
    required String functionId,
  }) {
    this.clientUserId = clientUserId;
    this.eventId = eventId;
    this.functionId = functionId;

    fetchHistory(selectedTab.value);
  }

  @override
  void onInit() {
    super.onInit();
    // ❌ YAHAN API CALL NAHI
  }

  Future<void> fetchHistory(String tabName) async {
    if (clientUserId == null || eventId == null || functionId == null) {
      debugPrint("⛔ OrderHistory IDs not ready");
      return;
    }

    try {
      isLoading.value = true;
      selectedTab.value = tabName;

      final apiStatus = _mapUiStatusToApi(tabName);

      final result = await ApiService().getOrderHistoryByStatus(
        clientUserId!,
        eventId!,
        functionId!,
        apiStatus,
      );
      final List<Data> dataList = (result?.success == true && result?.data != null)
          ? List<Data>.from(result!.data!)
          : <Data>[];

      if (result?.success == true) {

        tableOrders.assignAll(
          _applyRoleFilter(dataList),
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
        Get.snackbar("Success", "Status updated to $newStatus");
        fetchHistory(selectedTab.value);
      }
    } catch (e) {
      debugPrint("Update Status Error: $e");
    }
  }

  String _mapUiStatusToApi(String tab) {
    switch (tab) {
      case "New":
        return "New";
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

  List<Data> _applyRoleFilter(List<Data> data) {
    if (isCaptain) {
      return data;
    }

    return data;
  }
}
