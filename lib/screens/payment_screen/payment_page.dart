import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../constants/app_constant.dart';

class paymetPage extends StatefulWidget {
  final String url;
  const paymetPage({Key? key, required this.url}) : super(key: key);
  @override
  State<paymetPage> createState() => _paymetPageState(url: url);
}

class _paymetPageState extends State<paymetPage> {
  String url;
  _paymetPageState({required this.url});
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: url,
      javascriptMode: JavascriptMode.unrestricted,
      onPageFinished: (String url) {
        print('Page finished loading: $url');
        if (url.contains("yes")) {
          print(url.split("/")[url.split("/").length - 1]);
          Navigator.pushNamed(context, AppConstant.pageChatRoute,
              arguments: url.split("/")[url.split("/").length - 1]+"");
        }
      },
    );
  }
}
