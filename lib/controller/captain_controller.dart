import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CaptainController extends GetxController{
  final dynamic clientId;
  CaptainController({required this.clientId});

  final nameController=TextEditingController();
final ageController=TextEditingController();
final phonenoController=TextEditingController();
final email_addController=TextEditingController();
final company_emailController=TextEditingController();
final usernameController=TextEditingController();
final passwordController=TextEditingController();
final confirm_passwordController=TextEditingController();

var isLoading=false.obs;
Future<void> createCaptain() async {
  if(passwordController.text!=confirm_passwordController.text){
    _showBottomPopup(message: 'Error Password does not match', backgroundColor: Colors.red, iconPath: 'assets/icon/icon.png');
  }
  try{
    isLoading(true);
     Map<String,dynamic> body={
       "clientUserId" : 1,
       "name" : "Bhargav",
       "age" : 29 ,
       "emailId" : "brv@gmail.com",
       "companyEmail" : "shree@gmail.com",
       "mobileNo" : "9873114560",
       "userName" : "Bhargav",
       "password" : "Bhargav@123",
       "confirmPassword" : "Bhargav@123",
       "clientId" : 459,
       "clientCategory" : "Captain",
       "cityName" : "Ahmedabad"
     };
     final response=await http.post(Uri.parse("https://justwedding.in/WS/adduser/"),
         headers: {"Content-Type":"application/json"},
         body: body
     );
     if(response.statusCode==200){
       _showBottomPopup(message: 'Welcome Captain', backgroundColor: Colors.green, iconPath: 'assets/icon/icon.png');
       Get.back();
     }
  }
  catch(e){
    _showBottomPopup(message: 'Server Error', backgroundColor: Colors.red, iconPath: 'assets/icon/icon.png');
  }
finally{
    isLoading(false);
}
}

  void _showBottomPopup({
    required String message,
    required Color backgroundColor,
    required String iconPath,
  }) {
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 60,
        left: MediaQuery.of(context).size.width * 0.1,
        right: MediaQuery.of(context).size.width * 0.1,
        child: Material(
          color: Colors.transparent,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: 1.0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    iconPath,
                    height: 25,
                    width: 25,
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(Get.overlayContext!).insert(overlayEntry);
    Future.delayed(const Duration(seconds: 2), () => overlayEntry.remove());
  }
 }