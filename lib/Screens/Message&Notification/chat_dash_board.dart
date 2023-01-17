import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:radda_moodle_learning/ApiModel/group_message_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ApiCall/HttpNetworkCall.dart';
import '../../Helper/colors_class.dart';
import '../../Helper/operations.dart';

class ChatDashBoardScreen extends StatefulWidget {
  String from;
  String currentId;
  dynamic mChatData;
  ChatDashBoardScreen(this.from, this.currentId, this.mChatData);



  @override
  State<StatefulWidget> createState() => InitState();
// TODO: implement createState

}

class InitState extends State<ChatDashBoardScreen> {
  final textController = TextEditingController();
  final messageController = TextEditingController();

  NetworkCall networkCall = NetworkCall();
  List<dynamic> courseList = [];
  List<Messages> groupMessagesList = [];
  List<Members> groupMembersList = [];
  String token = '';
  String userId = '';
  String name = '';
  String message = '';
  String memberName = '';
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
          widget.from=='private'?widget.mChatData.members.first.fullname.toString():widget.from=='contact'?widget.mChatData.fullname.toString():widget.mChatData.name.toString(),
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
      color: Colors.grey.shade300,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: messageController,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value) {
                message = value;
              },
              decoration: InputDecoration(
                  hintText: 'Send a message..'
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () {
              FocusScope.of(context).requestFocus(FocusNode());
              messageController.clear();
              widget.from == 'private'?sendMessage(token, message, widget.mChatData.members.first.id.toString())
                  :sendGroupMessage(token, message, widget.mChatData.id.toString());
            },
          ),
        ],
      ),
    );
  }

  void getSharedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('TOKEN')!;
    userId = prefs.getString('userId')!;
    Future.wait([getGroupMessage(token, widget.currentId, widget.mChatData.id.toString()), ]);
    setState(() {

    });

  }

  Future getGroupMessage(String token, String userId, String convId) async {
    CommonOperation.showProgressDialog(context, "loading", true);
    final groupMessageData =
    await networkCall.GroupMessageCall(token, userId, convId);
    if (groupMessageData != null && groupMessageData.exception == null) {
      groupMessagesList = groupMessageData.messages!;
      groupMembersList = groupMessageData.members!;

      CommonOperation.hideProgressDialog(context);

      setState(() {
      });
    }else if(groupMessageData!.exception != null){
      CommonOperation.hideProgressDialog(context);
      showToastMessage(groupMessageData.exception.toString());
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
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0 //message font size
    );
  }

  String getDateStump(String sTime) {
    int timeNumber = int.parse(sTime);
    return DateTime.fromMillisecondsSinceEpoch(timeNumber * 1000).toString();
  }

  Widget MessageWidget(Messages mContactData) {
    if(mContactData.useridfrom.toString() == userId){
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: 250),
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.only(right: 8, bottom: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: SecondaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Html(data: mContactData.text!),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                      DateFormat.yMMMEd().format(DateTime.parse(
                          getDateStump(mContactData.timecreated.toString()))),
                      style: GoogleFonts.comfortaa(
                          color: Colors.black54,
                          fontSize: 13,
                          fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ),
        ],
      );
    }else{
      for(int i = 0;i<groupMembersList.length;i++){
        if(groupMembersList[i].id.toString() == mContactData.useridfrom.toString()){
          memberName = groupMembersList[i].fullname.toString();
        }
      }
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
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(memberName),
                ),
                Html(data: mContactData.text!),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                      DateFormat.yMMMEd().format(DateTime.parse(
                          getDateStump(mContactData.timecreated.toString()))),
                      style: GoogleFonts.comfortaa(
                          color: Colors.black54,
                          fontSize: 13,
                          fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ),
        ],
      );
    }
  }

  Future sendMessage(String token, String message, String receiverId) async{
    CommonOperation.showProgressDialog(context, "loading", true);
    final sendMessageResponse =
    await networkCall.SendMessageCall(token, message, receiverId);
    CommonOperation.hideProgressDialog(context);
    if(sendMessageResponse != null){
      getSharedData();
    }
  }
  Future sendGroupMessage(String token, String message, String conversationId) async{
    CommonOperation.showProgressDialog(context, "loading", true);
    final sendMessageResponse =
    await networkCall.SendGroupMessageCall(token, message, conversationId);
    CommonOperation.hideProgressDialog(context);
    if(sendMessageResponse != null){
      getSharedData();
    }
  }


}
