
class OrderRequestModel {
  final int clientUserId;
  final int eventId;
  final int functionId;
  final int tableId;
  final List<OrderItemDetail> itemDetails;

  OrderRequestModel({
    required this.clientUserId,
    required this.eventId,
    required this.functionId,
    required this.tableId,
    required this.itemDetails,
  });

  Map<String, dynamic> toJson() {
    return {
      "clientUserId": clientUserId,
      "eventId": eventId,
      "functionId": functionId,
      "tableId": tableId,
      "itemDetails": itemDetails.map((x) => x.toJson()).toList(),
    };
  }
}

class OrderItemDetail {
  final int itemId;
  final String itemName;
  final int qty;
  final String instruction;
  final String mealType;
  final int menuCatId;
  final String menuCatName;

  OrderItemDetail({
    required this.itemId,
    required this.itemName,
    required this.qty,
    required this.instruction,
    required this.mealType,
    required this.menuCatId,
    required this.menuCatName,
  });

  Map<String, dynamic> toJson() {
    return {
      "itemId": itemId,
      "itemName": itemName,
      "qty": qty,
      "instruction": instruction,
      "mealType": mealType,
      "menuCatId": menuCatId,
      "menuCatName": menuCatName,
    };
  }
}