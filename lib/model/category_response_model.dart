class CategoryResponse {
  bool? success;
  String? msg;
  List<CategoryData>? data;

  CategoryResponse({this.success, this.msg, this.data});

  CategoryResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <CategoryData>[];
      json['data'].forEach((v) {
        data!.add(CategoryData.fromJson(v));
      });
    }
  }
}

class CategoryData {
  MenuCategoryDetails? menuDetails;
  List<ItemsDetails>? itemDetails;

  CategoryData({this.menuDetails, this.itemDetails});

  CategoryData.fromJson(Map<String, dynamic> json) {
    menuDetails = json['menuDetails'] != null
        ? MenuCategoryDetails.fromJson(json['menuDetails'])
        : null;
    if (json['itemDetails'] != null) {
      itemDetails = <ItemsDetails>[];
      json['itemDetails'].forEach((v) {
        itemDetails!.add(ItemsDetails.fromJson(v));
      });
    }
  }
}

class MenuCategoryDetails {
  int? id;
  String? menuname;
  String? menuslogan;
  String? menuImage;

  MenuCategoryDetails({this.id, this.menuname, this.menuslogan, this.menuImage});

  MenuCategoryDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    menuname = json['menuname'];
    menuslogan = json['menuslogan'];
    menuImage = json['menuImage'];
  }
}

class ItemsDetails {
  int? itemId;
  String? itemName;
  String? itemSlogan;
  String? itemImage;
  int? categoryId;

  ItemsDetails({this.itemId, this.itemName, this.itemSlogan, this.itemImage, this.categoryId});

  ItemsDetails.fromJson(Map<String, dynamic> json) {
    itemId = json['id'];
    itemName = json['itemname'];
    itemSlogan = json['itemslogan'];
    itemImage = json['itemimage'];
    categoryId = json['menucategory_id'];
  }
}