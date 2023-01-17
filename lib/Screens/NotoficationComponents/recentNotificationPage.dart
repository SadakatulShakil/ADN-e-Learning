import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:radda_moodle_learning/ApiModel/notificationResponse.dart';
import 'package:radda_moodle_learning/Screens/NotoficationComponents/notificationDetailsPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ApiCall/HttpNetworkCall.dart';
import '../../Helper/operations.dart';
class RecentNotificationPage extends StatefulWidget{
  List<Messages> unReadNotiList;
  RecentNotificationPage(this.unReadNotiList);


  @override
  State<StatefulWidget> createState() => InitState();
// TODO: implement createState

}

class InitState extends State<RecentNotificationPage> {

  String lassAccess ='';
  String token ='';
  String userId ='';
  NetworkCall networkCall = NetworkCall();
  @override
  void initState() {
    // TODO: implement initState
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
      body: Column(
        children: [
          Visibility(
            visible: widget.unReadNotiList.length>0?true:false,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, top: 10),
                  child: Text('Total '+widget.unReadNotiList.length.toString(),style: GoogleFonts.nanumGothic(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0, top: 10),
                  child: Text(widget.unReadNotiList.length.toString()=='1'?' Notification':' Notifications',style: GoogleFonts.nanumGothic(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          Divider(),
          SizedBox(
            height: 8,
          ),
          widget.unReadNotiList.length>0?
          Expanded(
            child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: ListView.builder(
                    itemCount: widget.unReadNotiList.length,
                    itemBuilder: (context, index) {
                      final mNotificationData = widget.unReadNotiList[index];

                      return buildNotification(mNotificationData);
                    })),
          ):
          Center(
            child: SizedBox(
              height: 100,
              child: Column(
                children: [
                  Icon(Icons.warning_amber, size: 30,),
                  Text('No Notification Found!'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNotification(mNotificationData) => GestureDetector(
    onTap: () {
      /// do click item task
      CallNotificationView(mNotificationData.id.toString(), mNotificationData);
    },
    child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    //crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              mNotificationData.subject.toString(),
                              style: GoogleFonts.nanumGothic(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              DateFormat.yMMMEd().format(DateTime.parse(DateTime.fromMillisecondsSinceEpoch(mNotificationData.timecreated * 1000).toString())),
                              style: GoogleFonts.nanumGothic(
                                fontSize: 14,
                              ),),

                          ),
                        ),
                      ]),
                ),
              ),
            )
          ],
        )),
  );

  void getSharedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('TOKEN')!;
    userId = prefs.getString('userId')!;
  }


  void CallNotificationView(String notificationId, mNotificationData) async{
    CommonOperation.showProgressDialog(context, "loading", true);
    final quizSubmitData =
    await networkCall.ViewNotificationCall(token, notificationId);
    if (quizSubmitData != null) {
      CommonOperation.hideProgressDialog(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationDetailsPage(mNotificationData)));

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
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0 //message font size
    );
  }
}