import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/components/badge/gf_badge.dart';
import 'package:getwidget/components/badge/gf_button_badge.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:radda_moodle_learning/ApiModel/allChatsHolderResponse.dart';
import 'package:radda_moodle_learning/Screens/Message&Notification/contact_components.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ApiCall/HttpNetworkCall.dart';
import '../../Helper/operations.dart';
import 'chat_dash_board.dart';

class MessageComponents extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<MessageComponents> {
  List<Map<String, dynamic>> categoryList = [
    {"name": "All chats"},
    {"name": "Group"},
    {"name": "Private"},
    {"name": "Contacts"},
  ];
  NetworkCall networkCall = NetworkCall();
  List<Conversations> chatHolderList = [];
  List<Conversations> groupChatHolderList = [];
  List<Conversations> privateChatHolderList = [];
  List<Conversations> contactsList = [];
  List<dynamic> contactRequestList = [];
  bool selectedCat = false;
  int fieldVisible = 1;
  String token ='';
  String userid ='';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      getSharedData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return initWidget(context);
  }

  Widget initWidget(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0E95),
      body: Container(
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
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/rectangle_bg.png"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8,top: 5.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("Messages", style: GoogleFonts.comfortaa(
                        fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white
                    ),),
                  ),
                )
            ),
            Container(
              height: 120,
              color: Colors.blue.shade100,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15.0, top: 8, right: 10),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Container(
                            child: GFButtonBadge(
                              color: fieldVisible == 1?Color(0xFF0E0E95):Color(0xFFE7EAEC),
                              onPressed: () {
                                fieldVisible = 1;
                                setState(() {

                                });
                              },
                              text: 'All chat',textStyle: GoogleFonts.comfortaa(
                                color: fieldVisible == 1?Colors.white:Color(0xFF01A9B8)),
                              icon: GFBadge(
                                child: Text(chatHolderList.length.toString()),
                              ),
                            ),),
                          SizedBox(width: 5,),
                          Container(
                            child: GFButtonBadge(
                              color: fieldVisible == 2?Color(0xFF0E0E95):Color(0xFFE7EAEC),
                              onPressed: () {
                                fieldVisible = 2;
                                setState(() {

                                });
                              },
                              text: 'Group',textStyle: GoogleFonts.comfortaa(
                                color: fieldVisible == 2?Colors.white:Color(0xFF01A9B8)),
                              icon: GFBadge(
                                child: Text(groupChatHolderList.length.toString()),
                              ),
                            ),
                          ),
                          SizedBox(width: 5,),
                          Container(
                            child: GFButtonBadge(
                              color: fieldVisible == 3?Color(0xFF0E0E95):Color(0xFFE7EAEC),
                              onPressed: () {
                                fieldVisible = 3;
                                setState(() {

                                });
                              },
                              text: 'Private',textStyle: GoogleFonts.comfortaa(
                                color: fieldVisible == 3?Colors.white:Color(0xFF01A9B8)),
                              icon: GFBadge(
                                child: Text(privateChatHolderList.length.toString()),
                              ),
                            ),),
                          SizedBox(width: 5,),
                          Container(
                            child: GFButtonBadge(
                              color: fieldVisible == 4?Color(0xFF0E0E95):Color(0xFFE7EAEC),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ContactComponents(contactsList, contactRequestList, userid)));
                                setState(() {

                                });
                              },
                              text: 'Contact',textStyle: GoogleFonts.comfortaa(
                                color: fieldVisible == 4?Colors.white:Color(0xFF01A9B8)),
                              icon: GFBadge(
                                child: Text((contactsList.length+contactRequestList.length).toString()),
                              ),
                            ),
                          ),
                        ],
                          // children: List.generate(categoryList.length,
                          //         (index) => CategoryCard(
                          //         text: categoryList[index]['name'],
                          //         press: () {
                          //           selectedCat = true;
                          //           Navigator.push(context, MaterialPageRoute(builder: (context) => ContactComponents(contactsList, contactRequestList)));
                          //           debugPrint('>>>>>>>>>>  '+categoryList[index]['name']+ ' is clicked !');
                          //         }
                          //     )
                          // )
                      ),
                    ),
                  ),
                  SizedBox(height: 8,),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, top: 8, right: 18),
                    child: SizedBox(
                      height: 40,
                      child: TextField(
                        //controller: searchCtrl,
                        textInputAction: TextInputAction.go,
                        maxLines: 1,
                        minLines: 1,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search, color: Colors.blueAccent,),
                          contentPadding: EdgeInsets.all(8),
                          hintText: 'search',
                          hintStyle: TextStyle(fontSize: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: fieldVisible == 1?true:false,
              child: Expanded(
                child: Padding(
                    padding:
                    const EdgeInsets.only(left: 12.0, right: 12.0),
                    child: ListView.builder(
                        itemCount: chatHolderList.length,
                        itemBuilder: (context, index) {
                          final mChatData = chatHolderList[index];

                          return buildChatHolderList(mChatData);
                        })),
              ),
            ),
            Visibility(
              visible: fieldVisible == 2?true:false,
              child: Expanded(
                child: Padding(
                    padding:
                    const EdgeInsets.only(left: 12.0, right: 12.0),
                    child: ListView.builder(
                        itemCount: groupChatHolderList.length,
                        itemBuilder: (context, index) {
                          final mGroupChatData = groupChatHolderList[index];

                          return buildGroupHolderList(mGroupChatData);
                        })),
              ),
            ),
            Visibility(
              visible: fieldVisible == 3?true:false,
              child: Expanded(
                child: Padding(
                    padding:
                    const EdgeInsets.only(left: 12.0, right: 12.0),
                    child: ListView.builder(
                        itemCount: privateChatHolderList.length,
                        itemBuilder: (context, index) {
                          final mPrivateChatData = privateChatHolderList[index];

                          return buildPrivateHolderList(mPrivateChatData);
                        })),
              ),
            ),
            SizedBox(height: 12,)
          ],
        ),
      ),
    );
  }
  void getSharedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('TOKEN')!;
    userid = prefs.getString('userId')!;
    setState(() {
      getChatHolders(token, userid);
    });
  }

  void getChatHolders(String token, String userId) async {
    CommonOperation.showProgressDialog(context, "loading", true);
    final chatHolderData =
    await networkCall.ChatHolderListCall(token, userId);
    if (chatHolderData != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String message = 'Success';

      chatHolderList = chatHolderData.conversations!;
      groupChatHolderList = chatHolderList.where((element) => element.type==2).toList();
      privateChatHolderList = chatHolderList.where((element) => element.type==1).toList();
      for(int i=0;i<chatHolderList.length;i++){
        if(chatHolderList[i].members!.length >0  && chatHolderList[i].subname != null && chatHolderList[i].members!.first.iscontact!){
          contactsList.add(chatHolderList[i]);
        }
      }
      print('new data'+ contactsList.length.toString());

      //print('data_count1 ' + chatHolderData.first.toString());
      CommonOperation.hideProgressDialog(context);
      showToastMessage(message);
      setState(() {
        getContactRequest(token, userId);
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

  Widget buildChatHolderList(mChatData) => GestureDetector(
      onTap: () {
        /// do click item task
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatDashBoardScreen(userid, mChatData)));
      },
      child: Card(
        color: !mChatData.isread?Colors.grey.shade200:Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),),
        child: Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black12)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  FadeInImage.assetNetwork(
                      placeholder: 'assets/images/chat_head.jpg',
                      image:  'https://www.pngkit.com/png/full/44-443934_post-navigation-people-icon-grey.png',
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover),

                  Visibility(
                    visible: mChatData.isfavourite?true:false,
                      child: Icon(Icons.star, color: Colors.deepOrange,))
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 1.4,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Text(mChatData.name.toString()==''?'--':mChatData.name.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.comfortaa(
                                color: mChatData.isread?Colors.black:Colors.blueAccent,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Text( mChatData.subname.toString(),
                              style: GoogleFonts.comfortaa(
                                  color: Colors.black54,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Visibility(
                            visible: !mChatData.isread?true:false,
                            child: Icon(Icons.info_rounded, color: Colors.blueAccent,))
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.4,
                      child: Row(
                        children: [
                          Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Text(mChatData.members.length>0?mChatData.members.first.fullname.toString()+':':'', style: TextStyle(color: mChatData.isread?Colors.black:Colors.blueAccent),),
        ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2.8,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: Html(data: mChatData.messages.length>0?mChatData.messages.first.text.toString():''),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )
  );
  Widget buildGroupHolderList(mGroupChatData) => GestureDetector(
      onTap: () {
        /// do click item task
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => CourseDetailsPage(mCourseData)));
      },
      child: Card(
        color: !mGroupChatData.isread?Colors.grey.shade200:Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),),
        child: Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black12)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  FadeInImage.assetNetwork(
                      placeholder: 'assets/images/chat_head.jpg',
                      image:  'https://www.pngkit.com/png/full/44-443934_post-navigation-people-icon-grey.png',
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover),

                  Visibility(
                      visible: mGroupChatData.isfavourite?true:false,
                      child: Icon(Icons.star, color: Colors.deepOrange,))
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 1.4,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Text(mGroupChatData.name.toString()==''?'--':mGroupChatData.name.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.comfortaa(
                                color: mGroupChatData.isread?Colors.black:Colors.blueAccent,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Text( mGroupChatData.subname.toString(),
                              style: GoogleFonts.comfortaa(
                                  color: Colors.black54,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Visibility(
                            visible: !mGroupChatData.isread?true:false,
                            child: Icon(Icons.info_rounded, color: Colors.blueAccent,))
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.4,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Text(mGroupChatData.members.length>0?mGroupChatData.members.first.fullname.toString()+':':'', style: TextStyle(color: mGroupChatData.isread?Colors.black:Colors.blueAccent),),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2.8,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: Html(data: mGroupChatData.messages.length>0?mGroupChatData.messages.first.text.toString():''),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )
  );
  Widget buildPrivateHolderList(mPrivateChatData) => GestureDetector(
      onTap: () {
        /// do click item task
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => CourseDetailsPage(mCourseData)));
      },
      child: Card(
        color: !mPrivateChatData.isread?Colors.grey.shade200:Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),),
        child: Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black12)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  FadeInImage.assetNetwork(
                      placeholder: 'assets/images/chat_head.jpg',
                      image:  'https://www.pngkit.com/png/full/44-443934_post-navigation-people-icon-grey.png',
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover),

                  Visibility(
                      visible: mPrivateChatData.isfavourite?true:false,
                      child: Icon(Icons.star, color: Colors.deepOrange,))
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 1.4,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Text(mPrivateChatData.name.toString()==''?'--':mPrivateChatData.name.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.comfortaa(
                                color: mPrivateChatData.isread?Colors.black:Colors.blueAccent,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Text( mPrivateChatData.subname.toString(),
                              style: GoogleFonts.comfortaa(
                                  color: Colors.black54,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Visibility(
                            visible: !mPrivateChatData.isread?true:false,
                            child: Icon(Icons.info_rounded, color: Colors.blueAccent,))
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.4,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Text(mPrivateChatData.members.length>0?mPrivateChatData.members.first.fullname.toString()+':':'', style: TextStyle(color: mPrivateChatData.isread?Colors.black:Colors.blueAccent),),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2.8,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: Html(data: mPrivateChatData.messages.length>0?mPrivateChatData.messages.first.text.toString():''),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )
  );
  

  void getContactRequest(String token, String userId) async{
    CommonOperation.showProgressDialog(context, "loading", true);
    final contactRequestData =
    await networkCall.ContactRequestCall(token, userId);
    if (contactRequestData != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String message = 'SuccessContactList';

      contactRequestList = contactRequestData;
      //print('data_count1 ' + chatHolderData.first.toString());
      CommonOperation.hideProgressDialog(context);
      showToastMessage(message);
      setState(() {
       // getContactRequest(token, userId);
      });
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoged', false);
      showToastMessage('your session is expire ');
    }
  }

}
class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String? text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(5.0),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFFE7EAEC),
                borderRadius: BorderRadius.circular(10),
              ),
              child:  Text(text!, textAlign: TextAlign.center,style: GoogleFonts.comfortaa(
                color: const Color(0xFF01A9B8)) ),
            ),
          ],
        ),
      ),
    );
  }
}

