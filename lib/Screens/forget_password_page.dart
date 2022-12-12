import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../ApiCall/HttpNetworkCall.dart';
import '../Helper/colors_class.dart';
import '../Helper/operations.dart';
import 'home_screen.dart';

class ForgetPasswordPage extends StatefulWidget{

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage>{

final userEmailController = TextEditingController();
String token ='';
NetworkCall networkCall = NetworkCall();
  @override
  void initState() {

    setState(() {
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
                      child: Image.asset("assets/images/forget_password.png", fit: BoxFit.fill,),
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
                            padding: const EdgeInsets.all(15),
                            child: Text("Please provide your email to reset your password!",
                                style: GoogleFonts.nanumGothic(color: PrimaryColor,
                                    fontSize: 15, fontWeight: FontWeight.w900)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 32.0, left: 12, right: 12),
                            child: TextField(
                              textInputAction: TextInputAction.next,
                              controller: userEmailController,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.email_outlined, color: Colors.greenAccent,),
                                  border: OutlineInputBorder(),
                                  labelText: 'Email',labelStyle: GoogleFonts.nanumGothic(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                                  hintText: 'Enter your email',hintStyle: GoogleFonts.nanumGothic(
                                fontSize: 15,
                              )
                              ),
                              autofocus: false,
                            ),
                          ),


                          SizedBox(height: 15,),
                          Padding(
                            padding: EdgeInsets.only(left: 20.0, right: 20.0),
                            child: InkWell(
                              onTap: ()async{
                                ShowSuccessDialog();
                                //sendResetPasswordMail(token, userEmailController.text.toString());
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
                                    child: Text("Continue", style: GoogleFonts.nanumGothic(color: Colors.white, fontWeight: FontWeight.bold),),
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

void getSharedData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  token = prefs.getString('TOKEN')!;
  setState(() {

  });
}

  Future sendResetPasswordMail(String token, String email) async{
    CommonOperation.showProgressDialog(context, "loading", true);
    final resetPasswordMailData =
    await networkCall.ResetPasswordMailCall(token, email);

    if(resetPasswordMailData != null){
      CommonOperation.hideProgressDialog(context);
      ShowSuccessDialog();
    }
  }

ShowSuccessDialog() {
  print(',,,,,,,,,,,,,,,,,,,,,');
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          title:Flexible(child: Align(
            alignment: Alignment.center,
            child: Text('Successfull !',style: GoogleFonts.nanumGothic(
                fontSize: 18
            )),
          )),

          content: Container(
            height: MediaQuery.of(context).size.height/4,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text('If you supplied a correct or unique email address then an email should have been sent to you. If you continue to have difficulty, please contact the site Administrator.'
                      '\n\n\nNote: After change password, please logout and login with new password.')
                ],
              ),
            ),
          ),
          actions: [
            InkWell(
              onTap: (){
                Navigator.pop(context);
                Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) => HomeScreen()
                ));
                setState(() {

                });
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: SecondaryColor,
                  ),
                  child: Center(
                    child: Text("OK", style: GoogleFonts.nanumGothic(color: Colors.white, fontWeight: FontWeight.bold),),
                  ),
                ),
              ),
            ),
          ],
        );
      });
}



}