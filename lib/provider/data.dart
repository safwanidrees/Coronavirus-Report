import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

class DataItem {
  final String id;
  final String newsid;
  final int title;
  final String image;
  final String time;
  final String url;

  DataItem({
    @required this.id,
    @required this.newsid,
    @required this.title,
    @required this.image,
    @required this.time,
    @required this.url,
  });

  // factory DataItem.fromJson(Map<String, dynamic> json) {
  //   return DataItem(
  //       newsid: json['newsid'],
  //       title: json['title'],
  //       image: json['description'],
  //       time: json['price'],
  //       url: json['isFavourite']);
  // }
}

class Data with ChangeNotifier {
  List<DataItem> _datalist = [];

  List<DataItem> get datalist {
    return [..._datalist];
  }

  Future<void> fetchdata() async {
    final url = "https://thevirustracker.com/free-api?countryTotal=PK";
    try {
      final responce = await http.get(url);
      List<DataItem> loadeddata = [];
      final extractedData = json.decode(responce.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return null;
      }
      // print(extractedData['countrynewsitems']);
      // print(json.decode(responce.body));
      // final dt=extractedData['countrynewsitems'] as List<dynamic>;
      // print(dt);
      // loadeddata.add(
      //  extractedData.forEach((prodId,element){
      // (element['countrynewsitems'] as List<dynamic>).map((item)=>DataItem(),
      //  }).toList(),
      // );

      extractedData['countrynewsitems'].forEach((element) {
        DataItem data = DataItem(
           
            newsid: element['newsid'],
            title: element['title'],
            image: element['image'],
            time: element['time'],
            url: element['url']);
        print(data.title);
        loadeddata.add(data);
        _datalist = loadeddata;
        notifyListeners();
      });
    } catch (error) {
      throw error;
    }
  }
}

// class Data with ChangeNotifier {
//   List<DataItem> _datalist = [];
//   List<DataItem> list;

//   List<DataItem> get data {
//     return [..._datalist];
//   }

//   Future<void> productAdd(DataItem dataItem) async {
//     // const url = 'https://thevirustracker.com/free-api?countryTotal=PK';

//     String link =
//           "https://thevirustracker.com/free-api?countryTotal=PK";
//     var res = await http
//         .get(Uri.encodeFull(link), headers: {"Accept": "application/json"});
//     print(res.body);
//       if (res.statusCode == 200) {
//         var data = json.decode(res.body);
//         var rest = data["countrynewsitems"] as List;
//         print(rest);
//         list = rest.map<DataItem>((json) => DataItem.fromJson(json)).toList();
//       }
//     print("List Size: ${list.length}");
//     return list;

//     // try {
//     //   final responce = await http.get(url);
//     //   final extractedData = json.decode(responce.body) as Map<String, dynamic>;
//     //   final List<DataItem> loadedData = [];
//     //   if (extractedData == null) {
//     //     return null;
//     //   }
//     //   extractedData.forEach((prodId, prodData) {
//     //     loadedData.add(
//     //       DataItem(
//     //         newsid: prodData['newsid'],
//     //         title: prodData['title'],
//     //         image: prodData['description'],
//     //         time: prodData['price'],
//     //         url: prodData['isFavourite'],
//     //       ),
//     //     );
//     //   });

//     //   _datalist = loadedData;
//     //   notifyListeners();
//     // } catch (error) {
//     //   throw error;
//     // }
//   }
// }
