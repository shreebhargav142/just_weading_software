import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart' hide ResponsiveScreen;
import 'package:just_weding_software/view/home_screen.dart';
import '../../controller/auth_controller.dart';
import '../../controller/function_controller.dart';
import '../../controller/order_history_controller.dart';
import '../../model/function_model.dart' hide Data;
import '../../model/order_history_model.dart';
import '../../utils/date_utils.dart';
import '../../widgets/responsive_screen.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  late final FunctionController functionController;
  late final OrderHistoryController historyController;
  final authController = Get.find<AuthController>();

  final List<String> statusTabs = ["New", "In Progress", "Delivered", "All"];

  @override
  void initState() {
    super.initState();
    functionController = Get.find<FunctionController>();
    final clientId = authController.user.value?.clientUserId ?? 504;
    final eventId = functionController.selectedFunction.value?.eventId ?? 471194;
    final functionId = functionController.selectedFunction.value?.functionId ?? 23266;

    if (Get.isRegistered<OrderHistoryController>()) {
      Get.delete<OrderHistoryController>();
    }
    historyController = Get.put(
      OrderHistoryController(
        clientId: clientId,
        eventId: eventId,
        functionId: functionId,
        isCaptain: authController.isCaptain,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isTablet = width >= 600;
    final isCaptain = authController.isCaptain;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Get.offAll(() => HomeScreen()),
          icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
        ),
        title: Text(
          "Order History",
          style: GoogleFonts.nunito(
            fontSize: isTablet ? 22 : 19,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: ResponsiveScreen(
        maxWidth: isTablet ? 900 : double.infinity,
        padding: EdgeInsets.only(
          left: isTablet ? 24 : 16,
          right: isTablet ? 24 : 16,
          top: isTablet? 20 : 10,
        ),
        child: Column(
          children: [
            _buildFunctionSelector(isTablet),
            _buildTabSelector(isTablet),
            Expanded(child: _buildOrderList(isCaptain, isTablet)),
          ],
        ),
      ),
    );
  }
  Widget _buildFunctionSelector(bool isTablet) {
    return GestureDetector(
      onTap: _openFunctionSelectorDialog,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(() {
            final f = functionController.selectedFunction.value;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Select Function",
                  style: GoogleFonts.nunito(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  f == null
                      ? "Tap to choose"
                      :"${f.functionName}",
                  style: GoogleFonts.nunito(
                    fontSize: isTablet ? 17 : 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            );
          }),
          const Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
  void _openFunctionSelectorDialog() {
    final tempSelected =
    Rx<FunctionManagerAssignDetails?>(
      functionController.selectedFunction.value,
    );
    Get.dialog(
      Center(
        child: ResponsiveScreen(
          maxWidth: MediaQuery.of(context).size.width >= 600 ? 600 : 360,
          padding: const EdgeInsets.all(0),
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Select Function",
                      style: GoogleFonts.nunito(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Divider(),
                  Flexible(
                    child: Obx(() => ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                      functionController.functionList.length,
                      itemBuilder: (_, index) {
                        final item =
                        functionController.functionList[index];

                        final isSelected =
                            tempSelected.value?.functionId ==
                                item.functionId;

                        return InkWell(
                          onTap: () => tempSelected.value = item,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            margin:
                            const EdgeInsets.symmetric(vertical: 6),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Colors.grey.shade200
                              ),
                              borderRadius:
                              BorderRadius.circular(12),
                              color:  Colors.white,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Event Name : ${item.eventName ?? ''}",
                                        style: GoogleFonts.nunito(
                                            fontWeight:
                                            FontWeight.w600),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "Function Name : ${item.functionName ?? ''}",
                                        style:
                                        GoogleFonts.nunito( fontWeight:
                                        FontWeight.w600),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "Date : ${formatDate(item.startTime)}",
                                        style: GoogleFonts.nunito(
                                            fontWeight: FontWeight.w600                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (isSelected)
                                  const Icon(Icons.check_circle,
                                      color: Colors.green),
                              ],
                            ),
                          ),
                        );
                      },
                    )),
                  ),
                  const Divider(),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child:
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(8),
                              side:  BorderSide(
                                color: Colors.grey.shade200,
                                width: 1,)
                            ),
                          ),
                          onPressed: () {
                            Get.back();
                          },
                          child: Text(
                            "Close",
                            style: TextStyle(fontWeight: FontWeight.w400,color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child:
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            if (tempSelected.value != null) {
                              functionController.onFunctionChanged(
                                  tempSelected.value);
                              historyController.fetchHistory(
                                  historyController.selectedTab.value);
                            }
                            Get.back();
                          },
                          child: const Text(
                            "Done",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.4),
    );
  }
  Widget _buildTabSelector(bool isTablet) {
    return Container(
      height: isTablet ? 70 : 60,
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFE0E0E0),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Obx(() => Row(
          children: List.generate(statusTabs.length, (index) {
            final tab = statusTabs[index];
            final isSelected =
                historyController.selectedTab.value == tab;

            return Expanded(
              child: GestureDetector(
                onTap: () => historyController.fetchHistory(tab),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: isSelected
                        ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                      )
                    ]
                        : [],
                  ),
                  child: Text(
                    tab,
                    style: GoogleFonts.nunito(
                      fontSize: isTablet ? 15 : 13,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          }),
        )),
      ),
    );
  }
  Widget _buildOrderList(bool isCaptain, bool isTablet) {
    return Obx(() {
      if (historyController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (historyController.tableOrders.isEmpty) {
        return const Center(child: Text("No Orders Found"));
      }

      return ListView.builder(
        itemCount: historyController.tableOrders.length,
        itemBuilder: (_, index) {
          return _buildTableCard(
            historyController.tableOrders[index],
            index,
            isCaptain,
            isTablet,
          );
        },
      );
    });
  }
  Widget _buildTableCard(
      Data table, int index, bool isCaptain, bool isTablet) {
    return Obx(() {
      final expanded = historyController.expandedTableIndex.value == index;

      return Column(
        children: [
          GestureDetector(
            onTap: () {
              historyController.expandedTableIndex.value =
              expanded ? -1 : index;
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              padding: EdgeInsets.symmetric(
                horizontal: isTablet ? 20 : 16,
                vertical: isTablet ? 18 : 15,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black26),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    table.tableName ?? "",
                    style: GoogleFonts.nunito(
                      fontSize: isTablet ? 18 : 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    expanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
          if (expanded)
            Column(
              children: table.orderTableDetails!
                  .map((e) =>
                  _buildOrderItem(e, isCaptain, isTablet))
                  .toList(),
            ),
        ],
      );
    });
  }

  Widget _buildOrderItem(
      OrderTableDetails item, bool isCaptain, bool isTablet) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: isTablet ? 20 : 2,
        vertical: isTablet ? 18 : 15,
      ),
      padding: EdgeInsets.all(isTablet ? 20 : 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _detail("Category", item.menuCatName),
                _detail("Item", item.itemName),
                _detail("Quantity", "${item.qty ?? 0}"),
                _detail("Instruction", item.instruction),
                _detail("Meal Type", item.mealType),
                _detail("Order Time", "${item.time} min ago"),
              ],
            ),
          ),
          _buildStatusBadge(item.status ?? "New", isCaptain, item.orderTableId),
        ],
      ),
    );}

  Widget _detail(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: RichText(
        text: TextSpan(
          style: GoogleFonts.nunito(fontSize: 14, color: Colors.black),
          children: [
            TextSpan(
              text: "$label : ",
              style: const TextStyle(color: Colors.grey),
            ),
            TextSpan(
              text: value ?? "",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status, bool isCaptain, int? orderTableId) {
    Color color = switch (status) {
      "Create" || "New" => Colors.red,
      "InProgress" => Colors.orange,
      "Delivered" => Colors.green,
      _ => Colors.grey,
    };

    return InkWell(
      onTap: isCaptain ? () => _showStatusActionSheet(orderTableId, status) : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color),
        ),
        child: Text(
          status == "Create" ? "New" : status,
          style: GoogleFonts.nunito(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  void _showStatusActionSheet(int? orderId, String currentStatus) {
    if (orderId == null) return;

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Update Status", style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),

            if (currentStatus == "Create" || currentStatus == "New")
              _statusTile("InProgress", "Move to In Progress", Colors.orange, orderId),
            if (currentStatus == "InProgress")
              _statusTile("Delivered", "Mark as Delivered", Colors.green, orderId),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _statusTile(String apiValue, String label, Color color, int orderId) {
    return ListTile(
      leading: Icon(Icons.sync, color: color),
      title: Text(label, style: GoogleFonts.nunito(fontWeight: FontWeight.w600)),
      onTap: () {
        Get.back();
        historyController.updateStatus(orderId, apiValue);
      },
    );
  }
}
