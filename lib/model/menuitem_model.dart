class MenuItemModel {
  String? msg;
  Data? data;
  bool? success;

  MenuItemModel({this.msg, this.data, this.success});

  MenuItemModel.fromJson(Map<String, dynamic> json) {
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
  List<EventMenuPlanDetails>? eventMenuPlanDetails;

  Data({this.eventMenuPlanDetails});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['eventMenuPlanDetails'] != null) {
      eventMenuPlanDetails = <EventMenuPlanDetails>[];
      json['eventMenuPlanDetails'].forEach((v) {
        eventMenuPlanDetails!.add(new EventMenuPlanDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.eventMenuPlanDetails != null) {
      data['eventMenuPlanDetails'] =
          this.eventMenuPlanDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EventMenuPlanDetails {
  int? menuCategoryId;
  String? menuName;
  String? menuImage;
  int? menuSortorder;
  List<ItemsDetails>? itemsDetails;

  EventMenuPlanDetails(
      {this.menuCategoryId,
        this.menuName,
        this.menuImage,
        this.menuSortorder,
        this.itemsDetails});

  EventMenuPlanDetails.fromJson(Map<String, dynamic> json) {
    menuCategoryId = json['menuCategoryId'];
    menuName = json['menuName'];
    menuImage = json['menuImage'];
    menuSortorder = json['menu_sortorder'];
    if (json['itemsDetails'] != null) {
      itemsDetails = <ItemsDetails>[];
      json['itemsDetails'].forEach((v) {
        itemsDetails!.add(new ItemsDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menuCategoryId'] = this.menuCategoryId;
    data['menuName'] = this.menuName;
    data['menuImage'] = this.menuImage;
    data['menu_sortorder'] = this.menuSortorder;
    if (this.itemsDetails != null) {
      data['itemsDetails'] = this.itemsDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItemsDetails {
  int? itemId;
  String? itemName;
  String? itemImage;
  String? itemSlogan;
  int? itemSortorder;

  ItemsDetails(
      {this.itemId,
        this.itemName,
        this.itemImage,
        this.itemSlogan,
        this.itemSortorder});

  ItemsDetails.fromJson(Map<String, dynamic> json) {
    itemId = json['itemId'];
    itemName = json['itemName'];
    itemImage = json['itemImage'];
    itemSlogan = json['itemSlogan'];
    itemSortorder = json['item_sortorder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemId'] = this.itemId;
    data['itemName'] = this.itemName;
    data['itemImage'] = this.itemImage;
    data['itemSlogan'] = this.itemSlogan;
    data['item_sortorder'] = this.itemSortorder;
    return data;
  }
}

