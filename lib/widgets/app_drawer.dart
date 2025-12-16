import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_weding_software/screens/feedback_screen.dart';
import '../Home/home_screen.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        // CHANGE 1: ListView ko Column mein badla
        child: Column(
          children: [
            // CHANGE 2: Saare scrollable items ko Expanded -> ListView mein dala
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: const BoxDecoration(),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/icon/icon.png',
                          color: Colors.blue,
                          height: 92,
                          width: 73,
                        ),
                        const SizedBox(width: 20),
                        Padding(
                          padding: const EdgeInsets.only(top: 48.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Manager Name",
                                style: GoogleFonts.nunito(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '@manager123',
                                style: GoogleFonts.nunito(
                                    color: const Color(0xFF23232399),
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
                    onTap: () {},
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
                        const Spacer(), // Yeh Spacer chalega kyunki yeh Row mein hai
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
                        const Spacer(), // Yeh Spacer chalega kyunki yeh Row mein hai
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
                  // CHANGE 3: Yahan se 'Spacer()' hata diya kyunki ab zaroorat nahi
                ],
              ),
            ),

            // CHANGE 4: Logout Button ko ListView ke bahar, Column ke bottom mein rakha
            const Divider(),
            ListTile(
              leading: const Icon(Icons.exit_to_app, color: Colors.red),
              title: Text(
                'Log out',
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w700,
                    color: Colors.red,
                    fontSize: 14.8),
              ),
              onTap: () {},
            ),
            const SizedBox(height: 20), // Bottom padding
          ],
        ),
      ),
    );
  }
}