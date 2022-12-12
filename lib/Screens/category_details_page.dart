import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:radda_moodle_learning/Helper/colors_class.dart';
import 'package:radda_moodle_learning/Screens/category_wise_course.dart';

import '../ApiCall/HttpNetworkCall.dart';

class CategoryDetailsPage extends StatefulWidget {
  String name;
  List<dynamic> categoryList;
  String catId;

  CategoryDetailsPage(this.name, this.categoryList, this.catId);

  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<CategoryDetailsPage> {
  List<dynamic> subCategoryList = [];
  String token = '';
  String countSubCat = '';
  NetworkCall networkCall = NetworkCall();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSubCat(widget.catId);
    print('kkkkk '+ widget.catId.toString());
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
                    height: 100,
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
                        SizedBox(height: 8,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widget.name, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text('Total papers: '+ countSubCat.toString(), style: TextStyle(color: Colors.white),)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Align(alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0,right: 15, top: 8, bottom: 8),
                      child: Text('Our Papers', style: TextStyle(color: SecondaryColor, fontSize: 18, fontWeight: FontWeight.bold),),
                    ),
                  ),
                  SizedBox(height: 12,),
                  Expanded(
                    child: Padding(
                        padding:
                        const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: ListView.builder(
                            itemCount: widget.categoryList.length,
                            itemBuilder: (context, index) {

                              final mCategoryData = widget.categoryList[index];
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
  // void getSharedData() async{
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   token = prefs.getString('TOKEN')!;
  //   setState(() {
  //     getCategories(token);
  //   });
  // }
  // void getCategories(String token) async{
  //   CommonOperation.showProgressDialog(
  //       context, "loading", true);
  //   final categoryListCallData = await networkCall.CategoryListCall(token);
  //   if(categoryListCallData != null){
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     String message = 'Success';
  //     categoryList = categoryListCallData;
  //     //count = categoryList.length.toString();
  //     print('data_count1 '+ categoryList.first.toString());
  //     showToastMessage(message);
  //     setState(() {
  //       CommonOperation.hideProgressDialog(context);
  //     });
  //
  //   }else{
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     await prefs.setBool('isLoged', false);
  //     showToastMessage('your session is expire ');
  //   }
  // }
  // void showToastMessage(String message) {
  //   Fluttertoast.showToast(
  //       msg: message,
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.TOP,
  //       timeInSecForIosWeb: 1,
  //       textColor: Colors.white,
  //       fontSize: 16.0 //message font size
  //   );
  // }
  Widget buildCategoryCourse(mCategoryData) =>
      Visibility(
        visible: mCategoryData.parent.toString() == widget.catId.toString()?true:false,
        child: GestureDetector(
          onTap: (){
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
                              'View Courses', style: GoogleFonts.nanumGothic(
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
                                    mCategoryData.name.toString(), style: GoogleFonts.nanumGothic(
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
                                  color: PrimaryColor,
                                  size: 17,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    mCategoryData.coursecount.toString()+' courses', style: GoogleFonts.nanumGothic(
                                    color: PrimaryColor,
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

  void getSubCat(String catId) {
    subCategoryList = widget.categoryList.where((element) => element.parent.toString() == catId).toList();
    countSubCat = subCategoryList.length.toString();

    print('???? '+ countSubCat);
  }


}
