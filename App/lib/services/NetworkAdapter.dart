import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:spacex_universe/dataModels/LaunchDataModel.dart';
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

  Future<LaunchesList> getAllLaunches() async {
    final response = await http.get(AppConstants.SERVER_ULR +
        AppConstants.API_VERSION +
        AppConstants.API_GET_ALL_LAUNCHES);

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON;
      LaunchesList res = null;
      try {
        //Iterable l = json.decode(response.body);
        res = LaunchesList.fromJson(json.decode(response.body));
        //res = (json.decode(response.body) as List).map((e) => new LaunchDataModel.fromJson(e)).toList();
        //res = (json.decode(response.body) as List<dynamic>).cast<LaunchDataModel>();
      } catch (e) {
        debugPrint(e);
      }
      return res;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
