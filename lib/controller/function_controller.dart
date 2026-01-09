import 'package:get/get.dart';
import 'package:just_weding_software/model/function_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';

class FunctionController extends GetxController {
  RxString eventId="0".obs;
  RxString functionId="0".obs;
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
    print("************************************************");
    print(clientUserId);
    try {
      isLoading(true);
      var response = await ApiService().fetchFunction(clientUserId.toString());
      if (response != null && response.data != null) {
        var details = response.data!.functionManagerAssignDetails;

        if (details != null && details.isNotEmpty) {
          functionList.assignAll(details);
          eventId.value=details[0].eventId ?? "0";
          functionId.value=details[0].functionId ?? "0";
          selectedFunction.value = details[0];
          imageUrl.value = details[0].imgUrl ?? "";
          eventId.value = details[0].eventId ?? "0";
          functionId.value = details[0].functionId ?? "0";
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

