import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:radda_moodle_learning/Screens/AllCoursesPage.dart';
import 'package:radda_moodle_learning/Screens/recentAccessCourses.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../ApiCall/HttpNetworkCall.dart';
import '../../../Helper/colors_class.dart';
import '../../../Helper/operations.dart';
import '../../courseDetailsPage.dart';

class DashBoardCoursesList extends StatefulWidget {
  List<dynamic> recentCourseList;
  List<dynamic> courseList;

  DashBoardCoursesList(this.recentCourseList, this.courseList);

  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<DashBoardCoursesList> {
  NetworkCall networkCall = NetworkCall();

  // List<dynamic> recentCourseList = [];
  // List<dynamic> courseList = [];
  int current = 0;
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return initWidget(context);
  }

  Widget initWidget(BuildContext context) {
    final List<Widget> sliderList = widget.recentCourseList
        .map((item) => Container(
        child: InkWell(
          onTap: () {
            final recentCourseData = item;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CourseDetailsPage('recent', recentCourseData)));
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black12)),
            child: Row(
              children: [
                PhysicalModel(
                  color: Colors.black,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  borderRadius: BorderRadius.circular(12),
                  child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/course_image.png',
                      image: widget.recentCourseList.length > 0
                          ? item.courseimage.toString()
                          : "",
                      height: 80,
                      width: 80,
                      fit: BoxFit.fill),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                          const EdgeInsets.only(bottom: 5.0, top: 5),
                          child: Text(
                              widget.recentCourseList.length > 0
                                  ? item.coursecategory.toString()
                                  : "",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.nanumGothic(
                                color: Colors.black54,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2.2,
                            child: Text(
                                widget.recentCourseList.length > 0
                                    ? item.fullname.toString()
                                    : "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.nanumGothic(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Text(
                              widget.recentCourseList.length > 0
                                  ? DateFormat.yMMMEd().format(
                                  DateTime.parse(getDateStump(
                                      item.startdate.toString())))
                                  : "",
                              style: GoogleFonts.nanumGothic(
                                  color: Colors.black54,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold)),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(bottom: 5.0),
                        //   child: Text('50% complete ',
                        //       style: GoogleFonts.comfortaa(
                        //           color: Colors.greenAccent,
                        //           fontSize: 13,
                        //           fontWeight: FontWeight.bold)),
                        // )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )))
        .toList();
    return Scaffold(
        backgroundColor: Color(0xFFF1F1FA),
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
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
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0, top: 5),
                              child: Text('Recently accessed courses ',
                                  style: GoogleFonts.nanumGothic(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Visibility(
                              visible: widget.recentCourseList.length > 0?true:false,
                              child: InkWell(
                                onTap: () {
                                  print(
                                      'asjgcshcJZbcjhjhbchbhbsbddvsjsbjhbbb jbhu z');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RecentAccessCourses(widget
                                                  .recentCourseList)));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8.0, top: 5),
                                  child: Container(
                                    height: 25,
                                    width: 60,
                                    child: Center(
                                      child: Text('See All',
                                          style: GoogleFonts.nanumGothic(
                                              color: SecondaryColor,
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      widget.recentCourseList.length > 0?CarouselSlider(
                          items: sliderList,
                          options: CarouselOptions(
                              autoPlay: sliderList.length>1?true:false,
                              enlargeCenterPage: true,
                              aspectRatio: 3.0,
                              viewportFraction: 0.9,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  current = index;
                                });
                              }))
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: sliderList.asMap().entries.map((entry) {
                          return GestureDetector(
                            onTap: () =>
                                _controller.animateToPage(entry.key),
                            child: Container(
                              width: 8.0,
                              height: 8.0,
                              margin: EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 4.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: (Theme.of(context).brightness ==
                                      Brightness.dark
                                      ? Colors.white
                                      : PrimaryColor)
                                      .withOpacity(current == entry.key
                                      ? 0.9
                                      : 0.4)),
                            ),
                          );
                        }).toList(),
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
                          style: GoogleFonts.nanumGothic(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.bold)),
                    ),
                    Visibility(
                      visible: widget.courseList.length > 0?true:false,
                      child: InkWell(
                        onTap: () {
                          print(
                              'asjgcshcJZbcjhjhbchbhbsbddvsjsbjhbbb jbhu z');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AllCoursesPage(widget.courseList)));
                        },
                        child: Padding(
                          padding:
                          const EdgeInsets.only(right: 12.0, top: 5),
                          child: Container(
                            height: 25,
                            width: 60,
                            child: Center(
                              child: Text('See All',
                                  style: GoogleFonts.nanumGothic(
                                      color: SecondaryColor,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              widget.courseList.length > 0?Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.courseList.length,
                      itemBuilder: (context, index) {
                        final mCourseData = widget.courseList[index];

                        return buildAllCourse(mCourseData);
                      })): Center(
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
          ),
        )
    );
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
      child: Container(
        margin: const EdgeInsets.only(left: 5.0, right: 5 , top: 5, bottom: 5),
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            PhysicalModel(
              color: Colors.black,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/course_image.png',
                  image: mCourseData.overviewfiles.length != 0
                      ? mCourseData.overviewfiles.first.fileurl
                      .replaceAll("/webservice", "")
                      .toString()
                      : 'https://image.shutterstock.com/image-photo/online-courses-text-man-using-260nw-600126515.jpg',
                  height: 80,
                  width: 80,
                  fit: BoxFit.fill),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left:8,bottom: 5.0),
                    child: Text(mCourseData.displayname.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.nanumGothic(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:8,bottom: 5.0),
                  child: Text(
                      DateFormat.yMMMEd().format(DateTime.parse(
                          getDateStump(mCourseData.startdate.toString()))),
                      style: GoogleFonts.nanumGothic(
                        fontSize: 13,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: LinearPercentIndicator(
                    width: 140.0,
                    lineHeight: 5.0,
                    percent: mCourseData.progress != null
                        ?mCourseData.progress.ceil()/100:0.0,
                    trailing: Text(
                        mCourseData.progress != null
                            ? mCourseData.progress.ceil().toString() +
                            ' % complete'
                            : '0 % complete',
                        style: GoogleFonts.nanumGothic(
                          fontSize: 12,
                        )),
                    barRadius: const Radius.circular(5),
                    backgroundColor: Colors.grey.shade300,
                    progressColor: PrimaryColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:8,bottom: 5.0),
                  child: Text(
                      'Total user: ' +
                          mCourseData.enrolledusercount.toString(),
                      style: GoogleFonts.nanumGothic(
                        fontSize: 13,
                      )),
                ),
              ],
            )
          ],
        ),
      ));
}
