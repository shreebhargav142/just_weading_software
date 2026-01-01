class CaptainModel {
  String? msg;
  Data? data;
  bool? success;

  CaptainModel({this.msg, this.data, this.success});

  CaptainModel.fromJson(Map<String, dynamic> json) {
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
  List<ClientUserDetails>? clientUserDetails;
  String? moduleName;
  int? moduleId;
  String? fileType;

  Data({this.clientUserDetails, this.moduleName, this.moduleId, this.fileType});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['clientUserDetails'] != null) {
      clientUserDetails = <ClientUserDetails>[];
      json['clientUserDetails'].forEach((v) {
        clientUserDetails!.add(new ClientUserDetails.fromJson(v));
      });
    }
    moduleName = json['moduleName'];
    moduleId = json['moduleId'];
    fileType = json['fileType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.clientUserDetails != null) {
      data['clientUserDetails'] =
          this.clientUserDetails!.map((v) => v.toJson()).toList();
    }
    data['moduleName'] = this.moduleName;
    data['moduleId'] = this.moduleId;
    data['fileType'] = this.fileType;
    return data;
  }
}

class ClientUserDetails {
  int? clientUserId;
  String? companyName;
  String? cityName;
  int? clientId;
  String? companyEmail;
  String? mobileNo;
  String? userName;
  String? emailId;
  int? age;
  String? clientCategory;

  ClientUserDetails(
      {this.clientUserId,
        this.companyName,
        this.cityName,
        this.clientId,
        this.companyEmail,
        this.mobileNo,
        this.userName,
        this.emailId,
        this.age,
        this.clientCategory});

  ClientUserDetails.fromJson(Map<String, dynamic> json) {
    clientUserId = json['clientUserId'];
    companyName = json['companyName'];
    cityName = json['cityName'];
    clientId = json['clientId'];
    companyEmail = json['companyEmail'];
    mobileNo = json['mobileNo'];
    userName = json['userName'];
    emailId = json['emailId'];
    age = json['age'];
    clientCategory = json['clientCategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clientUserId'] = this.clientUserId;
    data['companyName'] = this.companyName;
    data['cityName'] = this.cityName;
    data['clientId'] = this.clientId;
    data['companyEmail'] = this.companyEmail;
    data['mobileNo'] = this.mobileNo;
    data['userName'] = this.userName;
    data['emailId'] = this.emailId;
    data['age'] = this.age;
    data['clientCategory'] = this.clientCategory;
    return data;
  }
}
