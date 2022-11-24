import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:radda_moodle_learning/ApiModel/gradeDetailsResponse.dart';
import 'package:radda_moodle_learning/ApiModel/gradeResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../ApiCall/HttpNetworkCall.dart';
import '../Helper/operations.dart';

class BadgesDetailsPage extends StatefulWidget {
  dynamic mCourseData;
  List<dynamic> courseList;
  String token;
  BadgesDetailsPage(this.mCourseData, this.courseList, this.token);



  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<BadgesDetailsPage> {
  NetworkCall networkCall = NetworkCall();
  String token = '';
  String userId = '';
  String name = '';
  String courseName = '';
  List<Gradeitems> gradeDetailsList = [];

  @override
  void initState() {
    // TODO: implement initState
    getSharedData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return initWidget(context);
  }

  Widget initWidget(BuildContext context) {
    print('--------->  '+widget.mCourseData.badgeurl.toString()+"?token="+widget.token.toString());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF01974D),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('Grade Details',
              style: GoogleFonts.comfortaa(
                  color: const Color(0xFFFFFFFF),
                  fontWeight: FontWeight.w700,
                  fontSize: 18)),
          centerTitle: false,
        ),
        backgroundColor: const Color(0xFF01974D),
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
                          height: 125,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, top: 20.0, right: 8),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    widget.mCourseData.name.toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.comfortaa(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, top: 5, bottom: 5),
                                    child: Text(widget.mCourseData.messagesubject.toString(),
                                        style: GoogleFonts.comfortaa(
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold)),
                                  )),
                            ],
                          )),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(child: Column(
                          children: [
                            Align(
                              alignment:Alignment.centerLeft,
                              child: Text('Recipient details',
                                  style: GoogleFonts.comfortaa(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18)),
                            ),
                            SizedBox(height: 8,),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, top: 5, bottom: 5),
                              child: Align(
                                alignment:Alignment.centerLeft,
                                child: Text('Name:  '+name.toString(),
                                    style: GoogleFonts.comfortaa(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15)),
                              ),
                            ),
                            SizedBox(height: 8,),
                            Divider(thickness: 2,),
                            SizedBox(height: 8,),
                            Align(
                              alignment:Alignment.centerLeft,
                              child: Text('Issuer details',
                                  style: GoogleFonts.comfortaa(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18)),
                            ),
                            SizedBox(height: 8,),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, top: 5, bottom: 5),
                              child: Align(
                                alignment:Alignment.centerLeft,
                                child: Text('Issuer name:  '+widget.mCourseData.issuername.toString(),
                                    style: GoogleFonts.comfortaa(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15)),
                              ),
                            ),
                            SizedBox(height: 8,),
                            Divider(thickness: 2,),
                            Align(
                              alignment:Alignment.centerLeft,
                              child: Text('Badge details',
                                  style: GoogleFonts.comfortaa(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18)),
                            ),
                            SizedBox(height: 8,),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, top: 5, bottom: 5),
                              child: Align(
                                alignment:Alignment.centerLeft,
                                child: Text('Name:  '+widget.mCourseData.name.toString(),
                                    style: GoogleFonts.comfortaa(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15)),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, top: 5, bottom: 5),
                              child: Align (
                                alignment:Alignment.centerLeft,
                                child: Text(widget.mCourseData.language.toString()== 'en'?'Language:  '+'English':'Bangla',
                                    style: GoogleFonts.comfortaa(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15)),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, top: 5, bottom: 5),
                              child: Align(
                                alignment:Alignment.centerLeft,
                                child: Text('Description:  '+widget.mCourseData.description.toString(),
                                    style: GoogleFonts.comfortaa(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15)),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, top: 5, bottom: 5),
                              child: Align(
                                alignment:Alignment.centerLeft,
                                child: Text('Course:  '+courseName.toString(),
                                    style: GoogleFonts.comfortaa(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15)),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Divider(thickness: 2,),
                            Align(
                              alignment:Alignment.centerLeft,
                              child: Text('Badge expiry',
                                  style: GoogleFonts.comfortaa(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18)),
                            ),
                            SizedBox(height: 8,),
                            Align(
                              alignment:Alignment.centerLeft,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, top: 5, bottom: 5),
                                    child: Text(
                                        'Date issued: ' +
                                            DateFormat.yMMMEd().format(DateTime.parse(
                                                getDateStump(
                                                    widget.mCourseData.dateissued.toString()))),
                                        style: GoogleFonts.comfortaa(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                  )),
                            ),
                            SizedBox(height: 8,),
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

  void getSharedData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name')!;
    for(int i =0;i<widget.courseList.length;i++){
      if(widget.courseList[i].id.toString() == widget.mCourseData.courseid.toString()){
        courseName = widget.courseList[i].displayname.toString();
      }
    }
    setState(() {
    });
  }
}
