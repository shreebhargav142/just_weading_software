import 'package:flutter/material.dart';
import 'package:get/get.dart' hide ResponsiveScreen;
import 'package:google_fonts/google_fonts.dart';
import 'package:just_weding_software/widgets/responsive_screen.dart';
import '../../controller/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final authController = Get.put(AuthController());
  bool isPasswordVisible = false;

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
                // Replace with your actual asset path or Icon if asset isn't ready
                Image.asset(
                  iconPath,
                  height: 25,
                  width: 25,
                  errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.info, color: Colors.white, size: 25),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
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
    );

    Overlay.of(context).insert(overlayEntry);
    Future.delayed(const Duration(seconds: 2), () => overlayEntry.remove());
  }

  // --- VALIDATION LOGIC ---
// --- VALIDATION LOGIC ---
  Future<void> _validateAndLogin() async {
    String username = authController.usernameController.text.trim();
    String password = authController.passwordController.text.trim();

    // Check if empty
    if (username.isEmpty || password.isEmpty) {
      _showBottomPopup(
        message: "Please enter username and password",
        backgroundColor: Colors.red.shade700,
        iconPath: 'assets/icon/icon.png',
      );
      return; // Yahin se wapas chala jayega, niche wala login call nahi hoga
    }

    if (password.length < 6) {
      _showBottomPopup(
        message: "Password must be at least 6 characters",
        backgroundColor: Colors.red.shade700,
        iconPath: "assets/icon/icon.png",
      );
      return;
    }

    // Agar upar ki sab validation sahi hai, tabhi Login API call hogi
    bool success = await authController.login();

    if (!success) {
      _showBottomPopup(
        message: "Invalid Username and Password",
        backgroundColor: Colors.red.shade800,
        iconPath: "assets/icon/icon.png",
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ResponsiveScreen(
          maxWidth: 500,
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Manager Login',
                    style: GoogleFonts.nunito(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Hey, Enter your details below to sign in and access your account securely and easily.',
                    style: GoogleFonts.nunito(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54),
                  ),
                  const SizedBox(height: 30),

                  // USERNAME FIELD
                  Text('User Name', style: GoogleFonts.nunito(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: authController.usernameController,
                    decoration: _buildInputDecoration('Enter username'),
                  ),

                  const SizedBox(height: 20),
                  Text('Password', style: GoogleFonts.nunito(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: authController.passwordController,
                    obscureText: !isPasswordVisible,
                    decoration: _buildInputDecoration('Enter Password').copyWith(
                      suffixIcon: IconButton(
                        icon: Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off, color: Colors.black38),
                        onPressed: () => setState(() => isPasswordVisible = !isPasswordVisible),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // LOGIN BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Obx((){
                      if(authController.isLoading.value){
                        return const Center(child: CircularProgressIndicator());
                      }
                      return ElevatedButton(
                        onPressed: _validateAndLogin,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.shade700,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                          child: Text(
                            'Login Now',
                            style: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                          ));
                    },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper to keep code clean
  InputDecoration _buildInputDecoration(String hint) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey.shade100,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.black)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade300)),
      hintText: hint,
      hintStyle: GoogleFonts.nunito(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.black38),
    );
  }
}