import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:radda_moodle_learning/Screens/DashBoard/TabBarComponents/activity_list.dart';
import 'package:radda_moodle_learning/Screens/DashBoard/TabBarComponents/caleder_list.dart';
import 'package:radda_moodle_learning/Screens/DashBoard/TabBarComponents/courses_list.dart';
import 'package:radda_moodle_learning/Screens/DashBoard/TabBarComponents/grades_list.dart';

class HomeComponents extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<HomeComponents> {
  @override
  Widget build(BuildContext context) {
    return initWidget(context);
  }

  Widget initWidget(BuildContext context) {
    return DefaultTabController(
      length: 4,
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
              height: 100,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/icons/profile_demo.jpg"),
                      radius: 50,
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8,top: 35.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text("Jhon Smith", style: GoogleFonts.comfortaa(
                              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white
                          ),),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined, color: Colors.white, size: 13,),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text("Dhaka, Bangladesh", style: GoogleFonts.comfortaa(
                                fontSize: 10, color: Colors.white
                            ),),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              )
            ),

            // the tab bar with two items
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              height: 50,
              child: TabBar(

                isScrollable: true,
                // labelPadding: EdgeInsets.symmetric(horizontal: 0),
                labelColor: Colors.black,
                tabs: [
                  // Tab(text: 'All Products'),
                  Tab(text: 'Courses'),
                  Tab(text: 'Grades'),
                  Tab(text: 'Badges'),
                  Tab(text: 'Calender')
                ],
              ),
            ),

            // create widgets for each tab bar here
            Expanded(
              child: TabBarView(
                children: [
                  DashBoardCoursesList(),
                  DashBoardGradesList(),
                  DashBoardActivityList(),
                  DashBoardCalederList()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
