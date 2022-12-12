import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../Helper/colors_class.dart';

class WebViewPage extends StatefulWidget {
  String? url;
  String? title;
  WebViewPage(this.url, this.title);

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  bool isLoading = true;
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      print("hhhhhhhhhhhhhhhh"+widget.url.toString());
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: PrimaryColor,
        title: Text(widget.title.toString(),
            style: GoogleFonts.nanumGothic(
                color: const Color(0xFFFFFFFF),
                fontWeight: FontWeight.w700,
                fontSize: 18)),leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      ),
      body: Stack(
        children: <Widget>[
          WebView(
            initialUrl: widget.url.toString(),
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (_controller) {
              this._controller = _controller;

            },
            onPageFinished: (finish) {
              setState(() {
                _controller.evaluateJavascript("document.getElementByTagName('header')[0].style.display='none'");
                _controller.evaluateJavascript("document.getElementByTagName('footer')[0].style.display='none'");
                isLoading = false;
              });
            },
          ),
          isLoading ? Center( child: CircularProgressIndicator(),)
              : Stack(),
        ],
      ),
    );
  }

}
