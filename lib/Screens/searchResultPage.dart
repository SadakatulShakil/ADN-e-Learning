import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:radda_moodle_learning/Helper/colors_class.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Profile/other_user_profile.dart';

class SearchResultPage extends StatefulWidget {
  List<dynamic> searchedUserList;
  SearchResultPage(this.searchedUserList);


  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<SearchResultPage> {
  String token ='';
  String userId ='';
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
        backgroundColor: PrimaryColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Searched Users',
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
              height: MediaQuery.of(context).size.height-MediaQuery.of(context).size.height/9,
              transform: Matrix4.translationValues(0, 10, 1),
              decoration: BoxDecoration(
                  color: Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)
                  )
              ),
              child: Column(
                children: [
                  SizedBox(height: 15,),
                  Expanded(
                    child:
                    Padding(
                        padding:
                        const EdgeInsets.only(left: 12.0, right: 12.0),
                        child: ListView.builder(
                            itemCount: widget.searchedUserList.length,
                            itemBuilder: (context, index) {
                              final mSearchedUserListData = widget.searchedUserList[index];

                              return buildSearchEvent(mSearchedUserListData);
                            })),
                  ),
                ],
              )
          ),
        ],
      ),
    );
  }

  Widget buildSearchEvent(mSearchData) => GestureDetector(
      onTap: () {
        /// do click item task
        Navigator.pop(context, false);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OtherProfileBody(
                    'search', userId, mSearchData.id.toString())));
      },
      child: Container(
        margin: const EdgeInsets.only(left: 12.0, right: 12, top: 5, bottom: 8),
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black12)),
        child: Row(
          children: [
            FadeInImage.assetNetwork(
                placeholder: 'assets/images/chat_head.jpg',
                image: mSearchData.profileimageurl.toString(),
                height: 55,
                width: 55,
                fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 3,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Text(mSearchData.fullname.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: GoogleFonts.nanumGothic(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ));

  String getDateStump(String sTime) {
    int timeNumber = int.parse(sTime);
    return DateTime.fromMillisecondsSinceEpoch(timeNumber * 1000).toString();
  }
  void getSharedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('TOKEN')!;
    userId = prefs.getString('userId')!;
    setState(() {

    });
  }

}
