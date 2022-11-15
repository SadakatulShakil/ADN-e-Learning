import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:power_file_view/power_file_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:webview_flutter/webview_flutter.dart';
class PdfViwerPage extends StatefulWidget{
  String downloadUrl, downloadPath;
  PdfViwerPage(this.downloadUrl, this.downloadPath);


  @override
  State<StatefulWidget> createState() => InitState();
}
class InitState extends State<PdfViwerPage> {
  bool isLoading = true;
  String savePath ='';
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //loadFilePath();
  }
  @override
  Widget build(BuildContext context) {
    return initWidget(context);
  }

  Widget initWidget(BuildContext context) {
    //print(pdfFile+'&token=$token');

    return Scaffold(
        body:  SafeArea(
          child: WebView(
            initialUrl: 'https://radda.adnarchive.com/webservice/pluginfile.php/31/mod_folder/content/4/ppt%201.ppt?forcedownload=1&token=f201f9cd0e050c8fdf4541115195c250',
            //initialUrl: 'https://radda.adnarchive.com',
          )
          // Container(
          //   margin: const EdgeInsets.only(top: 10.0),
          //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
          //   child: PowerFileViewWidget(
          //     downloadUrl: widget.downloadUrl,
          //     filePath: widget.downloadPath,
          //   )
          // )
        )
    );
  }

}
