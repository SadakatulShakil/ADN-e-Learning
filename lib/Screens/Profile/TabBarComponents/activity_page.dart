import 'package:flutter/material.dart';

class ProfileActivityPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => InitState();
}
class InitState extends State<ProfileActivityPage> {
  @override
  Widget build(BuildContext context) {
    return initWidget(context);
  }

  Widget initWidget(BuildContext context) {

    return Scaffold(
        body:  Center(child: Text('ProfileActivityPage'))
    );
  }
}
