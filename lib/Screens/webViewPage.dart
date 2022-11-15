import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  String? url;
  String? title;
  WebViewPage(this.url, this.title);

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  late WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      print(widget.url.toString());
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF0E0E95),
        title: Text(widget.title.toString(),
            style: GoogleFonts.comfortaa(
                color: const Color(0xFFFFFFFF),
                fontWeight: FontWeight.w700,
                fontSize: 18)),leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      ),
      body: WebView(
        initialUrl: widget.url.toString(),
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _webViewController = webViewController;
          _controller.complete(webViewController);
        },
        onProgress: (int progress) {
          new Column(
            children: [
              Container(
                  child: CircularProgressIndicator(
                      strokeWidth: 3
                  ),
                  width: 60,
                  height: 32
              ),
              Text('Please wait ($progress%)')
            ],
          );
          print('WebView is loading (progress : $progress%)');
        },
        javascriptChannels: <JavascriptChannel>{
          _toasterJavascriptChannel(context),
        },
        navigationDelegate: (NavigationRequest request) {
          if (request.url.startsWith('https://diginet-elarning.adnarchive.com/')) {
            print('blocking navigation to $request}');
            return NavigationDecision.prevent;
          }
          print('allowing navigation to $request');
          return NavigationDecision.navigate;
        },
        onPageStarted: (String url) {
          print('Page started loading: $url');
        },
        onPageFinished: (String url) {
          print('Page finished loading: $url');
          _webViewController
              .evaluateJavascript("javascript:(function() { " +
              "var head = document.getElementsByTagName('header')[0];" +
              "head.parentNode.removeChild(head);" +
              "var footer = document.getElementsByTagName('footer')[0];" +
              "footer.parentNode.removeChild(footer);" +
              "})()")
              .then((value) => debugPrint('Page finished loading Javascript'))
              .catchError((onError) => debugPrint('$onError'));
        },
        gestureNavigationEnabled: true,
        backgroundColor: const Color(0x00000000),
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }

}
