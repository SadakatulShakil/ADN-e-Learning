import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/components/badge/gf_badge.dart';
import 'package:getwidget/components/badge/gf_button_badge.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/parser.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:radda_moodle_learning/ApiModel/allChatsHolderResponse.dart';
import 'package:radda_moodle_learning/Screens/Message&Notification/contact_components.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:html/dom.dart' as dom;
import '../../ApiCall/HttpNetworkCall.dart';
import '../../Helper/colors_class.dart';
import '../../Helper/operations.dart';
import '../Profile/other_user_profile.dart';
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
  List<dynamic> searchedUserList = [];
  var searchCtrl = TextEditingController();
  bool selectedCat = false;
  int fieldVisible = 1;
  String token = '';
  String userid = '';
  Connectivity connectivity = Connectivity();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      checkconnectivity();
    });
  }

  @override
  Widget build(BuildContext context) {
    return initWidget(context);
  }

  Widget initWidget(BuildContext context) {
    return Scaffold(
      backgroundColor: PrimaryColor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).size.height / 9,
        transform: Matrix4.translationValues(0, 10, 1),
        decoration: BoxDecoration(
            color: Color(0xFFFAFAFA),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
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
                  padding: const EdgeInsets.only(left: 8, top: 5.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Messages",
                      style: GoogleFonts.nanumGothic(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                )),
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
                              color: fieldVisible == 1
                                  ? PrimaryColor
                                  : Color(0xFFE7EAEC),
                              onPressed: () {
                                fieldVisible = 1;
                                setState(() {});
                              },
                              text: 'All chat',
                              textStyle: GoogleFonts.nanumGothic(
                                  color: fieldVisible == 1
                                      ? Colors.white
                                      : PrimaryColor),
                              icon: GFBadge(
                                child: Text(chatHolderList.length.toString()),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            child: GFButtonBadge(
                              color: fieldVisible == 2
                                  ? PrimaryColor
                                  : Color(0xFFE7EAEC),
                              onPressed: () {
                                fieldVisible = 2;
                                setState(() {});
                              },
                              text: 'Group',
                              textStyle: GoogleFonts.nanumGothic(
                                  color: fieldVisible == 2
                                      ? Colors.white
                                      : PrimaryColor),
                              icon: GFBadge(
                                child:
                                    Text(groupChatHolderList.length.toString()),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            child: GFButtonBadge(
                              color: fieldVisible == 3
                                  ? PrimaryColor
                                  : Color(0xFFE7EAEC),
                              onPressed: () {
                                fieldVisible = 3;
                                setState(() {});
                              },
                              text: 'Private',
                              textStyle: GoogleFonts.nanumGothic(
                                  color: fieldVisible == 3
                                      ? Colors.white
                                      : PrimaryColor),
                              icon: GFBadge(
                                child: Text(
                                    privateChatHolderList.length.toString()),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            child: GFButtonBadge(
                              color: fieldVisible == 4
                                  ? PrimaryColor
                                  : Color(0xFFE7EAEC),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ContactComponents(
                                            contactsList,
                                            contactRequestList,
                                            userid)));
                                setState(() {});
                              },
                              text: 'Contact',
                              textStyle: GoogleFonts.nanumGothic(
                                  color: fieldVisible == 4
                                      ? Colors.white
                                      : PrimaryColor),
                              icon: GFBadge(
                                child: Text((contactsList.length +
                                        contactRequestList.length)
                                    .toString()),
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
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 18.0, top: 8, right: 18),
                    child: SizedBox(
                      height: 40,
                      child: TextField(
                        controller: searchCtrl,
                        textInputAction: TextInputAction.go,
                        onSubmitted: (val) => val != ''
                            ? searchUser(token, searchCtrl.text)
                            : showToastMessage('please enter valid user'),
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
            Visibility(
              visible: fieldVisible == 1 ? true : false,
              child: Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                    child: RefreshIndicator(
                      onRefresh: checkconnectivity,
                      child: ListView.separated(
                        itemCount: chatHolderList.length,
                        itemBuilder: (context, index) {
                          final mChatData = chatHolderList[index];
                          return buildChatHolderList(mChatData);
                        },
                        separatorBuilder: (context, index) {
                          return Divider();
                        },
                      ),
                    )),
              ),
            ),
            Visibility(
              visible: fieldVisible == 2 ? true : false,
              child: Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                    child: RefreshIndicator(
                      onRefresh: checkconnectivity,
                      child: ListView.separated(
                        itemCount: groupChatHolderList.length,
                        itemBuilder: (context, index) {
                          final mGroupChatData = groupChatHolderList[index];

                          return buildGroupHolderList(mGroupChatData);
                        },
                        separatorBuilder: (context, index) {
                          return Divider();
                        },
                      ),
                    )),
              ),
            ),
            Visibility(
              visible: fieldVisible == 3 ? true : false,
              child: Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                    child: RefreshIndicator(
                      onRefresh: checkconnectivity,
                      child: ListView.separated(
                        itemCount: privateChatHolderList.length,
                        itemBuilder: (context, index) {
                          final mPrivateChatData = privateChatHolderList[index];

                          return buildPrivateHolderList(mPrivateChatData);
                        },
                        separatorBuilder: (context, index) {
                          return Divider();
                        },
                      ),
                    )),
              ),
            ),
            SizedBox(
              height: 12,
            )
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

  Future getChatHolders(String token, String userId) async {
    CommonOperation.showProgressDialog(context, "loading", true);
    final chatHolderData = await networkCall.ChatHolderListCall(token, userId);
    if (chatHolderData != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String message = 'Success';

      chatHolderList = chatHolderData.conversations!;
      groupChatHolderList =
          chatHolderList.where((element) => element.type == 2).toList();
      privateChatHolderList =
          chatHolderList.where((element) => element.type == 1).toList();
      for (int i = 0; i < chatHolderList.length; i++) {
        if (chatHolderList[i].members!.length > 0 &&
            chatHolderList[i].subname != null &&
            chatHolderList[i].members!.first.iscontact!) {
          contactsList.add(chatHolderList[i]);
        }
      }
      print('new data' + contactsList.length.toString());

      //print('data_count1 ' + chatHolderData.first.toString());
      CommonOperation.hideProgressDialog(context);
      //showToastMessage(message);
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

  Widget buildChatHolderList(mChatData) => ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatDashBoardScreen(
                      mChatData.type == 2 ? 'group' : 'private',
                      userid,
                      mChatData)));
        },
        title: Text(
            mChatData.name.toString() == ''
                ? mChatData.members.first.fullname.toString()
                : mChatData.name.toString(),
            overflow: TextOverflow.ellipsis),
        subtitle: Row(
          children: [
            Container(
              width: 55,
              child: Text(
                mChatData.members.length > 0 && mChatData.messages.length > 0
                    ? mChatData.messages.first.useridfrom.toString() == userid
                        ? 'you :'
                        : mChatData.members.first.fullname.toString() + ':'
                    : '',
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width / 2.7,
                child: Text(
                    mChatData.messages.length > 0
                        ? (parse(HtmlUnescape().convert(
                                    mChatData.messages.first.text.toString())))
                                .outerHtml
                                .contains('<p>')
                            ? (parse(HtmlUnescape().convert(
                                    mChatData.messages.first.text.toString())))
                                .getElementsByTagName('p')[0]
                                .innerHtml
                                .toString()
                            : (parse(HtmlUnescape().convert(mChatData
                                        .messages.first.text
                                        .toString())))
                                    .outerHtml
                                    .contains('<a href')
                                ? (parse(HtmlUnescape().convert(mChatData
                                        .messages.first.text
                                        .toString())))
                                    .getElementsByTagName('a')[0]
                                    .innerHtml
                                    .toString()
                                : ''
                        : '',
                    overflow: TextOverflow.ellipsis))
          ],
        ),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 3,
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(.3),
                  offset: Offset(0, 5),
                  blurRadius: 25)
            ],
          ),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: CircleAvatar(
                    backgroundImage: mChatData.type == 2
                        ? NetworkImage(mChatData.imageurl.toString())
                        : NetworkImage(mChatData.members.first.profileimageurl
                            .toString())),
              ),
            ],
          ),
        ),
        trailing: Container(
          width: 30,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  mChatData.isread
                      ? Icon(
                          Icons.check,
                          size: 15,
                        )
                      : Container(height: 15, width: 15),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              mChatData.isread
                  ? Container(
                      height: 25,
                      width: 25,
                    )
                  : Container(
                      alignment: Alignment.center,
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        "1",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
            ],
          ),
        ),
      );

  Widget buildGroupHolderList(mGroupChatData) => ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ChatDashBoardScreen('group', userid, mGroupChatData)));
        },
        title: Text(
            mGroupChatData.name.toString() == ''
                ? mGroupChatData.members.first.fullname.toString()
                : mGroupChatData.name.toString(),
            overflow: TextOverflow.ellipsis),
        subtitle: Row(
          children: [
            Container(
                width: 55,
                child: Text(
                    mGroupChatData.members.length > 0 &&
                            mGroupChatData.messages.length > 0
                        ? mGroupChatData.messages.first.useridfrom.toString() ==
                                userid
                            ? 'you :'
                            : mGroupChatData.members.first.fullname.toString() +
                                ': '
                        : '',
                    overflow: TextOverflow.ellipsis)),
            Container(
                width: MediaQuery.of(context).size.width / 2.7,
                child: Text(
                    mGroupChatData.messages.length > 0
                        ? (parse(HtmlUnescape().convert(mGroupChatData
                                    .messages.first.text
                                    .toString())))
                                .outerHtml
                                .contains('<p>')
                            ? (parse(HtmlUnescape().convert(mGroupChatData
                                    .messages.first.text
                                    .toString())))
                                .getElementsByTagName('p')[0]
                                .innerHtml
                                .toString()
                            : (parse(HtmlUnescape().convert(mGroupChatData
                                        .messages.first.text
                                        .toString())))
                                    .outerHtml
                                    .contains('<a href')
                                ? (parse(HtmlUnescape().convert(mGroupChatData
                                        .messages.first.text
                                        .toString())))
                                    .getElementsByTagName('a')[0]
                                    .innerHtml
                                    .toString()
                                : ''
                        : '',
                    overflow: TextOverflow.ellipsis))
          ],
        ),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 3,
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(.3),
                  offset: Offset(0, 5),
                  blurRadius: 25)
            ],
          ),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: CircleAvatar(
                    backgroundImage:
                        NetworkImage(mGroupChatData.imageurl.toString())),
              ),
            ],
          ),
        ),
        trailing: Container(
          width: 30,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  mGroupChatData.isread
                      ? Icon(
                          Icons.check,
                          size: 15,
                        )
                      : Container(height: 15, width: 15),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              mGroupChatData.isread
                  ? Container(
                      height: 25,
                      width: 25,
                    )
                  : Container(
                      alignment: Alignment.center,
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        "1",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
            ],
          ),
        ),
      );

  Widget buildPrivateHolderList(mPrivateChatData) => ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatDashBoardScreen(
                      'private', userid, mPrivateChatData)));
        },
        title: Text(mPrivateChatData.name.toString() == ''
            ? mPrivateChatData.members.first.fullname.toString()
            : mPrivateChatData.name.toString()),
        subtitle: Row(
          children: [
            Container(
              width: 55,
              child: Text(
                mPrivateChatData.members.length > 0 &&
                        mPrivateChatData.messages.length > 0
                    ? mPrivateChatData.messages.first.useridfrom.toString() ==
                            userid
                        ? 'you :'
                        : mPrivateChatData.members.first.fullname.toString() +
                            ':'
                    : '',
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width / 2.7,
                child: Text(
                    mPrivateChatData.messages.length > 0
                        ? (parse(HtmlUnescape().convert(mPrivateChatData
                                    .messages.first.text
                                    .toString())))
                                .outerHtml
                                .contains('<p>')
                            ? (parse(HtmlUnescape().convert(mPrivateChatData
                                    .messages.first.text
                                    .toString())))
                                .getElementsByTagName('p')[0]
                                .innerHtml
                                .toString()
                            : (parse(HtmlUnescape().convert(mPrivateChatData
                                        .messages.first.text
                                        .toString())))
                                    .outerHtml
                                    .contains('<a href')
                                ? (parse(HtmlUnescape().convert(mPrivateChatData
                                        .messages.first.text
                                        .toString())))
                                    .getElementsByTagName('a')[0]
                                    .innerHtml
                                    .toString()
                                : ''
                        : '',
                    overflow: TextOverflow.ellipsis))
          ],
        ),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 3,
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(.3),
                  offset: Offset(0, 5),
                  blurRadius: 25)
            ],
          ),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: CircleAvatar(
                    backgroundImage: NetworkImage(mPrivateChatData
                        .members.first.profileimageurl
                        .toString())),
              ),
            ],
          ),
        ),
        trailing: Container(
          width: 30,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  mPrivateChatData.isread
                      ? Icon(
                          Icons.check,
                          size: 15,
                        )
                      : Container(height: 15, width: 15),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              mPrivateChatData.isread
                  ? Container(
                      height: 25,
                      width: 25,
                    )
                  : Container(
                      alignment: Alignment.center,
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        "1",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
            ],
          ),
        ),
      );

  void getContactRequest(String token, String userId) async {
    CommonOperation.showProgressDialog(context, "loading", true);
    final contactRequestData =
        await networkCall.ContactRequestCall(token, userId);
    if (contactRequestData != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String message = 'SuccessContactList';

      contactRequestList = contactRequestData;
      //print('data_count1 ' + chatHolderData.first.toString());
      CommonOperation.hideProgressDialog(context);
      //showToastMessage(message);
      setState(() {
        // getContactRequest(token, userId);
      });
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoged', false);
      showToastMessage('your session is expire ');
    }
  }

  void searchUser(String token, String searchText) async {
    CommonOperation.showProgressDialog(context, "loading", true);
    final userSearchData = await networkCall.UserSearchCall(token, searchText);
    if (userSearchData != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String message = 'SuccessMessage done';

      searchedUserList = userSearchData;
      //print('data_count1 ' + chatHolderData.first.toString());
      CommonOperation.hideProgressDialog(context);
      //showToastMessage(message);
      setState(() {
        if (searchedUserList != null && searchedUserList.length > 0) {
          OpenUserDialog(searchedUserList);
        } else {
          message = 'No User matched !';
        }
        // getContactRequest(token, userId);
      });
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoged', false);
      showToastMessage('your session is expire ');
    }
  }

  void OpenUserDialog(List<dynamic> searchedUserList) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Searched User'),
            content: Container(
              // Change as per your requirement
              height: 250,
              width: MediaQuery.of(context).size.width / 3,
              child: Column(
                children: [
                  Container(
                    height: 220,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: searchedUserList.length,
                        itemBuilder: (context, index) {
                          final mSearchData = searchedUserList[index];

                          return buildSearchEvent(mSearchData);
                        }),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget buildSearchEvent(mSearchData) => GestureDetector(
      onTap: () {
        /// do click item task
        Navigator.pop(context, false);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OtherProfileBody(
                    'search', userid, mSearchData.id.toString())));
      },
      child: Container(
        margin: const EdgeInsets.only(left: 12.0, right: 12, top: 5, bottom: 8),
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black12)),
        child: Row(
          children: [
            FadeInImage.assetNetwork(
                placeholder: 'assets/images/chat_head.jpg',
                image: mSearchData.profileimageurl.toString(),
                height: 40,
                width: 40,
                fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 3,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Text(mSearchData.fullname.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: GoogleFonts.nanumGothic(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ));

  Future checkconnectivity() async {
    var connectivityResult = await connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      getSharedData();
    } else {
      openNetworkDialog();
      setState(() {});
    }
  }

  openNetworkDialog() {
    print(',,,,,,,,,,,,,,,,,,,,,');
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            insetPadding:
                const EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            title: Flexible(
                child: Align(
              alignment: Alignment.center,
              child: Text('Network Issue !',
                  style: GoogleFonts.nanumGothic(fontSize: 12)),
            )),
            content: Container(
              height: MediaQuery.of(context).size.height / 5,
              width: MediaQuery.of(context).size.width / 2,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                        'Please check your internet connectivity and try again.')
                  ],
                ),
              ),
            ),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  checkconnectivity();
                  setState(() {});
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    width: 150,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: SecondaryColor,
                    ),
                    child: Center(
                      child: Text(
                        "Try again",
                        style: GoogleFonts.nanumGothic(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
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
              child: Text(text!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nanumGothic(color: AccentColor)),
            ),
          ],
        ),
      ),
    );
  }
}
