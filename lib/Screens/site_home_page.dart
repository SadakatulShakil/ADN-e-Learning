import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:radda_moodle_learning/Helper/CustomScaffold.dart';
import 'package:radda_moodle_learning/Screens/category_details_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ApiCall/HttpNetworkCall.dart';
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
  List<dynamic> categoryList = [];
  List<dynamic> subCategoryList = [];
  String token = '';
  double value = 0;
  NetworkCall networkCall = NetworkCall();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedData();
    setState(() {});
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
            backgroundColor: const Color(0xFF0E0E95),
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text('Site Home',
                style: GoogleFonts.comfortaa(
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
          backgroundColor: const Color(0xFF0E0E95),
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
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: Align(
                              alignment: Alignment.center,
                                child: Text('Where you are at home, in a bus or commuting in a train or while you phycally are in the class, your daily notes, notifications and assignment are just one click', style: TextStyle(color: Colors.white),)),
                          ),
                        ],
                      ),
                    ),
                    Align(alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0,right: 15, top: 8, bottom: 8),
                        child: Text('Our Courses', style: TextStyle(color: Colors.blueAccent, fontSize: 18, fontWeight: FontWeight.bold),),
                      ),
                    ),
                    Align(alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15),
                        child: Text('The community paramedic course offered at Radda Paramedic Institute has a duration of two years which are divided into four semesters. '),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Expanded(
                      child: Padding(
                          padding:
                          const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: ListView.builder(
                              itemCount: categoryList.length,
                              itemBuilder: (context, index) {
                                final mCategoryData = categoryList[index];

                                return buildCategoryCourse(mCategoryData);
                              })),
                    ),
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
    token = prefs.getString('TOKEN')!;
    setState(() {
      getCategories(token);
    });
  }
  void getCategories(String token) async{
    CommonOperation.showProgressDialog(
        context, "loading", true);
    final categoryListCallData = await networkCall.CategoryListCall(token);
    if(categoryListCallData != null){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String message = 'Success';
      categoryList = categoryListCallData;
      //count = categoryList.length.toString();
      print('data_count1 '+ categoryList.first.toString());
      showToastMessage(message);
      setState(() {
        CommonOperation.hideProgressDialog(context);
      });

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

  Widget buildCategoryCourse(mCategoryData) =>
      Visibility(
        visible: mCategoryData.parent == 0,
        child: GestureDetector(
          onTap: (){
            mCategoryData.parent != 0?Navigator.push(context, MaterialPageRoute(builder: (context) =>
                CategoryDetailsPage(mCategoryData.name.toString(), categoryList, mCategoryData.id.toString()))):
            Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryWiseCoursesPage(mCategoryData.id.toString())));
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0, right: 8.0),
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
                              'View Courses', style: GoogleFonts.comfortaa(
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
                          image: AssetImage("assets/images/banner.png"),

                        ),
                      ),),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child:  Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Text(
                                    mCategoryData.name.toString(), style: GoogleFonts.comfortaa(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                  ),
                                  ),
                                ),
                              ]
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child:  Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                const Icon(Icons.library_add_rounded,
                                  color: Color(0xFF18D77E),
                                  size: 17,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    categoryList.where((element) => element.parent.toString() == mCategoryData.id.toString()).toList().length.toString()+' courses', style: GoogleFonts.comfortaa(
                                    color: const Color(0xFF18D77E),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900,
                                  ),
                                  ),
                                ),
                              ]
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
              ,
            )
            ,
          ),
        ),
      );
}
