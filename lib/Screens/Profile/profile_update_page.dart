import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:radda_moodle_learning/Screens/Profile/TabBarComponents/about_page.dart';
import 'package:radda_moodle_learning/Screens/Profile/TabBarComponents/settings_page.dart';

import '../../Helper/colors_class.dart';

class ProfileUpdatePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<ProfileUpdatePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return initWidget(context);
  }

  Widget initWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PrimaryColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Profile update',
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
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).size.height / 9,
            transform: Matrix4.translationValues(0, 10, 1),
            decoration: BoxDecoration(
                color: Color(0xFFFAFAFA),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 120.0,
                    backgroundColor: Color(0xFFFAFAFA),
                    child: CircleAvatar(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: CircleAvatar(
                            radius: 35.0,
                            child: SvgPicture.asset(
                                "assets/vectors/edit_icon.svg")),
                      ),
                      radius: 120.0,
                      backgroundImage:
                      AssetImage("assets/icons/profile_demo.jpg"),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                InkWell(
                  onTap: (){
                    //callLoginApi(userNameController.text, passwordController.text);
                    //agree?Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen())): showToastMessage('please accept our terms & condition');
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      width:350,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: PrimaryColor
                      ),
                      child: Center(
                        child: Text("Save changes", style: GoogleFonts.nanumGothic(color: Colors.white, fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12,),
                InkWell(
                  onTap: (){
                    //callLoginApi(userNameController.text, passwordController.text);
                    //agree?Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen())): showToastMessage('please accept our terms & condition');
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      width:350,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color(0xFFFFFFFF)
                      ),
                      child: Center(
                        child: Text("Cancel", style: GoogleFonts.nanumGothic(color: Colors.black, fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
