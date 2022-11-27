import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:radda_moodle_learning/ApiModel/quiz_attempt_summery.dart';
import 'package:radda_moodle_learning/Screens/Quiz/quiz_details_page.dart';
import 'package:radda_moodle_learning/Screens/category_wise_course.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ApiCall/HttpNetworkCall.dart';
import '../../Helper/colors_class.dart';
import '../../Helper/operations.dart';

class QuizViewPage extends StatefulWidget {
  String name;
  String quizId;

  QuizViewPage(this.name, this.quizId);


  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<QuizViewPage> {
  String token = '';
  String userId = '';
  String attemptCount = '';
  String state = '';
  String grade = '';
  String highestGrade ='';
  List<Attempts> quizSummeryList =[];
  NetworkCall networkCall = NetworkCall();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return initWidget(context);
  }

  Widget initWidget(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      transform: Matrix4.translationValues(0, 5, 1),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: PrimaryColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('Quiz',
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
                children: [
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/rectangle_bg.png"),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25))),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 8,),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Image.asset("assets/images/quiz_icon.png", height: 50,width: 50,),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width/1.3,
                              child: Text(
                                widget.name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Align(alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0,right: 15, top: 5, bottom: 5),
                          child: Text('Time limit: 10 minutes', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15),
                        child: Divider(thickness: 1,),
                      ),
                      Align(alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0,right: 15, top: 5, bottom: 5),
                          child: Text('Grading method: Highest grade', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15),
                        child: Divider(thickness: 1,),
                      ),

                      Align(alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0,right: 15, top: 5, bottom: 5),
                          child: Text('Highest grade: '+ highestGrade, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15),
                        child: Divider(thickness: 1,),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        color: Color(0XFF009AF1),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0,right: 15, top: 12, bottom:12),
                          child: Text('Summery of previous attempt', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
                        ),
                      ),
                      SizedBox(height: 8,),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SingleChildScrollView(
                          child: DataTable(
                            columns: [
                              DataColumn(label: Text('Attempt')),
                              DataColumn(label: Text('Status')),
                              DataColumn(label: Text('Grade')),
                              DataColumn(label: Text('Review')),
                            ],
                            rows: _createRows(),
                          ),
                        ),
                      ),
                      SizedBox(height: 8,),
                      InkWell(
                        onTap: (){
                          quizDialog();
                          //callLoginApi(userNameController.text, passwordController.text);
                          //agree?Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen())): showToastMessage('please accept our terms & condition');
                        },
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
                              child: Text("Attempt now", style: GoogleFonts.comfortaa(color: Colors.white, fontWeight: FontWeight.bold),),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8,),
                    ],
                  ),
                ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  List<DataRow> _createRows() {
    return quizSummeryList
        .map((item) => DataRow(cells: [
      DataCell(Text(item.attempt.toString())),
      DataCell(Text(item.state.toString())),
      DataCell(Text(item.sumgrades.toString())),
      DataCell(Text('Review', style: TextStyle(color: SecondaryColor),))
    ]))
        .toList();
  }
  void quizDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Start Attempt'),
            content: Container(
              height: MediaQuery.of(context).size.height/3,
             child: Column(
               children: [
                 Text('Your attempt will have a time limit of 10 mins. When you start, t'
                     'he timer will begin to count down and cannot be paused. '
                     'You must finish your attempt before it expires. Are you sure you wish to start now? '),


                 SizedBox(height: 20,),
                 InkWell(
                   onTap: (){
                     Navigator.pop(context);
                     callAttemptApi(token, widget.quizId);
                   },
                   child: Container(
                     width: MediaQuery.of(context).size.width,
                     color: PrimaryColor,
                       child: Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Align(
                           alignment: Alignment.center,
                             child: Text('Start Attempt', style: TextStyle(color: Colors.white),)),
                       )),
                 ),
                 SizedBox(height: 10,),
                 InkWell(
                     onTap: (){
                       Navigator.pop(context);
                       //callAttemptApi(token, widget.quizId);
                     },
                     child: Text('Cancel')),
               ],
             ),
            ),
          );
        });
  }
  void getSharedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('TOKEN')!;
    userId = prefs.getString('userId')!;
    setState(() {
      getQuizSummeryData(token, widget.quizId);
      //getGradeContent(token, widget.mGradeData.id.toString(), userId);
    });
  }

  void callAttemptApi(String token, String quizId) async{
    CommonOperation.showProgressDialog(context, "loading", true);
    final startAttemptData =
    await networkCall.StartQuizAttemptCall(token, quizId);
    if (startAttemptData != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String message = 'Success';
      print('data_Attempt ' + startAttemptData.attempt!.id.toString());


      CommonOperation.hideProgressDialog(context);
      //showToastMessage(message);
      setState(() {
        Navigator.push(context, MaterialPageRoute(builder: (context) => QuizDetailsPage(widget.name, widget.quizId, startAttemptData.attempt!.id.toString())));
      });
    } else {
      CommonOperation.hideProgressDialog(context);
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

  void getQuizSummeryData(String token, String quizId) async{
    CommonOperation.showProgressDialog(context, "loading", true);
    final attemptSummeryData =
    await networkCall.QuizAttemptSummeryCall(token, quizId);
    if (attemptSummeryData != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String message = 'Success';
      quizSummeryList = attemptSummeryData.attempts!;
      print('data_content ' + attemptSummeryData.attempts!.length.toString());
      for(int i=0;i<quizSummeryList.length;i++){
        if(quizSummeryList[i].sumgrades!> quizSummeryList[0].sumgrades!){
          highestGrade = quizSummeryList[i].sumgrades!.toString();
        }
      }

      CommonOperation.hideProgressDialog(context);
      //showToastMessage(message);
      setState(() {
        //Navigator.push(context, MaterialPageRoute(builder: (context) => QuizDetailsPage(widget.name, widget.quizId, startAttemptData.attempt!.id.toString())));
      });
    } else {
      CommonOperation.hideProgressDialog(context);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoged', false);
      showToastMessage('your session is expire ');
    }
  }

}
