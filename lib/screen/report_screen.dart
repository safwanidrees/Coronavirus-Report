import 'package:api_data/provider/report.dart';
import 'package:api_data/widget/report_global_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../widget/report_widget.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final report = Provider.of<Report>(context);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          // backgroundColor: Colors.white,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: <Color>[
                  Colors.blue,
                  Color.fromARGB(255, 42, 56, 124)
                ])),
          ),
          title: Text(
            'Coronovirus Report',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Container(height: 500, child: ReportWidget()),
              Text(
                'Globally',
                style: TextStyle(
                    fontSize: 25, color: Color.fromARGB(255, 42, 56, 124)),
              ),
              Container(height: 400, child: ReportGlobalWidget()),
            ],
          ),
        ));
  }
}
