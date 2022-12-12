import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:radda_moodle_learning/ApiModel/notificationResponse.dart';
import 'package:radda_moodle_learning/Screens/NotoficationComponents/previousNotificationPage.dart';
import 'package:radda_moodle_learning/Screens/NotoficationComponents/recentNotificationPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../ApiCall/HttpNetworkCall.dart';
import '../../Helper/colors_class.dart';
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
  Connectivity connectivity = Connectivity();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkconnectivity();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return inItWidget();
  }

  Widget inItWidget() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PrimaryColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Notifications',
            style: GoogleFonts.nanumGothic(
                color: const Color(0xFFFFFFFF),
                fontWeight: FontWeight.w700,
                fontSize: 18)),
        centerTitle: false,
      ),
      backgroundColor: PrimaryColor,
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
                  height: 50,
                  child:  TabBar(
                    labelColor: Colors.black,
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
                      RefreshIndicator( onRefresh: checkconnectivity,child: RecentNotificationPage(unReadNotiList)),
                      RefreshIndicator( onRefresh: checkconnectivity,child: PreviousNotificationPage(readNotiList)),
                    ],
                  )
              )
            ],
          ),
        ),
      ),
    );
  }

  Future getSharedData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('TOKEN')!;
    userId = prefs.getString('userId')!;
    setState(() {
      getURNotification(token, userId);
    });
  }

  Future getURNotification(String token, String userId) async{
    CommonOperation.showProgressDialog(
        context, "loading", true);
    final uRNotificationData = await networkCall.UserUnReadNotificationCall(token, userId);
    if(uRNotificationData != null){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String message = 'Success';

      CommonOperation.hideProgressDialog(context);
      //showToastMessage(message);
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
      //showToastMessage(message);
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

  Future checkconnectivity() async{
    var connectivityResult = await connectivity.checkConnectivity();
    if(connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi){
      getSharedData();
    }else{
      openNetworkDialog();
      setState(() {

      });
    }
  }
  openNetworkDialog() {
    print(',,,,,,,,,,,,,,,,,,,,,');
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            insetPadding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            title:Flexible(child: Align(
              alignment: Alignment.center,
              child: Text('Network Issue !',style: GoogleFonts.nanumGothic(
                  fontSize: 12
              )),
            )),

            content: Container(
              height: MediaQuery.of(context).size.height/5,
              width: MediaQuery.of(context).size.width/2,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text('Please check your internet connectivity and try again.')
                  ],
                ),
              ),
            ),
            actions: [
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                  checkconnectivity();
                  setState(() {

                  });
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    width:150,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: SecondaryColor,
                    ),
                    child: Center(
                      child: Text("Try again", style: GoogleFonts.nanumGothic(color: Colors.white, fontWeight: FontWeight.bold),),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}