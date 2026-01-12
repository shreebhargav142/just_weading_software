import 'package:get/get.dart';
import 'package:just_weding_software/model/function_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';

class FunctionController extends GetxController {
  var isLoading = true.obs;
  var selectedFunction = Rxn<FunctionManagerAssignDetails>();
  var functionList = <FunctionManagerAssignDetails>[].obs;
  var imageUrl = "".obs;

  @override
  void onInit() {
    getFunctions();
    super.onInit();
  }

  void getFunctions() async {
    final prefs = await SharedPreferences.getInstance();
    int clientUserId = prefs.getInt('clientUserId') ?? 0;
    try {
      isLoading(true);
      var response = await ApiService().fetchFunction(clientUserId);

      if (response != null && response.data != null) {
        var details = response.data!.functionManagerAssignDetails;

        if (details != null && details.isNotEmpty) {
          functionList.assignAll(details);
          selectedFunction.value = details[0];
          imageUrl.value = details[0].imgUrl ?? "";
        }
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading(false);
    }
  }

  void onFunctionChanged(FunctionManagerAssignDetails? newValue) {
    selectedFunction.value = newValue;
    if (newValue != null) {
      imageUrl.value = newValue.imgUrl ?? "";
    }
  }

}