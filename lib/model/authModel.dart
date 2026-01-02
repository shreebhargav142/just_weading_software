class AuthModel {
  String? msg;
  Data? data;
  bool? success;

  AuthModel({this.msg, this.data, this.success});

  AuthModel.fromJson(Map<String, dynamic> json) {
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

  Data({this.clientUserDetails});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['clientUserDetails'] != null) {
      clientUserDetails = <ClientUserDetails>[];
      json['clientUserDetails'].forEach((v) {
        clientUserDetails!.add(new ClientUserDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.clientUserDetails != null) {
      data['clientUserDetails'] =
          this.clientUserDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClientUserDetails {
  int? clientUserId;
  String? companyName;
  String? cityName;
  String? companyAddress;
  int? clientId;
  String? companyEmail;
  String? mobileNo;
  String? userName;
  String? category;
  String? emailId;
  String? imgUrl;
  String? pdfUrl;

  ClientUserDetails(
      {this.clientUserId,
        this.companyName,
        this.cityName,
        this.companyAddress,
        this.clientId,
        this.companyEmail,
        this.mobileNo,
        this.userName,
        this.category,
        this.emailId,
        this.imgUrl,
        this.pdfUrl
      });

  ClientUserDetails.fromJson(Map<String, dynamic> json) {
    clientUserId = json['clientUserId'];
    companyName = json['companyName'];
    cityName = json['cityName'];
    companyAddress = json['companyAddress'];
    clientId = json['clientId'];
    companyEmail = json['companyEmail'];
    mobileNo = json['mobileNo'];
    userName = json['userName'];
    category = json['category'];
    emailId = json['emailId'];
    imgUrl = json['imgUrl'];
    pdfUrl=json['pdfUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clientUserId'] = this.clientUserId;
    data['companyName'] = this.companyName;
    data['cityName'] = this.cityName;
    data['companyAddress'] = this.companyAddress;
    data['clientId'] = this.clientId;
    data['companyEmail'] = this.companyEmail;
    data['mobileNo'] = this.mobileNo;
    data['userName'] = this.userName;
    data['category'] = this.category;
    data['emailId'] = this.emailId;
    data['imgUrl'] = this.imgUrl;
    data['pdfUrl'] = this.pdfUrl;
    return data;
  }
}
