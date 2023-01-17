import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:radda_moodle_learning/ApiModel/badges_response.dart';
import 'package:radda_moodle_learning/Screens/badges_details_page.dart';

class DashBoardActivityList extends StatefulWidget{
  List<Badges> badgesDataList;
  List<dynamic> courseList;
  String token;
  DashBoardActivityList(this.badgesDataList, this.token, this.courseList);


  @override
  State<StatefulWidget> createState() => InitState();
}
class InitState extends State<DashBoardActivityList> {
  @override
  Widget build(BuildContext context) {
    return initWidget(context);
  }

  Widget initWidget(BuildContext context) {

    return Scaffold(
        backgroundColor: Color(0xFFF1F1FA),
        body:  widget.badgesDataList.length > 0
            ? Column(
          children: [
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                  child: ListView.builder(
                      itemCount: widget.badgesDataList.length,
                      itemBuilder: (context, index) {
                        final mBadgesData = widget.badgesDataList[index];
                        return buildAllBadges(mBadgesData);
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
        )
    );
  }

  String getDateStump(String sTime) {
    int timeNumber = int.parse(sTime);
    return DateTime.fromMillisecondsSinceEpoch(timeNumber * 1000).toString();
  }

  Widget buildAllBadges(mCourseData) => GestureDetector(
      onTap: () {
        /// do click item task
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BadgesDetailsPage(mCourseData, widget.courseList, widget.token)));
      },
      child: Container(
        margin: const EdgeInsets.only(left: 12.0, right: 12, top: 5, bottom: 8),
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black12)),
        child: Row(
          children: [
            PhysicalModel(
              color: Colors.black,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/course_image.png',
                  image: mCourseData.badgeurl.toString()+'?token='+widget.token,
                  height: 80,
                  width: 80,
                  fit: BoxFit.fill),
            ),
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
                          style: GoogleFonts.nanumGothic(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Text(mCourseData.messagesubject.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: GoogleFonts.nanumGothic(
                            color: Colors.black,
                            fontSize: 13,)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text(
                        'Issue date: ' +
                            DateFormat.yMMMEd().format(DateTime.parse(
                                getDateStump(
                                    mCourseData.dateissued.toString()))),
                        style: GoogleFonts.nanumGothic(
                          color: Colors.black54,
                          fontSize: 13,)),
                  ),
                ],
              ),
            )
          ],
        ),
      ));
}
