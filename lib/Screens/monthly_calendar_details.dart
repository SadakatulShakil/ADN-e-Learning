import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:radda_moodle_learning/Helper/colors_class.dart';
import 'package:radda_moodle_learning/Screens/create_calendar_event.dart';

class MonthlyCalenderDetailsPage extends StatefulWidget {
  List<dynamic> eventsList;
  MonthlyCalenderDetailsPage(this.eventsList);


  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<MonthlyCalenderDetailsPage> {
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
            style: GoogleFonts.comfortaa(
                color: const Color(0xFFFFFFFF),
                fontWeight: FontWeight.w700,
                fontSize: 18)),
        centerTitle: false,
      ),
      backgroundColor: PrimaryColor,
      body: SafeArea(
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
                                  'Event Details',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.comfortaa(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        )),
                    SizedBox(height: 15,),
                    Expanded(
                      child: Padding(
                          padding:
                          const EdgeInsets.only(left: 12.0, right: 12.0),
                          child: ListView.builder(
                              itemCount: widget.eventsList.length,
                              itemBuilder: (context, index) {
                                final mCourseData = widget.eventsList[index];

                                return buildEventCourse(mCourseData);
                              })),
                    ),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEventCourse(mCourseData) => GestureDetector(
      onTap: () {
        /// do click item task
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => CoursesDetailsPage(mCourseData)));
      },
      child: Container(
        margin: const EdgeInsets.only(left: 12.0, right: 12, top: 5, bottom: 8),
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black12)),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text(mCourseData.name.toString(),
                      maxLines: 5,
                      style: GoogleFonts.comfortaa(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(height: 12,),
              Row(
                children: [
                  Icon(Icons.calendar_month, color: Colors.black54, size: 18,),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text( DateFormat.yMMMEd().format(DateTime.parse(
                        getDateStump(mCourseData
                            .timestart
                            .toString()))),
                        style: GoogleFonts.comfortaa(
                            color: Colors.black54,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              SizedBox(height: 8,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Icon(Icons.access_time, color: Colors.black54, size: 20,),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/1.3,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                                mCourseData.course.shortname.toString(),
                                style: GoogleFonts.comfortaa(
                                    color: Colors.black54,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      )
  );

  String getDateStump(String sTime) {
    int timeNumber = int.parse(sTime);
    return DateTime.fromMillisecondsSinceEpoch(timeNumber * 1000).toString();
  }
}
