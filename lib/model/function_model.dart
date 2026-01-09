class FunctionModel {
  String? msg;
  Data? data;
  bool? success;

  FunctionModel({this.msg, this.data, this.success});

  FunctionModel.fromJson(Map<String, dynamic> json) {
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
  List<FunctionManagerAssignDetails>? functionManagerAssignDetails;

  Data({this.functionManagerAssignDetails});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['FunctionManagerAssignDetails'] != null) {
      functionManagerAssignDetails = <FunctionManagerAssignDetails>[];
      json['FunctionManagerAssignDetails'].forEach((v) {
        functionManagerAssignDetails!
            .add(new FunctionManagerAssignDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.functionManagerAssignDetails != null) {
      data['FunctionManagerAssignDetails'] =
          this.functionManagerAssignDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FunctionManagerAssignDetails {
  int? functionAssignId;
  int? clientUserId;
  String? clientUserName;
  String? eventId;
  String? eventName;
  String? functionId;
  String? functionName;
  String? startTime;
  String? endTime;
  String? imgUrl;

  FunctionManagerAssignDetails(
      {this.functionAssignId,
        this.clientUserId,
        this.clientUserName,
        this.eventId,
        this.eventName,
        this.functionId,
        this.functionName,
        this.startTime,
        this.endTime,
        this.imgUrl});

  FunctionManagerAssignDetails.fromJson(Map<String, dynamic> json) {
    functionAssignId = json['functionAssignId'];
    clientUserId = json['clientUserId'];
    clientUserName = json['clientUserName'];
    eventId = json['eventId']?.toString();
    eventName = json['eventName'];
    functionId = json['functionId']?.toString();
    functionName = json['functionName'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    imgUrl = json['imgUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['functionAssignId'] = this.functionAssignId;
    data['clientUserId'] = this.clientUserId;
    data['clientUserName'] = this.clientUserName;
    data['eventId'] = this.eventId;
    data['eventName'] = this.eventName;
    data['functionId'] = this.functionId;
    data['functionName'] = this.functionName;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['imgUrl'] = this.imgUrl;
    return data;
  }
}
