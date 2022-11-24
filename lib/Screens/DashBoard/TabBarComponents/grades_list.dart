import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:radda_moodle_learning/ApiModel/gradeResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../ApiCall/HttpNetworkCall.dart';
import '../../../Helper/operations.dart';
import '../../gradeDetailsPage.dart';

class DashBoardGradesList extends StatefulWidget {
  List<dynamic> courseList; List<Grades> gradeList;
  DashBoardGradesList(this.courseList, this.gradeList);

  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<DashBoardGradesList> {
  NetworkCall networkCall = NetworkCall();
  // List<dynamic> courseList = [];
  // List<Grades> gradeList = [];

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
        body: widget.gradeList.length > 0
            ? Column(
                children: [
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                        child: ListView.builder(
                            itemCount: widget.courseList.length,
                            itemBuilder: (context, index) {
                              final mCourseData = widget.courseList[index];
                              final mGradeData = widget.gradeList[index];
                              return buildAllCourse(mCourseData, mGradeData);
                            })),
                  ),
                ],
              )
            : Center(
                child: SizedBox(
                  height: 100,
                  child: Column(
                    children: [
                      Icon(
                        Icons.warning_amber,
                        size: 30,
                      ),
                      Text('No Data Found!'),
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
      // getAllCourses(token, userid);
      // getCoursesGrade(token);
    });
  }

  // void getAllCourses(String token, String userId) async {
  //   CommonOperation.showProgressDialog(context, "loading", true);
  //   final userCoursesData =
  //       await networkCall.UserCoursesListCall(token, userId);
  //   if (userCoursesData != null) {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     String message = 'Success2';
  //     courseList = userCoursesData;
  //     //count = courseList.length.toString();
  //     print('data_count1 ' + courseList.first.toString());
  //     //showToastMessage(message);
  //     CommonOperation.hideProgressDialog(context);
  //     setState(() {});
  //   } else {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     await prefs.setBool('isLoged', false);
  //     showToastMessage('your session is expire ');
  //   }
  // }
  //
  // void getCoursesGrade(String token) async {
  //   CommonOperation.showProgressDialog(context, "loading", true);
  //   final gradeListData = await networkCall.GradesCountCall(token);
  //   if (gradeListData != null) {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     String message = 'Success2';
  //     //showToastMessage(message);
  //     CommonOperation.hideProgressDialog(context);
  //     gradeList = gradeListData.grades!;
  //     print('-----> ' + gradeList.first.courseid.toString());
  //     setState(() {});
  //   } else {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     await prefs.setBool('isLoged', false);
  //     showToastMessage('your session is expire ');
  //   }
  // }

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

  Widget buildAllCourse(mCourseData, Grades mGradeData) => GestureDetector(
      onTap: () {
        /// do click item task
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => GradesDetailsPage(mCourseData, mGradeData)));
      },
      child: Container(
        margin: const EdgeInsets.only(left: 12.0, right: 12, top: 5, bottom: 8),
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
                    child: Text(
                        'Start date: ' +
                            DateFormat.yMMMEd().format(DateTime.parse(
                                getDateStump(
                                    mCourseData.startdate.toString()))),
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
                    child: Text(
                        mGradeData.grade.toString() != null && mGradeData.grade.toString() != '-'
                            ? 'Grade: ' + mGradeData.grade.toString()
                            : 'Grade: ' + "Not evaluated yet",
                        style: GoogleFonts.comfortaa(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            )
          ],
        ),
      ));
}
