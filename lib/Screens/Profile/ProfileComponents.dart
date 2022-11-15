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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {

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
        backgroundColor: const Color(0xFF0E0E95),
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
                          backgroundImage: AssetImage("assets/icons/profile_demo.jpg"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:10, top: 50.0),
                      child: Column(
                        children: [
                          Text("Jhon Smith", style: GoogleFonts.comfortaa(
                              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white
                          ),),
                          Row(
                            children: [
                              Icon(Icons.location_on_outlined, color: Colors.white, size: 13,),
                              Text("Dhaka, Bangladesh", style: GoogleFonts.comfortaa(
                                  fontSize: 10, color: Colors.white
                              ),),
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
}
