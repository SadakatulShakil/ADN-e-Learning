import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:radda_moodle_learning/ApiModel/notificationResponse.dart';
import 'package:radda_moodle_learning/Screens/NotoficationComponents/previousNotificationPage.dart';
import 'package:radda_moodle_learning/Screens/NotoficationComponents/recentNotificationPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../ApiCall/HttpNetworkCall.dart';
import '../../Helper/operations.dart';

class NotificationPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => InitState();
// TODO: implement createState

}

class InitState extends State<NotificationPage> {
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
    // TODO: implement initState
    super.initState();
    getSharedData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return inItWidget();
  }

  Widget inItWidget() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF01974D),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Notifications',
            style: GoogleFonts.comfortaa(
                color: const Color(0xFFFFFFFF),
                fontWeight: FontWeight.w700,
                fontSize: 18)),
        centerTitle: false,
      ),
      backgroundColor: const Color(0xFF01974D),
      body: DefaultTabController(
        length: 2,
        child: Container(
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
          child: Column(
            children: [
              SizedBox(height: 5.0,),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(25.0)
                  ),
                  child:  TabBar(
                    indicator: BoxDecoration(
                        color: const Color(0xFF00A6FF),
                        borderRadius:  BorderRadius.circular(25.0)
                    ) ,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    tabs: const  [
                      Tab(text: 'Recent '),
                      Tab(text: 'Previous ',)
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: TabBarView(
                    children:  [
                      RecentNotificationPage(unReadNotiList),
                      PreviousNotificationPage(readNotiList),
                    ],
                  )
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
    setState(() {
      getURNotification(token, userId);
    });
  }

  void getURNotification(String token, String userId) async{
    CommonOperation.showProgressDialog(
        context, "loading", true);
    final uRNotificationData = await networkCall.UserUnReadNotificationCall(token, userId);
    if(uRNotificationData != null){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String message = 'Success';

      CommonOperation.hideProgressDialog(context);
      showToastMessage(message);
      unReadNotiList = uRNotificationData.messages!;
      allNotification.addAll(unReadNotiList);
      setState(() {

        getRNotification(token, userId);
      });

    }else{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoged', false);
      showToastMessage('your session is expire ');
    }
  }

  void getRNotification(String token, String userId) async{
    CommonOperation.showProgressDialog(
        context, "loading", true);
    final rNotificationData = await networkCall.UserReadNotificationCall(token, userId);
    if(rNotificationData != null){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String message = 'Success';

      CommonOperation.hideProgressDialog(context);
      showToastMessage(message);
      readNotiList = rNotificationData.messages!;
      setState(() {
        allNotification.addAll(readNotiList);
      });

    }else{
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