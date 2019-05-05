import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:spacex_universe/dataModels/CapsuleDataModel.dart';
import 'package:spacex_universe/dataModels/companyInfo/CompanyInfoDataModel.dart';
import 'package:spacex_universe/dataModels/history/HistoryDataModel.dart';
import 'package:spacex_universe/dataModels/launch/LaunchDataModel.dart';
import 'package:spacex_universe/dataModels/rocket/RocketDataModel.dart';
import 'package:spacex_universe/services/AppConstants.dart';

class NetworkAdapter {
  Future<LaunchDataModel> getLastLaunch() async {
    final response = await http.get(AppConstants.SERVER_ULR +
        AppConstants.API_VERSION +
        AppConstants.API_GET_LAST_LAUNCH);

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      return LaunchDataModel.fromJson(json.decode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<CompanyInfoDataModel> getCompanyInfo() async {
    final response = await http.get(AppConstants.SERVER_ULR +
        AppConstants.API_VERSION +
        AppConstants.API_GET_COMPANY_INFO);

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      return CompanyInfoDataModel.fromJson(json.decode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<List<LaunchDataModel>> getAllLaunches() async {
    final response = await http.get(AppConstants.SERVER_ULR +
        AppConstants.API_VERSION +
        AppConstants.API_GET_ALL_LAUNCHES);

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON;
      try {
        var js = json.decode(response.body);
        return (js as List).map((e) => new LaunchDataModel.fromJson(e)).toList();
      } catch (e) {
        debugPrint(e);
      }
      return new List<LaunchDataModel>();
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<List<RocketDataModel>> getAllRockets() async {
    final response = await http.get(AppConstants.SERVER_ULR +
        AppConstants.API_VERSION +
        AppConstants.API_GET_ALL_ROCKETS);

    if (response.statusCode == 200) {
      try {
        var js = json.decode(response.body);
        return (js as List).map((e) => new RocketDataModel.fromJson(e)).toList();
      } catch (e) {
        debugPrint(e);
      }
      return new List<RocketDataModel>();
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<List<HistoryDataModel>> getAllHistoryEvents() async {
    final response = await http.get(AppConstants.SERVER_ULR +
        AppConstants.API_VERSION +
        AppConstants.API_GET_HISTORY);

    if (response.statusCode == 200) {
      try {
        var js = json.decode(response.body);
        return (js as List).map((e) => new HistoryDataModel.fromJson(e)).toList();
      } catch (e) {
        debugPrint(e);
      }
      return new List<HistoryDataModel>();
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<List<CapsuleDataModel>> getAllCapsules() async {
    final response = await http.get(AppConstants.SERVER_ULR +
        AppConstants.API_VERSION +
        AppConstants.API_GET_ALL_CAPSULES);

    if (response.statusCode == 200) {
      try {
        var js = json.decode(response.body);
        return (js as List).map((e) => new CapsuleDataModel.fromJson(e)).toList();
      } catch (e) {
        debugPrint(e);
      }
      return new List<CapsuleDataModel>();
    } else {
      throw Exception('Failed to load post');
    }
  }

}
