import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyEventsPage extends StatelessWidget {
  final List<Map<String, dynamic>> events = [
    {
      "partyName": "ASHISH BHAI",
      "type": "FUNCTION",
      "pax": 400,
      "venue": "-",
      "startDate": "04 December 2025",
      "endDate": "04 December 2025",
      "status": "Confirmed",
    },
    {
      "partyName": "SHAILESH BHAI",
      "type": "FUNCTION",
      "pax": 500,
      "venue": "-",
      "startDate": "07 December 2025",
      "endDate": "07 December 2025",
      "status": "Confirmed",
    },
    {
      "partyName": "NITIN BHAI",
      "type": "FUNCTION",
      "pax": 550,
      "venue": "-",
      "startDate": "10 December 2025",
      "endDate": "10 December 2025",
      "status": "Confirmed",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          SizedBox(height: 40,),
          Padding(
            padding: const EdgeInsets.only(left: 11.0),
            child: Row(
              children: [
                IconButton(onPressed: (){
                  Navigator.pop(context);
                }, icon: Icon(Icons.arrow_back_ios,color: Colors.black,)),
                SizedBox(width: 10,),
                Text('My Events',style: GoogleFonts.nunito(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 19),),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: events.length,
              itemBuilder: (context, index) {
                final e = events[index];
                return Card(
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  children: [

                    // ------------------ TOP GREY SECTION ------------------
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xffF5F5F5),  // light grey
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Party name: ${e['partyName']}",
                                style: GoogleFonts.nunito(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  e['status'],
                                  style: GoogleFonts.nunito(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 6),

                          Text(
                            e['type'],
                            style: GoogleFonts.nunito(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ------------------ MIDDLE WHITE SECTION ------------------
                    Container(
                      width: double.infinity,
                      color: Colors.white,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          // Pax / Venue
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Number of Pax",
                                      style: GoogleFonts.nunito(color: Colors.grey)),
                                  Text("${e['pax']}",
                                      style: GoogleFonts.nunito(color: Colors.black,
                                          fontWeight: FontWeight.bold, fontSize: 16)),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Venue",
                                      style: GoogleFonts.nunito(color: Colors.grey)),
                                  Text("${e['venue']}",
                                      style: GoogleFonts.nunito(color: Colors.black,
                                          fontWeight: FontWeight.bold, fontSize: 16)),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: 14),

                          // Dates
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Start Date",
                                      style: GoogleFonts.nunito(color: Colors.grey)),
                                  Text("${e['startDate']}",
                                      style: GoogleFonts.nunito(color: Colors.black,
                                          fontWeight: FontWeight.w700, fontSize: 15)),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("End Date",
                                      style: GoogleFonts.nunito(color: Colors.grey)),
                                  Text("${e['endDate']}",
                                      style: GoogleFonts.nunito(color: Colors.black,
                                          fontWeight: FontWeight.w700, fontSize: 15)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // ------------------ BOTTOM GREY ICON BAR ------------------
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color(0xffF5F5F5),
                        borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(14)),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Padding(
                        padding: EdgeInsets.only(left: 78,right: 65),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(onPressed:(){},icon: const Icon(Icons.visibility_outlined)),
                            IconButton(onPressed:(){},icon: const Icon(Icons.note_alt_outlined)),
                            IconButton(onPressed:(){},icon: const Icon(Icons.restaurant_menu)),
                            IconButton(onPressed:(){},icon: const Icon(Icons.video_collection)),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                );

              },
            ),
          ),
          const SizedBox(height: 37,),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.red,
        onPressed: () {},
        label: const Text("+ Add Event"),
      ),
    );
  }
}
