import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:radda_moodle_learning/Helper/colors_class.dart';
import 'package:radda_moodle_learning/Screens/courseDetailsPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ApiCall/HttpNetworkCall.dart';
import '../Helper/operations.dart';

class CategoryWiseCoursesPage extends StatefulWidget {
  String catId;

  CategoryWiseCoursesPage(this.catId);

  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<CategoryWiseCoursesPage> {
  NetworkCall networkCall = NetworkCall();
  List<dynamic> courseList = [];
  List<dynamic> categoryWiseCourseList = [];

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
      appBar: AppBar(
        backgroundColor: PrimaryColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Our Courses',
            style: GoogleFonts.comfortaa(
                color: const Color(0xFFFFFFFF),
                fontWeight: FontWeight.w700,
                fontSize: 18)),
        centerTitle: false,
      ),
      backgroundColor: PrimaryColor,
      body: Column(
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  categoryWiseCourseList.length > 0
                      ? Expanded(
                          child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0, right: 12.0),
                              child: ListView.builder(
                                  itemCount: categoryWiseCourseList.length,
                                  itemBuilder: (context, index) {
                                    final mCourseData =
                                        categoryWiseCourseList[index];

                                    return buildRecentCourse(mCourseData);
                                  })),
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
                        ),
                ],
              )),
        ],
      ),
    );
  }

  Widget buildRecentCourse(mCourseData) => GestureDetector(
      onTap: () {
        /// do click item task
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CourseDetailsPage('site', mCourseData)));
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => CoursesDetailsPage(mCourseData)));
      },
      child: Container(
        margin: const EdgeInsets.only(left: 8.0, right: 8, top: 5, bottom: 8),
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
                height: 120,
                width: 130,
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
                          maxLines: 4,
                          style: GoogleFonts.comfortaa(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.account_circle_sharp,
                                    size: 17,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      mCourseData.enrolledusercount.toString() +
                                          ' users',
                                      style: GoogleFonts.comfortaa(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Container(
                            width: 100,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color(0xFFFFFFFF)),
                            child: Center(
                              child: Text(
                                "View details",
                                style: GoogleFonts.comfortaa(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ));

  String getDateStump(String sTime) {
    int timeNumber = int.parse(sTime);
    return DateTime.fromMillisecondsSinceEpoch(timeNumber * 1000).toString();
  }

  void getSharedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('TOKEN')!;
    String userid = prefs.getString('userId')!;
    setState(() {
      getAllCourses(token, userid);
    });
  }

  void getAllCourses(String token, String userId) async {
    CommonOperation.showProgressDialog(context, "loading", true);
    final userCoursesData =
        await networkCall.UserCoursesListCall(token, userId);
    if (userCoursesData != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String message = 'Success2';
      courseList = userCoursesData;
      categoryWiseCourseList = courseList
          .where((element) =>
              element.category.toString() == widget.catId.toString())
          .toList();
      //count = courseList.length.toString();
      print('data_count1 ' + courseList.first.toString());
      //showToastMessage(message);
      CommonOperation.hideProgressDialog(context);
      setState(() {});
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoged', false);
      showToastMessage('your session is expire ');
    }
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
