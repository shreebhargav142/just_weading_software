import 'package:get/get.dart';

import '../model/category_response_model.dart';
import '../services/api_service.dart';

class CategoryyController extends GetxController {
   dynamic eventId;
   dynamic functionId;

  CategoryyController({required this.eventId, required this.functionId});

  var isLoading = true.obs;
  var categories = <MenuCategoryDetails>[].obs;
  var itemsByCategoryId = <int, List<ItemsDetails>>{}.obs;

  @override
  void onInit() {
    fetchApiData();
    super.onInit();
  }
  void fetchDataWithNewIds({required int newEventId, required int newFunctionId}) {
    this.eventId = newEventId;
    this.functionId = newFunctionId;
    fetchApiData();
  }
  void fetchApiData() async {
    try {
      isLoading(true);
      var response = await ApiService.fetchMenuData(eventId, functionId);
      if (response != null && response.data != null) {
        categories.clear();
        itemsByCategoryId.clear();

        for (var entry in response.data!) {
          if (entry.menuDetails != null) {
            categories.add(entry.menuDetails! as MenuCategoryDetails);
            itemsByCategoryId[entry.menuDetails!.id!] = entry.itemDetails ?? [];
          }
        }
      }
    } finally {
      isLoading(false);
    }
  }

  List<ItemsDetails> getItemsByCategoryId(int categoryId) {
    return itemsByCategoryId[categoryId] ?? [];
  }
}