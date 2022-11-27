import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:radda_moodle_learning/ApiModel/group_message_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ApiCall/HttpNetworkCall.dart';
import '../../Helper/colors_class.dart';
import '../../Helper/operations.dart';

class ChatDashBoardScreen extends StatefulWidget {
  String currentUserId;
  dynamic mChatData;

  ChatDashBoardScreen(this.currentUserId, this.mChatData);

  @override
  State<StatefulWidget> createState() => InitState();
// TODO: implement createState

}

class InitState extends State<ChatDashBoardScreen> {
  final textController = TextEditingController();
  final _scrollController = ScrollController();

  NetworkCall networkCall = NetworkCall();
  List<dynamic> courseList = [];
  List<Messages> groupMessagesList = [];
  String token = '';
  String name = '';
  String imageUrl =
      'https://3rdpartyservicesofflorida.com/wp-content/uploads/2015/03/blank-profile.jpg';
  String lastAccess = '';
  String city = '';
  String email = '';
  String count = '';

  @override
  void initState() {
    getSharedData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return inItWidget();
  }

  Widget inItWidget() {
    return Scaffold(
      backgroundColor: PrimaryColor,
      appBar: AppBar(leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
        backgroundColor: PrimaryColor,
        title: Text(
          widget.mChatData.name.toString(),
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: Container(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0)
                      )
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0)
                    ),
                    child: ListView.builder(
                        reverse: true,
                        padding: EdgeInsets.only(top: 14.0),
                        itemCount: groupMessagesList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final message = groupMessagesList[index];
                          final bool isMe = message.useridfrom.toString() == '60';
                          return MessageWidget(message);
                        }
                    ),
                  )
              ),
            ),
            _buildMessageComposer(),
          ],
        ),
      ),
    );
  }

  _buildMessageComposer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value) {},
              decoration: InputDecoration(
                  hintText: 'Send a message..'
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  void getSharedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('TOKEN')!;
    setState(() {
      getGroupMessage(
          token, widget.currentUserId, widget.mChatData.id.toString());
    });
  }

  void getGroupMessage(String token, String userId, String convId) async {
    CommonOperation.showProgressDialog(context, "loading", true);
    final groupMessageData =
        await networkCall.GroupMessageCall(token, userId, convId);
    if (groupMessageData != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String message = 'Success';
      groupMessagesList = groupMessageData.messages!;
      //print('hospital data' + groupMessageData.messages!.first.text.toString());
      CommonOperation.hideProgressDialog(context);
      //showToastMessage(message);
      setState(() {
        // name = userProfilesData.fullname.toString();
        // imageUrl = userProfilesData.profileimageurl.toString();
        // String lastAccessRaw =
        //     getDateStump(userProfilesData.lastaccess.toString());
        // DateTime raw = DateTime.parse(lastAccessRaw);
        // lastAccess = DateFormat.yMMMEd().format(raw);
        // city = userProfilesData.city.toString();
        // email = userProfilesData.email.toString();
        // getUserCourses(token, userId);
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

  String getDateStump(String sTime) {
    int timeNumber = int.parse(sTime);
    return DateTime.fromMillisecondsSinceEpoch(timeNumber * 1000).toString();
  }

  void getUserCourses(String token, String id) async {
    CommonOperation.showProgressDialog(context, "loading", true);
    final userCoursesData = await networkCall.UserCoursesListCall(token, id);
    if (userCoursesData != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String message = 'Success';
      courseList = userCoursesData;
      count = courseList.length.toString();
      print('data_count ' + courseList.toString());
      CommonOperation.hideProgressDialog(context);
      //showToastMessage(message);
      setState(() {});
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoged', false);
      showToastMessage('your session is expire ');
    }
  }

  Widget MessageWidget(Messages mContactData) {
    if(mContactData.useridfrom.toString() == '60'){
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: 250),
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.only(right: 8, bottom: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: PrimaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(mContactData.text!,
                    style: TextStyle(color: Colors.black)),
                SizedBox(
                  height: 4,
                ),
                Text(mContactData.timecreated.toString(),
                    style: TextStyle(color: Colors.black)),
              ],
            ),
          ),
        ],
      );
    }else{
      return Row(
        children: [
          Container(
            constraints: BoxConstraints(
                maxWidth: 250
            ),
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.only(left: 8, bottom: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color.fromARGB(255, 225, 231, 236),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(mContactData.text!, style: TextStyle(color: Colors.black)),
                SizedBox(height: 4,),
                Text(mContactData.timecreated.toString(), style: TextStyle(color: Colors.black)),
              ],
            ),
          ),
        ],
      );
    }
  }

}
