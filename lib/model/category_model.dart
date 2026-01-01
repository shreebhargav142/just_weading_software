class MenuCategoryModel {
  String? msg;
  Data? data;
  bool? success;

  MenuCategoryModel({this.msg, this.data, this.success});

  MenuCategoryModel.fromJson(Map<String, dynamic> json) {
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
  List<MenuCategoryDetails>? menuCategoryDetails;

  Data({this.menuCategoryDetails});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['menuCategoryDetails'] != null) {
      menuCategoryDetails = <MenuCategoryDetails>[];
      json['menuCategoryDetails'].forEach((v) {
        menuCategoryDetails!.add(new MenuCategoryDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.menuCategoryDetails != null) {
      data['menuCategoryDetails'] =
          this.menuCategoryDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MenuCategoryDetails {
  int? id;
  String? menuname;
  String? menunamelanguage;
  String? menuslogan;
  double? price;
  double? isActive;
  String? menuImage;
  int? isMenuHasSepItem;
  int? databaseId;
  int? clientuserId;

  MenuCategoryDetails(
      {this.id,
        this.menuname,
        this.menunamelanguage,
        this.menuslogan,
        this.price,
        this.isActive,
        this.menuImage,
        this.isMenuHasSepItem,
        this.databaseId,
        this.clientuserId});

  MenuCategoryDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    menuname = json['menuname'];
    menunamelanguage = json['menunamelanguage'];
    menuslogan = json['menuslogan'];
    price = json['price'];
    isActive = json['isActive'];
    menuImage = json['menuImage'];
    isMenuHasSepItem = json['isMenuHasSepItem'];
    databaseId = json['database_id'];
    clientuserId = json['clientuser_id'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['menuname'] = this.menuname;
    data['menunamelanguage'] = this.menunamelanguage;
    data['menuslogan'] = this.menuslogan;
    data['price'] = this.price;
    data['isActive'] = this.isActive;
    data['menuImage'] = this.menuImage;
    data['isMenuHasSepItem'] = this.isMenuHasSepItem;
    data['database_id'] = this.databaseId;
    data['clientuser_id'] = this.clientuserId;
    return data;
  }
}
