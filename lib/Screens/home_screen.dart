import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/badge/gf_badge.dart';
import 'package:getwidget/components/badge/gf_button_badge.dart';
import 'package:getwidget/components/badge/gf_icon_badge.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:radda_moodle_learning/ApiModel/notificationResponse.dart';
import 'package:radda_moodle_learning/Helper/CustomScaffold.dart';
import 'package:radda_moodle_learning/Helper/colors_class.dart';
import 'package:radda_moodle_learning/Screens/site_home_page.dart';
import 'package:radda_moodle_learning/Screens/video_content_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ApiCall/HttpNetworkCall.dart';
import '../Helper/operations.dart';
import '../language/Languages .dart';
import '../language/LocalConstant.dart';
import 'DashBoard/HomePageBody.dart';
import 'NotoficationComponents/notificationPage.dart';
import 'login_screen.dart';

enum PopUpNavMenu { SwitchToBangla, RateThisApp }

class HomeScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<HomeScreen> {

  double value = 0;
  NetworkCall networkCall = NetworkCall();
  String token='';
  String name='';
  String imageUrl='';
  String userId = '';
  List<Messages> unReadNotiList = [];
  List<Messages> readNotiList = [];
  List<Messages> allNotification = [];

  @override
  void initState() {
    super.initState();
    getSharedData();
  }

  @override
  Widget build(BuildContext context) {
    return initWidget(context);
  }

  Widget initWidget(BuildContext context) {
    return MyCustomScaffold(
        endDrawer: populateDrawer(),
        body: DashBoard(),
        // Disable opening the end drawer with a swipe gesture.
        appBar: AppBar(
          bottom: PreferredSize(
              child: Container(
                color: PrimaryColor,
                height: 4.0,
              ),
              preferredSize: Size.fromHeight(4.0)),
          elevation: 0,
          backgroundColor: PrimaryColor,
          title: Text('Diginet Skillup',
              style: GoogleFonts.nanumGothic(
                  color: const Color(0xFFFFFFFF),
                  fontWeight: FontWeight.w700,
                  fontSize: 18)),
          centerTitle: false,
          automaticallyImplyLeading: false,
          actions: <Widget>[
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationPage()));
              },
              child: Container(
                child: GFIconBadge(
                  counterChild: Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Text(allNotification.length.toString(), style: TextStyle(color: Colors.red, fontWeight: FontWeight.w900),),
                  ),
                  child:  Icon(Icons.notifications_active),

                ),
              ),
            ),
          ],
        )
    );
  }

  void choiceAction(context, choice) async {
    if (PopUpNavMenu.SwitchToBangla == choice) {
      print('SwitchToBangla');

      if (Languages.of(context)!.switchLanguage == "English") {
        changeLanguage(context, 'en');
      } else {
        changeLanguage(context, 'bn');
      }
    } else if (PopUpNavMenu.RateThisApp == choice) {
      ///Do logic for NoticeBoard page
    }
  }

  Widget menuItem(String text, String assetName) {
    // TODO: Change the shape
    return Container(
        width: 500,
        child: Row(children: [
          SvgPicture.asset(
            'vectors/$assetName',
            height: 20,
            width: 20,
          ),
          SizedBox(
            width: 24.08,
          ),
          Text(
            text,
            style: GoogleFonts.nanumGothic(color: Colors.black),
          ),
        ]));
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

  Future getURNotification(String token, String userId) async{
    CommonOperation.showProgressDialog(
        context, "loading", true);
    final uRNotificationData = await networkCall.UserUnReadNotificationCall(token, userId);
    if(uRNotificationData != null){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      CommonOperation.hideProgressDialog(context);
      unReadNotiList = uRNotificationData.messages!;
      allNotification.addAll(unReadNotiList);

    }else{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoged', false);
      showToastMessage('your session is expire ');
    }
  }

  Future getRNotification(String token, String userId) async{
    CommonOperation.showProgressDialog(
        context, "loading", true);
    final rNotificationData = await networkCall.UserReadNotificationCall(token, userId);
    if(rNotificationData != null){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      CommonOperation.hideProgressDialog(context);

      readNotiList = rNotificationData.messages!;
      allNotification.addAll(readNotiList);

      setState(() {});
    }else{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoged', false);
      showToastMessage('your session is expire ');
    }
  }

  void OnDateClick() {
    int timeNumber = 1658033030;
    final DateTime date1 =
    DateTime.fromMillisecondsSinceEpoch(timeNumber * 1000);
    print('new ' + date1.toString());
  }

  populateDrawer() {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Color(0xFFFFFFFF)),
      child: Container(
        transform: Matrix4.translationValues(0, 87, 1),
        child: Drawer(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20)),
          ),
          child: Column(
            children: <Widget>[
              DrawerHeader(
                child: Center(
                  child: Image.asset("assets/images/login_banner.png",width: 200,
                      fit: BoxFit.fill),
                ),
              ),
              Divider(),
              ListTile(
                dense: true,
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SiteHomePage()));
                },
                leading: const Icon(
                  Icons.menu_book,
                ),
                title: Text(
                  "Home",
                  style: GoogleFonts.nanumGothic(fontSize: 15),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationPage()));
                },
                leading: const Icon(
                  Icons.notifications_active,
                ),
                title: Text(
                  "Notification ("+allNotification.length.toString()+")",
                  style: GoogleFonts.nanumGothic(fontSize: 13),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyVideoPlayerPage()));
                },
                leading: const Icon(
                  Icons.settings,
                ),
                title: Text(
                  "Settings",
                  style: GoogleFonts.nanumGothic(fontSize: 15),
                ),
              ),
              ListTile(
                onTap: () {
                  if (Languages.of(context)!.switchLanguage == "English") {
                    changeLanguage(context, 'en');
                  } else {
                    changeLanguage(context, 'bn');
                  }
                },
                leading: const Icon(
                  Icons.language,
                ),
                title: Text(
                  Languages.of(context)!.switchLanguage,
                  style: GoogleFonts.nanumGothic(),
                ),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(
                  Icons.star,
                ),
                title: Text(
                  Languages.of(context)!.RateApp,
                  style: GoogleFonts.nanumGothic(),
                ),
              ),
              Divider(
                height: 50,
              ),
              ListTile(
                leading: Icon(Icons.info_outline),
                title: Text('Privacy And Policy',
                  style: GoogleFonts.nanumGothic(),),

                onTap: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => PrivacyPolicy(),
                  //   ),
                  //);
                },
              ),
              ListTile(
                onTap: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.setString('TOKEN', '');
                  await prefs.setString('isLoged', 'false');
                  Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) => LoginScreen()
                  ));
                },
                leading: const Icon(
                  Icons.logout,
                ),
                title: Text(
                  "Logout",
                  style: GoogleFonts.nanumGothic(fontSize: 15),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void getSharedData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('TOKEN')!;
    userId = prefs.getString('userId')!;
    getURNotification(token, userId);
    getRNotification(token, userId);
  }

}
