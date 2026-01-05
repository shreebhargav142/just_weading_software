class OrderHistoryModel {
  String? msg;
  List<Data>? data;
  bool? success;

  OrderHistoryModel({this.msg, this.data, this.success});

  OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    return data;
  }
}

class Data {
  int? tableId;
  String? tableName;
  List<OrderTableDetails>? orderTableDetails;

  Data({this.tableId, this.tableName, this.orderTableDetails});

  Data.fromJson(Map<String, dynamic> json) {
    tableId = json['tableId'];
    tableName = json['tableName'];
    if (json['orderTableDetails'] != null) {
      orderTableDetails = <OrderTableDetails>[];
      json['orderTableDetails'].forEach((v) {
        orderTableDetails!.add(new OrderTableDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tableId'] = this.tableId;
    data['tableName'] = this.tableName;
    if (this.orderTableDetails != null) {
      data['orderTableDetails'] =
          this.orderTableDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderTableDetails {
  int? orderTableId;
  int? tableId;
  String? tableName;
  String? memberName;
  int? itemId;
  String? itemName;
  String? itemImage;
  String? createdDatetime;
  int? qty;
  String? status;
  int? time;
  String? instruction;
  String? mealType;
  int? menuCatId;
  String? menuCatName;

  OrderTableDetails(
      {this.orderTableId,
        this.tableId,
        this.tableName,
        this.memberName,
        this.itemId,
        this.itemName,
        this.itemImage,
        this.createdDatetime,
        this.qty,
        this.status,
        this.time,
        this.instruction,
        this.mealType,
        this.menuCatId,
        this.menuCatName});

  OrderTableDetails.fromJson(Map<String, dynamic> json) {
    orderTableId = json['orderTableId'];
    tableId = json['tableId'];
    tableName = json['tableName'];
    memberName = json['memberName'];
    itemId = json['itemId'];
    itemName = json['itemName'];
    itemImage = json['itemImage'];
    createdDatetime = json['createdDatetime'];
    qty = json['qty'];
    status = json['status'];
    time = json['time'];
    instruction = json['instruction'];
    mealType = json['mealType'];
    menuCatId = json['menuCatId'];
    menuCatName = json['menuCatName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderTableId'] = this.orderTableId;
    data['tableId'] = this.tableId;
    data['tableName'] = this.tableName;
    data['memberName'] = this.memberName;
    data['itemId'] = this.itemId;
    data['itemName'] = this.itemName;
    data['itemImage'] = this.itemImage;
    data['createdDatetime'] = this.createdDatetime;
    data['qty'] = this.qty;
    data['status'] = this.status;
    data['time'] = this.time;
    data['instruction'] = this.instruction;
    data['mealType'] = this.mealType;
    data['menuCatId'] = this.menuCatId;
    data['menuCatName'] = this.menuCatName;
    return data;
  }
}
