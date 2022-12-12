import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/parser.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:power_file_view/power_file_view.dart';
import 'package:radda_moodle_learning/Helper/colors_class.dart';
import 'package:radda_moodle_learning/Screens/Quiz/quiz_view_page.dart';
import 'package:radda_moodle_learning/Screens/assignmentDetailsPage.dart';
import 'package:radda_moodle_learning/Screens/demo_video_content.dart';
import 'package:radda_moodle_learning/Screens/pdfViwer.dart';
import 'package:radda_moodle_learning/Screens/video_content_page.dart';
import 'package:radda_moodle_learning/Screens/webViewPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../ApiCall/HttpNetworkCall.dart';
import '../Helper/GapRF.dart';
import '../Helper/operations.dart';

class CourseDetailsPage extends StatefulWidget {
  String form;
  dynamic mCourseData;

  CourseDetailsPage(this.form, this.mCourseData);

  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<CourseDetailsPage> {
  NetworkCall networkCall = NetworkCall();
  String token = '';
  List<dynamic> courseContentList = [];
  List<String> courseContentList1 = [];
  ScrollController scrollController = ScrollController();
  ScrollController scrollController1 = ScrollController();
  int showSub = -1;
  int showContact = -1;
  int showMap = -1;
  String content1 ='';
  String content2 ='';
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  Connectivity connectivity = Connectivity();
  @override
  void initState() {
    // TODO: implement initState
    checkconnectivity();
    print('--------->  '+widget.mCourseData.summary.toString());
    dom.Document document2 = parse(HtmlUnescape().convert(widget.mCourseData.summary.toString()));
    content1 = document2.getElementsByTagName('span')[0].innerHtml.toString();
    content2 = document2.getElementsByTagName('strong')[1].innerHtml.toString();
    print('data_content_html ' + content1.toString());
    print('data_content_html ' + content2.toString());
    //getSharedData();
    //setAudio();
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    audioPlayer.dispose();
    super.dispose();
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
          title: Text('Course Details',
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
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height -
                      MediaQuery
                          .of(context)
                          .size
                          .height / 9,
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
                                    left: 18, top: 20.0, right: 8),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    widget.form == 'recent' ? widget.mCourseData
                                        .fullname.toString() : widget
                                        .mCourseData.displayname.toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.nanumGothic(
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
                                        left: 18.0, top: 10, bottom: 5),
                                    child: Text(content1+'\n'+content2, style: GoogleFonts.nanumGothic(color: Colors.white, fontSize: 15),),
                                  )),
                            ],
                          )),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            "Course Content",
                            style: GoogleFonts.nanumGothic(fontSize: 13),
                          ),
                        ),
                      ),
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: checkconnectivity,
                          child: Container(
                              width: ScreenRF.width(context),
                              child: list()),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ));
  }

  Future checkconnectivity() async{
    var connectivityResult = await connectivity.checkConnectivity();
    if(connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi){
      getSharedData();
    }else{
      openNetworkDialog();
      setState(() {

      });
    }
  }

  openNetworkDialog() {
    print(',,,,,,,,,,,,,,,,,,,,,');
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            insetPadding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            title:Flexible(child: Align(
              alignment: Alignment.center,
              child: Text('Network Issue !',style: GoogleFonts.nanumGothic(
                  fontSize: 12
              )),
            )),

            content: Container(
              height: MediaQuery.of(context).size.height/5,
              width: MediaQuery.of(context).size.width/2,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text('Please check your internet connectivity and try again.')
                  ],
                ),
              ),
            ),
            actions: [
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                  checkconnectivity();
                  setState(() {

                  });
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    width:150,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: SecondaryColor,
                    ),
                    child: Center(
                      child: Text("Try again", style: GoogleFonts.nanumGothic(color: Colors.white, fontWeight: FontWeight.bold),),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  String getDateStump(String sTime) {
    int timeNumber = int.parse(sTime);
    return DateTime.fromMillisecondsSinceEpoch(timeNumber * 1000).toString();
  }

  void getSharedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('TOKEN')!;
    setState(() {
      getCourseContent(token, widget.mCourseData.id.toString());
    });
  }

  void getCourseContent(String token, String courseId) async {
    CommonOperation.showProgressDialog(context, "loading", true);
    final userCourseContentData =
    await networkCall.CourseContentCall(token, courseId);
    if (userCourseContentData != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String message = 'Success';
      courseContentList = userCourseContentData;
      print('data_content ' + courseContentList.first.name.toString());
      CommonOperation.hideProgressDialog(context);
      //showToastMessage(message);
      setState(() {});
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

  list() {
    return ListView.builder(
        itemCount: courseContentList.length,
        itemBuilder: (context, index) {
          return InkWell(
              child: Container(
                color: (index ==0 || index%2== 0)?Color(0xFFFFFFFF):Color(0xFFF5F5F5),
                padding: EdgeInsets.only(top: 13, bottom: 11),
                width: ScreenRF.width(context),
                child: Column(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Stack(
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        courseContentList[index].name.toString(),
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: index == showSub
                                      ? Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    color: Colors.black,
                                    size: 24.0,

                                    /// semanticLabel: 'Text to announce in accessibility modes',
                                  )
                                      : Icon(
                                    Icons.keyboard_arrow_right,
                                    color: Colors.black,
                                    size: 24.0,

                                    /// semanticLabel: 'Text to announce in accessibility modes',
                                  )),
                            ],
                          )
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: index == showSub
                              ? Row(
                            children: [
                              Expanded(
                                  child: SingleChildScrollView(
                                    controller: scrollController,
                                    physics: NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    child: Column(
                                      key: GlobalKey(),
                                      children: [
                                        SizedBox(
                                          height: 30,
                                        ),
                                        courseContentList[index].summary.toString() != ""?Container(
                                         width: ScreenRF.width(context),
                                         child: Html(data: courseContentList[index].summary.toString())):
                                        Container(),
                                        Container(
                                            width: ScreenRF.width(context),
                                            child: sublist(index))
                                      ],
                                    ),
                                  ))
                            ],
                          )
                              : Container(),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              onTap: () {
                setState(() {
                  if (showSub == index) {
                    showSub = -1;
                    showContact = -1;
                    showMap = -1;
                  } else {
                    showSub = index;
                    showContact = -1;
                    showMap = -1;
                  }
                });
              });
        });
  }

  sublist(sub_index) {
    return ListView.builder(
        itemCount: courseContentList[sub_index].modules.length,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          return Visibility(
            visible: courseContentList[sub_index]
                .modules[index]
                .uservisible?true:false,
            child: InkWell(
                child: Container(
                  color: AccentColor,
                  padding: EdgeInsets.only(left: 15, right: 15, bottom: 5),
                  child: Column(
                    children: [
                    SizedBox(
                      height: 5,
                    ),
                    Stack(
                      children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 12),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 5,
                                          ),
                                          courseContentList[sub_index]
                                              .modules[index]
                                              .modname
                                              .toString() == 'hvp'?Image.asset("assets/images/h5p.png", height:40,width: 40,)
                                              :courseContentList[sub_index]
                                              .modules[index]
                                              .modname
                                              .toString() == 'quiz'?Image.asset("assets/images/quiz_icon.png", height:40,width: 40,):
                                          courseContentList[sub_index]
                                              .modules[index]
                                              .modname
                                              .toString() == 'page'?Image.asset("assets/images/video_icon.png", height:40,width: 40,):
                                          Image.asset("assets/images/course_icon.png", height:40,width: 40,),

                                          Column(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context).size.width/1.7,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 12.0,right: 12.0),
                                                  child: Text(
                                                    courseContentList[sub_index]
                                                        .modules[index]
                                                        .name
                                                        .toString(),
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 15),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 10,),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 8.0),
                                                child: Visibility(
                                                  visible: (courseContentList[sub_index]
                                                      .modules[index]
                                                      .completion.toString() == '1' || courseContentList[sub_index]
                                                      .modules[index]
                                                      .completion.toString() == '2')?true:false,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: ((courseContentList[sub_index]
                                                          .modules[index]
                                                          .completion.toString() == '1' || courseContentList[sub_index]
                                                          .modules[index]
                                                          .completion.toString() == '2')&&
                                                          courseContentList[sub_index]
                                                              .modules[index]
                                                              .completiondata
                                                              .state.toString() == '1')? AccentColor:Colors.redAccent,
                                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                                    ),
                                                    width: MediaQuery.of(context).size.width/1.8,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 5.0,right: 12.0, top: 5, bottom: 5),
                                                      child: Text(((courseContentList[sub_index]
                                                          .modules[index]
                                                          .completion.toString() == '1' || courseContentList[sub_index]
                                                          .modules[index]
                                                          .completion.toString() == '2')&&
                                                        courseContentList[sub_index]
                                                            .modules[index]
                                                            .completiondata
                                                            .state.toString() == '1')?'Done: Complete the Activity':'To do: Complete the Activity',
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 15, color: Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: index == showContact
                                      ? Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    color: Colors.black,
                                    size: 24.0,

                                    /// semanticLabel: 'Text to announce in accessibility modes',
                                  )
                                      : Icon(
                                    Icons.keyboard_arrow_right,
                                    color: Colors.black,
                                    size: 24.0,

                                    /// semanticLabel: 'Text to announce in accessibility modes',
                                  )),
                            ],
                          ),
                        ),
                      )
                    ],
                    ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: index == showContact &&
                            courseContentList[sub_index]
                                .modules[index]
                                .modname !=
                                "attendance" &&
                            courseContentList[sub_index]
                                .modules[index]
                                .modname !=
                                "quiz" &&
                            courseContentList[sub_index]
                                .modules[index]
                                .modname !=
                                "assign" &&
                            courseContentList[sub_index]
                                .modules[index]
                                .modname !=
                                "hvp" &&
                            courseContentList[sub_index]
                                .modules[index]
                                .modname !=
                                "label"&&
                            courseContentList[sub_index]
                                .modules[index]
                                .modname !=
                                "forum"&&
                            courseContentList[sub_index]
                                .modules[index]
                                .modname !=
                                "page"
                            ? Row(
                          children: [
                            Expanded(
                                child: SingleChildScrollView(
                                  controller: scrollController,
                                  physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  child: Column(
                                    key: GlobalKey(),
                                    children: [
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                          width: ScreenRF.width(context),
                                          child: sublist2(sub_index, index))
                                    ],
                                  ),
                                ))
                          ],
                        )
                            : index == showContact
                            ? InkWell(
                              onTap: () {
                                //quizDialog();
                                courseContentList[sub_index]
                                    .modules[index]
                                    .modname ==
                                    "quiz" ? Navigator.push(context,
                                    MaterialPageRoute(builder: (context) =>
                                        QuizViewPage(courseContentList[sub_index]
                                            .modules[index].name.toString(),
                                            courseContentList[sub_index]
                                                .modules[index].instance
                                                .toString())))
                                    : courseContentList[sub_index].modules[index]
                                    .modname ==
                                    "assign" ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AssignmentDetailsPage(
                                                widget.mCourseData.id.toString(),
                                                courseContentList[sub_index]
                                                    .modules[index].name.toString(),
                                                courseContentList[sub_index]
                                                    .modules[index].instance
                                                    .toString(),
                                                DateFormat.yMMMEd().format(
                                                    DateTime.parse(getDateStump(
                                                        courseContentList[sub_index]
                                                            .modules[index].dates[0]
                                                            .timestamp
                                                            .toString()))),
                                                DateFormat.yMMMEd().format(
                                                    DateTime.parse(getDateStump(
                                                        courseContentList[sub_index]
                                                            .modules[index].dates[1]
                                                            .timestamp.toString())))
                                            ))) :
                                     courseContentList[sub_index].modules[index]
                                    .modname ==
                                    "hvp" ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            WebViewPage(
                                                courseContentList[sub_index]
                                                    .modules[index].url.toString(),
                                                courseContentList[sub_index]
                                                    .modules[index].name.toString()
                                            ))) :
                                     courseContentList[sub_index].modules[index]
                                         .modname ==
                                         "label" ? OpenHtmlDialog(courseContentList[sub_index].modules[index]
                                         .name, "<p dir=\"ltr\" style=\"text-align: left;\"></p><p></p><p>Python is the most popular programming language in the\r\nworld. The average salary for a Python developer is 116k in the USA. That's\r\nalmost 30k more than other developers!</p>\r\n\r\n<p>Python is used by big companies like Google, Facebook,\r\nDropbox, Reddit, Spotify, Quora, etc.</p>\r\n\r\n<p>Mathematicians, scientists, engineers and developers love\r\nit because of its simple and elegant syntax.</p>\r\n\r\n<p>It's the #1 language for AI and machine learning, and the\r\nideal language to learn for beginners. Much easier than C++ or JavaScript!</p>\r\n\r\n<p>This course teaches you everything Python has to offer from\r\nthe basics to more advanced topics.</p>\r\n\r\n<p>A perfect mix of theory and practice, packed with\r\nreal-world examples, exercises and step-by-step solutions - free of \"fluff\"\r\nand lengthy description!</p>\r\n\r\n<p><b>Discover how to use Python in automation, web\r\ndevelopment and machine learning.</b></p><br><p></p><br><p></p>"
                                          )
                                         : courseContentList[sub_index].modules[index]
                                         .modname ==
                                         "forum" ? OpenDialog(courseContentList[sub_index].modules[index]
                                         .name.toString(), 'No description Yet!'):courseContentList[sub_index].modules[index]
                                         .modname ==
                                         "page" ? findVideoUrl(token, courseContentList[sub_index].modules[index].contents[0].fileurl.toString(), courseContentList[sub_index].modules[index].name.toString(), courseContentList[sub_index].modules[index].instance.toString()):
                                                      print("Not assignment clicked !");
                                     // Navigator.push(
                                     //     context,
                                     //     MaterialPageRoute(
                                     //         builder: (context) =>
                                     //             YoutubePlayerDemoApp())): print("Not assignment clicked !");
                                setState(() {

                                });
                              },
                              child: Container(
                                margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                  ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "View details",
                                    style:
                                    TextStyle(color: SecondaryColor),
                                  ),
                                ),
                              ),
                            )
                            : Container(),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  //on tap task
                  setState(() {
                    if (showContact == index) {
                      showContact = -1;
                      showMap = -1;
                    } else {
                      showContact = index;
                      showMap = -1;
                    }

                    // sublist2(sub_index, index);
                  });
                }),
          );
        });
  }

  sublist2(sub_index, int sub_index2) {
    print('????????? ' + 'check 2nd data');
    print('????????? ' +
        courseContentList[sub_index]
            .modules[sub_index2]
            .contents
            .length
            .toString());
    return ListView.builder(
        itemCount:
        courseContentList[sub_index].modules[sub_index2].contents.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return InkWell(
              child: Container(
                margin: const EdgeInsets.only(
                    left: 10, right: 20, top: 0, bottom: 0),
                padding: const EdgeInsets.all(2),
                width: ScreenRF.width(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          courseContentList[sub_index]
                              .modules[sub_index2]
                              .contents[index]
                              .filename
                              .toString(),
                          style: TextStyle(color: SecondaryColor),
                        )),

                    Visibility(
                      visible: courseContentList[sub_index]
                          .modules[sub_index2]
                          .contents[index]
                          .mimetype
                          .toString() ==
                          "audio/mp3"
                          ? true
                          : false,
                      child: InkWell(
                        onTap: () {
                          //isPlaying = false;
                          setAudio();
                          dialog();
                        },
                        child: Padding(
                            padding: const EdgeInsets.only(right: 25.0),
                            child: Icon(
                              Icons.play_circle,
                              color: SecondaryColor,
                            )),
                      ),
                    )
                    //cardItem(sub_index, sub_index2, index),
                  ],
                ),
              ),
              onTap: () async {
                final fileName = FileUtil.getFileName(
                    courseContentList[sub_index]
                        .modules[sub_index2]
                        .contents[index]
                        .fileurl
                        .toString());
                final fileType = FileUtil.getFileType(
                    courseContentList[sub_index]
                        .modules[sub_index2]
                        .contents[index]
                        .fileurl
                        .toString());
                String savePath = await getFilePath(fileType, fileName);
                // tapingFunction(context, courseContentList[sub_index]
                //     .modules[sub_index2]
                //     .contents[index]
                //     .fileurl
                //     .toString()+'&token=$token', savePath);
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => PdfViwerPage(courseContentList[sub_index]
                //             .modules[sub_index2]
                //             .contents[index]
                //             .fileurl
                //             .toString(), token)));
                FileDownloader.downloadFile(
                    url: courseContentList[sub_index]
                        .modules[sub_index2]
                        .contents[index]
                        .fileurl
                        .toString() +
                        '&token=$token',
                    name: courseContentList[sub_index]
                        .modules[sub_index2]
                        .contents[index]
                        .filename
                        .toString(),
                    onDownloadCompleted: (String path) {
                      //final File file = File('panda');
                      print('FILE DOWNLOADED TO PATH: $savePath');
                      //This will be the path of the downloaded file
                    });
              });
        });
  }

  cardItem(sub_index, int sub_index2, int index) {
    print('????????? ' + 'check 3rd data');
    print('+++++++++++++++++ ' +
        courseContentList[sub_index]
            .modules[sub_index2]
            .contents[index]
            .filename
            .toString());
    return Container(
      margin: const EdgeInsets.all(1.0),
      padding: const EdgeInsets.all(8),
      width: ScreenRF.width(context),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.white, Colors.white70],
            begin: FractionalOffset(0, 0),
            end: FractionalOffset(0, 1),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              offset: Offset(0, 2),
              blurRadius: 5,
              color: Colors.black.withOpacity(0.4)),
        ],
      ),
      child: Column(
        children: [
          GapRF(10),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
                courseContentList[sub_index]
                    .modules[sub_index2]
                    .contents[index]
                    .filename
                    .toString(),
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 12)),
          ),
        ],
      ),
    );
  }

  Future getFilePath(String type, String assetPath) async {
    final _directory = await getTemporaryDirectory();
    return "${_directory.path}/fileview/${base64.encode(
        utf8.encode(assetPath))}.$type";
  }

  void tapingFunction(BuildContext context, String downloadUrl,
      String downloadPath) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) {
        return PdfViwerPage(
          downloadUrl,
          downloadPath,
        );
      }),
    );
  }

  void dialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('audio.mp3'),
            content: Container(
              height: 80,
              child: Column(
                children: [
                  // Slider(
                  //   min: 0,
                  //   max: duration.inSeconds.toDouble(),
                  //   value: position.inSeconds.toDouble(),
                  //   onChanged: (value) async {},
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text('0.00'),
                  //     Text('3.00'),
                  //   ],
                  // ),
                  InkWell(
                      onTap: () async {
                        //isPlaying = true;
                        if (isPlaying) {
                          isPlaying = false;
                          //await audioPlayer.pause();
                        } else {
                          isPlaying = true;
                          String url =
                              'https://radda.adnarchive.com/webservice/pluginfile.php/31/mod_folder/content/4/audio%201.mp3?forcedownload=1&token=f201f9cd0e050c8fdf4541115195c250';
                          //await audioPlayer.resume();
                          //await audioPlayer.setSourceUrl(url);
                        }
                        setState(() {
                          print('checkIsPlaying ' + isPlaying.toString());
                          //setAudio();
                        });
                      },
                      child: Icon(
                        isPlaying ? Icons.pause_circle : Icons.play_circle,
                        color: SecondaryColor,
                        size: 40,
                      ))
                ],
              ),
            ),
          );
        });
  }

  void setAudio() async {
    audioPlayer.setReleaseMode(ReleaseMode.loop); //repeate audio when complete

    audioPlayer.setSourceUrl(
        'https://radda.adnarchive.com/webservice/pluginfile.php/31/mod_folder/content/4/audio%201.mp3?forcedownload=1&token=f201f9cd0e050c8fdf4541115195c250');
  }

  OpenDialog(String name, String description) {
    print(',,,,,,,,,,,,,,,,,,,,,');
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            insetPadding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            title:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(child: Align(
                    alignment: Alignment.center,
                    child: Text(name,style: GoogleFonts.nanumGothic(
                        fontSize: 12
                    )),
                  )),
                  Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                          onTap: (){
                            Navigator.pop(context, false);
                          },
                          child: Icon(Icons.cancel_outlined))),
                ]),

            content: Container(
              height: MediaQuery.of(context).size.height/2,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(description.toString())
                  ],
                ),
              ),
            ),
          );
        });
  }
  OpenHtmlDialog(String name, String description) {
    print(',,,,,,,,,,,,,,,,,,,,,');
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            insetPadding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            title:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(child: Align(
                    alignment: Alignment.center,
                    child: Text(name,style: GoogleFonts.nanumGothic(
                        fontSize: 12
                    )),
                  )),
                  Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                          onTap: (){
                            Navigator.pop(context, false);
                          },
                          child: Icon(Icons.cancel_outlined))),
                ]),

            content: Container(
              height: MediaQuery.of(context).size.height/2,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Html(data: description.toString())
                  ],
                ),
              ),
            ),
          );
        });
  }

  findVideoUrl(String token, String url, String name, String pageid) async{
    CommonOperation.showProgressDialog(context, "loading", true);
    dynamic contentdata =
    await networkCall.VideoUrlCall(token, url);
    if (contentdata != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print('data_content_html ' + HtmlUnescape().convert(contentdata).toString());
      CommonOperation.hideProgressDialog(context);
      dom.Document document = parse(HtmlUnescape().convert(contentdata));
      var mainUrl = widget.mCourseData.id.toString() == '82'?document.getElementsByClassName('no-overflow')[0].attributes["href"].toString():document.getElementsByClassName('mediafallbacklink')[0].attributes["href"].toString();
      String vidUrl = mainUrl; //|| 'https://www.youtube.com/watch?v=1gDhl4leEzA&t=2s';

      setState(() {
        activityView(pageid);
         Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    VideoContentStanding(vidUrl, name)));
      });
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoged', false);
      showToastMessage('your session is expire ');
    }
  }

  activityView(String pageid) async{
    dynamic activityViewData =
    await networkCall.activityViewCall(token, pageid);
    if (activityViewData != null) {
      print("View succesfully");
      setState(() {

      });
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoged', false);
      showToastMessage('your session is expire ');
    }
  }
}
