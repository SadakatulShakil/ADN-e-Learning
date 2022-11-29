import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:radda_moodle_learning/ApiModel/badges_response.dart';
import 'package:radda_moodle_learning/Screens/DashBoard/TabBarComponents/activity_list.dart';
import 'package:radda_moodle_learning/Screens/DashBoard/TabBarComponents/caleder_list.dart';
import 'package:radda_moodle_learning/Screens/DashBoard/TabBarComponents/courses_list.dart';
import 'package:radda_moodle_learning/Screens/DashBoard/TabBarComponents/grades_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:radda_moodle_learning/ApiModel/calendar_events_response.dart' as upComing;
import 'package:radda_moodle_learning/ApiModel/monthly_calendar_response.dart' as monthly;
import '../../ApiCall/HttpNetworkCall.dart';
import '../../ApiModel/gradeResponse.dart';
import '../../Helper/colors_class.dart';
import '../../Helper/operations.dart';

class HomeComponents extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<HomeComponents> {
  NetworkCall networkCall = NetworkCall();
  List<dynamic> recentCourseList = [];
  List<Badges> badgesDataList = [];
  List<dynamic> courseList = [];
  List<Grades> gradeList = [];
  String name ='';
  String token ='';
  String imageurl ='';
  String email ='';
  String firstUpcomingEvent = '';
  String firstUpcomingEventDate = '';
  Map<String, dynamic> dateList = {};
  List<upComing.Events> eventList = [];
  List<monthly.Weeks> weekList = [];
  List<monthly.Days> daysList = [];
  List<monthly.Events> monthlyEventList = [];
  DateTime _focusedDay = DateTime.now();
  Connectivity connectivity = Connectivity();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkconnectivity();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return initWidget(context);
  }

  Widget initWidget(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: PrimaryColor,
        body: Column(
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/rectangle_bg.png"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
                height: 100,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(imageurl.toString()),
                        radius: 50,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(name.toString(), style: GoogleFonts.comfortaa(
                              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white
                          ),),
                        ),
                        Row(
                          children: [
                            Icon(Icons.email_outlined, size: 12, color: Colors.white,),
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0, bottom: 2),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(email.toString(), style: GoogleFonts.comfortaa(
                                    fontSize: 12, color: Colors.white
                                ),),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                )
            ),

            // the tab bar with two items
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              height: 50,
              child: TabBar(
                isScrollable: true,
                labelColor: Colors.black,
                tabs: [
                  // Tab(text: 'All Products'),
                  Tab(text: 'Courses'),
                  Tab(text: 'Grades'),
                  Tab(text: 'Badges'),
                  Tab(text: 'Calender')
                ],
              ),
            ),

            // create widgets for each tab bar here
            Expanded(
              child: TabBarView(
                children: [
                  RefreshIndicator(
                      onRefresh: checkconnectivity,
                      child: DashBoardCoursesList(recentCourseList, courseList)),
                  RefreshIndicator(
                      onRefresh: checkconnectivity,
                      child: DashBoardGradesList(courseList, gradeList)),
                  RefreshIndicator(
                      onRefresh: checkconnectivity,
                      child: DashBoardActivityList(badgesDataList,token, courseList)),
                  RefreshIndicator(
                      onRefresh: checkconnectivity,
                      child: DashBoardCalederList(firstUpcomingEvent, firstUpcomingEventDate, dateList, eventList))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future getSharedData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name')!;
    imageurl = prefs.getString('imageUrl')!;
    token = prefs.getString('TOKEN')!;
    String userid = prefs.getString('userId')!;
    setState(() {
      getProfileInfo(token, userid);
      getRecentCourses(token, userid);
    });
  }
  Future<void> getProfileInfo(String token, String userId) async {
    //CommonOperation.showProgressDialog(context, "loading", true);
    final profileInfoData =
    await networkCall.ProfileInfoCall(token, userId);
    if (profileInfoData != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String message = 'Success';
      //userName = profileInfoList[0].username.toString();
      email = profileInfoData[0].email.toString();
      //CommonOperation.hideProgressDialog(context);
      //showToastMessage(message);
      setState(() {
        getBadgesInfo(token, userId);
      });
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoged', false);
      showToastMessage('your session is expire ');
    }
  }
  Future<void> getBadgesInfo(String token, String userId) async {
    CommonOperation.showProgressDialog(context, "loading", true);
    final badgesData =
    await networkCall.BadgesResponseCall(token, userId);
    if (badgesData != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String message = 'Success';
      badgesDataList = badgesData.badges!;
      //print('data_count1 ' + recentCourseList.first.toString());
      CommonOperation.hideProgressDialog(context);
      //showToastMessage(message);
      setState(() {

      });
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoged', false);
      showToastMessage('your session is expire ');
    }
  }
  Future<void> getRecentCourses(String token, String userId) async {
    CommonOperation.showProgressDialog(context, "loading", true);
    final recentCoursesData =
    await networkCall.RecentCoursesListCall(token, userId);
    if (recentCoursesData != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String message = 'Success';
      recentCourseList = recentCoursesData;
      //print('data_count1 ' + recentCourseList.first.toString());
      //CommonOperation.hideProgressDialog(context);
      //showToastMessage(message);
      setState(() {
        getAllCourses(token, userId);
      });
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoged', false);
      showToastMessage('your session is expire ');
    }
  }
  Future<void> getAllCourses(String token, String userId) async {
    //CommonOperation.showProgressDialog(context, "loading", true);
    final userCoursesData =
    await networkCall.UserCoursesListCall(token, userId);
    if (userCoursesData != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String message = 'Success2';
      courseList = userCoursesData;
      //count = courseList.length.toString();
      //print('data_count1 ' + courseList.first.toString());
      //showToastMessage(message);
      //CommonOperation.hideProgressDialog(context);
      setState(() {
        getCoursesGrade(token);
      });
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoged', false);
      showToastMessage('your session is expire ');
    }
  }
  Future<void> getCoursesGrade(String token) async {
    //CommonOperation.showProgressDialog(context, "loading", true);
    final gradeListData = await networkCall.GradesCountCall(token);
    if (gradeListData != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String message = 'Success2';
      //showToastMessage(message);
      //CommonOperation.hideProgressDialog(context);
      gradeList = gradeListData.grades!;
      //print('-----> ' + gradeList.first.courseid.toString());
      setState(() {
        getEventsData(token);
      });
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoged', false);
      showToastMessage('your session is expire ');
    }
  }
  Future<void> getEventsData(String token) async{
    //CommonOperation.showProgressDialog(context, "loading", true);
    final calenderEventsData =
    await networkCall.CalendarEventsCall(token);
    if (calenderEventsData != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String message = 'Success';
      eventList = calenderEventsData.events!;
      firstUpcomingEvent = eventList.length>0?eventList.first.name.toString():'';
      firstUpcomingEventDate =  eventList.length>0?eventList.first.timestart.toString():'';
      for(int i =0; i<eventList.length;i++){
        var dateListIndex = DateTime.parse(getDateStump(eventList[i].timesort.toString())).toString();
        dateList.containsKey(dateListIndex) ? dateList[dateListIndex].add(eventList[i].timesort) : dateList[dateListIndex] = [eventList[i].timesort];
      }
      print('date list '+ dateList.toString());
      CommonOperation.hideProgressDialog(context);
      //showToastMessage(message);
      setState(() {
        //getMonthlyEventsData(token, _focusedDay.year.toString(),_focusedDay.month.toString());
        //Navigator.push(context, MaterialPageRoute(builder: (context) => QuizDetailsPage(widget.name, widget.quizId, startAttemptData.attempt!.id.toString())));
      });
    } else {
      CommonOperation.hideProgressDialog(context);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoged', false);
      showToastMessage('your session is expire ');
    }
  }
  Future<void> getMonthlyEventsData(String token, String year, String month) async{
    //CommonOperation.showProgressDialog(context, "loading", true);
    final monthlyCalenderEventsData =
    await networkCall.MonthlyCalendarEventsCall(token, year, month);
    if (monthlyCalenderEventsData != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String message = 'Success';
      weekList = monthlyCalenderEventsData.weeks!;
      // for(int i =0;i<weekList.length; i++){
      //   daysList = monthlyCalenderEventsData.weeks![i].days!;
      //   for(int j=0; j<daysList.length;j++){
      //     monthlyEventList = monthlyCalenderEventsData.weeks![i].days![j].events!;
      //     for(int k=0;k<monthlyEventList.length;k++){
      //       var dateListIndex = DateTime.parse(getDateStump( monthlyCalenderEventsData.weeks![i].days![j].events![k].timesort.toString())).toString();
      //       dateList.containsKey(dateListIndex) ? dateList[dateListIndex].add(monthlyCalenderEventsData.weeks![i].days![j].events![k]) : dateList[dateListIndex] = [monthlyCalenderEventsData.weeks![i].days![j].events![k]];
      //     }
      //   }
      // }
      print('date list '+ dateList.toString());
      //CommonOperation.hideProgressDialog(context);
      //showToastMessage(message);
      setState(() {

      });
    } else {
      CommonOperation.hideProgressDialog(context);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoged', false);
      showToastMessage('your session is expire ');
    }

  }

  String getDateStump(String sTime) {
    int timeNumber = int.parse(sTime);
    return DateTime.fromMillisecondsSinceEpoch(timeNumber * 1000).toString();
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

  Future checkconnectivity() async{
    dateList.clear();
    var connectivityResult = await connectivity.checkConnectivity();
    if(connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi){
      getSharedData();
    }else{
      openNetworkDialog();
      setState(() {

      });
    }
  }
  openNetworkDialog() {
    print(',,,,,,,,,,,,,,,,,,,,,');
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            insetPadding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            title:Flexible(child: Align(
              alignment: Alignment.center,
              child: Text('Network Issue !',style: GoogleFonts.comfortaa(
                  fontSize: 12
              )),
            )),

            content: Container(
              height: MediaQuery.of(context).size.height/5,
              width: MediaQuery.of(context).size.width/2,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text('Please check your internet connectivity and try again.')
                  ],
                ),
              ),
            ),
            actions: [
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                  checkconnectivity();
                  setState(() {

                  });
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    width:150,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: SecondaryColor,
                    ),
                    child: Center(
                      child: Text("Try again", style: GoogleFonts.comfortaa(color: Colors.white, fontWeight: FontWeight.bold),),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
