import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:radda_moodle_learning/Helper/CustomScaffold.dart';
import 'package:radda_moodle_learning/Screens/site_home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ApiCall/HttpNetworkCall.dart';
import '../language/Languages .dart';
import '../language/LocalConstant.dart';
import 'DashBoard/HomePageBody.dart';

enum PopUpNavMenu { SwitchToBangla, RateThisApp }

class HomeScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<HomeScreen> {

  double value = 0;
  NetworkCall networkCall = NetworkCall();


  @override
  void initState() {
    super.initState();
    //getSharedData();
    //getRecentCourseData();
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
                  color: Color(0xFF0E0E95),
                  height: 4.0,
                ),
                preferredSize: Size.fromHeight(4.0)),
            elevation: 0,
            backgroundColor: Color(0xFF0E0E95),
            title: Text('Radda e-Learning',
                style: GoogleFonts.comfortaa(
                    color: const Color(0xFFFFFFFF),
                    fontWeight: FontWeight.w700,
                    fontSize: 18)),
            centerTitle: false,
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: Image.asset("assets/icons/notification_icon.png",
            height: 100, width: 100),
              onPressed: () => {},
            )
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
            style: GoogleFonts.comfortaa(color: Colors.black),
          ),
        ]));
  }


  // void getUserDetails(String token) async{
  //
  //   CommonOperation.showProgressDialog(
  //       context, "loading", true);
  //   final userDetailsData = await networkCall.UserDetailsCall(token);
  //   if(userDetailsData != null){
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     String message = 'Success';
  //     OnDateClick();
  //     print('hospital data'+ userDetailsData.firstname.toString());
  //     CommonOperation.hideProgressDialog(context);
  //     showToastMessage(message);
  //     setState(() {
  //       getURNotification(token, userDetailsData.userid.toString());
  //       name = userDetailsData.fullname.toString();
  //       imageUrl = userDetailsData.userpictureurl.toString();
  //       userId = userDetailsData.userid.toString();
  //     });
  //
  //   }else{
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     await prefs.setBool('isLoged', false);
  //     showToastMessage('your session is expire ');
  //   }
  //
  // }
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

  // void getURNotification(String token, String userId) async{
  //   CommonOperation.showProgressDialog(
  //       context, "loading", true);
  //   final uRNotificationData = await networkCall.UserUnReadNotificationCall(token, userId);
  //   if(uRNotificationData != null){
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     String message = 'Success';
  //
  //     CommonOperation.hideProgressDialog(context);
  //     showToastMessage(message);
  //     unReadNotiList = uRNotificationData.messages!;
  //     setState(() {
  //
  //     });
  //
  //   }else{
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     await prefs.setBool('isLoged', false);
  //     showToastMessage('your session is expire ');
  //   }
  // }

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
                  child: Image.asset("assets/images/banner.png",
                      fit: BoxFit.cover),
                ),
              ),
              Divider(),
              ListTile(
                dense: true,
                onTap: () {
                  setState(() {
                    Navigator.of(context).pop();
                  });
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SiteHomePage()));
                },
                leading: const Icon(
                  Icons.menu_book,
                ),
                title: Text(
                  "Site Home",
                  style: GoogleFonts.comfortaa(fontSize: 15),
                ),
              ),
              ListTile(
                onTap: () {
                  setState(() {
                    value = 0;
                  });
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationPage(userId.toString())));
                },
                leading: const Icon(
                  Icons.notifications_active,
                ),
                title: Text(
                  "Notification (5)",
                  style: GoogleFonts.comfortaa(fontSize: 13),
                ),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(
                  Icons.settings,
                ),
                title: Text(
                  "Settings",
                  style: GoogleFonts.comfortaa(fontSize: 15),
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
                  style: GoogleFonts.comfortaa(),
                ),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(
                  Icons.star,
                ),
                title: Text(
                  Languages.of(context)!.RateApp,
                  style: GoogleFonts.comfortaa(),
                ),
              ),
              Divider(
                height: 50,
              ),
              ListTile(
                leading: Icon(Icons.info_outline),
                title: Text('Privacy And Policy',
                  style: GoogleFonts.comfortaa(),),

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
                  // Navigator.pushReplacement(context, MaterialPageRoute(
                  //     builder: (context) => LoginScreen()
                  // ));
                },
                leading: const Icon(
                  Icons.logout,
                ),
                title: Text(
                  "Logout",
                  style: GoogleFonts.comfortaa(fontSize: 15),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}
