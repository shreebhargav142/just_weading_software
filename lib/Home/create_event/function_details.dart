import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:just_weding_software/Home/create_event/event_details.dart';
import 'package:just_weding_software/Home/create_event/venue_details.dart';

import 'package:step_progress_indicator/step_progress_indicator.dart';

class FunctionDetailsScreen extends StatefulWidget {
  const FunctionDetailsScreen({super.key});

  @override
  State<FunctionDetailsScreen> createState() => _FunctionDetailsScreenState();
}

class _FunctionDetailsScreenState extends State<FunctionDetailsScreen> {
  final TextEditingController _endtimeController=TextEditingController();
  final TextEditingController _starttimeController=TextEditingController();
  TimeOfDay _time = TimeOfDay.now();
  TimeOfDay? pickedTime;

  Future<void> _selectTime(BuildContext context, TextEditingController controller) async {
    pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),

        builder:  (context,child){
          return Theme(data: Theme.of(context).copyWith(
              timePickerTheme: TimePickerThemeData(
                  hourMinuteTextStyle: TextStyle(
                      fontSize: 19
                  ),
                  helpTextStyle: TextStyle(
                      fontSize: 19,color: Colors.black
                  )
              )
          ), child:child!);
        }
    );

    if (pickedTime != null) {
      setState(() {
        controller.text = pickedTime!.format(context);
      });
    }
  }

  int currentStep = 4; // current screen number
  String? selectedFunction;
  final List<String> Function =[
    'MORNING',
    'AFTERNOON',
    'LUNCH',
    'SNACKS',
    'DINNER',
    'CANDLE LIGHT DINNER'
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
                            'Function Details',
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
                                      value: selectedFunction,
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
                                      items: Function.map((String item) {
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
                                          selectedFunction = newValue!;
                                        });

                                        // Bottom sheet that matches typical video behavior (draggable + scrollable + sized)
                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,           // lets us set a larger height
                                          backgroundColor: Colors.transparent, // so we can have rounded white container
                                          barrierColor: Colors.black54,       // dim the background
                                          builder: (context) {
                                            return DraggableScrollableSheet(
                                              initialChildSize: 0.55, // sheet height when opened (55% of screen)
                                              minChildSize: 0.35,
                                              maxChildSize: 0.95,
                                              expand: false,
                                              builder: (context, scrollController) {
                                                return Container(
                                                  // white rounded card look
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black26,
                                                        blurRadius: 10,
                                                      )
                                                    ],
                                                  ),
                                                  padding: EdgeInsets.fromLTRB(20, 2, 20, 20),
                                                  child: ListView(
                                                    controller: scrollController,
                                                    children: [
                                                      // top handle
                                                      Center(
                                                        child: Container(
                                                          width: 45,
                                                          height: 5,
                                                          margin: EdgeInsets.only(bottom: 12),
                                                          decoration: BoxDecoration(
                                                            color: Colors.grey[300],
                                                            borderRadius: BorderRadius.circular(10),
                                                          ),
                                                        ),
                                                      ),

                                                      // Title row
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text(
                                                            selectedFunction ?? '',
                                                            style: GoogleFonts.nunito(
                                                              fontSize: 20,
                                                              fontWeight: FontWeight.w700,
                                                            ),
                                                          ),
                                                          IconButton(
                                                            onPressed: () => Navigator.pop(context),
                                                            icon: Icon(Icons.close),
                                                          ),
                                                        ],
                                                      ),

                                                      SizedBox(height: 8),

                                                      Text(
                                                        'Function Name',
                                                        style: GoogleFonts.nunito(fontSize: 18, color: Colors.black,fontWeight: FontWeight.w700),
                                                      ),

                                                      SizedBox(height: 10),
                                                      TextField(
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
                                                            'LUNCH',
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
                                                     const SizedBox(height: 10,),
                                                      Text('Start Time',style: GoogleFonts.nunito(fontWeight: FontWeight.w700,fontSize: 18,color: Colors.black),),
                                                      const SizedBox(height: 5,),
                                                      // Start Time Field
                                                      TextField(
                                                        style: GoogleFonts.nunito(
                                                          fontSize: 16,
                                                          color: Colors.black
                                                        ),
                                                        cursorColor: Colors.black,
                                                        
                                                        controller: _starttimeController,
                                                        readOnly: true,
                                                        onTap: () async {
                                                          // reuse your existing _selectTime function
                                                          await _selectTime(context, _starttimeController);
                                                        },
                                                        decoration: InputDecoration(
                                                          
                                                          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                                          hintText: 'Start Time',
                                                          suffixIcon: Icon(Icons.access_time),
                                                          
                                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(color: Colors.black),
                                                            borderRadius: BorderRadius.circular(10)
                                                          )
                                                        ),
                                                        
                                                      ),

                                                      SizedBox(height: 10),
                                                      Text('End Time',style: GoogleFonts.nunito(fontWeight: FontWeight.w700,fontSize: 18,color: Colors.black),),
                                                       const SizedBox(height: 5,),

                                                      // End Time Field
                                                      TextField(
                                                        style: GoogleFonts.nunito(fontSize: 18,color: Colors.black),
                                                        controller: _endtimeController,
                                                        readOnly: true,
                                                        onTap: () async {
                                                          await _selectTime(context, _endtimeController);
                                                        },
                                                        decoration: InputDecoration(
                                                          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                                          hintText: 'End Time',
                                                          suffixIcon: Icon(Icons.access_time),
                                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Colors.black))
                                                        ),
                                                      ),

                                                      SizedBox(height: 10),
                                                      Text('Venue Name',style: GoogleFonts.nunito(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w700),),
                                                      SizedBox(height: 5,),
                                                      TextField(
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
                                                            'Venue Name',
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
                                                      const SizedBox(height: 10,),
                                                      Text('Number Of Pax',style: GoogleFonts.nunito(fontWeight: FontWeight.w700,color: Colors.black,fontSize: 18),),
                                                      const SizedBox(height: 5,),
                                                      TextField(
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
                                                            'Number of Pax',
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
                                                      // Optional note / description area

                                                      SizedBox(height: 22),

                                                      // Buttons: Back & Save
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: ElevatedButton(
                                                              style: ElevatedButton.styleFrom(
                                                                backgroundColor: Colors.white,
                                                                foregroundColor: Colors.black,
                                                                elevation: 0,
                                                                side: BorderSide(color: Colors.black12),
                                                                padding: EdgeInsets.symmetric(vertical: 14),
                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                                              ),
                                                              onPressed: () {
                                                                Navigator.pop(context); // just close sheet
                                                              },
                                                              child: Text('Back', style: GoogleFonts.nunito(fontWeight: FontWeight.w700)),
                                                            ),
                                                          ),
                                                          SizedBox(width: 14),
                                                          Expanded(
                                                            child: ElevatedButton(
                                                              style: ElevatedButton.styleFrom(
                                                                backgroundColor: Colors.red.shade700,
                                                                padding: EdgeInsets.symmetric(vertical: 14),
                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                                              ),
                                                              onPressed: () {
                                                                // TODO: save to your functions list or state here.
                                                                // Example: add to a list and call setState() outside this snippet.
                                                                Navigator.pop(context);
                                                              },
                                                              child: Text('Save', style: GoogleFonts.nunito(fontWeight: FontWeight.w700,color: Colors.white)),
                                                            ),
                                                          ),
                                                        ],
                                                      ),

                                                      // spacing bottom so sheet can be scrolled above keyboard
                                                      SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        );
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
                                      showDialog(
                                        context: context,
                                        barrierDismissible: true, // tap outside to dismiss
                                        builder: (context) {
                                          return Dialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(16)),
                                            child: Padding(
                                              padding: const EdgeInsets.all(20),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text('Add Function',style: GoogleFonts.nunito(color:Colors.black,fontSize: 18,fontWeight: FontWeight.w700,),),
                                                  const SizedBox(height: 5,),
                                                  TextField(
                                                    style: GoogleFonts.nunito(
                                                      fontSize: 14,
                                                      color: Colors.black
                                                    ),
                                                    cursorColor: Colors.black,
                                                    decoration: InputDecoration(
                                                      contentPadding: EdgeInsets.symmetric(vertical: 12,horizontal: 23),
                                                      border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(10),
                                                        borderSide: BorderSide(
                                                          color: Colors.black38
                                                        )
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(10),
                                                          borderSide: BorderSide(
                                                              color: Colors.black38
                                                          )
                                                      ),
                                                      hint: Text('Function Name',style: GoogleFonts.nunito(fontSize: 16,color: Colors.black38),)
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  TextField(
                                                    cursorColor: Colors.black,
                                                    controller: _starttimeController,
                                                    style: GoogleFonts.nunito(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                    ),
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
                                                        'Start Time',
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
                                                    onTap: (){
                                                      _selectTime(context,_starttimeController);
                                                    },
                                                  ),
                                                  const SizedBox(height: 10,),
                                                  TextField(
                                                    cursorColor: Colors.black,
                                                    controller: _endtimeController,
                                                    style: GoogleFonts.nunito(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                    ),
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
                                                        'End Time',
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
                                                    onTap: (){
                                                      _selectTime(context,_endtimeController);
                                                    },
                                                  ),
                                                  const SizedBox(height: 20,),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        height: 40,
                                                        child: ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                            elevation: 0,
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(12),
                                                              side: BorderSide(color: Colors.black12),
                                                            ),
                                                            backgroundColor: Colors.white,
                                                            padding: EdgeInsets.symmetric(
                                                              horizontal: 35,
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            Navigator.pop(context);
                                                          },
                                                          child: Text(
                                                            'Back',
                                                            style: GoogleFonts.nunito(
                                                              fontSize: 15,
                                                              color: Colors.black,
                                                              fontWeight: FontWeight.w700,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: 20),
                                                      SizedBox(
                                                        height: 40,
                                                        child: ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                            elevation: 0,
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(10),
                                                              side: BorderSide(color: Colors.black12),
                                                            ),
                                                            backgroundColor: Colors.red.shade700,
                                                            padding: EdgeInsets.symmetric(
                                                              horizontal: 35,
                                                            ),
                                                          ),
                                                          onPressed:  () {
                                                            Navigator.pop(context);
                                                          },
                                                          child:
                                                              Text(
                                                                'Save',
                                                                style: GoogleFonts.nunito(
                                                                  fontSize: 15,
                                                                  color: Colors.white,
                                                                  fontWeight: FontWeight.w600,
                                                                ),
                                                              ),

                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                ],
                                              ),
                                            ),
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
                          const SizedBox(height: 35,),
                          Text('Added Functions',style: GoogleFonts.nunito(color:Colors.black,fontSize: 16,fontWeight: FontWeight.w700),),
                          const SizedBox(height: 10,),
                          Container(

                          ),
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
