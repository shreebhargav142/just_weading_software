import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';


class AddPartySheet extends StatefulWidget {
  const AddPartySheet({super.key});

  @override
  State<AddPartySheet> createState() => _AddPartySheetState();
}

class _AddPartySheetState extends State<AddPartySheet> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _aniversarydateController=TextEditingController();
  List<String> categories=[
   'A','B','C'
  ];
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            height: 23,
            top: -10,
            child:
            IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.close,color: Colors.white,)),
          ),
          Image.asset('assets/images/sheet.png',height: 680,fit: BoxFit.fill,   // <— makes image cover the area
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: 0,
              left: 20,
              right: 20,
              top: 10,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 0,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(40),
                            topRight: Radius.circular(40)
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Text("Party Name",
                      style: GoogleFonts.nunito(color:Colors.black,fontSize:16,fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  TextField(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16
                    ),
                    cursorColor: Colors.black,
      
                    decoration: InputDecoration(
      
                      hintText: "Wedding Reception",
                      hintStyle: GoogleFonts.nunito(color: Colors.black38),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.black
                        )
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Text('Category',style: GoogleFonts.nunito(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),),
                  const SizedBox(height: 5,),
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
                          value: selectedCategory,
                          padding: EdgeInsets.only(left: 19),
                          isExpanded: true,
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey,
                          ),
      
                          hint: Text(
                            "Select category",
                            style: GoogleFonts.nunito(
                              fontSize: 16,
                              color: Colors.black38,
                            ),
                          ),
                          items: categories.map((String item) {
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
                              selectedCategory = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
      
                  const SizedBox(height: 15),
                  Text("Address",
                      style: GoogleFonts.nunito(color:Colors.black,fontSize:16,fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  TextField(
                    maxLines: 4,
                    cursorColor: Colors.black,
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      color: Colors.black
                    ),
                    decoration: InputDecoration(
                        hint: Text('Address',style: GoogleFonts.nunito(fontSize: 16,color: Colors.black38)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                color: Colors.black
                            )
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                color: Colors.grey
                            )
                        )
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Text("Email Id",
                      style: GoogleFonts.nunito(color:Colors.black,fontSize:16,fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  TextField(
                    cursorColor: Colors.black,
                    style:GoogleFonts.nunito(
                      fontSize: 16,
                      color: Colors.black
                    ),
                    maxLines: 1,
                    decoration: InputDecoration(
                        hint: Text('Email',style: GoogleFonts.nunito(fontSize: 16,color: Colors.black38)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                color: Colors.black
                            )
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                color: Colors.grey
                            )
                        )
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Text("BirthDate", style: GoogleFonts.nunito(color:Colors.black,fontSize:16,fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  TextField(
                    cursorColor: Colors.black,
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      color: Colors.black
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
                        'Select BirthDate',
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
                          _dateController.text = formattedDate;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 15),
                  Text("Aniversary Date", style: GoogleFonts.nunito(color:Colors.black,fontSize:16,fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  TextField(
                    style: GoogleFonts.nunito(
                      color: Colors.black,
                      fontSize: 16
                    ),
                    controller: _aniversarydateController,
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
                              _aniversarydateController.text = formattedDate;
                            });
                          }
                        },
                        icon: Icon(
                          Icons.calendar_month,
                          color: Colors.grey,
                        ),
                      ),
                      hint: Text(
                        'Select AniversaryDate',
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
                          _aniversarydateController.text = formattedDate;
                        });
                      }
                    },
                  ),
                  Text("Mobile No",
                      style: GoogleFonts.nunito(color:Colors.black,fontSize:16,fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  TextField(
                    cursorColor: Colors.black,
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      color: Colors.black
                    ),
                    decoration: InputDecoration(
                        hintText: "Enter number of pax",
                        hintStyle: GoogleFonts.nunito(color: Color(0xFF23232380)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                color: Colors.grey
                            )
                        )
                    ),
                  ),
      
                  const SizedBox(height: 25),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF005BA8),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("+ Add Function",
                        style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(height: 60),
      
                ],
              ),
      
            ),
          )
        ],
      ),
    );
  }
}
