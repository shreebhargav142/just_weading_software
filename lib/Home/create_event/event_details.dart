import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:just_weding_software/Home/create_event/party_details.dart';

import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../home_screen.dart';

class EventDetailsScreen extends StatefulWidget {
  const EventDetailsScreen({super.key});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _startdateController = TextEditingController();
  final TextEditingController _endtimeController=TextEditingController();
  final TextEditingController _starttimeController=TextEditingController();
  TimeOfDay _time = TimeOfDay.now();
  TimeOfDay? pickedTime;
  int currentStep = 1; // current screen number
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
                            color: Colors.blue,
                            height: 18,
                            width: 4, // spacing around the divider
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Event Details',
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
                                'Status',
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
                                  value: selectedStatus,
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
                                  items: statusList.map((String item) {
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
                                      selectedStatus = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 11),
                          Row(
                            children: [
                              Text(
                                'Event Name',
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
                                  'Your event name',
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
                          SizedBox(height: 11),
                          Text(
                            'Event Date *',
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
                              controller: _startdateController,
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
                                        _startdateController.text =
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

                                    color: Colors.black38,
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
                                    _startdateController.text = formattedDate;
                                  });
                                }
                              },
                            ),
                          ),
                          SizedBox(height: 11),
                          Text(
                            'Start Time *',
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
                                suffixIcon: Icon(
                                Icons.access_time, // Changed to a Clock icon
                                color: Colors.grey,
                              ),

                                hint: Text(
                                  'Please Enter Time',
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
                          ),
                          SizedBox(height: 11),
                          Text(
                            'End Time *',
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
                                suffixIcon: IconButton(
                                  onPressed: () async {
                                    _selectTime(context,_endtimeController);
                                  },
                                  icon: Icon(
                                    Icons.access_time, // Changed to a Clock icon
                                    color: Colors.grey,
                                  ),
                                ),
                                hint: Text(
                                  'Please Enter Enter Date',
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
                          ),
                             const SizedBox(height: 10,),
                              Text(
                                'Number of Pax',
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
                              keyboardType: TextInputType.numberWithOptions(),
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
                                  'Please Enter Number of Pax',
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
                          SizedBox(height: 11),
                          Row(
                            children: [
                              Text(
                                'Event Remarks',
                                style: GoogleFonts.nunito(
                                  color: Colors.black,

                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
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
                                  'Please Enter Remarks',
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
                          const SizedBox(height: 10,),
                          Text('Party Type *',style: GoogleFonts.nunito(fontSize:16,fontWeight: FontWeight.bold,color: Colors.black),),
                          const SizedBox(height: 10,),
                          Padding(padding: EdgeInsets.only(right: 25),
                          child: Container(
                           decoration: BoxDecoration(
                             border: Border.all(color: Colors.grey,width: 1.5),
                             borderRadius: BorderRadius.circular(10)
                           ),
                            child: DropdownButtonHideUnderline(child: DropdownButton<String>(
                              borderRadius: BorderRadius.circular(12),
                              value: selectedParty,
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
                              items: partyList.map((String item) {
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
                                  selectedParty= newValue!;
                                });
                              },

                            )),
                            
                          ),
                          ),

                          SizedBox(height: 20),
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
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
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
                                    backgroundColor: Colors.red.shade700,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 50,
                                    ),
                                  ),
                                  onPressed:  () {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>PartyDetailsScreen()));
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
