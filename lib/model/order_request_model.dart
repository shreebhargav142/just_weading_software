class OrderRequest {
  final int clientUserId;
  final String eventId;
  final String functionId;
  final int tableId;
  final List<OrderItemDetail> itemDetails;

  OrderRequest({
    required this.clientUserId,
    required this.eventId,
    required this.functionId,
    required this.tableId,
    required this.itemDetails,
  });

  Map<String, dynamic> toJson() => {
    "clientUserId": clientUserId,
    "eventId": eventId,
    "functionId": functionId,
    "tableId": tableId,
    "itemDetails": itemDetails.map((x) => x.toJson()).toList(),
  };
}

class OrderItemDetail {
  final int itemId;
  final String itemName;
  final int qty;
  final String instruction;
  final String mealType;
  final String menuCatId;
  final String menuCatName;

  OrderItemDetail({
    required this.itemId,
    required this.itemName,
    required this.qty,
    this.instruction = "",
    this.mealType = "Normal",
    this.menuCatId = "",
    this.menuCatName = "",
  });

  Map<String, dynamic> toJson() => {
    "itemId": itemId,
    "itemName": itemName,
    "qty": qty,
    "instruction": instruction,
    "mealType": mealType,
    "menuCatId": menuCatId,
    "menuCatName": menuCatName,
  };
}