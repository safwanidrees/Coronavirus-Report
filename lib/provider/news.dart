import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../provider/data.dart';

class NewsModel {
  final List<DataItem> id;

  NewsModel({@required this.id});
}

class News with ChangeNotifier {
  List<NewsModel> _newsList = [];
  List<NewsModel> get newsList {
    return [..._newsList];
  }

  Future<void> fetchNews() async {
    final url = "https://thevirustracker.com/free-api?countryTotal=PK";
    final responce = await http.get(url);
    List<NewsModel> newsdata = [];
    final getnews = json.decode(responce.body) as Map<String, dynamic>;
    if (responce == null) {
      return null;
    }
    getnews['countrynewsitems'].forEach((element) {
      NewsModel newsModel = NewsModel(
          id: (element).forEach((item) {
        DataItem(
          newsid: item['newsid'],
          title: item['title'],
          image: item['image'],
          time: item['time'],
          url: item['url'],
        );
      })
          // id: (element as List<dynamic>)
          //     .map(
          //       (item) => DataItem(
          //         newsid: item['newsid'],
          //         title: item['title'],
          //         image: item['image'],
          //         time: item['time'],
          //         url: item['url'],
          //       ),
          //     )
          //     .toList(),
          );

      newsdata.add(newsModel);
    });
    print(newsdata.toList());
    _newsList = newsdata;
    notifyListeners();
  }
}
