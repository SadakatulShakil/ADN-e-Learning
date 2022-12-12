import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ApiCall/HttpNetworkCall.dart';
import '../../ApiModel/userCoursesList.dart';
import '../../Helper/colors_class.dart';
import '../../Helper/operations.dart';

class OtherProfileBody extends StatefulWidget {
  String from, currentUserId, requestId;
  OtherProfileBody(this.from, this.currentUserId, this.requestId);
  @override
  State<StatefulWidget> createState() => InitState();
// TODO: implement createState

}

class InitState extends State<OtherProfileBody> {
  NetworkCall networkCall = NetworkCall();
  List<dynamic> courseList = [];
  String token='';
  String name='';
  String imageUrl='https://3rdpartyservicesofflorida.com/wp-content/uploads/2015/03/blank-profile.jpg';
  String lastAccess = '';
  String city = '';
  String email = '';
  String count = '';
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
        backgroundColor: PrimaryColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Profile',
            style: GoogleFonts.nanumGothic(
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
            height: MediaQuery.of(context).size.height-MediaQuery.of(context).size.height/9,
            transform: Matrix4.translationValues(0, 10, 1),
            decoration: BoxDecoration(
                color: Color(0xFFFAFAFA),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)
                )
            ),
            child:  Column(
              children: [
                Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.bottomCenter,
                    children: [
                      SizedBox(height: 10,),
                      Image(
                        height: MediaQuery.of(context).size.height / 3,
                        fit: BoxFit.cover,
                        image: NetworkImage(imageUrl),
                      ),
                      Positioned(
                          bottom: -50.0,
                          child: CircleAvatar(
                            backgroundColor:
                            Get.isDarkMode ? Colors.black : Color(0xFFFCFAFA),
                            radius: 80,
                            backgroundImage:
                            NetworkImage(imageUrl),
                          ))
                    ]),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Visibility(
                      visible: widget.from == 'search'?false:true,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 50),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 5.0, right: 10, top: 8, bottom: 8),
                              child: Text('Reject',
                                  style: GoogleFonts.nanumGothic(
                                    color: const Color(0xFFFFFFFF),
                                    fontWeight: FontWeight.w900,
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: widget.from == 'search'?EdgeInsets.only(left: 150.0, top: 30):EdgeInsets.only(left: 50.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          decoration: BoxDecoration(
                            color: PrimaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 5.0, right: 10, top: 8, bottom: 8),
                            child: widget.from == 'search'?Text('Send request',
                                style: GoogleFonts.nanumGothic(
                                  color: const Color(0xFFFFFFFF),
                                  fontWeight: FontWeight.w900,
                                )): Text('Accept',
                                style: GoogleFonts.nanumGothic(
                                  color: const Color(0xFFFFFFFF),
                                  fontWeight: FontWeight.w900,
                                )),
                          ),
                        ),
                      ),
                    ),
                  ],),
                SizedBox(
                  height: 20,
                ),
                Text(name,
                    style: GoogleFonts.nanumGothic(
                        fontWeight: FontWeight.w900, fontSize: 18)),
                SizedBox(
                  height: 10,
                ),
                Text(email,
                    style: GoogleFonts.nanumGothic(
                        fontWeight: FontWeight.w900, fontSize: 12)),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18),
                  child: Divider(
                    thickness: 2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: (){
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => MyCourses(widget.userId.toString())));
                          },
                          child: Container(
                            width: 160,
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text('Courses I have',style: GoogleFonts.nanumGothic(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 15)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(count,style: GoogleFonts.nanumGothic(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 15)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 160,
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text('Last visited',style: GoogleFonts.nanumGothic(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 15)),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(lastAccess,style: GoogleFonts.nanumGothic(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 12)),
                                ],
                              ),
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
        ],
      ),
    );
  }

  void getSharedData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('TOKEN')!;
    setState(() {
      getProfileInfo(token, widget.requestId);
    });
  }

  void getProfileInfo(String token, String userId) async{
    CommonOperation.showProgressDialog(
        context, "loading", true);
    final userProfilesData = await networkCall.UserProfileCall(token, userId);
    if(userProfilesData != null){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String message = 'Success';
      //print('hospital data'+ userProfilesData.firstname.toString());
      CommonOperation.hideProgressDialog(context);
      //showToastMessage(message);
      setState(() {
        name = userProfilesData.fullname.toString();
        imageUrl = userProfilesData.profileimageurl.toString();
        String lastAccessRaw = getDateStump(userProfilesData.lastaccess.toString());
        DateTime raw = DateTime.parse(lastAccessRaw);
        lastAccess = DateFormat.yMMMEd().format(raw);
        city = userProfilesData.city.toString();
        email = userProfilesData.email.toString();
        getUserCourses(token, userId);
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

  String getDateStump(String sTime) {
    int timeNumber = int.parse(sTime);
    return DateTime.fromMillisecondsSinceEpoch(timeNumber * 1000).toString();
  }

  void getUserCourses(String token, String id) async{
    CommonOperation.showProgressDialog(
        context, "loading", true);
    final userCoursesData = await networkCall.UserCoursesListCall(token, id);
    if(userCoursesData != null){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String message = 'Success';
      courseList = userCoursesData;
      count = courseList.length.toString();
      print('data_count '+ courseList.toString());
      CommonOperation.hideProgressDialog(context);
      //showToastMessage(message);
      setState(() {
      });

    }else{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoged', false);
      showToastMessage('your session is expire ');
    }
  }


}
