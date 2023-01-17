import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:radda_moodle_learning/ApiModel/assignmentResponse.dart';
import 'package:radda_moodle_learning/ApiModel/gradeDetailsResponse.dart';
import 'package:radda_moodle_learning/Helper/colors_class.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../ApiCall/HttpNetworkCall.dart';
import '../Helper/operations.dart';

class AssignmentDetailsPage extends StatefulWidget {
  String courseId, name, assignmentId, openedTime, dueTime;
  AssignmentDetailsPage(this.courseId, this.name, this.assignmentId, this.openedTime, this.dueTime);

  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<AssignmentDetailsPage> {
  NetworkCall networkCall = NetworkCall();
  String token = '';
  String userId = '';
  String htmlData = '';
  bool feedbackShow = false;
  bool onlineText = false;
  bool subFileShow = false;
  bool feedFileShow = false;
  String submissionStatus = '';
  String gradingStatus = '';
  String lastDateSubmission = '3216216';
  String onlineTextAnswer = '';
  String gradeFromTeacher = '';
  String gradeDate = '';
  String feedBackComments = '';
  String feedBackFileName = '';
  String subFileName = '';

  List<Gradeitems> gradeDetailsList = [];
  List<Assignments> assignmentIntroList = [];

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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: PrimaryColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('Assignment details',
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
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset("assets/vectors/assignment_icon.svg"),
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, top: 20.0, right: 8),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        widget.name.toString(),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.nanumGothic(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8,),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, top: 5, bottom: 5),
                                        child: Text(
                                            'start date: '+widget.openedTime.toString(),
                                            style: GoogleFonts.nanumGothic(
                                                fontSize: 11,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                      )),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, top: 5, bottom: 5),
                                        child: Text(
                                            'Due date: '+widget.dueTime.toString(),
                                            style: GoogleFonts.nanumGothic(
                                                color: Colors.white,
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold)),
                                      )),
                                ],
                              ),
                            ],
                          )),
                      Expanded(
                        child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  color: Color(0xFFCAECFF),
                                  child: Column(
                                    children: [
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 8.0, top: 10),
                                            child: Text('Topic'),
                                          )),
                                      Html(data: htmlData)
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      Container(
                                        color: Colors.grey[350],
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text("Submission Status", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),
                                        ),
                                      ),
                                      SizedBox(height: 8,),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text("Submission Status: ", style: TextStyle(fontSize: 15),)),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text(submissionStatus == 'new'?'Not Attempt':'Submitted', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                                            child: Divider(thickness: 2,),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text("Grading Status: ", style: TextStyle(fontSize: 15),)),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text(gradingStatus == 'notgraded'?'Not Graded':'Graded', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                                            child: Divider(thickness: 2,),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text("Last Modified: ", style: TextStyle(fontSize: 15),)),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text(DateFormat.yMMMEd().format(
                                                        DateTime.parse(getDateStump(
                                                            lastDateSubmission
                                                                .toString()))), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                                            child: Divider(thickness: 2,),
                                          ),
                                        ],
                                      ),
                                      Visibility(
                                        visible: onlineText?true:false,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text("Submitted Text: ", style: TextStyle(fontSize: 15),)),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 8.0),
                                              child: Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Html(data: onlineTextAnswer)),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                                              child: Divider(thickness: 2,),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Visibility(
                                        visible: subFileShow?true:false,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text("Submission File: ", style: TextStyle(fontSize: 15),)),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 8.0),
                                              child: Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(subFileName, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: SecondaryColor),)),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                                              child: Divider(thickness: 2,),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text("Comments: ", style: TextStyle(fontSize: 15),)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text('No comments', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: feedbackShow?true:false,
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          color: Colors.grey[350],
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text("Feedback", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),
                                          ),
                                        ),
                                        SizedBox(height: 8,),
                                        Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text("Grade: ", style: TextStyle(fontSize: 15),)),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 8.0),
                                              child: Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Html(data: gradeFromTeacher)),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                                              child: Divider(thickness: 2,),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Text("Grade on: ", style: TextStyle(fontSize: 15),)),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Text(gradeDate, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                                              child: Divider(thickness: 2,),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Text("Feedback Comments: ", style: TextStyle(fontSize: 15),)),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Text('No Comments', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                                              child: Divider(thickness: 2,),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text("Annotate File: ", style: TextStyle(fontSize: 15),)),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(feedBackFileName, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: SecondaryColor),)),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                                              child: Divider(thickness: 2,),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                InkWell(
                                  onTap: (){
                                    //callLoginApi(userNameController.text, passwordController.text);
                                    //agree?Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen())): showToastMessage('please accept our terms & condition');
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Container(
                                        width:350,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: PrimaryColor
                                        ),
                                        child: Center(
                                          child: Text("Submit", style: GoogleFonts.nanumGothic(color: Colors.white, fontWeight: FontWeight.bold),),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ));
  }

  void getSharedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('TOKEN')!;
    userId = prefs.getString('userId')!;
    Future.wait([getAssignmentContent(token, widget.courseId.toString()), getAssignmentDetails(token, widget.assignmentId)]);
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

  String getDateStump(String sTime) {
    int timeNumber = int.parse(sTime);
    return DateTime.fromMillisecondsSinceEpoch(timeNumber * 1000).toString();
  }

  Future getAssignmentContent(String token, String courseid) async{
    CommonOperation.showProgressDialog(context, "loading", true);
    final assignmentData =
    await networkCall.CourseAssignmentCall(token, courseid);
    if (assignmentData != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String message = 'Success';
      assignmentIntroList = assignmentData.courses!.first.assignments!;
      for(int i=0;i<assignmentIntroList.length;i++){
        if(assignmentIntroList[i].id.toString() == widget.assignmentId){
          htmlData = assignmentIntroList[i].intro.toString();
          print('------>intro '+ assignmentIntroList[i].intro.toString());
        }
      }
      CommonOperation.hideProgressDialog(context);
      showToastMessage(message);
      setState(() {});
    } else {
      CommonOperation.hideProgressDialog(context);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoged', false);
      showToastMessage('your session is expire ');
    }

  }
  Future getAssignmentDetails(String token, String assignmentId) async {
    CommonOperation.showProgressDialog(context, "loading", true);
    final assignmentDetailsData =
    await networkCall.AssignmentDetailsCall(token, assignmentId);
    if (assignmentDetailsData != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String message = 'Success';
      submissionStatus = assignmentDetailsData.lastattempt!.submission!.status.toString();
      gradingStatus = assignmentDetailsData.lastattempt!.gradingstatus.toString();
      lastDateSubmission = assignmentDetailsData.lastattempt!.submission!.timemodified.toString();
      for(int i=0;i<assignmentDetailsData.lastattempt!.submission!.plugins!.length;i++){
        if(assignmentDetailsData.lastattempt!.submission!.plugins![i].type == 'onlinetext'){
          onlineText = true;
          onlineTextAnswer = assignmentDetailsData.lastattempt!.submission!.plugins![i].editorfields!.first.text.toString();
        }else if(assignmentDetailsData.lastattempt!.submission!.plugins![i].type =="file" && assignmentDetailsData.lastattempt!.submission!.plugins![i].fileareas!.first.files!.length>0){
          subFileShow = true;
          subFileName = assignmentDetailsData.lastattempt!.submission!.plugins![i].fileareas!.first.files!.first.filename.toString();
        }
      }
      if(assignmentDetailsData.toJson().containsKey('feedback')){
        feedbackShow = true;
        gradeFromTeacher = assignmentDetailsData.feedback!.gradefordisplay.toString();
        gradeDate = assignmentDetailsData.feedback!.gradeddate.toString();
        for(int j =0; j<assignmentDetailsData.feedback!.plugins!.length;j++){
          if(assignmentDetailsData.feedback!.plugins![j].type =='editpdf' && assignmentDetailsData.feedback!.plugins![j].fileareas!.first.files!.length>0){
            feedBackFileName = assignmentDetailsData.feedback!.plugins![j].fileareas!.first.files!.first.filename.toString();
          }
        }
      }
      CommonOperation.hideProgressDialog(context);
      showToastMessage(message);
      setState(() {});
    } else {
      CommonOperation.hideProgressDialog(context);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoged', false);
      showToastMessage('your session is expire ');
    }
  }

}
