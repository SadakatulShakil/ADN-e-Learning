import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:radda_moodle_learning/Screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ApiCall/HttpNetworkCall.dart';
import '../Helper/operations.dart';

class LoginScreen extends StatefulWidget{

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{

  bool _passwordVisible =false;
  bool agree = false;
  int error = 0;
  NetworkCall networkCall = NetworkCall();
  late TextEditingController userNameController;
  late TextEditingController passwordController;
  String val = 'false', name ='', userId='', imageUrl= '', _getUserName = "", _getPassword = "", userName = '', password = '';

  @override
  void initState() {
    _passwordVisible = false;
    setState(() {
      userNameController = TextEditingController();
      passwordController = TextEditingController();
      getSharedData();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: AnimatedContainer(
            curve: Curves.fastLinearToSlowEaseIn,
            duration: Duration(
              microseconds: 2000),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    child: Image.asset("assets/images/login_banner.png", fit: BoxFit.fill,),
                  ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    transform: Matrix4.translationValues(0, 350, 1),
                    decoration: BoxDecoration(
                        color: Color(0xFFFAFAFA),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25)
                        )
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 32.0),
                          child: Text("Log in to DigiNet SkillUP",
                              style: GoogleFonts.comfortaa(color: const Color(
                                  0xFF01974D),
                                  fontSize: 20, fontWeight: FontWeight.w900)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 32.0, left: 12, right: 12),
                          child: TextField(
                            textInputAction: TextInputAction.next,
                            controller: userNameController,
                            decoration: InputDecoration(
                              prefixIcon: Image.asset("assets/icons/user_icon.png", width: 20, height: 20),
                                border: OutlineInputBorder(),
                                labelText: 'User name',labelStyle: GoogleFonts.comfortaa(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                                hintText: 'Enter user name',hintStyle: GoogleFonts.comfortaa(
                              fontSize: 15,
                            )
                            ),
                            autofocus: false,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:15.0, left: 12, right: 12),
                          child: TextField(
                            controller: passwordController,
                            keyboardType: TextInputType.text,
                            obscureText: !_passwordVisible,
                            decoration: InputDecoration(

                                prefixIcon: Image.asset("assets/icons/pass_icon.png", width: 20, height: 20),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    // Based on passwordVisible state choose the icon
                                    _passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: const Color(0xFFBDBDBD),
                                  ),
                                  onPressed: () {
                                    // Update the state i.e. toogle the state of passwordVisible variable
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                ),
                                border: OutlineInputBorder(),
                                labelText: 'Password',labelStyle: GoogleFonts.comfortaa(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                                hintText: 'Enter password',hintStyle: GoogleFonts.comfortaa(
                              fontSize: 15,
                            )
                            ),
                            autofocus: true,
                          ),
                        ),
                        SizedBox(height: 8,),
                        Visibility(
                          visible: error == 1?true:false,
                          child: Text("Warning: "+ 'Invalid credentials',
                              style: GoogleFonts.comfortaa(color: Colors.red)),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12.0),
                                      child: SizedBox(
                                        width: 15,
                                        height: 15,
                                        child: Material(
                                          child: Checkbox(
                                            value: agree,
                                            onChanged: (value) {
                                              setState(() {
                                                agree = value ?? false;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text("Remember me",
                                          style: GoogleFonts.comfortaa()),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text("Forget password?",
                                    style: GoogleFonts.comfortaa(color: Color(0xFF01974D))),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 25,),
                        Padding(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0),
                          child: InkWell(
                            onTap: ()async{
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              if(agree){
                                await prefs.setString('userName', userNameController.text.toString());
                                await prefs.setString('password', passwordController.text.toString());
                              }
                              callLoginApi(userNameController.text, passwordController.text);
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
                                    color: const Color(0xFF00BC78)
                                ),
                                child: Center(
                                  child: Text("Log In", style: GoogleFonts.comfortaa(color: Colors.white, fontWeight: FontWeight.bold),),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                ),
              ],
            ),
          ),
        ),
      )
    );
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

  void callLoginApi(String userName, String password) async{
    CommonOperation.showProgressDialog(
        context, "loading", true);
    final loginresponseData = await networkCall.LoginCall(
      userName,
      password,
    );
    if(loginresponseData != null){
      if (loginresponseData.token.toString() == 'null') {
        CommonOperation.hideProgressDialog(context);
        setState(() {});
        error = 1;
        //showToastMessage(loginresponseData.error.toString());
        print('error '+ loginresponseData.errorcode.toString());

      }
      else{
        SharedPreferences prefs = await SharedPreferences.getInstance();
        val = 'true';
        await prefs.setString('isLoged', val);
        String message = 'Login Success';
        print('token data'+ loginresponseData.token.toString());
        await prefs.setString('TOKEN', loginresponseData.token.toString());
        CommonOperation.hideProgressDialog(context);
        //showToastMessage(message);
        setState(() {
          callUserSiteDetail(loginresponseData.token.toString());
        });
      }
    }else{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoged', false);
      showToastMessage('your session is expire ');
    }

  }

  void callUserSiteDetail(String token) async{

    CommonOperation.showProgressDialog(
        context, "loading", true);
    final userDetailsData = await networkCall.UserDetailsCall(token);
    if(userDetailsData != null){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String message = 'Success';
      //OnDateClick();
      print('userId data'+ userDetailsData.userid.toString());
      await prefs.setString('userId', userDetailsData.userid.toString());
      await prefs.setString('imageUrl', userDetailsData.userpictureurl.toString());
      await prefs.setString('name', userDetailsData.fullname.toString());
      CommonOperation.hideProgressDialog(context);
      //showToastMessage(message);
      setState(() {
        //getURNotification(token, userDetailsData.userid.toString());
        name = userDetailsData.fullname.toString();
        imageUrl = userDetailsData.userpictureurl.toString();
        userId = userDetailsData.userid.toString();
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => HomeScreen()
        ));
      });

    }else{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoged', false);
      showToastMessage('your session is expire ');
    }
  }

  void getSharedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userNameController.text = prefs.getString('userName')!;
    passwordController.text = prefs.getString('password')!;
    setState(() {
      //getEventsData(token);
      //getGradeContent(token, widget.mGradeData.id.toString(), userId);
    });
  }

}