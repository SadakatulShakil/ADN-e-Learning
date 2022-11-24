import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:radda_moodle_learning/ApiModel/calendar_events_response.dart' as upComing;
import 'package:radda_moodle_learning/ApiModel/monthly_calendar_response.dart' as monthly;
import 'package:radda_moodle_learning/Screens/create_calendar_event.dart';
import 'package:radda_moodle_learning/Screens/monthly_calendar_details.dart';
import 'package:radda_moodle_learning/Screens/upcoming_calender_details.dart';
import 'package:radda_moodle_learning/utills.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../ApiCall/HttpNetworkCall.dart';
import '../../../Helper/operations.dart';

class DashBoardCalederList extends StatefulWidget{
  String firstUpcomingEvent;
  String firstUpcomingEventDate;
  Map<String, dynamic> dateList;
  List<upComing.Events> eventList;
  List<monthly.Weeks> weekList;
  List<monthly.Days> daysList;
  List<monthly.Events> monthlyEventList;
  DashBoardCalederList(this.firstUpcomingEvent, this.firstUpcomingEventDate, this.dateList, this.eventList, this.weekList, this.daysList, this.monthlyEventList);


  @override
  State<StatefulWidget> createState() => InitState();
}
class InitState extends State<DashBoardCalederList> {
  NetworkCall networkCall = NetworkCall();
  String token = '';
  String userId = '';
  // String firstUpcomingEvent = '';
  // String firstUpcomingEventDate = '';
  // Map<String, dynamic> dateList = {};
  // List<upComing.Events> eventList = [];
  // List<monthly.Weeks> weekList = [];
  // List<monthly.Days> daysList = [];
  // List<monthly.Events> monthlyEventList = [];
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late PageController pageController;
  // final kToday = DateTime.now();
// final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
// final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
  @override
  void initState() {
    super.initState();
    getSharedData();
    setState(() {

    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<dynamic> getEventsForDay(day){
     print(">>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<"+widget.dateList[day.toString().replaceAll("Z", "")].toString());
    return widget.dateList[day.toString().replaceAll("Z", "")] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return initWidget(context);
  }

  Widget initWidget(BuildContext context) {
    String headerText = DateFormat.MMMM().format(_focusedDay);
    print('Syear: '+ _focusedDay.year.toString()+'Smonth: '+ _focusedDay.month.toString());
    return Scaffold(
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      print(_focusedDay);
                      pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                      _focusedDay = _focusedDay.subtract(const Duration(days: 30));
                      print('year-: '+ _focusedDay.year.toString()+' month-: '+ _focusedDay.month.toString());
                      setState((){});
                    },
                    icon: Icon(
                      Icons.keyboard_arrow_left,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(headerText, style: TextStyle(color: Colors.green, fontSize: 15)),
                      SizedBox(width: 8,),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CreateCalenderEventPage()));
                        },
                          child: Text('[Create Events]', style: TextStyle(color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold))),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                      _focusedDay = _focusedDay.add(const Duration(days: 30));
                      print('year+: '+ _focusedDay.year.toString()+' month+: '+ _focusedDay.month.toString());
                      setState((){});
                    },
                    icon: const Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Card(
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.all(8),
                child: TableCalendar(
                  firstDay: DateTime.utc(DateTime.now().year,DateTime.now().month-10,DateTime.now().day),
                  lastDay: DateTime.utc(DateTime.now().year,DateTime.now().month+10,DateTime.now().day),
                  focusedDay: _focusedDay,
                  headerVisible: false,
                  onCalendarCreated: (controller) => pageController = controller,
                  onPageChanged: (focusedDay) => _focusedDay = focusedDay,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);

                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    if (!isSameDay(_selectedDay, selectedDay)) {
                      // Call `setState()` when updating the selected day
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                        openDialog(getEventsForDay(selectedDay));
                        print('output '+getEventsForDay(selectedDay).first.name.toString());
                      });
                    }
                  },
                  // holidayPredicate: (day) {
                  //   // Every 20th day of the month will be treated as a holiday
                  //   return day.weekday == 5;
                  // },
                  daysOfWeekVisible: true,
                  sixWeekMonthsEnforced: true,
                  shouldFillViewport: false,
                  headerStyle: HeaderStyle(titleTextStyle: TextStyle(fontSize: 20, color: Colors.deepPurple, fontWeight: FontWeight.w800)),
                  calendarStyle: CalendarStyle(todayTextStyle: TextStyle(fontSize:20, color: Colors.white, fontWeight: FontWeight.bold )),
                  eventLoader: getEventsForDay,
                ),
              ),
              const SizedBox(height: 8.0),
              ///upcoming events list
              Visibility(
                visible: widget.eventList.length>0?true:false,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UpcomingCalenderDetailsPage(widget.eventList)));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Upcoming Event', style: TextStyle(fontSize: 12)),
                        Text('View all', style: TextStyle(color: Colors.greenAccent, fontSize: 12),),
                      ],
                    ),
                  ),
                ),
              ),
              Divider(),
              Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.eventList.length,
                      itemBuilder: (context, index) {
                        final mCourseData = widget.eventList[index];

                        return buildUpcomingEvent(mCourseData);
                      })),
            ],
          ),
        ),
    );
  }
  void getSharedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('TOKEN')!;
    userId = prefs.getString('userId')!;
    setState(() {
      //getEventsData(token);
      //getGradeContent(token, widget.mGradeData.id.toString(), userId);
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
  String getDateStump(String sTime) {
    int timeNumber = int.parse(sTime);
    return DateTime.fromMillisecondsSinceEpoch(timeNumber * 1000).toString();
  }

  Widget buildUpcomingEvent(upComing.Events mCourseData) => GestureDetector(
      onTap: () {
        /// do click item task
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => CoursesDetailsPage(mCourseData)));
      },
      child:
      Container(
        margin: const EdgeInsets.only(left: 12.0, right: 12, top: 5, bottom: 8),
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black12)),
        child: Row(
          children: [
            Image.asset('assets/images/course_image.png',height: 30, width: 30,fit: BoxFit.cover,),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Text(mCourseData.name.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: GoogleFonts.comfortaa(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text( DateFormat.yMMMEd().format(DateTime.parse(
                        getDateStump(mCourseData
                            .timestart
                            .toString()))),
                        style: GoogleFonts.comfortaa(
                            color: Colors.black54,
                            fontSize: 13,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            )
          ],
        ),
      )
  );


  void openDialog(List<dynamic> eventsForDay) {

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Events'),
            content: Container(
              height: 200.0, // Change as per your requirement
              width: MediaQuery.of(context).size.width/3,
              child: Column(
                children: [
              eventsForDay.length>0?ListView.builder(
                      shrinkWrap: true,
                      itemCount: eventsForDay.length,
                      itemBuilder: (context, index) {
                        final mEventData = eventsForDay[index];

                        return buildDialogEvent(mEventData);
                      }):Center(
              child: SizedBox(
              height: 100,
              child: Column(
                children: [
                  Icon(Icons.warning_amber, size: 30,),
                  Text('No event Found!'),
                ],
              ),
            ),
          ),
                ],
              ),
            ),
            actions: [
              Visibility(
                visible: eventsForDay.length>0?true:false,
                child: InkWell(
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MonthlyCalenderDetailsPage(eventsForDay)));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      width:150,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xFF00BC78)
                      ),
                      child: Center(
                        child: Text("View Details", style: GoogleFonts.comfortaa(color: Colors.white, fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: eventsForDay.length>0?true:false,
                child: InkWell(
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CreateCalenderEventPage()));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      width:150,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blueAccent,
                      ),
                      child: Center(
                        child: Text("Create Events", style: GoogleFonts.comfortaa(color: Colors.white, fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
  Widget buildDialogEvent(mEventData) => GestureDetector(
      onTap: () {
        /// do click item task
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => CoursesDetailsPage(mCourseData)));
      },
      child:
      Container(
        margin: const EdgeInsets.only(left: 12.0, right: 12, top: 5, bottom: 8),
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black12)),
        child: Row(
          children: [
            Image.asset('assets/images/course_image.png',height: 30, width: 30,fit: BoxFit.cover,),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 3,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Text(mEventData.popupname.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: GoogleFonts.comfortaa(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text( DateFormat.yMMMEd().format(DateTime.parse(
                        getDateStump(mEventData
                            .timestart
                            .toString()))),
                        style: GoogleFonts.comfortaa(
                            color: Colors.black54,
                            fontSize: 13,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            )
          ],
        ),
      )
  );


}

