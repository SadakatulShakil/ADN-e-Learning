import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AllCoursesPage extends StatefulWidget {
  List<dynamic> allCourseList;
  AllCoursesPage(this.allCourseList);


  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<AllCoursesPage> {
  @override
  Widget build(BuildContext context) {
    return initWidget(context);
  }

  Widget initWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF01974D),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Enrolled Courses',
            style: GoogleFonts.comfortaa(
                color: const Color(0xFFFFFFFF),
                fontWeight: FontWeight.w700,
                fontSize: 18)),
        centerTitle: false,
      ),
      backgroundColor: const Color(0xFF01974D),
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
              child: Column(
                children: [
                  SizedBox(height: 15,),
                  Expanded(
                    child: Padding(
                        padding:
                        const EdgeInsets.only(left: 12.0, right: 12.0),
                        child: ListView.builder(
                            itemCount: widget.allCourseList.length,
                            itemBuilder: (context, index) {
                              final mCourseData = widget.allCourseList[index];

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
      )
  );

  String getDateStump(String sTime) {
    int timeNumber = int.parse(sTime);
    return DateTime.fromMillisecondsSinceEpoch(timeNumber * 1000).toString();
  }
}
