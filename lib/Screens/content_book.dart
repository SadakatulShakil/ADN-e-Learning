import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:radda_moodle_learning/Helper/colors_class.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ApiCall/HttpNetworkCall.dart';

class BookContentPage extends StatefulWidget {
  List<dynamic> bookContent;
  String token, title, id;
  BookContentPage(this.bookContent, this.token, this.title, this.id);



  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<BookContentPage> {
  NetworkCall networkCall = NetworkCall();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ViewActivity(widget.id, widget.token);
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
        title: Text('Course Content',
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
              child: Column(
                children: [
                  SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.title.toString(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(height: 10,),
                  Expanded(
                    child: Padding(padding:
                        const EdgeInsets.only(left: 12.0, right: 12.0),
                        child: ListView.builder(
                            itemCount: widget.bookContent.length,
                            itemBuilder: (context, index) {
                              final mCourseData = widget.bookContent[index];

                              return buildBookContent(mCourseData);
                            })),
                  ),
                  SizedBox(height: 20,)
                ],
              )
          ),
        ],
      ),
    );
  }

  Widget buildBookContent(mCourseData) => GestureDetector(
      onTap: () {
        /// do click item task
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => CoursesDetailsPage(mCourseData)));
      },
      child:
      mCourseData.filename.toString() == 'index.html'?Padding(
        padding: const EdgeInsets.only(top: 15.0, bottom: 8.0),
        child: Text(mCourseData.content.toString()),
      ):mCourseData.filename.toString() == 'structure'?Container():
      Container(
        margin: const EdgeInsets.only(left: 5.0, right: 5, top: 5),
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            border: Border.all(color: Colors.black12)),
        child: FadeInImage.assetNetwork(
            placeholder: 'assets/images/course_image.png',
            image: mCourseData.fileurl.toString()+'?token='+widget.token.toString(),
            fit: BoxFit.cover),
      )
  );

  String getDateStump(String sTime) {
    int timeNumber = int.parse(sTime);
    return DateTime.fromMillisecondsSinceEpoch(timeNumber * 1000).toString();
  }

  void ViewActivity(String id, String token) async{
    //print("succesfully----------");
    dynamic activityViewData =
    await networkCall.ViewManualActivityCall(token, id, 1);
    if (activityViewData != null) {
      print("View succesfully");
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
