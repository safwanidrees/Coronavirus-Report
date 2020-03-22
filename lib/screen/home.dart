import 'package:provider/provider.dart';
import 'package:api_data/provider/data.dart';

import 'package:api_data/screen/info_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../provider/news.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _init=true;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if(_init){

    Provider.of<News>(context).fetchNews();
    }
    _init=false;
    super.didChangeDependencies();
  }
  // void openlink(String url) {
  //   Future<void> _launchinBrowser(String url) async {
  //     if (await canLaunch(url)) {
  //       await launch(
  //         url,
  //         forceSafariVC: false,
  //         forceWebView: false,
  //         headers: <String, String>{'header_key': 'header_value'},
  //       );
  //     } else {
  //       throw 'Could not laucn $url';
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final loaddata=Provider.of<News>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Coronovirus Data'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: loaddata.newsList.length,
          itemBuilder: (ctx, index) {
            return InkWell(
              onTap: () {
                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (ctx) =>
                //       InfoScreen(loaddata.newsList[index].id[index].title, '${loaddata.newsList[index].id[index].url}'),
                // ));
              },
              child: Container(
                height: 260,
                child: Card(
                    child: Column(
                  children: <Widget>[
                    // Container(
                    //   height: 130,
                    //   width: double.infinity,
                    //   child: Image.network(
                    //    ' ${loaddata.newsList[index].id[index].image}',
                    //     fit: BoxFit.fill,
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    Text('${loaddata.newsList[index].id[index].title}'),
                    // Container(
                    //     padding: EdgeInsets.only(top: 10, right: 10, left: 10),
                    //     child: Text(
                    //       loaddata.newsList[index].id[index].title.toString(),
                    //       style: TextStyle(
                    //           fontSize: 20, fontWeight: FontWeight.bold),
                    //     )),
                  ],
                )),
              ),
            );
          }),
    );
  }
}
