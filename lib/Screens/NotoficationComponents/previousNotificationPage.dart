import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:radda_moodle_learning/ApiModel/notificationResponse.dart';

class PreviousNotificationPage extends StatefulWidget{
  List<Messages> readNotiList;
  PreviousNotificationPage(this.readNotiList);


  @override
  State<StatefulWidget> createState() => InitState();
// TODO: implement createState

}

class InitState extends State<PreviousNotificationPage> {

  String lassAccess ='';
  @override
  void initState() {
    // TODO: implement initState
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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Visibility(
            visible: widget.readNotiList.length>0?true:false,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, top: 10),
                  child: Text('Total '+widget.readNotiList.length.toString(),style: GoogleFonts.comfortaa(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0, top: 10),
                  child: Text(widget.readNotiList.length.toString() == '1'? ' Notification': ' Notifications',style: GoogleFonts.comfortaa(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          Divider(),
          SizedBox(
            height: 8,
          ),
          widget.readNotiList.length>0?
          Expanded(
            child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: ListView.builder(
                    itemCount: widget.readNotiList.length,
                    itemBuilder: (context, index) {
                      final mNotificationData = widget.readNotiList[index];

                      return buildNotification(mNotificationData);
                    })),
          ): Center(
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
      //Navigator.push(context, MaterialPageRoute(builder: (context) => CoursesDetailsPage(mCourseData)));
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
                              style: GoogleFonts.comfortaa(
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
                              style: GoogleFonts.comfortaa(
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
}