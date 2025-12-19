import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_weding_software/view/auth/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../view/home_screen.dart';
import '../view/screens/feedback_screen.dart';
import '../view/screens/order_history_screen.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String companyName = "";
  String profileImage = "";
  String managerName = "@manager123";

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    print("DEBUG: Loading User Data...");
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userData = prefs.getString('userData');

    print("DEBUG: Raw JSON from Prefs: $userData");

    if (userData != null) {
      try {
        Map<String, dynamic> userMap = jsonDecode(userData);
        var details = userMap['data']['clientUserDetails'][0];

        if (userMap['data'] != null &&
            userMap['data']['clientUserDetails'] != null &&
            (userMap['data']['clientUserDetails'] as List).isNotEmpty) {

          String nameFromApi = userMap['data']['clientUserDetails'][0]['companyName'] ?? "";
          String userFromApi = userMap['data']['clientUserDetails'][0]['companyEmail'] ?? "manager";
          String imageFromApi = userMap['data']['clientUserDetails'][0]['imgUrl'] ?? "assets/icon/icon.png";



          print("DEBUG: Extracted Company Name: $nameFromApi");

          setState(() {
            companyName = nameFromApi;
            managerName = userFromApi;
            profileImage = imageFromApi;
          });
        } else {
          print("DEBUG: No data found in 'data' or 'clientUserDetails'");
        }
      } catch (e) {
        print("DEBUG ERROR: Data parsing failed: $e");
      }
    } else {
      print("DEBUG: No saved data found (userData is null)");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: const BoxDecoration(),
                    child: Row(
                      children: [
                        Container(height: 80,width: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[200],
                        ),
                          clipBehavior: Clip.antiAlias,
                          child: profileImage.isNotEmpty ? Image.network(
                            profileImage,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Icon(Icons.person, color: Colors.grey[400],size: 40,)
                          ) : Image.asset('assets/icon/icon.png'),
                        ),
                        const SizedBox(width: 14),
                        Padding(
                          padding: const EdgeInsets.only(top: 48.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 140,
                                child: Text(
                                  companyName.isEmpty ? "Welcome" : companyName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.nunito(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                managerName,
                                style: GoogleFonts.nunito(
                                    color: Colors.black45,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.home, color: Colors.black),
                    title: Text("Home",
                        style: GoogleFonts.nunito(
                            color: const Color(0xFF121212),
                            fontSize: 14.8,
                            fontWeight: FontWeight.w700)),
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => const HomeScreen()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.auto_graph, color: Colors.black),
                    title: Text("Activity",
                        style: GoogleFonts.nunito(
                            color: Colors.black,
                            fontSize: 14.8,
                            fontWeight: FontWeight.w700)),
                    onTap: () {},
                  ),
                  ListTile(
                    leading:
                    const Icon(Icons.library_books_rounded, color: Colors.black),
                    title: Text("Order History",
                        style: GoogleFonts.nunito(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontSize: 14.8)),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const OrderHistoryScreen()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.star_border, color: Colors.black),
                    title: Text(
                      'Rate our App',
                      style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontSize: 14.8),
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading:
                    const Icon(Icons.message_outlined, color: Colors.black),
                    title: Text(
                      'Leave a feedback',
                      style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontSize: 14.8),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FeedbackScreen()));
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.settings, color: Colors.black),
                    title: Text(
                      'Settings',
                      style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontSize: 14.8),
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading:
                    const Icon(Icons.language_outlined, color: Colors.black),
                    title: Row(
                      children: [
                        Text(
                          'Language',
                          style: GoogleFonts.nunito(
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                              fontSize: 14.8),
                        ),
                        const Spacer(),
                        Text(
                          'English',
                          style: GoogleFonts.nunito(
                              fontWeight: FontWeight.w700,
                              color: Colors.grey,
                              fontSize: 12),
                        )
                      ],
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.info_outline, color: Colors.black),
                    title: Text(
                      'About Us',
                      style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontSize: 14.8),
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.headphones, color: Colors.black),
                    title: Text(
                      'Contact Us',
                      style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontSize: 14.8),
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading:
                    const Icon(Icons.library_books_rounded, color: Colors.black),
                    title: Text(
                      'Disclaimer',
                      style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontSize: 14.8),
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.tips_and_updates_outlined,
                        color: Colors.black),
                    title: Row(
                      children: [
                        Text(
                          'Version',
                          style: GoogleFonts.nunito(
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                              fontSize: 14.8),
                        ),
                        const Spacer(),
                        Text(
                          'V 1.2.0',
                          style: GoogleFonts.nunito(
                              fontWeight: FontWeight.w700,
                              color: Colors.grey,
                              fontSize: 14.8),
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),

            ListTile(
              leading: const Icon(Icons.exit_to_app, color: Colors.red),
              title: Text(
                'Log out',
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w700,
                    color: Colors.red,
                    fontSize: 14.8),
              ),
              onTap: () async {
                print("DEBUG: Logging out...");
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.clear(); // Data Clear
                print("DEBUG: Data Cleared.");

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                        (route) => false
                );
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}