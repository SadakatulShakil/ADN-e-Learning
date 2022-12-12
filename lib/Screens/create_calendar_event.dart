import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:radda_moodle_learning/Helper/colors_class.dart';

class CreateCalenderEventPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<CreateCalenderEventPage> {
  String initialDateText = 'Select event date ';
  String initialTimeText = 'Select event time ';
  String? selectedTime;
  DateTime? startdate;
  DateTime? startdate1;
  @override
  void initState() {
    setState(() {
    });
    super.initState();
    startdate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return initWidget(context);
  }

  Widget initWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PrimaryColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Calendar',
            style: GoogleFonts.nanumGothic(
                color: const Color(0xFFFFFFFF),
                fontWeight: FontWeight.w700,
                fontSize: 18)),
        centerTitle: false,
      ),
      backgroundColor: PrimaryColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height-MediaQuery.of(context).size.height/9,
                  transform: Matrix4.translationValues(0, 10, 1),
                  decoration: BoxDecoration(
                      color: Color(0xFFFAFAFA),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25)
                      )
                  ),
                  child: Column(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/rectangle_bg.png"),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25))),
                          height: 70,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, top: 20.0, right: 8),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Create Event',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.nanumGothic(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      SizedBox(height: 15,),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12, right: 12, bottom: 5),
                          child: Text("Event title",
                              style: GoogleFonts.nanumGothic(
                                  color: Colors.black45,
                                  fontSize: 12, fontWeight: FontWeight.bold)),
                        ),),
                      Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: TextField(
                          //controller: firstNameController..text = firstName,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              isDense: true,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black12),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black12),
                              ),
                              //prefixIcon: Image.asset("assets/icons/user_icon.png", width: 20, height: 20),
                              hintText: 'Enter event title',hintStyle: GoogleFonts.nanumGothic(
                            color: Colors.black,
                            fontSize: 15,
                          )
                          ),
                          autofocus: false,
                        ),
                      ),
                      SizedBox(height: 15,),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12, right: 12, bottom: 5),
                          child: Text("Description",
                              style: GoogleFonts.nanumGothic(
                                  color: Colors.black45,
                                  fontSize: 12, fontWeight: FontWeight.bold)),
                        ),),
                      Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: TextField(
                          //controller: firstNameController..text = firstName,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              isDense: true,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black12),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black12),
                              ),
                              //prefixIcon: Image.asset("assets/icons/user_icon.png", width: 20, height: 20),
                              hintText: 'Enter event description',hintStyle: GoogleFonts.nanumGothic(
                            color: Colors.black,
                            fontSize: 15,
                          )
                          ),
                          autofocus: false,
                        ),
                      ),
                      SizedBox(height: 15,),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0, right: 15.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Event date', style: GoogleFonts.nanumGothic(
                                fontSize: 15,
                                //color: Colors.black,
                                fontWeight: FontWeight.w700,)),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 5.0),
                            child: InkWell(
                              onTap: () async{
                                final newDate = await pickDate();
                                if(newDate == null) return;
                                final newDateTime = DateTime(
                                    newDate.year,
                                    newDate.month,
                                    newDate.day

                                );
                                setState(() {
                                  startdate = newDateTime;

                                  String dateTimeText = '${startdate!.day}/${startdate!.month}/${startdate!.year}';
                                  initialDateText = dateTimeText;
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 7,
                                        offset: Offset(0,2)
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(width: 1, color: Color(0XFFE8E8E8)),
                                ),
                                child:Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(right: 15.0, left: 5.0),
                                          child: Text(
                                            initialDateText, style: GoogleFonts.nanumGothic(
                                            color: Colors.black54,
                                            fontSize: 15,
                                          ),
                                          ),
                                        ),
                                        Icon(Icons.calendar_today_rounded,
                                            size: 15,
                                            color: Colors.black54),
                                      ]
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15,),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0, right: 15.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Event time', style: GoogleFonts.nanumGothic(
                                fontSize: 15,
                                //color: Colors.black,
                                fontWeight: FontWeight.w700,)),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 5.0),
                            child: InkWell(
                              onTap: () {
                                print('----------  '+ 'clicked time');
                                displayTimeDialog();
                                setState(() {

                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 7,
                                        offset: Offset(0,2)
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(width: 1, color: Color(0XFFE8E8E8)),
                                ),
                                child:Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(right: 15.0, left: 5.0),
                                          child: Text(
                                            selectedTime != null? '$selectedTime':initialTimeText, style: GoogleFonts.nanumGothic(
                                            color: Colors.black54,
                                            fontSize: 15,
                                          ),
                                          ),
                                        ),
                                        Icon(Icons.calendar_today_rounded,
                                            size: 15,
                                            color: Colors.black54),
                                      ]
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25,),
                      Padding(
                        padding: EdgeInsets.only(left: 30.0, right: 30.0),
                        child: InkWell(
                          onTap: (){
                            //print('check settings  '+ firstNameController.text.toString());
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Container(
                              width:350,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: PrimaryColor
                              ),
                              child: Center(
                                child: Text("Create now", style: GoogleFonts.nanumGothic(color: Colors.white, fontWeight: FontWeight.bold),),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15,),
                      Padding(
                        padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30),
                        child: InkWell(
                          onTap: (){
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Container(
                              width:350,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),

                              ),
                              child: Center(
                                child: Text("Cancel", style: GoogleFonts.nanumGothic(color: Colors.black, fontWeight: FontWeight.bold),),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getDateStump(String sTime) {
    int timeNumber = int.parse(sTime);
    return DateTime.fromMillisecondsSinceEpoch(timeNumber * 1000).toString();
  }

  Future<DateTime?>pickDate() => showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1990),
    lastDate: DateTime(2050),
  );
  Future<void> displayTimeDialog() async {
    final TimeOfDay? time =
    await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      setState(() {
        selectedTime = time.format(context);
      });
    }
  }

}
