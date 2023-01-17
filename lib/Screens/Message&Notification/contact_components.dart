import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/badge/gf_badge.dart';
import 'package:getwidget/components/badge/gf_button_badge.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:radda_moodle_learning/ApiModel/allChatsHolderResponse.dart';
import 'package:radda_moodle_learning/Screens/Message&Notification/MessageComponents.dart';
import 'package:radda_moodle_learning/Screens/Message&Notification/chat_dash_board.dart';
import 'package:radda_moodle_learning/Screens/Profile/other_user_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ApiCall/HttpNetworkCall.dart';
import '../../Helper/colors_class.dart';
import '../../Helper/operations.dart';

class ContactComponents extends StatefulWidget {
  List<dynamic> contactRequestList;
  String userid;
  ContactComponents(this.contactRequestList, this.userid);

  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<ContactComponents> {
  List<dynamic> contactsListData = [];
  List<dynamic> subCategoryList = [];
  String token = '';
  String currentId = '';
  double value = 0;
  int fieldVisible = 1;
  NetworkCall networkCall = NetworkCall();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedData();
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
          title: Text('Contacts',
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
                    height: 110,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/rectangle_bg.png"),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25))),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              child: GFButtonBadge(
                                color: fieldVisible == 1?PrimaryColor:Color(0xFFE7EAEC),
                                onPressed: () {
                                  fieldVisible = 1;
                                  setState(() {
                                  });
                                },
                                text: 'My contacts',textStyle: GoogleFonts.comfortaa(
                                  color: fieldVisible == 1?Colors.white:PrimaryColor),
                                icon: GFBadge(
                                  child: Text(contactsListData.length.toString()),
                                ),
                              ),),
                            Container(
                              child: GFButtonBadge(
                                color: fieldVisible == 2?PrimaryColor:Color(0xFFE7EAEC),
                                onPressed: () {
                                  fieldVisible = 2;
                                  setState(() {
                                  });
                                },
                                text: 'Request',textStyle: GoogleFonts.comfortaa(
                                  color: fieldVisible == 2?Colors.white:PrimaryColor),
                                icon: GFBadge(
                                  child: Text(widget.contactRequestList.length.toString()),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 18.0, top: 15, right: 18),
                          child: SizedBox(
                            height: 40,
                            child: TextField(
                              //controller: searchCtrl,
                              textInputAction: TextInputAction.go,
                              maxLines: 1,
                              minLines: 1,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: SecondaryColor,
                                ),
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
                  SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: fieldVisible == 1 ? true : false,
                    child: contactsListData.length>0?Expanded(
                      child: Padding(
                          padding:
                          const EdgeInsets.only(left: 12.0, right: 12.0),
                          child: ListView.builder(
                              itemCount: contactsListData.length,
                              itemBuilder: (context, index) {
                                final mChatData = contactsListData[index];

                                return buildChatHolderList(mChatData);
                              })),
                    ):Center(
                      child: SizedBox(
                        height: 100,
                        child: Column(
                          children: [
                            Icon(
                              Icons.warning_amber,
                              size: 30,
                            ),
                            Text('No Data Found!'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: fieldVisible == 2 ? true : false,
                    child: widget.contactRequestList.length>0?Expanded(
                      child: Padding(
                          padding:
                          const EdgeInsets.only(left: 12.0, right: 12.0),
                          child: ListView.builder(
                              itemCount: widget.contactRequestList.length,
                              itemBuilder: (context, index) {
                                final mContactData = widget.contactRequestList[index];

                                return buildContactRequestList(mContactData);
                              })),
                    ):Center(
                      child: SizedBox(
                        height: 100,
                        child: Column(
                          children: [
                            Icon(
                              Icons.warning_amber,
                              size: 30,
                            ),
                            Text('No Data Found1!'),
                          ],
                        ),
                      ),
                    ),
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
    currentId = prefs.getString('userId')!;
    getContactList();
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
                builder: (context) => ChatDashBoardScreen('contact', widget.userid, mChatData)));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
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
                  Image.network(mChatData.profileimageurl.toString(), height: 40, width: 40,),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Text(
                                mChatData.fullname.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.comfortaa(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        Visibility(
                          visible: false,
                          child: Icon(
                            Icons.more_vert,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ));

  Widget buildContactRequestList(mContactData) => GestureDetector(
      onTap: () {
        /// do click item task
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => CourseDetailsPage(mCourseData)));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
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
                      image: mContactData.profileimageurl.toString(),
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Text(
                                mContactData.fullname.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.comfortaa(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            OpenDialog(context, mContactData);
                          },
                          child: Icon(
                            Icons.more_vert,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Text('e-Learning',
                          style: GoogleFonts.comfortaa(
                              color: Colors.black54,
                              fontSize: 13,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ));

  void OpenDialog(BuildContext context, mContactData) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            insetPadding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(child: Align(
                    alignment: Alignment.center,
                    child: Text('Request',style: GoogleFonts.comfortaa(
                        fontSize: 18
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
              height: MediaQuery.of(context).size.height/6,
              width: MediaQuery.of(context).size.width/6,
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.network(mContactData.profileimageurl.toString(),height: 60, width: 60,),
                      SizedBox(width: 8,),
                      Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width/2.5,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(mContactData.fullname.toString(),textAlign: TextAlign.center,
                                  style: GoogleFonts.comfortaa(
                                      fontWeight: FontWeight.w900, fontSize: 12)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 18),
                    child: Divider(
                      thickness: 2,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: (){
                        Navigator.pop(context, false);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => OtherProfileBody('contact', widget.userid, mContactData.id.toString())));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(top: 5.0, bottom: 5.0,),
                        padding: EdgeInsets.only(left: 8.0,  top: 8.0, bottom: 8.0),
                        decoration: BoxDecoration(
                          color: AccentColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 2,
                              // changes position of shadow
                            ),
                          ],
                        ),
                        child:  Align(
                          alignment: Alignment.center,
                          child: Text('View profile', textAlign: TextAlign.center,style: GoogleFonts.comfortaa(
                            color: const Color(0xFFFFFFFF),
                            fontWeight: FontWeight.bold,) ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              Row(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.pop(context, false);
                      callDeclineRequest(token, currentId, mContactData.id.toString());
                    },
                    child: Container(
                      width: 150,
                      margin: EdgeInsets.only(top: 5.0, bottom: 5.0,),
                      padding: EdgeInsets.only(left: 8.0,  top: 8.0, bottom: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 2,
                            // changes position of shadow
                          ),
                        ],
                      ),
                      child:  Align(
                        alignment: Alignment.center,
                        child: Text('Cancel', textAlign: TextAlign.center,style: GoogleFonts.comfortaa(
                          color: const Color(0xFFFFFFFF),) ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8,),
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                      callAcceptRequest(token, currentId, mContactData.id.toString());
                    },
                    child: Container(
                      width: 150,
                      margin: EdgeInsets.only(top: 5.0, bottom: 5.0,),
                      padding: EdgeInsets.only(left: 8.0,  top: 8.0, bottom: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 2,
                            // changes position of shadow
                          ),
                        ],
                      ),
                      child:  Align(
                        alignment: Alignment.center,
                        child: Text('Accept', textAlign: TextAlign.center,style: GoogleFonts.comfortaa(
                          color: const Color(0xFFFFFFFF),
                          fontWeight: FontWeight.bold,) ),
                      ),
                    ),
                  )

                ],
              )
            ],
          );
        });
  }

  void callAcceptRequest(String token, String currentId, String requestUserId) async{
    CommonOperation.showProgressDialog(
        context, "loading", true);
    final userProfilesData = await networkCall.ContactRequestAcceptCall(token, currentId, requestUserId);

    if(userProfilesData != null){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String message = 'Success';
      print('accept data'+ userProfilesData.toString());
      CommonOperation.hideProgressDialog(context);
      //showToastMessage(message);
      fieldVisible = 1;
      getContactRequest(token, widget.userid);
      getContactList();
      setState(() {
      });
    }else{
      CommonOperation.hideProgressDialog(context);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoged', false);
      showToastMessage('your session is expire ');
    }
  }

  void callDeclineRequest(String token, String currentId, String requestUserId) async{
    CommonOperation.showProgressDialog(
        context, "loading", true);
    final userProfilesData = await networkCall.ContactRequestDeclineCall(token, currentId, requestUserId);

    if(userProfilesData != null){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String message = 'Success';
      print('accept data'+ userProfilesData.toString());
      CommonOperation.hideProgressDialog(context);
      //showToastMessage(message);
      fieldVisible = 1;
      getContactRequest(token, widget.userid);
      getContactList();
      setState(() {
      });

    }else{
      CommonOperation.hideProgressDialog(context);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoged', false);
      showToastMessage('your session is expire ');
    }
  }
  void getContactRequest(String token, String userId) async {
    CommonOperation.showProgressDialog(context, "loading", true);
    final contactRequestData =
    await networkCall.ContactRequestCall(token, userId);
    if (contactRequestData != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String message = 'SuccessContactList';

      widget.contactRequestList.clear();
      widget.contactRequestList = contactRequestData;
      //print('data_count1 ' + chatHolderData.first.toString());
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

  void getContactList() async {
    CommonOperation.showProgressDialog(context, "loading", true);
    final contactListData =
    await networkCall.ContactsListCall(token, widget.userid);
    if (contactListData != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String message = 'SuccessContactList';

      contactsListData.clear();
      contactsListData = contactListData;
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

}
