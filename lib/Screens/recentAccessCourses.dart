import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:radda_moodle_learning/Screens/courseDetailsPage.dart';

import '../Helper/colors_class.dart';
class RecentAccessCourses extends StatefulWidget {
  List<dynamic> recentCourseList;
  RecentAccessCourses(this.recentCourseList);


  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<RecentAccessCourses> {
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
        title: Text('Recent Courses',
            style: GoogleFonts.nanumGothic(
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
              height: MediaQuery.of(context).size.height-MediaQuery.of(context).size.height/9,
              transform: Matrix4.translationValues(0, 10, 1),
              decoration: BoxDecoration(
                  color: Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)
                  )
              ),
              child:
              Column(
                children: [
                  SizedBox(height: 15,),
                  Expanded(
                    child: Padding(
                        padding:
                        const EdgeInsets.only(left: 12.0, right: 12.0),
                        child: ListView.builder(
                            itemCount: widget.recentCourseList.length,
                            itemBuilder: (context, index) {
                              final mCourseData = widget.recentCourseList[index];

                              return buildRecentCourse(mCourseData);
                            })),
                  ),
                ],
              )
          ),
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
                builder: (context) => CourseDetailsPage('recent', mCourseData)));
      },
      child:
      Container(
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
                image: mCourseData.courseimage.toString(),
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
                        mCourseData
                            .coursecategory
                            .toString(),
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
                      width:
                      MediaQuery.of(context).size.width / 2,
                      child: Text(
                          mCourseData.fullname.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.nanumGothic(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text(
                        DateFormat.yMMMEd().format(DateTime.parse(
                            getDateStump(mCourseData
                                .startdate
                                .toString()))),
                        style: GoogleFonts.nanumGothic(
                            color: Colors.black54,
                            fontSize: 13,
                            )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Text(
                          mCourseData.progress != null
                              ? mCourseData.progress.ceil().toString() +
                              ' % complete'
                              : '0 % complete',
                          style: GoogleFonts.nanumGothic(
                              color: PrimaryColor,
                              fontSize: 13,
                              )),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )
  );

  String getDateStump(String sTime) {
    int timeNumber = int.parse(sTime);
    return DateTime.fromMillisecondsSinceEpoch(timeNumber * 1000).toString();
  }
}
