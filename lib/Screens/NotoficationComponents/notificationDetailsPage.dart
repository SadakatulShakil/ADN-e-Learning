import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/parser.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:intl/intl.dart';
import 'package:radda_moodle_learning/ApiModel/gradeDetailsResponse.dart';
import 'package:radda_moodle_learning/ApiModel/gradeResponse.dart';
import 'package:radda_moodle_learning/Helper/colors_class.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../ApiCall/HttpNetworkCall.dart';

class NotificationDetailsPage extends StatefulWidget {
  dynamic mNotificationData;
  NotificationDetailsPage(this.mNotificationData);

  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<NotificationDetailsPage> {
  NetworkCall networkCall = NetworkCall();
  String token = '';
  String userId = '';

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
    //print('--------->  '+widget.mCourseData.badgeurl.toString()+"?token="+widget.token.toString());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: PrimaryColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('Notification Details',
              style: GoogleFonts.nanumGothic(
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
                  height: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).size.height / 9,
                  transform: Matrix4.translationValues(0, 10, 1),
                  decoration: BoxDecoration(
                      color: Color(0xFFFAFAFA),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25))),
                  child: Column(
                    children: [
                      // Container(
                      //     decoration: BoxDecoration(
                      //         image: DecorationImage(
                      //           image: AssetImage(
                      //               "assets/images/rectangle_bg.png"),
                      //           fit: BoxFit.cover,
                      //         ),
                      //         borderRadius: BorderRadius.only(
                      //             topLeft: Radius.circular(25),
                      //             topRight: Radius.circular(25))),
                      //     height: 125,
                      //     child: Column(
                      //       children: [
                      //         Padding(
                      //           padding: const EdgeInsets.only(
                      //               left: 8, top: 20.0, right: 8),
                      //           child: Align(
                      //             alignment: Alignment.centerLeft,
                      //             child: Text(
                      //               widget.mNotificationData.subject.toString(),
                      //               maxLines: 2,
                      //               overflow: TextOverflow.ellipsis,
                      //               style: GoogleFonts.nanumGothic(
                      //                   fontSize: 20,
                      //                   fontWeight: FontWeight.bold,
                      //                   color: Colors.white),
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     )),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(child: Column(
                          children: [
                            SizedBox(height: 8,),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, top: 5, bottom: 5),
                              child: Align(
                                alignment:Alignment.centerLeft,
                                child: Text('Subject:  '+widget.mNotificationData.subject.toString(),
                                    style: GoogleFonts.nanumGothic(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15)),
                              ),
                            ),
                            SizedBox(height: 8,),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 5.0, top: 5, bottom: 5),
                              child: Align(
                                alignment:Alignment.centerLeft,
                                child: Text('Created time:  '+getDateStump(widget.mNotificationData.timecreated.toString()),
                                    style: GoogleFonts.nanumGothic(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15)),
                              ),
                            ),
                            SizedBox(height: 8,),
                            Divider(thickness: 2,),
                            SizedBox(height: 8,),


                            SizedBox(height: 8,),

                            parseNotification(widget.mNotificationData.fullmessagehtml.toString())
                          ],
                        ),),
                      )
                    ],
                  )),

            ],
          ),
        ));
  }

  String getDateStump(String sTime) {
    int timeNumber = int.parse(sTime);
    return DateTime.fromMillisecondsSinceEpoch(timeNumber * 1000).toString();
  }

  parseNotification(mNotificationSet) {
    RegExp regExp = RegExp(r'<[^>]*>|&[^;]+;',multiLine: true,caseSensitive: true);
    var quesHTML = parse(HtmlUnescape().convert(mNotificationSet.toString()));

    return Text(quesHTML.getElementsByTagName('div')[0].innerHtml.toString().replaceAll(regExp, '').trim().replaceAll('Go to activity', 'Go to related course details page'));
  }

}
