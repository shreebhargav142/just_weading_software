import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:just_weding_software/Home/create_event/venue_details.dart';

import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../widgets/add_partynamesheet.dart';
import 'event_details.dart';

class PartyDetailsScreen extends StatefulWidget {
  const PartyDetailsScreen({super.key});

  @override
  State<PartyDetailsScreen> createState() => _PartyDetailsScreenState();
}

class _PartyDetailsScreenState extends State<PartyDetailsScreen> {
  int currentStep = 2; // current screen number
  String? selectedPartyName;
  String? selectedExecutive;
  final List<String> PartyName =[
    'MehulBhai',
    'PritamBhai',
    'RameshBhai',
    'UmeshBhai',
    'SureshBhai',
    'SahilBhai'
  ];
  final List<String> RelationExecutive=[
    'SanjayBhai',
    'SumitBhai',
    'AnandBhai',
    'DharmeshBhai',
    'TarunBhai'
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

                        // total number of steps
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
                            'Party Details',
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
                          Text('Party Name *',style: GoogleFonts.nunito(fontSize:16,fontWeight: FontWeight.bold,color: Colors.black),),
                          const SizedBox(height: 11,),
                          Padding(padding: EdgeInsets.only(right: 12),
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
                                      value: selectedPartyName,
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
                                      items: PartyName.map((String item) {
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
                                          selectedPartyName= newValue!;
                                        });
                                      },

                                    )),

                                  ),
                                ),
                                SizedBox(width: 10,),
                                SizedBox(
                                  width: 45,
                                  height: 40,
                                  child: FloatingActionButton(
                                    backgroundColor: Colors.red,
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        backgroundColor: Colors.transparent,
                                        isScrollControlled: true, // 👈 Important for full height sheet
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(top: Radius.circular(500)),
                                        ),

                                        builder: (context) {
                                          return FractionallySizedBox(
                                            heightFactor: 0.75,
                                            child: const AddPartySheet(),
                                          );
                                        },
                                      );
                                    },
                                    child: Icon(Icons.add, color: Colors.white),
                                  ),
                                ),

                              ],
                            ),

                          ),

                          const SizedBox(height: 10,),
                          Row(
                            children: [
                              Text(
                                'Party Contact No',
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
                                  'Party Contact No',
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
                          SizedBox(height: 11,),
                          Text(
                            'Reference',
                            style: GoogleFonts.nunito(                            color: Colors.black,
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
                                  'Reference',
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
                          Row(
                            children: [
                              Text(
                                'Guest Relation Executive',
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
                                  value: selectedExecutive,
                                  padding: EdgeInsets.only(left: 19),
                                  isExpanded: true,
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.grey,
                                  ),

                                  hint: Text(
                                    "Select function",
                                    style: GoogleFonts.nunito(
                                      fontSize: 16,
                                      color: Colors.black38,
                                    ),
                                  ),
                                  items: RelationExecutive.map((String item) {
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
                                      selectedExecutive = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 120,),
                          Row(
                            children: [
                              SizedBox(
                                height: 46,
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
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              SizedBox(
                                height: 46,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(color: Colors.black12),
                                    ),
                                    backgroundColor: Colors.red.shade700,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 50,
                                    ),
                                  ),
                                  onPressed:  () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>VenueDetailsScreen()));
                                    if (currentStep < 3) {
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
                                          fontSize: 15,
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
