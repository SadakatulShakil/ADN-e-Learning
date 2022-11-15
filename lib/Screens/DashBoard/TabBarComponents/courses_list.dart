import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:radda_moodle_learning/Screens/AllCoursesPage.dart';
import 'package:radda_moodle_learning/Screens/recentAccessCourses.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../ApiCall/HttpNetworkCall.dart';
import '../../../Helper/operations.dart';
import '../../courseDetailsPage.dart';

class DashBoardCoursesList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<DashBoardCoursesList> {
  NetworkCall networkCall = NetworkCall();
  List<dynamic> recentCourseList = [];
  List<dynamic> courseList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      getSharedData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return initWidget(context);
  }

  Widget initWidget(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF1F1FA),
        body: recentCourseList.length>0 && courseList.length>0 ?
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0, top: 5),
                            child: Text('Recent courses ',
                                style: GoogleFonts.comfortaa(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold)),
                          ),
                          InkWell(
                            onTap: (){
                              print('asjgcshcJZbcjhjhbchbhbsbddvsjsbjhbbb jbhu z');
                              Navigator.push(context, MaterialPageRoute(builder: (context) => RecentAccessCourses(recentCourseList)));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0, top: 5),
                              child: Container(
                                height: 25,
                                width: 60,
                                child: Center(
                                  child: Text('See All',
                                      style: GoogleFonts.comfortaa(
                                          color: Colors.greenAccent,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        final recentCourseData = recentCourseList[0];
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CourseDetailsPage('recent', recentCourseData)));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 12.0, right: 12, top: 5, bottom: 8),
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black12)),
                        child: Row(
                          children: [
                            FadeInImage.assetNetwork(
                                placeholder: 'assets/images/course_image.png',
                                image: recentCourseList.length > 0 ? recentCourseList[0].courseimage.toString() : "",
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 5.0, top: 5),
                                    child: Text(
                                        recentCourseList.length > 0 ? recentCourseList[0]
                                            .coursecategory
                                            .toString() : "",
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.comfortaa(
                                          color: Colors.black54,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5.0),
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Text(
                                          recentCourseList.length > 0 ? recentCourseList[0].fullname.toString() : "",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.comfortaa(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5.0),
                                    child: Text(
                                        recentCourseList.length > 0 ? DateFormat.yMMMEd().format(DateTime.parse(
                                            getDateStump(recentCourseList[0]
                                                .startdate
                                                .toString()))) : "",
                                        style: GoogleFonts.comfortaa(
                                            color: Colors.black54,
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5.0),
                                    child: Text('50% complete ',
                                        style: GoogleFonts.comfortaa(
                                            color: Colors.greenAccent,
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold)),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, top: 5),
                    child: Text('All courses ',
                        style: GoogleFonts.comfortaa(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.bold)),
                  ),
                  InkWell(
                    onTap: (){
                      print('asjgcshcJZbcjhjhbchbhbsbddvsjsbjhbbb jbhu z');
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AllCoursesPage(courseList)));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12.0, top: 5),
                      child: Container(
                        height: 25,
                        width: 60,
                        child: Center(
                          child: Text('See All',
                              style: GoogleFonts.comfortaa(
                                  color: Colors.greenAccent,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                  padding:
                  const EdgeInsets.only(left: 12.0, right: 12.0),
                  child: ListView.builder(
                      itemCount: courseList.length,
                      itemBuilder: (context, index) {
                        final mCourseData = courseList[index];

                        return buildAllCourse(mCourseData);
                      })),
            ),
          ],
        ) : Center(
          child: SizedBox(
            height: 100,
            child: Column(
              children: [
                Icon(Icons.warning_amber, size: 30,),
                Text('Not Data Found!'),
              ],
            ),
          ),
        ));
  }

  void getSharedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('TOKEN')!;
    String userid = prefs.getString('userId')!;
    setState(() {
      getRecentCourses(token, userid);
    });
  }

  void getRecentCourses(String token, String userId) async {
    CommonOperation.showProgressDialog(context, "loading", true);
    final recentCoursesData =
        await networkCall.RecentCoursesListCall(token, userId);
    if (recentCoursesData != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String message = 'Success';
      recentCourseList = recentCoursesData;
      print('data_count1 ' + recentCourseList.first.toString());
      CommonOperation.hideProgressDialog(context);
      showToastMessage(message);
      setState(() {
        getAllCourses(token, userId);
      });
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoged', false);
      showToastMessage('your session is expire ');
    }
  }

  void getAllCourses(String token, String userId) async {
    CommonOperation.showProgressDialog(context, "loading", true);
    final userCoursesData =
        await networkCall.UserCoursesListCall(token, userId);
    if (userCoursesData != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String message = 'Success2';
      courseList = userCoursesData;
      //count = courseList.length.toString();
      print('data_count1 ' + courseList.first.toString());
      showToastMessage(message);
      CommonOperation.hideProgressDialog(context);
      setState(() {});
    } else {
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

  Widget buildAllCourse(mCourseData) => GestureDetector(
      onTap: () {
        /// do click item task
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CourseDetailsPage('all', mCourseData)));
      },
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),),
        child: Container(
          margin: const EdgeInsets.only(left: 5.0, right: 5, top: 5, bottom: 5),
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black12)),
          child: Row(
            children: [
              FadeInImage.assetNetwork(
                  placeholder: 'assets/images/course_image.png',
                  image: mCourseData.overviewfiles.length != 0
                      ? mCourseData.overviewfiles.first.fileurl
                          .replaceAll("/webservice", "")
                          .toString()
                      : 'https://image.shutterstock.com/image-photo/online-courses-text-man-using-260nw-600126515.jpg',
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Text(mCourseData.displayname.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.comfortaa(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Text( DateFormat.yMMMEd().format(DateTime.parse(
                          getDateStump(mCourseData
                              .startdate
                              .toString()))),
                          style: GoogleFonts.comfortaa(
                              color: Colors.black54,
                              fontSize: 13,
                              fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Text(
                          mCourseData.progress != null
                              ? mCourseData.progress.ceil().toString() +
                                  ' % complete'
                              : '0 % complete',
                          style: GoogleFonts.comfortaa(
                              color: Colors.greenAccent,
                              fontSize: 13,
                              fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Text( 'Total user: '+mCourseData.enrolledusercount.toString(),
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
        ),
      )
      );
}
