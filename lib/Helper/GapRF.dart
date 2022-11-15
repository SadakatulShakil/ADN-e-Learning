import 'package:flutter/material.dart';

class GapRF extends StatefulWidget {
  double gap;

  GapRF([this.gap = 5]);

  @override
  _GapRFState createState() => _GapRFState();
}

class _GapRFState extends State<GapRF> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.gap,
      width: widget.gap,
    );
  }
}

class ScreenRF {
  static height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

}