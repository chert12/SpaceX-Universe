import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spacex_universe/dataModels/LaunchDataModel.dart';
import 'package:spacex_universe/services/AppConstants.dart';

class NetworkAdapter {
  Future<LaunchDataModel> getLastLaunch() async {
    final response =
    await http.get(AppConstants.API_GET_LAST_LAUNCH);

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      return LaunchDataModel.fromJson(json.decode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
