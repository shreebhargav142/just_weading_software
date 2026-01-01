import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart' hide ResponsiveScreen;
import '../../controller/auth_controller.dart';
import '../../controller/function_controller.dart';
import '../../controller/order_history_controller.dart';
import '../../model/function_model.dart';
import '../../model/order_history_model.dart';
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
    final eventId =
        functionController.selectedFunction.value?.eventId ?? 471194;
    final functionId =
        functionController.selectedFunction.value?.functionId ?? 23266;

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
          onPressed: Get.back,
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

  // ------------------------------------------------------------
  // FUNCTION SELECTOR
  // ------------------------------------------------------------
  Widget _buildFunctionSelector(bool isTablet) {
    return Obx(() => Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select Function",
            style: GoogleFonts.nunito(
              fontSize: isTablet ? 16 : 14,
              fontWeight: FontWeight.w300,
            ),
          ),
          DropdownButtonHideUnderline(
            child: DropdownButton<FunctionManagerAssignDetails>(
              isExpanded: true,
              value: functionController.selectedFunction.value,
              items: functionController.functionList.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(
                    item.functionName ?? "",
                    style: GoogleFonts.nunito(
                      fontSize: isTablet ? 18 : 16,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                functionController.onFunctionChanged(value);
                historyController.fetchHistory(
                    historyController.selectedTab.value);
              },
            ),
          ),
        ],
      ),
    ));
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
      TableData table, int index, bool isCaptain, bool isTablet) {
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
      OrderTableDetail item, bool isCaptain, bool isTablet) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: isTablet ? 32 : 20,
        vertical: 5,
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
                _detail("Instruction", item.instruction),
                _detail("Meal Type", item.mealType),
                _detail("Quantity", "${item.qty ?? 0}"),
              ],
            ),
          ),
          _buildStatusBadge(item.status ?? "New", isCaptain),
        ],
      ),
    );
  }

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


  Widget _buildStatusBadge(String status, bool isCaptain) {
    Color color = switch (status) {
      "Create" || "New" => Colors.red,
      "InProgress" => Colors.orange,
      "Delivered" => Colors.green,
      _ => Colors.grey,
    };

    final badge = Container(
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
    );

    return isCaptain ? InkWell(child: badge) : badge;
  }
}
