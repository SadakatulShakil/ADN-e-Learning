import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:radda_moodle_learning/Helper/colors_class.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ApiCall/HttpNetworkCall.dart';
import '../Helper/operations.dart';

class CreateCalenderEventPage extends StatefulWidget {
  String isSelectd;
  String date;
  CreateCalenderEventPage(this.isSelectd, this.date);

  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<CreateCalenderEventPage> {
  String initialDateText = 'Select event start date';
  String initialTimeText = 'Select event start time';
  String initialDateText2 = 'Select event duration date';
  String initialTimeText2 = 'Select event duration time';
  final dateController = TextEditingController();
  final eventDescriptionController = TextEditingController();
  final eventTitleController = TextEditingController();
  String? selectedTime;
  String? selectedTime2;
  DateTime? startdate;
  DateTime? startdate1;
  String? durationValue;
  int? duration_val;
  String token ='';
  String userId ='';
  NetworkCall networkCall = NetworkCall();
  @override
  void initState() {
    super.initState();
    getSharedData();
    duration_val = 0;
    startdate = DateTime.now();
    setState(() {});
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
                  height: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).size.height / 9,
                  transform: Matrix4.translationValues(0, 10, 1),
                  decoration: BoxDecoration(
                      color: Color(0xFFFAFAFA),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25))),
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
                      SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, bottom: 5),
                          child: Text("Event title",
                              style: GoogleFonts.nanumGothic(

                                  fontSize: 12,
                                  )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: TextField(
                          controller: eventTitleController,
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
                              hintText: 'Enter event title',
                              hintStyle: GoogleFonts.nanumGothic(
                                color: Colors.black,
                                fontSize: 15,
                              )),
                          autofocus: false,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, bottom: 5),
                          child: Text("Description",
                              style: GoogleFonts.nanumGothic(

                                  fontSize: 12,
                                  )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: TextField(
                          controller: eventDescriptionController,
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
                              hintText: 'Enter event description',
                              hintStyle: GoogleFonts.nanumGothic(
                                color: Colors.black,
                                fontSize: 15,
                              )),
                          autofocus: false,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      widget.isSelectd != 'selected'
                          ? Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12.0, right: 15.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Event start date',
                                        style: GoogleFonts.nanumGothic(
                                          fontSize: 12,
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12.0, right: 15.0, bottom: 5.0),
                                  child: InkWell(
                                    onTap: () async {
                                      final newDate = await pickDate();
                                      if (newDate == null) return;
                                      final newDateTime = DateTime(newDate.year,
                                          newDate.month, newDate.day);
                                      setState(() {
                                        startdate = newDateTime;
                                        String mth = '${startdate!.month}';
                                        String dy = '${startdate!.day}';
                                        print('---=-=-=-=- '+mth.length.toString());
                                        mth.length == 1? mth = '0'+mth: mth = mth;
                                        dy.length == 1? dy = '0'+dy: dy = dy;
                                        String dateTimeText =
                                            '${startdate!.year}-'+mth+'-'+dy;
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
                                              offset: Offset(0, 2))
                                        ],
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            width: 1, color: Color(0XFFE8E8E8)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15.0, left: 5.0),
                                                child: Text(
                                                  initialDateText,
                                                  style:
                                                      GoogleFonts.nanumGothic(
                                                    color: Colors.black54,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                              Icon(Icons.calendar_today_rounded,
                                                  size: 15,
                                                  color: Colors.black54),
                                            ]),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 12, right: 12, bottom: 5),
                              child: Text("Event start date",
                                  style: GoogleFonts.nanumGothic(
                                    fontSize: 12,)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            child: TextField(
                              controller: dateController..text = widget.date,
                              enabled: false,
                              decoration: InputDecoration(
                                  isDense: true,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black12),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black12),
                                  ),
                                  //prefixIcon: Image.asset("assets/icons/user_icon.png", width: 20, height: 20),
                                  hintText: '',
                                  hintStyle: GoogleFonts.nanumGothic(
                                    color: Colors.black,
                                    fontSize: 15,
                                  )),
                              autofocus: false,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 12.0, right: 15.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Event start time',
                                  style: GoogleFonts.nanumGothic(
                                    fontSize: 12,
                                    //color: Colors.black,
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 12.0, right: 15.0, bottom: 5.0),
                            child: InkWell(
                              onTap: () {
                                print('----------  ' + 'clicked time');
                                displayTimeDialog();
                                setState(() {});
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 7,
                                        offset: Offset(0, 2))
                                  ],
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 1, color: Color(0XFFE8E8E8)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 15.0, left: 5.0),
                                          child: Text(
                                            selectedTime != null
                                                ? '$selectedTime'
                                                : initialTimeText,
                                            style: GoogleFonts.nanumGothic(
                                              color: Colors.black54,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        Icon(Icons.calendar_today_rounded,
                                            size: 15, color: Colors.black54),
                                      ]),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Container(
                          child: Row(
                            children: [
                              Radio(
                                value: 0,
                                groupValue: duration_val,
                                onChanged: _handleRadioValueChange,
                                activeColor: new Color(0xFF29A74A),
                              ),
                              Text('Without duration', style: GoogleFonts.comfortaa(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,)),
                              Radio(
                                value: 1,
                                groupValue: duration_val,
                                onChanged: _handleRadioValueChange,
                                activeColor: new Color(0xFF29A74A),
                              ),
                              Text('Until', style: GoogleFonts.comfortaa(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,)),
                            ],
                          ),
                        ),
                      ),


                      Visibility(
                        visible: duration_val != 0?true:false,
                        child: Container(
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0, right: 15.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('Event duration date',
                                          style: GoogleFonts.nanumGothic(
                                            fontSize: 12,
                                          )),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0, right: 15.0, bottom: 5.0),
                                    child: InkWell(
                                      onTap: () async {
                                        final newDate = await pickDate();
                                        if (newDate == null) return;
                                        final newDateTime = DateTime(newDate.year,
                                            newDate.month, newDate.day);
                                        setState(() {
                                          startdate = newDateTime;
                                          String mth = '${startdate!.month}';
                                          String dy = '${startdate!.day}';
                                          print('---=-=-=-=- '+mth.length.toString());
                                          mth.length == 1? mth = '0'+mth: mth = mth;
                                          dy.length == 1? dy = '0'+dy: dy = dy;
                                          String dateTimeText =
                                              '${startdate!.year}-'+mth+'-'+dy;
                                          initialDateText2 = dateTimeText;
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
                                                offset: Offset(0, 2))
                                          ],
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                              width: 1, color: Color(0XFFE8E8E8)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      right: 15.0, left: 5.0),
                                                  child: Text(
                                                    initialDateText2,
                                                    style:
                                                    GoogleFonts.nanumGothic(
                                                      color: Colors.black54,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                                Icon(Icons.calendar_today_rounded,
                                                    size: 15,
                                                    color: Colors.black54),
                                              ]),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(left: 12.0, right: 15.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('Event duration time',
                                          style: GoogleFonts.nanumGothic(
                                            fontSize: 12,
                                            //color: Colors.black,
                                          )),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0, right: 15.0, bottom: 5.0),
                                    child: InkWell(
                                      onTap: () {
                                        print('----------  ' + 'clicked time');
                                        displayTimeDialog2();
                                        setState(() {});
                                      },
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey,
                                                blurRadius: 7,
                                                offset: Offset(0, 2))
                                          ],
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                              width: 1, color: Color(0XFFE8E8E8)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      right: 15.0, left: 5.0),
                                                  child: Text(
                                                    selectedTime2 != null
                                                        ? '$selectedTime2'
                                                        : initialTimeText2,
                                                    style: GoogleFonts.nanumGothic(
                                                      color: Colors.black54,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                                Icon(Icons.timelapse_sharp,
                                                    size: 15, color: Colors.black54),
                                              ]),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),


                      SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 30.0, right: 30.0),
                        child: InkWell(
                          onTap: () {

                            String startDateValue = widget.isSelectd != 'selected'?getEpochTime(initialDateText, selectedTime!):getEpochTime(widget.date, selectedTime!);
                            String durationDate = duration_val == 0?'0':getEpochTime(initialDateText2, selectedTime2!);
                            String name = eventTitleController.text.toString();
                            String description = eventDescriptionController.text.toString();
                            String format = '1';
                            String visible = '1';
                            String sequence = '1';
                            String courseid = '0';
                            String groupid = '0';
                            String eventtype = 'user';

                            CallEventCreate(name, description, startDateValue, durationDate, format, visible, sequence, courseid, groupid, eventtype);
                            //print('check settings  '+ firstNameController.text.toString());
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Container(
                              width: 350,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: PrimaryColor),
                              child: Center(
                                child: Text(
                                  "Create now",
                                  style: GoogleFonts.nanumGothic(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),

                      // Padding(
                      //   padding: EdgeInsets.only(
                      //       left: 30.0, right: 30.0, bottom: 30),
                      //   child: InkWell(
                      //     onTap: () {
                      //       //Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                      //     },
                      //     child: Card(
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(15),
                      //       ),
                      //       child: Container(
                      //         width: 350,
                      //         height: 50,
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(15),
                      //         ),
                      //         child: Center(
                      //           child: Text(
                      //             "Cancel",
                      //             style: GoogleFonts.nanumGothic(
                      //                 color: Colors.black,
                      //                 fontWeight: FontWeight.bold),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  )),
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

  Future<DateTime?> pickDate() => showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1990),
        lastDate: DateTime(2050),
      );

  Future<void> displayTimeDialog() async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      setState(() {
        selectedTime = time.format(context);
      });
    }
  }
  Future<void> displayTimeDialog2() async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      setState(() {
        selectedTime2 = time.format(context);
      });
    }
  }


  void _handleRadioValueChange(int? value) {
    setState(() {
      duration_val = value!;

      switch (value) {
        case 0:
          durationValue = "Without duration";
          break;
        case 1:
          durationValue = "Until";
          break;
      }
    });
  }



  getEpochTime(String date, String time){
    DateTime timeStartDt = DateTime.parse(date+' '+time);
    return timeStartDt.millisecondsSinceEpoch.toString();
  }

  Future CallEventCreate(String name,
      String description,
      String startDateValue,
      String durationDate,
      String format,
      String visible,
      String sequence,
      String courseid,
      String groupid,
      String eventtype) async{

    print('value:  '+ name+' '+description+' '+ startDateValue+' '+durationDate+' '+format+' '+visible+' '+sequence+' '+courseid+' '+groupid+ ' '+eventtype);

    CommonOperation.showProgressDialog(context, "loading", true);
    final eventCreateData =
    await networkCall.EventCreateCall(token, name, description, startDateValue, format, durationDate, visible, sequence, courseid, groupid, eventtype);
    if (eventCreateData != null) {

      CommonOperation.hideProgressDialog(context);
      //showToastMessage(message);
      setState(() {
        showToastMessage('Event Create successfully !');
        Navigator.of(context).pop();
      });
    } else {
      CommonOperation.hideProgressDialog(context);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoged', false);
      showToastMessage('your session is expire ');
    }
  }

  void getSharedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('TOKEN')!;
    userId = prefs.getString('userId')!;
    setState(() {

    });
  }

  void showToastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0 //message font size
    );
  }


}
