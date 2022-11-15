import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:radda_moodle_learning/ApiModel/group_message_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ApiCall/HttpNetworkCall.dart';
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
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(
          widget.mChatData.name.toString(),
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_horiz),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {},
          ),
        ],
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

    // return Scaffold(
    //   appBar: AppBar(
    //     backgroundColor: const Color(0xFF0E0E95),
    //     elevation: 0,
    //     leading: IconButton(
    //       icon: Icon(Icons.arrow_back_ios, color: Colors.white),
    //       onPressed: () => Navigator.of(context).pop(),
    //     ),
    //     title: Text(widget.mChatData.name.toString(),
    //         style: GoogleFonts.comfortaa(
    //             color: const Color(0xFFFFFFFF),
    //             fontWeight: FontWeight.w700,
    //             fontSize: 18)),
    //     centerTitle: false,
    //   ),
    //   backgroundColor: const Color(0xFF0E0E95),
    //   body: Column(
    //     children: <Widget>[
    //       Container(
    //         width: MediaQuery.of(context).size.width,
    //         height: MediaQuery.of(context).size.height -
    //             MediaQuery.of(context).size.height / 9,
    //         transform: Matrix4.translationValues(0, 10, 1),
    //         decoration: BoxDecoration(
    //             color: Color(0xFFFAFAFA),
    //             borderRadius: BorderRadius.only(
    //                 topLeft: Radius.circular(25),
    //                 topRight: Radius.circular(25))),
    //         child: Stack(
    //           fit: StackFit.expand,
    //           children: [
    //             Container(
    //               child: Column(
    //                 children: [
    //                   Expanded(
    //                     child: groupMessagesList.length > 0
    //                         ? ListView.builder(
    //                             reverse: true,
    //                             shrinkWrap: true,
    //                             controller: _scrollController,
    //                             padding: EdgeInsets.symmetric(vertical: 8),
    //                             itemCount: groupMessagesList.length,
    //                             itemBuilder: (context, index) {
    //                               final mMessageData = groupMessagesList[index];
    //                               return MessageWidget(mMessageData);
    //                             },
    //                           )
    //                         : Container(
    //                             padding: EdgeInsets.symmetric(vertical: 8),
    //                             child: Center(
    //                               child: Column(
    //                                 mainAxisAlignment: MainAxisAlignment.center,
    //                                 children: [
    //                                   Icon(
    //                                     Icons.chat,
    //                                     size: 80,
    //                                     color: Colors.grey.shade400,
    //                                   ),
    //                                   SizedBox(
    //                                     height: 20,
    //                                   ),
    //                                   Text(
    //                                     'No messages yet',
    //                                   ),
    //                                 ],
    //                               ),
    //                             ),
    //                           ),
    //                   ),
    //                   Align(
    //                     alignment: Alignment.bottomCenter,
    //                     child: Card(
    //                       margin: EdgeInsets.zero,
    //                       child: Padding(
    //                         padding: EdgeInsets.only(
    //                             right: 8,
    //                             left: 8,
    //                             bottom:
    //                                 MediaQuery.of(context).viewInsets.bottom > 0
    //                                     ? 15
    //                                     : 28,
    //                             top: 8),
    //                         child: Stack(
    //                           children: [
    //                             Row(
    //                               mainAxisAlignment: MainAxisAlignment.center,
    //                               crossAxisAlignment: CrossAxisAlignment.end,
    //                               children: [
    //                                 Expanded(
    //                                   child: Row(
    //                                     children: [
    //                                       IconButton(
    //                                         splashRadius: 20,
    //                                         icon: Icon(
    //                                           Icons.add,
    //                                           color: Colors.grey.shade700,
    //                                           size: 28,
    //                                         ),
    //                                         onPressed: () {},
    //                                       ),
    //                                       Expanded(
    //                                         child: Container(
    //                                           margin:
    //                                               EdgeInsets.only(bottom: 5),
    //                                           child: TextField(
    //                                             controller: textController,
    //                                             minLines: 1,
    //                                             maxLines: 5,
    //                                             cursorColor: Colors.black,
    //                                             decoration: InputDecoration(
    //                                               isDense: true,
    //                                               contentPadding:
    //                                                   EdgeInsets.only(
    //                                                       right: 16,
    //                                                       left: 20,
    //                                                       bottom: 10,
    //                                                       top: 10),
    //                                               hintStyle: TextStyle(
    //                                                   fontSize: 14,
    //                                                   color: Colors
    //                                                       .grey.shade700),
    //                                               hintText: 'Type a message',
    //                                               border: InputBorder.none,
    //                                               filled: true,
    //                                               fillColor:
    //                                                   Colors.grey.shade100,
    //                                               enabledBorder:
    //                                                   OutlineInputBorder(
    //                                                 borderRadius:
    //                                                     BorderRadius.circular(
    //                                                         20),
    //                                                 gapPadding: 0,
    //                                                 borderSide: BorderSide(
    //                                                     color: Colors
    //                                                         .grey.shade200),
    //                                               ),
    //                                               focusedBorder:
    //                                                   OutlineInputBorder(
    //                                                 borderRadius:
    //                                                     BorderRadius.circular(
    //                                                         20),
    //                                                 gapPadding: 0,
    //                                                 borderSide: BorderSide(
    //                                                     color: Colors
    //                                                         .grey.shade300),
    //                                               ),
    //                                             ),
    //                                             onChanged: (value) {
    //                                               if (value.length > 0) {
    //                                                 //hideTheMic();
    //                                               } else {
    //                                                 //showTheMic();
    //                                               }
    //                                             },
    //                                           ),
    //                                         ),
    //                                       ),
    //                                     ],
    //                                   ),
    //                                 ),
    //                                 Row(
    //                                   children: [
    //                                     IconButton(
    //                                       splashRadius: 20,
    //                                       icon: Icon(
    //                                         Icons.send,
    //                                         color: Colors.blue,
    //                                       ),
    //                                       onPressed: () {
    //                                         if (textController.text.length >
    //                                             0) {
    //                                           // addToMessages(
    //                                           //     textController.text);
    //                                           textController.clear();
    //                                           //showTheMic();
    //                                         }
    //                                       },
    //                                     ),
    //                                   ],
    //                                 ),
    //                               ],
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ],
    //         ),
    //         // Column(
    //         //   crossAxisAlignment: CrossAxisAlignment.center,
    //         //   mainAxisSize: MainAxisSize.max,
    //         //   mainAxisAlignment: MainAxisAlignment.end,
    //         //   children: [
    //         //     Container(
    //         //       padding: EdgeInsets.symmetric(horizontal: 20),
    //         //       color: Colors.white,
    //         //       height: 100,
    //         //       child: Row(
    //         //         children: [
    //         //           Expanded(
    //         //             child: Container(
    //         //               padding: EdgeInsets.symmetric(horizontal: 14),
    //         //               height: 60,
    //         //               decoration: BoxDecoration(
    //         //                 color: Colors.grey[200],
    //         //                 borderRadius: BorderRadius.circular(30),
    //         //               ),
    //         //               child: Row(
    //         //                 children: [
    //         //                   Icon(
    //         //                     Icons.emoji_emotions_outlined,
    //         //                     color: Colors.grey[500],
    //         //                   ),
    //         //                   SizedBox(
    //         //                     width: 10,
    //         //                   ),
    //         //                   Expanded(
    //         //                     child: TextField(
    //         //                       decoration: InputDecoration(
    //         //                         border: InputBorder.none,
    //         //                         hintText: 'Type your message ...',
    //         //                         hintStyle:
    //         //                             TextStyle(color: Colors.grey[500]),
    //         //                       ),
    //         //                     ),
    //         //                   ),
    //         //                 ],
    //         //               ),
    //         //             ),
    //         //           ),
    //         //           SizedBox(
    //         //             width: 16,
    //         //           ),
    //         //         ],
    //         //       ),
    //         //     )
    //         //
    //         //   ],
    //         // ),
    //       ),
    //     ],
    //   ),
    // );
  }
  // _buildMessage(Messages message, bool isMe, ){
  //   final Container msg = Container(
  //     width: MediaQuery.of(context).size.width * 0.75,
  //     margin: isMe
  //         ? EdgeInsets.only(top: 7.0, bottom: 8.0, left: 80.0)
  //         : EdgeInsets.only(top:8.0, bottom: 8.0),
  //     padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
  //     decoration: isMe ? BoxDecoration(
  //         color: Theme.of(context).accentColor,
  //         borderRadius: BorderRadius.only(
  //             topLeft: Radius.circular(15.0),
  //             bottomLeft: Radius.circular(15.0),
  //             topRight: Radius.circular(15.0)
  //         )
  //     ) : BoxDecoration(
  //         color: Color(0xFFe4f1fe),
  //         borderRadius: BorderRadius.only(
  //             topLeft: Radius.circular(15.0),
  //             topRight: Radius.circular(15.0),
  //             bottomRight: Radius.circular(15.0)
  //         )
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: <Widget>[
  //         Text(
  //           message.timecreated.toString(),
  //           style: TextStyle(
  //               color: Colors.blueGrey,
  //               fontSize: 13.0,
  //               fontWeight: FontWeight.w600
  //           ),
  //         ),
  //         SizedBox(height: 8.0,)
  //         ,       Html(data:
  //             message.text.toString(),
  //         ),
  //       ],
  //     ),
  //   );
  //   if (isMe){
  //     return msg;
  //   }
  // }

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
      showToastMessage(message);
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
      showToastMessage(message);
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
              color: Color(0xff1972F5),
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
