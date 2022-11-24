import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:radda_moodle_learning/Screens/Profile/TabBarComponents/about_page.dart';
import 'package:radda_moodle_learning/Screens/Profile/TabBarComponents/activity_page.dart';
import 'package:radda_moodle_learning/Screens/Profile/TabBarComponents/settings_page.dart';
import 'package:radda_moodle_learning/Screens/Profile/profile_update_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ApiCall/HttpNetworkCall.dart';

class ProfileComponents extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<ProfileComponents> {
  NetworkCall networkCall = NetworkCall();
  List<dynamic> profileInfoList = [];
  String imageurl ='';
  String name ='';
  String firstName ='';
  String surName ='';
  String email ='';

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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFF01974D),
        body: Column(
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
                height: 140,
                child: Row(
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: CircleAvatar(
                    //     backgroundColor: Colors.white,
                    //     radius: 51,
                    //     child: CircleAvatar(
                    //       backgroundImage: AssetImage("assets/icons/profile_demo.jpg"),
                    //       radius: 50,
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 51.0,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileUpdatePage()));
                            },
                            child: Align(
                              alignment: Alignment.topRight,
                              child: CircleAvatar(
                                radius: 15.0,
                                child: SvgPicture.asset("assets/vectors/edit_icon.svg")
                              ),
                            ),
                          ),
                          radius: 50.0,
                          backgroundImage: NetworkImage(imageurl.toString()),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(name.toString(), style: GoogleFonts.comfortaa(
                              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white
                          ),),
                          Row(
                            children: [
                              Icon(Icons.email_outlined, size: 12, color: Colors.white,),
                              Padding(
                                padding: const EdgeInsets.only(left: 5.0, bottom: 2),
                                child: Text(email, style: GoogleFonts.comfortaa(
                                    fontSize: 12, color: Colors.white
                                ),),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )
            ),

            // the tab bar with two items
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              height: 50,
              child: TabBar(

                isScrollable: false,
                // labelPadding: EdgeInsets.symmetric(horizontal: 0),
                labelColor: Colors.black,
                tabs: [
                  // Tab(text: 'All Products'),
                  Tab(text: 'About'),
                  Tab(text: 'Settings')
                ],
              ),
            ),

            // create widgets for each tab bar here
            Expanded(
              child: TabBarView(
                children: [
                  ProfileAboutPage(),
                  ProfileSettingsPage()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getSharedData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name')!;
    imageurl = prefs.getString('imageUrl')!;
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
      email = profileInfoList[0].email.toString();
      //userName = profileInfoList[0].username.toString();
      print('data_count1 ' + profileInfoList.first.toString());
      //CommonOperation.hideProgressDialog(context);
      //showToastMessage(message);
      setState(() {
        //getAllCourses(token, userId);
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
}
