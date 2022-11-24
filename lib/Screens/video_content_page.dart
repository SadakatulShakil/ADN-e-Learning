import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import '../ApiCall/HttpNetworkCall.dart';
import '../Helper/operations.dart';

class VideoContentPage extends StatefulWidget {
  String url, name;
  VideoContentPage(this.name, this.url);
  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<VideoContentPage> {

  String token = '';
  String vidUrl = '';
  late VideoPlayerController _controller;
  NetworkCall networkCall = NetworkCall();
  @override
  void initState() {
    // TODO: implement initState
    getSharedData();
    //setAudio();
    _controller = VideoPlayerController.network(
        'https://www.youtube.com/watch?v=1gDhl4leEzA&t=2s')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return initWidget(context);
  }

  Widget initWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF01974D),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(widget.name,
            style: GoogleFonts.comfortaa(
                color: const Color(0xFFFFFFFF),
                fontWeight: FontWeight.w700,
                fontSize: 18)),
        centerTitle: false,
      ),
      backgroundColor: const Color(0xFF01974D),
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
              child: Scaffold(
                body: Center(
                  child: _controller.value.isInitialized
                      ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                      : Container(),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      _controller.value.isPlaying
                          ? _controller.pause()
                          : _controller.play();
                    });
                  },
                  child: Icon(
                    _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  ),
                ),
              ),
    ),
        ],
      ),
    );
  }

  String getDateStump(String sTime) {
    int timeNumber = int.parse(sTime);
    return DateTime.fromMillisecondsSinceEpoch(timeNumber * 1000).toString();
  }

  void getSharedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('TOKEN')!;
    setState(() {
      getVideoUrl(token, widget.url);
    });
  }

  void getVideoUrl(String token, String url) async{
    CommonOperation.showProgressDialog(context, "loading", true);
    dynamic contentdata =
        await networkCall.VideoUrlCall(token, url);
    if (contentdata != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print('data_content_html ' + HtmlUnescape().convert(contentdata).toString());
      CommonOperation.hideProgressDialog(context);
      dom.Document document = parse(HtmlUnescape().convert(contentdata));
      var mainUrl = document
          .getElementsByClassName('mediafallbacklink')[0].attributes["href"].toString();
      vidUrl = mainUrl; //|| 'https://www.youtube.com/watch?v=1gDhl4leEzA&t=2s';
      showToastMessage(vidUrl);
      print(vidUrl);
      _controller = VideoPlayerController.network(
          vidUrl)
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {});
        });
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
