import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:step_progress_indicator/step_progress_indicator.dart';

import 'event_details.dart';
import 'function_details.dart';

class VenueDetailsScreen extends StatefulWidget {
  const VenueDetailsScreen({super.key});

  @override
  State<VenueDetailsScreen> createState() => _VenueDetailsScreenState();
}

class _VenueDetailsScreenState extends State<VenueDetailsScreen> {
  int currentStep = 3; // current screen number
  String? selectedVenueName;
  String? selectedFood;
  final List<String> VenueName =[
    'SHREE BALAJI',
    'SHREE DAMA',
    'SHREE NATHJI',
    'SUKHADIYA',
    'SHREEHARI',

  ];
  final List<String> FoodPreference=[
    '100% VEG',
    '100% jain',
    '100% wagad',
    '100% Marvadi',
    '20% Jain food + 80% regular',
    'no onion no garlic'
  ];
  @override
  Widget build(BuildContext conte1xt) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back_ios),
                        ),
                        SizedBox(width: 15),
                        Text(
                          'Create Event',
                          style: GoogleFonts.nunito(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: StepProgressIndicator(
                        totalSteps: 4,
                        currentStep: currentStep,
                        selectedColor: Colors.green,
                        unselectedColor: Colors.grey[300]!,
                        size: 6,
                        roundedEdges: const Radius.circular(10),
                      ),
                    ),
                    // Image.asset('assets/progress.png', width: 320),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, right: 18),
                      child: Row(
                        children: [
                          Container(
                            color: Colors.red.shade700,
                            height: 18,
                            width: 4, // spacing around the divider
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Venue Details',
                            style: GoogleFonts.nunito(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),

                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Venue Name',style: GoogleFonts.nunito(fontSize:16,fontWeight: FontWeight.bold,color: Colors.black),),
                          const SizedBox(height: 11,),
                          Padding(padding: EdgeInsets.only(right: 25),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey,width: 1.5),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: DropdownButtonHideUnderline(child: DropdownButton<String>(
                                      borderRadius: BorderRadius.circular(12),
                                      value: selectedVenueName,
                                      padding: EdgeInsets.only(left: 19),
                                      isExpanded: true,
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.grey,
                                      ),

                                      hint: Text(
                                        "Select party type",
                                        style: GoogleFonts.nunito(
                                          fontSize: 16,
                                          color: Colors.black38,
                                        ),
                                      ),
                                      items: VenueName.map((String item) {
                                        return DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: GoogleFonts.nunito(
                                              fontSize: 16,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedVenueName= newValue!;
                                        });
                                      },

                                    )),

                                  ),
                                ),
                              ],
                            ),

                          ),

                          const SizedBox(height: 10,),
                          Text('Address',style: GoogleFonts.nunito(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black),),
                          const SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.only(right: 25.0),
                            child: TextField(
                              maxLines: 4,
                              cursorColor: Colors.black,
                              style: GoogleFonts.nunito(
                                fontSize: 16,
                                color: Colors.black
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black
                                  )
                                ),
                                contentPadding: EdgeInsets.symmetric(vertical: 12,horizontal: 23),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black
                                  ),
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                hintText: 'Address',
                                hintStyle: GoogleFonts.nunito(color: Colors.black38,fontSize: 16)
                              ),
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Text(
                            'Food Preference',
                            style: GoogleFonts.nunito(
                              color: Colors.black,

                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),

                          const SizedBox(height: 11),

                          Padding(
                            padding: const EdgeInsets.only(right: 25.0),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),

                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  borderRadius: BorderRadius.circular(13),
                                  value: selectedFood,
                                  padding: EdgeInsets.only(left: 19),
                                  isExpanded: true,
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.grey,
                                  ),

                                  hint: Text(
                                    "Select food",
                                    style: GoogleFonts.nunito(
                                      fontSize: 16,
                                      color:Colors.black38,
                                    ),
                                  ),
                                  items: FoodPreference.map((String item) {
                                    return DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: GoogleFonts.nunito(
                                          fontSize: 16,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedFood = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Text(
                                'Food Notes',
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
                                  'Food Notes',
                                  style: GoogleFonts.nunito(
                                    fontSize: 16,
                                    color: Colors.black38,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 11,),

                          SizedBox(height: 60),
                          Row(
                            children: [
                              SizedBox(
                                height: 45,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: BorderSide(color: Colors.black12),
                                    ),
                                    backgroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 50,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>EventDetailsScreen()));
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.arrow_back_ios,
                                        color: Colors.black,
                                        size: 12,
                                      ),
                                      Text(
                                        'Back',
                                        style: GoogleFonts.nunito(
                                          fontSize: 13,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              SizedBox(
                                height: 45,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(color: Colors.black12),
                                    ),
                                    backgroundColor: Colors.red,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 50,
                                    ),
                                  ),
                                  onPressed:  () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>FunctionDetailsScreen()));
                                    if (currentStep < 4) {
                                      setState(() {
                                        currentStep++;
                                      });
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        'Next',
                                        style: GoogleFonts.nunito(
                                          fontSize: 13,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
