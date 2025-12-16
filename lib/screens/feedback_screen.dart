import 'package:flutter/material.dart';
import 'package:just_weding_software/screens/feedback_success_screen.dart';
import 'package:just_weding_software/widgets/feedback_textfield.dart';
import '../widgets/responsive_layout.dart'; // Make sure path is correct

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  int _selectedRating = 5;

  // Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _instagramController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _anniversaryController = TextEditingController();
  final TextEditingController _feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 16, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: const Text(
          "Feedback",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      // YAHAN HUMNE RESPONSIVE LAYOUT USE KIYA HAI
      body: SafeArea(
        child: ResponsiveDiffLayout(
          MobileBody: _buildMobileLayout(),
          TabletBody: _buildTabletLayout(),
        ),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 30),
          _buildRatingSection(),
          const SizedBox(height: 30),

          FeedbackTextfield(label: "What's your name?", hint: "Full name", controller: _nameController),
          FeedbackTextfield(label: "Your mobile number?", hint: "Mobile number", controller: _mobileController, isNumber: true),
          FeedbackTextfield(label: "What's your city?", hint: "City name", controller: _cityController),
          FeedbackTextfield(label: "What's your Instagram ID", hint: "Instagram ID", controller: _instagramController),
          FeedbackTextfield(label: "What's your DOB", hint: "DD MM YYYY", controller: _dobController),
          FeedbackTextfield(label: "What's your Anniversary", hint: "DD MM YYYY", controller: _anniversaryController),
          FeedbackTextfield(label: "Any feedback, comments, or concerns?", hint: "Describe your experience here...", controller: _feedbackController, maxLines: 4),

          const SizedBox(height: 20),
          _buildSubmitButton(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildTabletLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(40.0), // Tablet pe zyada padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: _buildHeader()), // Header Center mein
          const SizedBox(height: 30),
          Center(child: SizedBox(width: 400, child: _buildRatingSection())), // Rating Center mein
          const SizedBox(height: 40),

          Row(
            children: [
              Expanded(child: FeedbackTextfield(label: "What's your name?", hint: "Full name", controller: _nameController)),
              const SizedBox(width: 20),
              Expanded(child: FeedbackTextfield(label: "Your mobile number?", hint: "Mobile number", controller: _mobileController, isNumber: true)),
            ],
          ),

          Row(
            children: [
              Expanded(child: FeedbackTextfield(label: "What's your city?", hint: "City name", controller: _cityController)),
              const SizedBox(width: 20),
              Expanded(child: FeedbackTextfield(label: "What's your Instagram ID", hint: "Instagram ID", controller: _instagramController)),
            ],
          ),

          Row(
            children: [
              Expanded(child: FeedbackTextfield(label: "What's your DOB", hint: "DD MM YYYY", controller: _dobController)),
              const SizedBox(width: 20),
              Expanded(child: FeedbackTextfield(label: "What's your Anniversary", hint: "DD MM YYYY", controller: _anniversaryController)),
            ],
          ),

          FeedbackTextfield(label: "Any feedback, comments, or concerns?", hint: "Describe your experience here...", controller: _feedbackController, maxLines: 4),

          const SizedBox(height: 30),
          Center(child: SizedBox(width: 300, child: _buildSubmitButton())), // Button chhota aur center mein
          const SizedBox(height: 40),
        ],
      ),
    );
  }


  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Rate your experience",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          "We highly value your feedback! Kindly take a moment to rate your experience.",
          style: TextStyle(fontSize: 14, color: Colors.grey[600], height: 1.5),
        ),
      ],
    );
  }

  Widget _buildRatingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Rate our service from 1 to 5?", style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 15),
        Row(
          children: [
            Text("Worst", style: TextStyle(color: Colors.grey[600], fontSize: 13)),
            const SizedBox(width: 10),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(5, (index) {
                  int ratingValue = index + 1;
                  bool isSelected = _selectedRating == ratingValue;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedRating = ratingValue),
                    child: Container(
                      width: 40, height: 40,
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF00C853) : Colors.grey[200],
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "$ratingValue",
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.grey[600],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(width: 10),
            const Text("Best", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          ],
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: () {
         Navigator.push(context, MaterialPageRoute(builder: (context)=>FeedbackSuccessScreen()));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFD32F2F),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: const Text("Send Feedback", style: TextStyle(color: Colors.white, fontSize: 16)),
      ),
    );
  }
}