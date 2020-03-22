import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ReportModel {
  final int total_cases;
  final int total_recovered;
  final int total_unresolved;
  final int total_deaths;
  final int total_new_cases_today;
  final int total_new_deaths_today;
  final int total_active_cases;
  final int total_serious_cases;

  ReportModel({
    @required this.total_cases,
    @required this.total_recovered,
    @required this.total_unresolved,
    @required this.total_deaths,
    @required this.total_new_cases_today,
    @required this.total_new_deaths_today,
    @required this.total_active_cases,
    @required this.total_serious_cases,
  });
}

class Report with ChangeNotifier {
  ReportModel reportModel;
  ReportModel global;

  List<ReportModel> _reportList = [];
  List<ReportModel> get reportList {
    return [..._reportList];
  }

  Future<void> getGlobally() async {
    final url = 'https://thevirustracker.com/free-api?global=stats';

    try {
      final responce = await http.get(url);
      ReportModel globballyreport;
      final getReport = json.decode(responce.body) as Map<String, dynamic>;
      if (reportModel == null && getReport['results'] == null) {
        return null;
      }

      getReport['results'].forEach((element) {
        global = ReportModel(
          total_cases: element['total_cases'],
          total_recovered: element['total_recovered'],
          total_unresolved: element['total_unresolved'],
          total_deaths: element['total_deaths'],
          total_new_cases_today: element['total_new_cases_today'],
          total_new_deaths_today: element['total_new_deaths_today'],
          total_active_cases: element['total_active_cases'],
          total_serious_cases: element['total_serious_cases'],
        );

        print(global.total_active_cases);

        notifyListeners();
      });
    } catch (error) {
      throw error;
    }
  }

  Future<void> getReport(String countryCode) async {
    final url =
        'https://thevirustracker.com/free-api?countryTotal=$countryCode';

    try {
      final responce = await http.get(url);
      ReportModel dummyreport;
      final getReport = json.decode(responce.body) as Map<String, dynamic>;

      if (reportModel == null && getReport['countrydata'] == null) {
        return null;
      }

      getReport['countrydata'].forEach((element) {
        reportModel = ReportModel(
          total_cases: element['total_cases'],
          total_recovered: element['total_recovered'],
          total_unresolved: element['total_unresolved'],
          total_deaths: element['total_deaths'],
          total_new_cases_today: element['total_new_cases_today'],
          total_new_deaths_today: element['total_new_deaths_today'],
          total_active_cases: element['total_active_cases'],
          total_serious_cases: element['total_serious_cases'],
        );

        print(reportModel.total_active_cases);

        notifyListeners();
      });
      // final responce = await http.get(url);
      // final List<ReportModel> report = [];
      // final getReport = json.decode(responce.body) as Map<String, dynamic>;
      // if (getReport == null) {
      //     return null;
      //   }
      // getReport['countrydata'].forEach((element) {

      //  ReportModel reportModel= ReportModel(
      //     total_cases: element['total_cases'],
      //     total_recovered: element['total_recovered'],
      //     total_unresolved: element['total_unresolved'],
      //     total_deaths: element['total_deaths'],
      //     total_new_cases_today: element['total_new_cases_today'],
      //     total_new_deaths_today: element['total_new_deaths_today'],
      //     total_active_cases: element['total_active_cases'],
      //     total_serious_cases: element['total_serious_cases'],

      //   );
      //   print(reportModel.total_active_cases);
      //     report.add(reportModel);
      //     _reportList=report;
      // notifyListeners();
      // });
    } catch (error) {
      throw error;
    }
  }
}
