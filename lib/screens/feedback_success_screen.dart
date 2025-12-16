import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/responsive_layout.dart'; // Apna responsive file import karein

class FeedbackSuccessScreen extends StatelessWidget {
  const FeedbackSuccessScreen({super.key});

  // Colors as per Image
  static const Color _iconBgColor = Color(0xFFE0F2F1); // Light green
  static const Color _themeColor = Color(0xFF00C853); // Main green
  static const Color _textColor = Color(0xFF757575); // Grey text
  static const Color _borderColor = Color(0xFFE0E0E0); // Grey border

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ResponsiveDiffLayout(
          // 1. Mobile View (Normal Sizes)
          MobileBody: _buildContent(context, isTablet: false),

          // 2. Tablet View (Bade Sizes - Scaled Up)
          TabletBody: _buildContent(context, isTablet: true),
        ),
      ),
    );
  }

  // --- REUSABLE CONTENT BUILDER ---
  Widget _buildContent(BuildContext context, {required bool isTablet}) {
    // Tablet ke liye sizes adjust karte hain
    double iconSize = isTablet ? 150 : 100;
    double iconInnerSize = isTablet ? 60 : 40;
    double titleSize = isTablet ? 32 : 22;
    double subtitleSize = isTablet ? 18 : 14;
    double buttonWidth = isTablet ? 200 : 140;
    double buttonHeight = isTablet ? 55 : 45;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 1. Thumbs Up Icon
            Container(
              width: iconSize,
              height: iconSize,
              decoration: const BoxDecoration(
                color: _iconBgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.thumb_up_alt_outlined,
                color: _themeColor,
                size: iconInnerSize,
              ),
            ),
            SizedBox(height: isTablet ? 48 : 32),

            // 2. Main Title
            Text(
              "Thank you for your valuable feedback",
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                color: _themeColor,
                fontSize: titleSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            // 3. Subtitle
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Valuable feedback and insights are much appreciated",
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                  color: _textColor,
                  fontSize: subtitleSize,
                  height: 1.5,
                ),
              ),
            ),
            SizedBox(height: isTablet ? 60 : 48),

            // 4. Back Button
            SizedBox(
              width: buttonWidth,
              height: buttonHeight,
              child: OutlinedButton.icon(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: _borderColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  foregroundColor: Colors.black87,
                ),
                icon: Icon(Icons.arrow_back_ios_new, size: isTablet ? 18 : 14),
                label: Text(
                  "Back",
                  style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w600,
                    fontSize: isTablet ? 18 : 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}