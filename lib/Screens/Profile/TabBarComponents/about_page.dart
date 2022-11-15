import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../ApiCall/HttpNetworkCall.dart';
import '../../../Helper/operations.dart';

class ProfileAboutPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => InitState();
}
class InitState extends State<ProfileAboutPage> {
  NetworkCall networkCall = NetworkCall();
  List<dynamic> profileInfoList = [];
  List<dynamic> courseList = [];
  String name ='';
  String firstName ='';
  String surName ='';
  String email ='';
  String language ='';
  String city ='';
  String startDate ='';
  String lastDate ='';
  String count ='';
  bool generalVisibility = false;
  bool changePasswordVisibility = false;
  // bool _passwordVisible =false;

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
        backgroundColor: Color(0xFFF1F1FA),
        body: SingleChildScrollView(
          child:
          Column(
            children: [
              InkWell(
                onTap: (){
                  print('---------------- '+ 'clicked');
                  changePasswordVisibility = false;
                  generalVisibility?generalVisibility = false:generalVisibility = true;
                  setState(() {

                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, top: 18, bottom: 12),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text("Profile",
                              style: GoogleFonts.comfortaa(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0, top: 5),
                        child: SvgPicture.asset("assets/vectors/arrow_down.svg"),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: generalVisibility? true:false,
                child: Column(
                  children: [
                    SizedBox(height: 18,),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12, bottom: 5),
                        child: Text("First name",
                            style: GoogleFonts.comfortaa(
                                color: Colors.black45,
                                fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    SizedBox(height: 8,),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12, bottom: 5),
                        child: Text(firstName,
                            style: GoogleFonts.comfortaa(
                                color: Colors.black,
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12),
                      child: Divider(thickness: 1,),
                    ),
                    SizedBox(height: 15,),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12, bottom: 5),
                        child: Text("Second name",
                            style: GoogleFonts.comfortaa(
                                color: Colors.black45,
                                fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    SizedBox(height: 8,),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12, bottom: 5),
                        child: Text(surName,
                            style: GoogleFonts.comfortaa(
                                color: Colors.black,
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12),
                      child: Divider(thickness: 1,),
                    ),
                    SizedBox(height: 15,),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12, bottom: 5),
                        child: Text("Email",
                            style: GoogleFonts.comfortaa(
                                color: Colors.black45,
                                fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    SizedBox(height: 8,),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12, bottom: 5),
                        child: Text(email,
                            style: GoogleFonts.comfortaa(
                                color: Colors.black,
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12),
                      child: Divider(thickness: 1,),
                    ),
                    SizedBox(height: 15,),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: Text("Preferred language",
                            style: GoogleFonts.comfortaa(
                                color: Colors.black45,
                                fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    SizedBox(height: 8,),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12, bottom: 5),
                        child: Text(language == 'en'? 'English':'Bangla',
                            style: GoogleFonts.comfortaa(
                                color: Colors.black,
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12),
                      child: Divider(thickness: 1,),
                    ),
                    SizedBox(height: 15,),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: Text("City/town",
                            style: GoogleFonts.comfortaa(
                                color: Colors.black45,
                                fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    SizedBox(height: 8,),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12, bottom: 5),
                        child: Text(city,
                            style: GoogleFonts.comfortaa(
                                color: Colors.black,
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12),
                      child: Divider(thickness: 1,),
                    ),
                    SizedBox(height: 15,),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: Text("Country",
                            style: GoogleFonts.comfortaa(
                                color: Colors.black45,
                                fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    SizedBox(height: 8,),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12, bottom: 5),
                        child: Text('Bangladesh',
                            style: GoogleFonts.comfortaa(
                                color: Colors.black,
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12),
                      child: Divider(thickness: 1,),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: generalVisibility? false:true,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12),
                  child: Divider(thickness: 1,),
                ),
              ),
              InkWell(
                onTap: (){
                  print('---------------- '+ 'clicked');
                  changePasswordVisibility?changePasswordVisibility = false: changePasswordVisibility = true;
                  generalVisibility = false;
                  setState(() {

                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, top: 10, bottom: 12),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("Recent Activity",
                            style: GoogleFonts.comfortaa(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: SvgPicture.asset("assets/vectors/arrow_down.svg"),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: changePasswordVisibility?true:false,
                child: Column(
                  children: [
                    SizedBox(height: 15,),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 5),
                        child: Text("First access to site",
                            style: GoogleFonts.comfortaa(color: Colors.black45,
                                fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                    ),

                    SizedBox(height: 8,),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 5),
                        child: Text(startDate,
                            style: GoogleFonts.comfortaa(
                                color: Colors.black,
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, right: 30),
                      child: Divider(thickness: 1,),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 5),
                        child: Text("Last access to site",
                            style: GoogleFonts.comfortaa(
                                color: Colors.black45,
                                fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                    ),

                    SizedBox(height: 8,),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 5),
                        child: Text(lastDate,
                            style: GoogleFonts.comfortaa(
                                color: Colors.black,
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, right: 30),
                      child: Divider(thickness: 1,),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 5),
                            child: Text("Courses I have taken",
                                style: GoogleFonts.comfortaa(
                                    color: Colors.black45,
                                    fontSize: 12, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 5),
                            child: Text("View",
                                style: GoogleFonts.comfortaa(
                                    color: Colors.blueAccent,
                                    fontSize: 12, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 50, right: 30, bottom: 5),
                        child: Text(count,
                            style: GoogleFonts.comfortaa(
                                color: Colors.blueAccent,
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, right: 30),
                      child: Divider(thickness: 1,),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: changePasswordVisibility?false:true,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12),
                  child: Divider(thickness: 1,),
                ),
              ),
            ],
          ),
    )

    );
  }

  void getSharedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('TOKEN')!;
    String userid = prefs.getString('userId')!;
    setState(() {
      getSiteInfo(token, userid);
    });
  }
  void getSiteInfo(String token, String userid) async{

    //CommonOperation.showProgressDialog(context, "loading", true);
    final userDetailsData = await networkCall.UserDetailsCall(token);
    if(userDetailsData != null){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String message = 'Success';
      print('hospital data'+ userDetailsData.firstname.toString());
      surName = userDetailsData.lastname.toString();
      firstName = userDetailsData.firstname.toString();
      setState(() {
        getProfileInfo(token, userid);
      });

    }else{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoged', false);
      showToastMessage('your session is expire ');
    }

  }


  void getProfileInfo(String token, String userId) async {
    //CommonOperation.showProgressDialog(context, "loading", true);
    final profileInfoData =
    await networkCall.ProfileInfoCall(token, userId);
    if (profileInfoData != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String message = 'Success';
      profileInfoList = profileInfoData;
      name = profileInfoList[0].fullname.toString();
      //userName = profileInfoList[0].username.toString();
      email = profileInfoList[0].email.toString();
      language = profileInfoList[0].lang.toString();
      city = profileInfoList[0].city.toString();
      startDate = DateFormat.yMMMEd().format(DateTime.parse(
          getDateStump(profileInfoList[0]
              .firstaccess
              .toString())));
      lastDate = DateFormat.yMMMEd().format(DateTime.parse(
          getDateStump(profileInfoList[0]
              .lastaccess
              .toString())));
      print('data_count1 ' + profileInfoList.first.toString());
      //CommonOperation.hideProgressDialog(context);
      showToastMessage(message);
      setState(() {
        getAllCourses(token, userId);
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
  void getAllCourses(String token, String userId) async {
    //CommonOperation.showProgressDialog(context, "loading", true);
    final userCoursesData =
    await networkCall.UserCoursesListCall(token, userId);
    if (userCoursesData != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String message = 'Success2';
      courseList = userCoursesData;
      count = courseList.length.toString();
      print('data_count1 ' + courseList[0].fullname.toString());
      showToastMessage(message);
      //CommonOperation.hideProgressDialog(context);
      setState(() {});
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoged', false);
      showToastMessage('your session is expire ');
    }
  }

  String getDateStump(String sTime) {
    int timeNumber = int.parse(sTime);
    return DateTime.fromMillisecondsSinceEpoch(timeNumber * 1000).toString();
  }
}
