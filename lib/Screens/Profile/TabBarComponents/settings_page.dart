import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../ApiCall/HttpNetworkCall.dart';
import '../../../Helper/operations.dart';

class ProfileSettingsPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => InitState();
}
class InitState extends State<ProfileSettingsPage> {
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
  List <String> languageList = [
    'English',
    'Bangla'
  ];
  List <String> cityList = [
  'Dhaka',
  'Faridpur',
  'Gazipur',
  'Gopalganj',
  'Jamalpur',
  'Kishoreganj',
  'Madaripur',
  'Manikganj',
  'Munshiganj',
  'Mymensingh',
 'Narayanganj',
  'Narsingdi',
  'Netrokona',
  'Rajbari',
  'Shariatpur',
  'Sherpur',
  'Tangail',
  'Bogura',
  'Joypurhat',
  'Naogaon',
  'Natore',
  'Nawabganj',
  'Pabna',
  'Rajshahi',
  'Sirajgonj',
  'Dinajpur',
  'Gaibandha',
  'Kurigram',
  'Lalmonirhat',
  'Nilphamari',
  'Panchagarh',
  'Rangpur',
  'Thakurgaon',
  'Barguna',
  'Barishal',
  'Bhola',
  'Jhalokati',
  'Patuakhali',
  'Pirojpur',
  'Bandarban',
  'Brahmanbaria',
  'Chandpur',
  'Chattogram',
  'Cumilla',
  'Coxs Bazar',
  'Feni',
  'Khagrachari',
  'Lakshmipur',
  'Noakhali',
  'Rangamati',
  'Habiganj',
  'Maulvibazar',
  'Sunamganj',
  'Sylhet',
  'Bagerhat',
  'Chuadanga',
  'Jashore',
  'Jhenaidah',
  'Khulna',
  'Kushtia',
  'Magura',
  'Meherpur',
  'Narail',
  'Satkhira',
  ];
  List <String> countryList = [
    'Bangladesh',
    'India'
  ];
  String? _selectedLanguage;
  String? _selectedCity;
  String _selectedCountry = 'Bangladesh';
  bool generalVisibility = false;
  bool changePasswordVisibility = false;
  bool _passwordVisible =false;

  final firstNameController = TextEditingController();
  final surnameController = TextEditingController();
  final emailController = TextEditingController();
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
        body:  SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
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
                          child: Text("General",
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

                    Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: TextField(
                        controller: firstNameController..text = firstName,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            isDense: true,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                            ),
                            //prefixIcon: Image.asset("assets/icons/user_icon.png", width: 20, height: 20),
                            hintText: 'Enter first name',hintStyle: GoogleFonts.comfortaa(
                          color: Colors.black,
                          fontSize: 15,
                        )
                        ),
                        autofocus: false,
                      ),
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
                    Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: TextField(
                        controller: surnameController..text = surName,
                        decoration: InputDecoration(
                            isDense: true,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                            ),
                            //prefixIcon: Image.asset("assets/icons/user_icon.png", width: 20, height: 20),
                            hintText: 'Enter second name',hintStyle: GoogleFonts.comfortaa(
                          color: Colors.black,
                          fontSize: 15,
                        )
                        ),
                        autofocus: false,
                      ),
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
                    Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: TextField(
                        controller: emailController..text = email,
                        decoration: InputDecoration(
                            isDense: true,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                            ),
                            //prefixIcon: Image.asset("assets/icons/user_icon.png", width: 20, height: 20),
                            hintText: 'Enter email',hintStyle: GoogleFonts.comfortaa(
                          color: Colors.black,
                          fontSize: 15,
                        )
                        ),
                        autofocus: false,
                      ),
                    ),
                    SizedBox(height: 20,),
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
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,

                        child:DropdownButton<String>(
                          // Not necessary for Option 1
                          //underline: SizedBox(), //remove underline
                          hint: Text('Select language',
                            style: GoogleFonts.comfortaa(
                              color: Colors.black45,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          value: _selectedLanguage,
                          isExpanded: true,
                          onChanged: (String? newValue) {
                            setState(() {
                              //hint = '';
                              _selectedLanguage = newValue!;
                              print("Accoutn no: " + _selectedLanguage.toString());
                            });
                          },
                          items: languageList.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style: GoogleFonts.comfortaa(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,)),
                            );
                          })
                              .toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: 8,),
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

                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,

                        child:DropdownButton<String>(
                          // Not necessary for Option 1
                          hint: Text('Select city',
                            style: GoogleFonts.comfortaa(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          value: _selectedCity,
                          isExpanded: true,
                          onChanged: (String? newValue) {
                            setState(() {
                              //hint = '';
                              _selectedCity = newValue!;
                              print("Accoutn no: " + _selectedCity.toString());
                            });
                          },
                          items: cityList.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style: GoogleFonts.comfortaa(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,)),
                            );
                          })
                              .toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: 8,),
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
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child:DropdownButton<String>(
                          // Not necessary for Option 1
                          hint: Text('Bangladesh',
                            style: GoogleFonts.comfortaa(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          value: _selectedCountry,
                          isExpanded: true,
                          onChanged: (String? newValue) {
                            setState(() {
                              //hint = '';
                              _selectedCountry = newValue!;
                              print("Accoutn no: " + _selectedCountry.toString());
                            });
                          },
                          items: countryList.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style: GoogleFonts.comfortaa(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,)),
                            );
                          })
                              .toList(),
                        ),
                      ),
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
                        child: Text("Change password",
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
                        padding: const EdgeInsets.only(left: 12, right: 12, bottom: 5),
                        child: Text("Current password",
                            style: GoogleFonts.comfortaa(color: Colors.black45,
                                fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 18.0),
                            isDense: true,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                            ),
                            //prefixIcon: Image.asset("assets/icons/pass_icon.png", width: 20, height: 20),
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
                            hintText: 'Enter current password',hintStyle: GoogleFonts.comfortaa(
                          fontSize: 15,
                        )
                        ),
                        autofocus: false,
                      ),
                    ),
                    SizedBox(height: 8,),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12, bottom: 5),
                        child: Text("New password",
                            style: GoogleFonts.comfortaa(
                                color: Colors.black45,
                                fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 18.0),
                            isDense: true, enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black12),
                        ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                            ),
                            //prefixIcon: Image.asset("assets/icons/pass_icon.png", width: 20, height: 20),
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
                            hintText: 'Enter new password',hintStyle: GoogleFonts.comfortaa(
                          fontSize: 15,
                        )
                        ),
                        autofocus: false,
                      ),
                    ),
                    SizedBox(height: 8,),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12, bottom: 5),
                        child: Text("Confirm password",
                            style: GoogleFonts.comfortaa(
                                color: Colors.black45,
                                fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 18.0),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                            ),
                            isDense: true, enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black12),
                        ),
                            //prefixIcon: Image.asset("assets/icons/pass_icon.png", width: 20, height: 20),
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
                            hintText: 'Confirm new password',hintStyle: GoogleFonts.comfortaa(
                          fontSize: 15,
                        )
                        ),
                        autofocus: false,
                      ),
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
              SizedBox(height: 25,),
              Padding(
                padding: EdgeInsets.only(left: 30.0, right: 30.0),
                child: InkWell(
                  onTap: (){
                    print('check settings  '+ firstNameController.text.toString());
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
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
                        child: Text("Save changes", style: GoogleFonts.comfortaa(color: Colors.white, fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 15,),
              Padding(
                padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30),
                child: InkWell(
                  onTap: (){
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
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

                      ),
                      child: Center(
                        child: Text("Cancel", style: GoogleFonts.comfortaa(color: Colors.black, fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ),
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
      email = profileInfoList[0].email.toString();
      _selectedLanguage = profileInfoList[0].lang.toString()=='en'?'English':'Bangla';
      _selectedCity = profileInfoList[0].city.toString();
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
      //count = courseList.length.toString();
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
