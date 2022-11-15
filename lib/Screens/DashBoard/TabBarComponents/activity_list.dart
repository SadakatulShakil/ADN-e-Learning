import 'package:flutter/material.dart';

class DashBoardActivityList extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => InitState();
}
class InitState extends State<DashBoardActivityList> {
  @override
  Widget build(BuildContext context) {
    return initWidget(context);
  }

  Widget initWidget(BuildContext context) {

    return Scaffold(
        body:  Center(
          child: SizedBox(
            height: 100,
            child: Column(
              children: [
                Icon(Icons.warning_amber, size: 30,),
                Text('Not Data Found!'),
              ],
            ),
          ),
        )
    );
  }
}
