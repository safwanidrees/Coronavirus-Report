import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InfoScreen extends StatefulWidget {
  final int title;
  final String webvieweurl;
  InfoScreen(this.title, this.webvieweurl);

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  final _key = UniqueKey();
  Completer<WebViewController> _controller = Completer<WebViewController>();
  var _isLoading;
  var _init = true;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _isLoading = true;
  }

  num position = 1;

  final key = UniqueKey();

  doneLoading(String A) {
    setState(() {
      position = 0;
    });
  }

  startLoading(String A) {
    setState(() {
      position = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SAS'),
      ),
      body: IndexedStack(
        index: position,
        children: <Widget>[
          WebView(
            key: _key,
            initialUrl: widget.webvieweurl,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            onPageFinished: doneLoading,
            onPageStarted: startLoading,
          ),
          Container(
            color: Colors.white,
            child: Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }
}
