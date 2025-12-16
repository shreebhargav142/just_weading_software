import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../create_event/event_details.dart';
import '../home_screen.dart';

class InquiryScreen extends StatefulWidget {
  const InquiryScreen({super.key});

  @override
  State<InquiryScreen> createState() => _InquiryScreenState();
}

class _InquiryScreenState extends State<InquiryScreen> {
  int selectedIndex=1;
  bool isChecked=false;
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _startdateController = TextEditingController();
  final TextEditingController _tentativedateController=TextEditingController();
  TimeOfDay? pickedTime;
  String? selectedStatus;
  String? selectedParty;
  final List<String> statusList =[
    'Inquiry',
    'Confirm',
    'Cancel'
  ];
  final List<String> partyList=[
    "Regular",
    "VIP"
  ];

  final List<String> referrelSources=[
    "Friends",
    "Relatives",
    "Social Media",
    "Adverticement",
    "Other",
  ];
  Map<String,bool>referrelSelected={};
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(var items in referrelSources){
      referrelSelected[items]=false;
    }
  }
  @override
  Widget build(BuildContext conte1xt) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:28,left: 18.0),
                    child: Text(
                      'Inquiry',
                      style: GoogleFonts.nunito(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Image.asset('assets/progress.png', width: 320),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Inquiry Date',
                              style: GoogleFonts.nunito(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            Text(' *',style: TextStyle(color: Colors.black),),
                          ],
                        ),
                        SizedBox(height: 11),
                        Padding(
                          padding: const EdgeInsets.only(right: 25.0),
                          child: TextField(
                            cursorColor: Colors.black,
                            style: GoogleFonts.nunito(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            controller: _dateController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 23,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100),
                                  );

                                  if (pickedDate != null) {
                                    String formattedDate = DateFormat(
                                      'MM-dd-yyyy',
                                    ).format(pickedDate);
                                    setState(() {
                                      _dateController.text = formattedDate;
                                    });
                                  }
                                },
                                icon: Icon(
                                  Icons.calendar_month,
                                  color: Colors.grey,
                                ),
                              ),
                              hint: Text(
                                'Select Date',
                                style: GoogleFonts.nunito(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );

                              if (pickedDate != null) {
                                String formattedDate = DateFormat(
                                  'MM-dd-yyyy',
                                ).format(pickedDate);
                                setState(() {
                                  _dateController.text = formattedDate;
                                });
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              'Guest Name',
                              style: GoogleFonts.nunito(
                                color: Colors.black,

                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(' *',style: TextStyle(color: Colors.black),),
                          ],
                        ),
                        SizedBox(height: 11),
                        Padding(
                          padding: const EdgeInsets.only(right: 25.0),
                          child: TextField(
                            style: GoogleFonts.nunito(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 23,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              hint: Text(
                                'Enter Guest Name',
                                style: GoogleFonts.nunito(
                                  fontSize: 16,
                                  color: Color(0xFF23232380),
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 11),
                        Row(
                          children: [
                            Text(
                              'Mobile NO',
                              style: GoogleFonts.nunito(
                                color: Colors.black,

                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(' *',style: TextStyle(color: Colors.black),),
                          ],
                        ),
                        SizedBox(height: 11),

                        Padding(
                          padding: const EdgeInsets.only(right: 25.0),
                          child: TextField(
                            keyboardType: TextInputType.numberWithOptions(),
                            style: GoogleFonts.nunito(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 23,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              hint: Text(
                                'Your event name',
                                style: GoogleFonts.nunito(
                                  fontSize: 16,
                                  color: Color(0xFF23232380),
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 11),
                        Text(
                          'Function Name *',
                          style: GoogleFonts.nunito(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 11),
                        Padding(
                          padding: const EdgeInsets.only(right: 25.0),
                          child: TextField(
                            style: GoogleFonts.nunito(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 23,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              hint: Text(
                                'Enter Function Name',
                                style: GoogleFonts.nunito(
                                  fontSize: 16,
                                  color: Color(0xFF23232380),
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                          ),
                        ),

                       const SizedBox(height: 11),
                        Text(
                          'Tentative Dates *',
                          style: GoogleFonts.nunito(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 11),
                        Padding(
                          padding: const EdgeInsets.only(right: 25.0),
                          child: TextField(
                            style: GoogleFonts.nunito(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            controller: _tentativedateController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 23,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100),
                                  );

                                  if (pickedDate != null) {
                                    String formattedDate = DateFormat(
                                      'MM-dd-yyyy',
                                    ).format(pickedDate);
                                    setState(() {
                                      _tentativedateController.text =
                                          formattedDate;
                                    });
                                  }
                                },
                                icon: Icon(
                                  Icons.calendar_month,
                                  color: Colors.grey,
                                ),
                              ),
                              hint: Text(
                                'Please Enter Start Date',
                                style: GoogleFonts.nunito(
                                  fontSize: 16,

                                  color: Color(0xFF23232380),
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );

                              if (pickedDate != null) {
                                String formattedDate = DateFormat(
                                  'MM-dd-yyyy',
                                ).format(pickedDate);
                                setState(() {
                                  _tentativedateController.text = formattedDate;
                                });
                              }
                            },
                          ),
                        ),

                        SizedBox(height: 11),
                        Text(
                          'Referral Source',
                          style: GoogleFonts.nunito(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),

                        SizedBox(height: 11),

                        Padding(
                          padding: const EdgeInsets.only(right: 25.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey.shade700),
                            ),
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              children: referrelSources.map((source) {
                                return Row(
                                  children: [
                                    Checkbox(
                                      value: referrelSelected[source],
                                      activeColor: Colors.green,
                                      onChanged: (value) {
                                        setState(() {
                                          referrelSelected[source] = value!;
                                        });
                                      },
                                    ),
                                    Text(
                                      source,
                                      style: GoogleFonts.nunito(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),   // ✅ FIXED missing closing bracket
                        ),

                        const SizedBox(height: 10),

                        Text(
                          'Email Id *',
                          style: GoogleFonts.nunito(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),

                        SizedBox(height: 11),

                        Padding(
                          padding: const EdgeInsets.only(right: 25.0),
                          child: TextField(
                            style: GoogleFonts.nunito(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 23,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              hint: Text(
                                'Enter Email Id',
                                style: GoogleFonts.nunito(
                                  fontSize: 16,
                                  color: Color(0xFF23232380),
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 20),

                        Padding(
                          padding: const EdgeInsets.only(right: 22),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(color: Colors.black12),
                              ),
                              backgroundColor: Colors.red,
                              minimumSize: const Size(340, 45),
                            ),
                            onPressed: () {},
                            child: Text(
                              'Add Inquiry  >',
                              style: GoogleFonts.nunito(
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ],
          ),
        ),

      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 95,vertical: 16),
          child: Row(
            children: [
              // Left side icons
              Row(
                children: [
                  _buildNavItem(Icons.calendar_today, "Events", 0),
                  const SizedBox(width: 90,),
                  _buildNavItem(Icons.person, "Inquiry", 1),

                ],
              ),
              // Right side icons
            ],
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>EventDetailsScreen()));
        },
        child: Image.asset(
          'assets/images/FAB.png',
          width: 130,
          height: 170,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
  Widget _buildNavItem(IconData icon, String label, int index) {
    final bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() => selectedIndex = index);

        if(index==0){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isSelected ? Colors.red : Colors.grey),
          Text(
            label,
            style: GoogleFonts.nunito(
              color: isSelected ? Colors.red : Color(0xFF121212),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

