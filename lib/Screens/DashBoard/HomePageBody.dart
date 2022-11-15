import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'HomeComponents.dart';
import '../Message&Notification/MessageComponents.dart';
import '../Profile/ProfileComponents.dart';

class DashBoard extends StatefulWidget {

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int _currentIndex = 1;
  final screens = [ProfileComponents(), HomeComponents(), MessageComponents()];

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  void _changeTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: Container(
        child: ConvexAppBar(
          backgroundColor: Color(0xFF0E0E95),
          style: TabStyle.react,
          items: [
            TabItem(icon: SvgPicture.asset("assets/vectors/bottom_profile.svg"), title: 'Profile', isIconBlend: true),
            TabItem(icon: SvgPicture.asset("assets/vectors/bottom_home.svg"), title: 'Home', isIconBlend: true),
            TabItem(icon: SvgPicture.asset("assets/vectors/bottom_message.svg"), title: 'Message', isIconBlend: true),
          ],
          initialActiveIndex: 1,
          onTap: (int i) => _changeTab(i),
        ),
      ),
    );
  }
}
