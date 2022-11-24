import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:radda_moodle_learning/ApiModel/gradeDetailsResponse.dart';
import 'package:radda_moodle_learning/ApiModel/gradeResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../ApiCall/HttpNetworkCall.dart';
import '../Helper/operations.dart';

class GradesDetailsPage extends StatefulWidget {
  dynamic mGradeData;
  Grades mGradesData;

  GradesDetailsPage(this.mGradeData, this.mGradesData);

  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<GradesDetailsPage> {
  NetworkCall networkCall = NetworkCall();
  String token = '';
  String userId = '';
  List<Gradeitems> gradeDetailsList = [];

  @override
  void initState() {
    // TODO: implement initState
    getSharedData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return initWidget(context);
  }

  Widget initWidget(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF01974D),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('Grade Details',
              style: GoogleFonts.comfortaa(
                  color: const Color(0xFFFFFFFF),
                  fontWeight: FontWeight.w700,
                  fontSize: 18)),
          centerTitle: false,
        ),
        backgroundColor: const Color(0xFF01974D),
        body: SafeArea(
          child: Column(
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
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/rectangle_bg.png"),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25))),
                          height: 125,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, top: 20.0, right: 8),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    widget.mGradeData.displayname.toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.comfortaa(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, top: 5, bottom: 5),
                                        child: Text(
                                            widget.mGradeData.progress != null
                                                ? widget.mGradeData.progress.ceil().toString() +
                                                ' % complete'
                                                : '0 % complete',
                                            style: GoogleFonts.comfortaa(
                                                fontSize: 11,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                      )),
                                  // Align(
                                  //     alignment: Alignment.centerLeft,
                                  //     child: Padding(
                                  //       padding: const EdgeInsets.only(
                                  //           left: 10.0, top: 5, bottom: 5),
                                  //       child: Text(
                                  //           'Start date: ' +
                                  //               DateFormat.yMMMEd().format(DateTime.parse(
                                  //                   getDateStump(
                                  //                       widget.mGradeData.startdate.toString()))),
                                  //           style: GoogleFonts.comfortaa(
                                  //               color: Colors.white,
                                  //               fontSize: 11,
                                  //               fontWeight: FontWeight.bold)),
                                  //     )),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, top: 5, bottom: 5),
                                        child: Text(
                                            widget.mGradesData.grade.toString() != null && widget.mGradesData.grade.toString() != '-'?
                                            'Total Grade: ' + widget.mGradesData.grade.toString():'Total Grade: ' + "Not evaluated yet",
                                            style: GoogleFonts.comfortaa(
                                                color: Colors.white,
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold)),
                                      )),
                                ],
                              ),
                            ],
                          )),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SingleChildScrollView(
                            child: DataTable(
                              columns: [
                                DataColumn(label: Text('Grade Item')),
                                DataColumn(label: Text('Calculated\nWeight')),
                                DataColumn(label: Text('Grade')),
                                DataColumn(label: Text('Range')),
                              ],
                              rows: _createRows(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ));
  }

  void getSharedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('TOKEN')!;
    userId = prefs.getString('userId')!;
    setState(() {
      getGradeContent(token, widget.mGradeData.id.toString(), userId);
    });
  }

  void getGradeContent(String token, String courseId, String userId) async {
    CommonOperation.showProgressDialog(context, "loading", true);
    final userGradeDetailsData =
        await networkCall.GradesDetailsCall(token, courseId, userId);
    if (userGradeDetailsData != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String message = 'Success';
      gradeDetailsList = userGradeDetailsData.usergrades![0].gradeitems!;
      print('data_content ' + gradeDetailsList.first.itemname.toString());
      CommonOperation.hideProgressDialog(context);
      //showToastMessage(message);
      setState(() {});
    } else {
      CommonOperation.hideProgressDialog(context);
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

  List<DataRow> _createRows() {
    return gradeDetailsList
        .map((item) => DataRow(cells: [
              DataCell(Container(
                  width: MediaQuery.of(context).size.width / 2.8,
                  child: Text(item.itemname.toString() == 'null'?'Not evaluated yet':
                    item.itemname.toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ))),
              DataCell(Text(item.weightformatted.toString() == 'null'?'Not evaluated yet':item.weightformatted.toString())),
              DataCell(Text(item.gradeformatted.toString() != null && item.gradeformatted.toString() != '-'?item.gradeformatted.toString():"Not evaluated yet")),
              DataCell(Text(
                  item.grademin.toString() + '-' + item.grademax.toString()))
            ]))
        .toList();
  }
  String getDateStump(String sTime) {
    int timeNumber = int.parse(sTime);
    return DateTime.fromMillisecondsSinceEpoch(timeNumber * 1000).toString();
  }
}
