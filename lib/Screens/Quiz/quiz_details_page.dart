import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ApiCall/HttpNetworkCall.dart';
import '../../Helper/operations.dart';

class QuizDetailsPage extends StatefulWidget {
  String name;
  String quizId;
  String attemptId;

  QuizDetailsPage(this.name, this.quizId, this.attemptId);


  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<QuizDetailsPage> {
  String token = '';
  String userId = '';
  String dumpQuestion='';
  var unescape = HtmlUnescape();
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
          backgroundColor: const Color(0xFF0E0E95),
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
        backgroundColor: const Color(0xFF0E0E95),
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
                          Html(data: dumpQuestion),

                          SizedBox(height: 20,),



                          SizedBox(height: 20,),
                          InkWell(
                            onTap: (){
                              //Navigator.push(context, MaterialPageRoute(builder: (context) => QuizDetailsPage(widget.name, widget.quizId)));
                            },
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                color: const Color(0xFF00BC78),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Text('Start Attempt', style: TextStyle(color: Colors.white),)),
                                )),
                          ),
                          SizedBox(height: 10,),
                          Text('Cancel'),


                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  void getSharedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('TOKEN')!;
    userId = prefs.getString('userId')!;
    setState(() {
      getQuizQuestionData(token, widget.quizId, widget.attemptId);
      //getGradeContent(token, widget.mGradeData.id.toString(), userId);
    });
  }

  void getQuizQuestionData(String token, String quizId, String attemptId) async{
    CommonOperation.showProgressDialog(context, "loading", true);
    final quizQuestionData =
    await networkCall.QuizQuestionCall(token, attemptId);
    if (quizQuestionData != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String message = 'Success';
      print('data_Question ' + quizQuestionData.attempt!.id.toString());
      dumpQuestion = unescape.convert(quizQuestionData.questions![0].html.toString());
      print('Unecaped String----> '+dumpQuestion);
      CommonOperation.hideProgressDialog(context);
      showToastMessage(message);
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
