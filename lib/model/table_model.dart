class TableModel {
  String? msg;
  Data? data;
  bool? success;

  TableModel({this.msg, this.data, this.success});

  TableModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['success'] = this.success;
    return data;
  }
}

class Data {
  List<ManagerTableAssignDetails>? managerTableAssignDetails;

  Data({this.managerTableAssignDetails});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['managerTableAssignDetails'] != null) {
      managerTableAssignDetails = <ManagerTableAssignDetails>[];
      json['managerTableAssignDetails'].forEach((v) {
        managerTableAssignDetails!
            .add(new ManagerTableAssignDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.managerTableAssignDetails != null) {
      data['managerTableAssignDetails'] =
          this.managerTableAssignDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ManagerTableAssignDetails {
  int? tableAssignId;
  int? clientUserId;
  int? tableId;
  int? eventId;
  int? functionId;
  int? functionAssignId;
  String? clientUserName;
  String? tableName;
  String? eventName;
  String? functionName;
  String? imgUrl;

  ManagerTableAssignDetails(
      {this.tableAssignId,
        this.clientUserId,
        this.tableId,
        this.eventId,
        this.functionId,
        this.functionAssignId,
        this.clientUserName,
        this.tableName,
        this.eventName,
        this.functionName,
        this.imgUrl});

  ManagerTableAssignDetails.fromJson(Map<String, dynamic> json) {
    tableAssignId = json['tableAssignId'];
    clientUserId = json['clientUserId'];
    tableId = json['tableId'];
    eventId = json['eventId'];
    functionId = json['functionId'];
    functionAssignId = json['functionAssignId'];
    clientUserName = json['clientUserName'];
    tableName = json['tableName'];
    eventName = json['eventName'];
    functionName = json['functionName'];
    imgUrl = json['imgUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tableAssignId'] = this.tableAssignId;
    data['clientUserId'] = this.clientUserId;
    data['tableId'] = this.tableId;
    data['eventId'] = this.eventId;
    data['functionId'] = this.functionId;
    data['functionAssignId'] = this.functionAssignId;
    data['clientUserName'] = this.clientUserName;
    data['tableName'] = this.tableName;
    data['eventName'] = this.eventName;
    data['functionName'] = this.functionName;
    data['imgUrl'] = this.imgUrl;
    return data;
  }
}
