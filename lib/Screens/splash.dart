import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';
import 'login_screen.dart';

class Splash extends StatefulWidget{
  late String isLog = 'false';
  @override
  _SplashState createState() => _SplashState();

}

class _SplashState extends State<Splash> {
  late AnimationController controller;
  @override
  void initState() {
    // TODO: implement initState
    print("running splash");
    super.initState();

    getSharedData();
    setState(() {

    });
  }

  startTimer(String isLog) async{
    var duration = Duration(seconds: 3);
    if(isLog == 'true'){
      print('-------->  '+ 'check 1');
      return new Timer(duration, homePageRoute);
    }else{
      print('-------->  '+ 'check 2');
      return new Timer(duration, loginPageRoute);
    }
  }

 loginPageRoute(){
    // Navigator.pushReplacement(context, MaterialPageRoute(
    //     builder: (context) => LoginScreen()
    // ));
   Navigator.pushReplacement(context, MaterialPageRoute(
       builder: (context) => LoginScreen()
   ));
  }
  homePageRoute(){
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => HomeScreen()
    ));
  }
  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  Widget initWidget() {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Container(
              margin:  EdgeInsets.only(bottom: 100.0),
              child: Image.asset("assets/icons/adn_icon.png", width: 200, height: 200),
            ),
          ),
          Center(
            child: Container(
              margin:  EdgeInsets.only(top: 120.0),
              child: Text('DigiNet SkillUP', style: GoogleFonts.comfortaa(color: Color(0XFF01974D), fontSize: 25, fontWeight: FontWeight.bold),),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 40.0),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: JumpingDotsProgressIndicator(
                    fontSize: 50.0,
                    numberOfDots: 5,
                    color: new Color(0xFFFFFFFF),
                    milliseconds: 120,
                  ),
                )
              ],
            ),
          ),
          Container(
            margin:  EdgeInsets.only(bottom: 10.0),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text('Technical support from ADN Diginet', style: GoogleFonts.comfortaa(color: const Color(0xFFFFFFFF))),
                )
              ],
            ),
          )

        ],
      ),
    );
  }

  void getSharedData() async{
    print('?????????  '+widget.isLog.toString());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    widget.isLog = await prefs.getString('isLoged').toString();
    setState(() {
    });
    startTimer(widget.isLog);
  }



}