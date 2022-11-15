import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:power_file_view/power_file_view.dart';
import 'package:radda_moodle_learning/Screens/Quiz/quiz_view_page.dart';
import 'package:radda_moodle_learning/Screens/assignmentDetailsPage.dart';
import 'package:radda_moodle_learning/Screens/pdfViwer.dart';
import 'package:radda_moodle_learning/Screens/webViewPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../ApiCall/HttpNetworkCall.dart';
import '../Helper/GapRF.dart';
import '../Helper/operations.dart';

class CourseDetailsPage extends StatefulWidget {
  dynamic mCourseData;

  CourseDetailsPage(this.mCourseData);

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
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    // TODO: implement initState
    getSharedData();
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
          backgroundColor: const Color(0xFF0E0E95),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('Course Details',
              style: GoogleFonts.comfortaa(
                  color: const Color(0xFFFFFFFF),
                  fontWeight: FontWeight.w700,
                  fontSize: 18)),
          centerTitle: false,
        ),
        backgroundColor: const Color(0xFF0E0E95),
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
                                    widget.mCourseData.displayname.toString(),
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
                                    child: Text(
                                        'Start date: ' +
                                            DateFormat.yMMMEd().format(
                                                DateTime.parse(getDateStump(
                                                    widget.mCourseData.startdate
                                                        .toString()))),
                                        style: GoogleFonts.comfortaa(
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold)),
                                  )),
                            ],
                          )),
                      Container(
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  "Course Content",
                                  style: GoogleFonts.comfortaa(fontSize: 13),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: SingleChildScrollView(
                        controller: scrollController,
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          key: GlobalKey(),
                          children: [
                            Container(
                                width: ScreenRF.width(context), child: list())
                          ],
                        ),
                      )),
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
      showToastMessage(message);
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
                margin: const EdgeInsets.all(1),
                padding: const EdgeInsets.all(10),
                width: ScreenRF.width(context),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.white, Colors.white70],
                      begin: FractionalOffset(0, 0),
                      end: FractionalOffset(0, 1),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        offset: Offset(0, 2),
                        blurRadius: 5,
                        color: Colors.black.withOpacity(0.4)),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Stack(
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
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text(
                                  courseContentList[index].name.toString(),
                                  style: TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.bold),
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
          return InkWell(
              child: Container(
                margin: const EdgeInsets.only(right: 25, top: 0, bottom: 0),
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: Text(
                            courseContentList[sub_index]
                                .modules[index]
                                .name
                                .toString(),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
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
                                  "assign"&&
                          courseContentList[sub_index]
                              .modules[index]
                              .modname !=
                              "hvp"
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
                        onTap: (){
                          courseContentList[sub_index]
                              .modules[index]
                              .modname ==
                              "assign"?Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AssignmentDetailsPage(
                                      widget.mCourseData.id.toString(),
                                      courseContentList[sub_index].modules[index].name.toString(),
                              courseContentList[sub_index].modules[index].instance.toString(),
                              DateFormat.yMMMEd().format(DateTime.parse(getDateStump(courseContentList[sub_index].modules[index].dates[0].timestamp.toString()))),
                              DateFormat.yMMMEd().format(DateTime.parse(getDateStump(courseContentList[sub_index].modules[index].dates[1].timestamp.toString())))
                                  ))) :print("Not assignment clicked !");
                        },
                                child: InkWell(
                                  onTap: (){
                                    //quizDialog();
                                    courseContentList[sub_index]
                                        .modules[index]
                                        .modname ==
                                        "quiz"?Navigator.push(context, MaterialPageRoute(builder: (context) => QuizViewPage(courseContentList[sub_index].modules[index].name.toString(), courseContentList[sub_index].modules[index].instance.toString())))
                                        :courseContentList[sub_index]
                                        .modules[index]
                                        .modname ==
                                        "assign"?Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AssignmentDetailsPage(
                                                widget.mCourseData.id.toString(),
                                                courseContentList[sub_index].modules[index].name.toString(),
                                                courseContentList[sub_index].modules[index].instance.toString(),
                                                DateFormat.yMMMEd().format(DateTime.parse(getDateStump(courseContentList[sub_index].modules[index].dates[0].timestamp.toString()))),
                                                DateFormat.yMMMEd().format(DateTime.parse(getDateStump(courseContentList[sub_index].modules[index].dates[1].timestamp.toString())))
                                            ))):courseContentList[sub_index]
                                        .modules[index]
                                        .modname ==
                                        "hvp"?Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => WebViewPage(
                                                courseContentList[sub_index].modules[index].url.toString(),
                                                courseContentList[sub_index].modules[index].name.toString()
                                            ))):print("Not assignment clicked !");
                                  },
                                  child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Check Now",
                                          style:
                                              TextStyle(color: Colors.blueAccent),
                                        ),
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
              });
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
                          style: TextStyle(color: Colors.blueAccent),
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
                              color: Colors.blueAccent,
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
    return "${_directory.path}/fileview/${base64.encode(utf8.encode(assetPath))}.$type";
  }

  void tapingFunction(
      BuildContext context, String downloadUrl, String downloadPath) {
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
                        color: Colors.blueAccent,
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

// String formatTime(Duration time) {
//   return();
// }
}
