class OrderHistoryModel {
  final bool? success;
  final String? msg;
  final List<TableData>? data;

  OrderHistoryModel({this.success, this.msg, this.data});

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) => OrderHistoryModel(
    success: json["success"],
    msg: json["msg"],
    data: json["data"] != null
        ? List<TableData>.from(json["data"].map((x) => TableData.fromJson(x)))
        : [],
  );
}

class TableData {
  final int? tableId;
  final String? tableName;
  final List<OrderTableDetail>? orderTableDetails;

  TableData({this.tableId, this.tableName, this.orderTableDetails});

  factory TableData.fromJson(Map<String, dynamic> json) => TableData(
    tableId: json["tableId"],
    tableName: json["tableName"],
    orderTableDetails: json["orderTableDetails"] != null
        ? List<OrderTableDetail>.from(json["orderTableDetails"].map((x) => OrderTableDetail.fromJson(x)))
        : [],
  );
}

class OrderTableDetail {
  final int? orderTableId;
  final String? itemName;
  final String? menuCatName;
  final int? qty;
  final String? status;
  final String? mealType;
  final String? instruction;
  final String? orderTime; // API format ke hisaab se string

  OrderTableDetail({
    this.orderTableId,
    this.itemName,
    this.menuCatName,
    this.qty,
    this.status,
    this.mealType,
    this.instruction,
    this.orderTime,
  });

  factory OrderTableDetail.fromJson(Map<String, dynamic> json) => OrderTableDetail(
    orderTableId: json["orderTableId"],
    itemName: json["itemName"],
    menuCatName: json["menuCatName"],
    qty: json["qty"],
    status: json["status"],
    mealType: json["mealType"],
    instruction: json["instruction"],
    orderTime: json["orderTime"],
  );
}