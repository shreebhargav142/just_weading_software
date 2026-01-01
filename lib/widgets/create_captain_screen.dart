import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_weding_software/controller/captain_controller.dart';

import '../controller/auth_controller.dart';

class CreateCaptainScreen extends StatefulWidget {
  const CreateCaptainScreen({super.key});

  @override
  State<CreateCaptainScreen> createState() => _CreateCaptainScreenState();
}

class _CreateCaptainScreenState extends State<CreateCaptainScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  late final CaptainController captainController;

  @override
  void initState() {
    super.initState();
    final authController = Get.find<AuthController>();

    final clientId = authController.user.value?.clientId ?? 512;
    captainController= Get.put(CaptainController(clientId: clientId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Create Captain', style: GoogleFonts.nunito(
            fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),),

        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),

        ),),

      body: Padding(padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Start Creating a Captain', style: GoogleFonts.nunito(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),),
                SizedBox(height: 10,),
                Text('Hey! Welcome and Thank you for Checking Our App.',
                  style: GoogleFonts.nunito(
                      fontSize: 13, color: Colors.black),),
                SizedBox(height: 20,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black38, width: 1),
                          ),
                          child: CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.grey[100],
                            backgroundImage: _selectedImage != null ? FileImage(_selectedImage!) : null,
                            child: _selectedImage == null
                                ? IconButton(
                              onPressed: _pickImage,
                              icon: const Icon(Icons.image, color: Colors.black),
                            )
                                : null,
                          ),
                        ),
                        if (_selectedImage != null)
                          Positioned(
                            top: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedImage = null; // This "unselects" the image
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.red, // Red background for the delete action
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 14,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    TextButton(onPressed: _pickImage,
                        child: Text('+ Upload Photo',
                          style: GoogleFonts.nunito(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),)

                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Text('Name', style: GoogleFonts.nunito(fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),),
                const SizedBox(height: 5,),
                TextFormField(
                  controller: captainController.nameController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintText: 'Captain Name',
                    hintStyle: GoogleFonts.nunito(
                        fontSize: 13, color: Colors.black38),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(38),
                      borderSide: BorderSide(
                          color: Colors.grey.shade300, width: 1),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    focusColor: Colors.black,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color: Colors.grey.shade300, width: 1),),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(
                          color: Colors.grey.shade300, width: 1),),
                  ),

                ),
                const SizedBox(height: 5,),
                Text('Age', style: GoogleFonts.nunito(fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),),
                const SizedBox(height: 5,),
                TextFormField(
                  controller: captainController.ageController,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintText: 'Captain Age',
                    hintStyle: GoogleFonts.nunito(
                        fontSize: 13, color: Colors.black38),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(38),
                      borderSide: BorderSide(
                          color: Colors.grey.shade300, width: 1),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    focusColor: Colors.black,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color: Colors.grey.shade300, width: 1),),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(
                          color: Colors.grey.shade300, width: 1),),
                  ),

                ),
                const SizedBox(height: 5,),
                Text('Phone Number,', style: GoogleFonts.nunito(fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),),
                const SizedBox(height: 5,),
                TextFormField(
                  controller: captainController.phonenoController,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                    hintStyle: GoogleFonts.nunito(
                        fontSize: 13, color: Colors.black38),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(38),
                      borderSide: BorderSide(
                          color: Colors.grey.shade300, width: 1),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    focusColor: Colors.black,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color: Colors.grey.shade300, width: 1),),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(
                          color: Colors.grey.shade300, width: 1),),
                  ),

                ),
                const SizedBox(height: 5,),
                Text('Email Address', style: GoogleFonts.nunito(fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),),
                const SizedBox(height: 5,),
                TextFormField(
                  controller: captainController.email_addController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintText: 'Captain Email address',
                    hintStyle: GoogleFonts.nunito(
                        fontSize: 13, color: Colors.black38),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(38),
                      borderSide: BorderSide(
                          color: Colors.grey.shade300, width: 1),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    focusColor: Colors.black,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color: Colors.grey.shade300, width: 1),),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(
                          color: Colors.grey.shade300, width: 1),),
                  ),

                ),
                const SizedBox(height: 5,),
                Text('Company Email Address', style: GoogleFonts.nunito(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),),
                const SizedBox(height: 5,),
                TextFormField(
                  controller: captainController.company_emailController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintText: 'Company Email Address ',
                    hintStyle: GoogleFonts.nunito(
                        fontSize: 13, color: Colors.black38),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(38),
                      borderSide: BorderSide(
                          color: Colors.grey.shade300, width: 1),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    focusColor: Colors.black,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color: Colors.grey.shade300, width: 1),),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(
                          color: Colors.grey.shade300, width: 1),),
                  ),

                ),
                const SizedBox(height: 5,),
                Text('User Name', style: GoogleFonts.nunito(fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),),
                const SizedBox(height: 5,),
                TextFormField(
                  controller: captainController.usernameController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintText: 'User Name',
                    hintStyle: GoogleFonts.nunito(
                        fontSize: 13, color: Colors.black38),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(38),
                      borderSide: BorderSide(
                          color: Colors.grey.shade300, width: 1),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    focusColor: Colors.black,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color: Colors.grey.shade300, width: 1),),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(
                          color: Colors.grey.shade300, width: 1),),
                  ),

                ),
                const SizedBox(height: 5,),
                Text('Password', style: GoogleFonts.nunito(fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),),
                const SizedBox(height: 5,),
                TextFormField(
                  controller: captainController.passwordController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: GoogleFonts.nunito(
                        fontSize: 13, color: Colors.black38),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(38),
                      borderSide: BorderSide(
                          color: Colors.grey.shade300, width: 1),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    focusColor: Colors.black,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color: Colors.grey.shade300, width: 1),),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(
                          color: Colors.grey.shade300, width: 1),),
                  ),
                ),
                const SizedBox(height: 5,),
                Text('Confirm Password', style: GoogleFonts.nunito(fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),),
                const SizedBox(height: 5,),
                TextFormField(
                  controller: captainController.confirm_passwordController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    hintStyle: GoogleFonts.nunito(
                        fontSize: 13, color: Colors.black38),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(38),
                      borderSide: BorderSide(
                          color: Colors.grey.shade300, width: 1),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    focusColor: Colors.black,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color: Colors.grey.shade300, width: 1),),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(
                          color: Colors.grey.shade300, width: 1),),
                  ),

                ),
                const SizedBox(height: 15,),
                Obx(()
                  => ElevatedButton(
                      onPressed: captainController.isLoading.value ? null :()=>captainController.createCaptain(),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 45),
                          backgroundColor: Colors.red.shade600,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),)
                      ),
                      child: captainController.isLoading.value ? SizedBox(width:20,height:20,child: CircularProgressIndicator()) :
                      Text('Create Account', style: GoogleFonts.poppins(
                          fontSize: 14, color: Colors.white),)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }
}
