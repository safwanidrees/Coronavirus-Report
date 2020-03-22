import 'package:flutter/material.dart';
import '../provider/report.dart';
import 'package:provider/provider.dart';

class ReportWidget extends StatefulWidget {
  @override
  _ReportWidgetState createState() => _ReportWidgetState();
}

class _ReportWidgetState extends State<ReportWidget> {
  var _country = [
    'Pakistan',
    'India',
    'USA',
    'Bangladesh',
    'Iran',
    'China',
    'Italy',
  ];

  var _selectedCountry = 'Pakistan';
  var _code = 'PK';
  var _isloading = true;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    switch (_selectedCountry) {
      case 'Pakistan':
        {
          _code = 'PK';
        }
        break;
      case 'India':
        {
          _code = 'IN';
        }
        break;
      case 'USA':
        {
          _code = 'US';
        }
        break;
      case 'Bangladesh':
        {
          _code = 'BD';
        }
        break;
      case 'Iran':
        {
          _code = 'IR';
        }
        break;
      case 'China':
        {
          _code = 'CN';
        }
        break;
      case 'Italy':
        {
          _code = 'IT';
        }
        break;
    }
    // if (_selectedCountry == 'Pakistan') {
    //   _code = 'PK';
    // }
    // if (_selectedCountry == 'India') {
    //   _code = 'IN';
    // }

    Provider.of<Report>(context).getReport(_code).then((_) {
      setState(() {
        _isloading = false;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // final report = Provider.of<Report>(context);

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

    return Column(
      children: <Widget>[
        DropdownButton<String>(
          iconEnabledColor: Color.fromARGB(255, 42, 56, 124),
          iconDisabledColor: Colors.deepOrangeAccent,
          iconSize: 40,
          items: _country.map((String dropDownStringItem) {
            return DropdownMenuItem<String>(
              value: dropDownStringItem,
              child: Container(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  dropDownStringItem,
                  style: TextStyle(
                      fontSize: 25, color: Color.fromARGB(255, 42, 56, 124)),
                ),
              ),
            );
          }).toList(),
          onChanged: (String newValue) {
            setState(() {
              _isloading = true;
              this._selectedCountry = newValue;
            });
          },
          value: _selectedCountry,
        ),
        Text(_selectedCountry),
        _isloading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<Report>(
                builder: (ctx, report, child) => Container(
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
                                  report.reportModel.total_cases.toString(),
                                  Color(0xff1877F2),
                                  'Infected',
                                  report.reportModel.total_deaths.toString(),
                                  Color(0xffFB3938),
                                  'Deaths'),
                              SizedBox(
                                height: 20,
                              ),
                              rowData(
                                  report.reportModel.total_recovered.toString(),
                                  Color(0xff3AA969),
                                  'Recovered',
                                  report.reportModel.total_unresolved
                                      .toString(),
                                  Color(0xff9191AC),
                                  'Unresolved'),
                              SizedBox(
                                height: 20,
                              ),
                              rowData(
                                  report.reportModel.total_active_cases
                                      .toString(),
                                  Color(0xff1877F2),
                                  'Active Cases',
                                  report.reportModel.total_new_cases_today
                                      .toString(),
                                  Color(0xffFB3938),
                                  'Cases Today'),
                              SizedBox(
                                height: 20,
                              ),
                              rowData(
                                  report.reportModel.total_new_deaths_today
                                      .toString(),
                                  Colors.orange,
                                  'Deaths Today',
                                  report.reportModel.total_serious_cases
                                      .toString(),
                                  Color(0xffFB3938),
                                  'Serious Cases'),
                            ],
                          )),
                    )),
      ],
    );
  }
}
