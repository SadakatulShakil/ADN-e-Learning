import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:radda_moodle_learning/Helper/CustomScaffold.dart';
import 'package:radda_moodle_learning/Screens/category_details_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ApiCall/HttpNetworkCall.dart';
import '../Helper/colors_class.dart';
import '../Helper/operations.dart';
import '../language/Languages .dart';
import '../language/LocalConstant.dart';
import 'category_wise_course.dart';
import 'home_screen.dart';

class SiteHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<SiteHomePage> {
  List<String> courseImageList = [
    'assets/images/sub1.png',
    'assets/images/sub2.png',
    'assets/images/sub3.png',
    'assets/images/sub4.png'
  ];
  List<dynamic> categoryList = [];
  List<dynamic>showCategoryList = [];
  List<dynamic> subCategoryList = [];
  String token = '';
  double value = 0;
  int countSubCat = 0;
  NetworkCall networkCall = NetworkCall();
  Connectivity connectivity = Connectivity();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkconnectivity();
  }

  @override
  Widget build(BuildContext context) {
    return initWidget(context);
  }

  Widget initWidget(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      transform: Matrix4.translationValues(0, 5, 1),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: PrimaryColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('Site Home',
              style: GoogleFonts.nanumGothic(
                  color: const Color(0xFFFFFFFF),
                  fontWeight: FontWeight.w700,
                  fontSize: 18)),
          centerTitle: false,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: IconButton(
                icon: Icon(Icons.home_outlined),
                onPressed: () => {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) => HomeScreen()
                  ))
                },
              ),
            )
          ],
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
                children: [
                  Container(
                    height: 130,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/rectangle_bg.png"),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25))),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Learn from anywhere', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
                          child: Align(
                              alignment: Alignment.center,
                              child: Text('The training courses and material offered at BTEB via the e-Learning platform caters to general knowledge transfer and professional skills development for BTEB personals', style: TextStyle(color: Colors.white),)),
                        ),
                      ],
                    ),
                  ),
                  Align(alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0,right: 15, top: 8, bottom: 8),
                      child: Text('Our Courses', style: TextStyle(color: SecondaryColor, fontSize: 18, fontWeight: FontWeight.bold),),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Expanded(
                    child: Padding(
                        padding:
                        const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: RefreshIndicator(
                          onRefresh: checkconnectivity,
                          child: ListView.builder(
                              itemCount: showCategoryList.length,
                              itemBuilder: (context, index) {
                                final mCategoryData = showCategoryList[index];
                                final mImageData = courseImageList[index];
                                return buildCategoryCourse(mCategoryData, mImageData);
                              }),
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future getSharedData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('TOKEN')!;
    Future.wait([getCategories(token)]);
  }
  Future getCategories(String token) async{
    CommonOperation.showProgressDialog(
        context, "loading", true);
    final categoryListCallData = await networkCall.CategoryListCall(token);
    if(categoryListCallData != null){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String message = 'Success';
      categoryList = categoryListCallData;
      showCategoryList = categoryList.where((element) => element.parent.toString() == '0').toList();
      print('data_count1 '+ showCategoryList.length.toString());
      CommonOperation.hideProgressDialog(context);
      setState(() {});

    }else{
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

  Widget buildCategoryCourse(mCategoryData, String mImageData) =>
      GestureDetector(
        onTap: (){
          getSubCat(mCategoryData.id.toString(),mCategoryData);
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0, right: 8.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Column(
                children: [
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFE7EAEC),
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            mCategoryData.name.toString(), style: GoogleFonts.nanumGothic(
                            color: const Color(0xFF000000),
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                          ),
                          ),
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF848484),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
                        image: AssetImage(mImageData),

                      ),
                    ),),
                ],
              ),
            )
            ,
          )
          ,
        ),
      );

  Future checkconnectivity() async{
    var connectivityResult = await connectivity.checkConnectivity();
    if(connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi){
      getSharedData();
    }else{
      openNetworkDialog();
      setState(() {});
    }
  }
  openNetworkDialog() {
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
              child: Text('Network Issue !',style: GoogleFonts.nanumGothic(
                  fontSize: 12
              )),
            )),

            content: Container(
              height: MediaQuery.of(context).size.height/5,
              width: MediaQuery.of(context).size.width/2,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text('Please check your internet connectivity and try again.')
                  ],
                ),
              ),
            ),
            actions: [
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                  checkconnectivity();
                  setState(() {});
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    width:150,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: SecondaryColor,
                    ),
                    child: Center(
                      child: Text("Try again", style: GoogleFonts.nanumGothic(color: Colors.white, fontWeight: FontWeight.bold),),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  void getSubCat(String catId, mCategoryData) {
    subCategoryList = categoryList.where((element) => element.parent.toString() == catId).toList();
    countSubCat = subCategoryList.length;
    if(countSubCat>0){
      Navigator.push(context, MaterialPageRoute(builder: (context) =>
          CategoryDetailsPage(mCategoryData.name.toString(), categoryList, mCategoryData.id.toString())));
    }else{
      Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryWiseCoursesPage(mCategoryData.id.toString())));
    }
    print('???? '+ countSubCat.toString());
  }
}
