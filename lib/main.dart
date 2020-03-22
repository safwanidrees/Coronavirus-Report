import 'package:api_data/provider/data.dart';
import 'package:api_data/provider/news.dart';
import 'package:api_data/provider/report.dart';
import 'package:api_data/screen/home.dart';
import 'package:api_data/screen/report_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      // FlutterStatusbarcolor.setStatusBarColor(Colors.white);
      // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(systemNavigationBarColor: Colors.black,statusBarColor: Colors.white,statusBarIconBrightness: Brightness.dark,statusBarBrightness: Brightness.dark));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Data(),
        ),
        ChangeNotifierProvider.value(
          value: News(),
        ),
        ChangeNotifierProvider.value(
          value: Report(),
        )
      ],
    
      child: MaterialApp(
        
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ReportScreen(),
      ),
    );
  }
}
