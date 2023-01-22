import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/parser.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:radda_moodle_learning/ApiModel/answer_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:custom_radio_group_list/custom_radio_group_list.dart';
import '../../ApiCall/HttpNetworkCall.dart';
import '../../ApiModel/quiz_question_response.dart';
import '../../Helper/colors_class.dart';
import '../../Helper/operations.dart';
import '../demo_screen.dart';

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
  String option = '';
  List<Questions> questionList =[];
  List<Answer> name = [];
  List<dynamic> values = [];
  Map<String, dynamic> answerMap = {
    "answers": "Here"
  };
  var unescape = HtmlUnescape();

  List<Map<dynamic, dynamic>> aaaaaaa = [
    {'type': 'hidden', 'name': 'q507:2_choice3', 'value': 0, 'text': '__main__'},
    {'type': 'hidden', 'name': 'q507:2_choice3', 'value': 0, 'text': '__main__'},
    {'type': 'hidden', 'name': 'q507:2_choice3', 'value': 0, 'text': '__main__'},
    {'type': 'hidden', 'name': 'q507:2_choice3', 'value': 0, 'text': '__main__'},
  ];
  List<String> ansDemo = [
    'Banana', 'Mango', 'Apple', 'Chery'
  ];
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
        floatingActionButton: Container(
          width: MediaQuery.of(context).size.width,
          height: 40,
          color: Colors.green,
          child: FloatingActionButton.extended(
            elevation: 0,
            backgroundColor: Colors.green,
            onPressed: () {
              //callQuizAttempt();
              Navigator.push(context, MaterialPageRoute(builder: (context) => ShowSelectRadio()));
            },
            label: const Text('Submit'),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          backgroundColor: PrimaryColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('Quiz',
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
                    child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 100),
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: questionList.length,
                            itemBuilder: (context, index) {
                              final mQuestionSet = questionList[index];

                              return buildQuestionSet(mQuestionSet);
                            })),
                  ),

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
    Future.wait([getQuizQuestionData(token, widget.quizId, widget.attemptId)]);

  }

  Future getQuizQuestionData(String token, String quizId, String attemptId) async{
    CommonOperation.showProgressDialog(context, "loading", true);
    final quizQuestionData =
    await networkCall.QuizQuestionCall(token, attemptId);
    if (quizQuestionData != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String message = 'Success';
      print('data_Question ' + quizQuestionData.attempt!.id.toString());
      questionList = quizQuestionData.questions!;
      dumpQuestion = unescape.convert(quizQuestionData.questions![0].html.toString());
      print('Unecaped String----> '+dumpQuestion);
      CommonOperation.hideProgressDialog(context);
      setState(() {
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

  Widget buildQuestionSet(Questions mQuestionSet) => GestureDetector(
    onTap: () {
      /// do click item task
      //Navigator.push(context, MaterialPageRoute(builder: (context) => CoursesDetailsPage(mCourseData)));
    },
    child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    //crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: parseQText(mQuestionSet), //Text(parse(HtmlUnescape().convert(mQuestionSet.html.toString())).getElementsByClassName("qtext")[0].text)
                          ),
                        ),
                      ]),
                ),
              ),
            )
          ],
        )),
  );

  parseQText(Questions mQuestionSet) {
    var quesHTML = parse(HtmlUnescape().convert(mQuestionSet.html.toString()));
    List<Map<dynamic, dynamic>> answers = [];
    String question = "";
    quesHTML.getElementsByClassName("qtext")[0].children.forEach((value) {
      if(value.localName == "p") {
        question += "<p>"+value.text +"</p>";
        value.children.forEach((element) {
          if(element.localName == "img"){
            question += "<img src='https://diginet-elearning.adnarchive.com/webservice/pluginfile.php"+element.attributes["src"].toString().split("pluginfile.php")[1]+"?token=$token' alt='Question Image' />";
          }
        });
      } else if (value.localName == "img") {
        question += "<img src='https://diginet-elearning.adnarchive.com/webservice/pluginfile.php"+value.attributes["src"].toString().split("pluginfile.php")[1]+"?token=$token' alt='Question Image' />";
      }
    });

    quesHTML.getElementsByClassName("answer")[0].children.forEach((value) {
      //print('new Val'+value.getElementsByTagName("div").toString());
      if(value.localName != "input"){
        Map<dynamic,dynamic> answerOption = value.getElementsByTagName("input")[0].attributes;
        answerOption["text"] = value.getElementsByTagName("p")[0].text;
        answers.add(answerOption);
      }else{
        Map<dynamic,dynamic> answerOption = value.attributes;
        answers.add(answerOption);
      }
    });
    //print('????????? '+ answers[0]['text'].toString());
    print(answers);
    return Column(

      children: [
        Html(data: question),


        answers[0]['type'].toString() == 'hidden'?RadioGroup(
            radioListObject: answers,
            textParameterName: 'text',
            selectedItem: -1,
            onChanged: (value) {

              try{
                String key = value['name'].split("_")[0];
                answerMap[key] = value["name"].split("_")[1];

              }catch(err){
                print(err);
              }
              print(value["name"].split("_")[1]);
            }):TextField(
          textInputAction: TextInputAction.next,
          onChanged: (textAnswer)=>  print('Value : '+textAnswer),
          decoration: InputDecoration(
            //prefixIcon: Image.asset("assets/icons/user_icon.png", width: 20, height: 20),
              border: OutlineInputBorder(),
              labelText: 'Answer',labelStyle: GoogleFonts.nanumGothic(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
              hintText: 'Enter your answer',hintStyle: GoogleFonts.nanumGothic(
            fontSize: 15,
          )
          ),
          autofocus: false,
        ),

      ],
    );
  }
}
