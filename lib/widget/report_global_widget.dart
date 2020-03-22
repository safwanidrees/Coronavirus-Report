import 'package:flutter/material.dart';
import '../provider/report.dart';
import 'package:provider/provider.dart';

class ReportGlobalWidget extends StatefulWidget {
  @override
  _ReportGlobalWidgetState createState() => _ReportGlobalWidgetState();
}

class _ReportGlobalWidgetState extends State<ReportGlobalWidget> {
  var _isloading = true;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    Provider.of<Report>(context).getGlobally().then((_) {
      setState(() {
        _isloading = false;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final reportGlobal = Provider.of<Report>(context);

    Widget dataText(String title, Color color) {
      return Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 26,
          color: color,
        ),
      );
    }

    Widget titleText(String title) {
      return Text(title,
          style:
              TextStyle(fontSize: 22, color: Color.fromARGB(255, 42, 56, 124)));
    }

    Widget rowData(String data1, Color colordata1, String title1, String data2,
        Color colordata2, String title2) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Column(
            children: <Widget>[
              dataText(data1, colordata1),
              SizedBox(
                height: 10,
              ),
              titleText(title1)
            ],
          ),
          Column(
            children: <Widget>[
              dataText(data2, colordata2),
              SizedBox(
                height: 10,
              ),
              titleText(title2),
            ],
          ),
        ],
      );
    }

    return _isloading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            padding: EdgeInsets.all(10),
            height: 400,
            child: Card(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    rowData(
                        reportGlobal.global.total_cases.toString(),
                        Color(0xff1877F2),
                        'Infected',
                        reportGlobal.global.total_deaths.toString(),
                        Color(0xffFB3938),
                        'Deaths'),
                    SizedBox(
                      height: 20,
                    ),
                    rowData(
                        reportGlobal.global.total_recovered.toString(),
                        Color(0xff3AA969),
                        'Recovered',
                        reportGlobal.global.total_unresolved.toString(),
                        Color(0xff9191AC),
                        'Unresolved'),
                    SizedBox(
                      height: 20,
                    ),
                    rowData(
                        reportGlobal.global.total_active_cases.toString(),
                        Color(0xff1877F2),
                        'Active Cases',
                        reportGlobal.global.total_new_cases_today.toString(),
                        Color(0xffFB3938),
                        'Cases Today'),
                    SizedBox(
                      height: 20,
                    ),
                    rowData(
                        reportGlobal.global.total_new_deaths_today.toString(),
                        Colors.orange,
                        'Deaths Today',
                        reportGlobal.global.total_serious_cases.toString(),
                        Color(0xffFB3938),
                        'Serious Cases'),
                  ],
                )),
          );
  }
}
