import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:spacex_universe/dataModels/CapsuleDataModel.dart';
import 'package:spacex_universe/dataModels/DragonDataModel.dart';
import 'package:spacex_universe/dataModels/LandpadDataModel.dart';
import 'package:spacex_universe/dataModels/LaunchpadDataModel.dart';
import 'package:spacex_universe/dataModels/companyInfo/CompanyInfoDataModel.dart';
import 'package:spacex_universe/dataModels/history/HistoryDataModel.dart';
import 'package:spacex_universe/dataModels/launch/LaunchDataModel.dart';
import 'package:spacex_universe/dataModels/rocket/RocketDataModel.dart';
import 'package:spacex_universe/services/AppConstants.dart';

class NetworkAdapter {
  BuildContext _buildContext;

  NetworkAdapter(BuildContext context) {
    _buildContext = context;
  }

  Future<LaunchDataModel> getLastLaunch({Function retryFunction}) async {
    try {
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
    } on SocketException catch (_) {
      _noInternetConnectionDialog(retryFunction);
    }
  }

  Future<CompanyInfoDataModel> getCompanyInfo({Function retryFunction}) async {
    try {
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
    } on SocketException catch (_) {
      _noInternetConnectionDialog(retryFunction);
    }
  }

  Future<List<LaunchDataModel>> getAllLaunches({Function retryFunction}) async {
    try {
      final response = await http.get(AppConstants.SERVER_ULR +
          AppConstants.API_VERSION +
          AppConstants.API_GET_ALL_LAUNCHES);

      if (response.statusCode == 200) {
        // If server returns an OK response, parse the JSON;
        try {
          var js = json.decode(response.body);
          return (js as List)
              .map((e) => new LaunchDataModel.fromJson(e))
              .toList();
        } catch (e) {
          debugPrint(e);
        }
        return new List<LaunchDataModel>();
      } else {
        throw Exception('Failed to load post');
      }
    } on SocketException catch (_) {
      _noInternetConnectionDialog(retryFunction);
    }
  }

  Future<List<RocketDataModel>> getAllRockets({Function retryFunction}) async {
    try {
      final response = await http.get(AppConstants.SERVER_ULR +
          AppConstants.API_VERSION +
          AppConstants.API_GET_ALL_ROCKETS);

      if (response.statusCode == 200) {
        try {
          var js = json.decode(response.body);
          return (js as List)
              .map((e) => new RocketDataModel.fromJson(e))
              .toList();
        } catch (e) {
          debugPrint(e);
        }
        return new List<RocketDataModel>();
      } else {
        throw Exception('Failed to load post');
      }
    } on SocketException catch (_) {
      _noInternetConnectionDialog(retryFunction);
    }
  }

  Future<List<HistoryDataModel>> getAllHistoryEvents(
      {Function retryFunction}) async {
    try {
      final response = await http.get(AppConstants.SERVER_ULR +
          AppConstants.API_VERSION +
          AppConstants.API_GET_HISTORY);

      if (response.statusCode == 200) {
        try {
          var js = json.decode(response.body);
          return (js as List)
              .map((e) => new HistoryDataModel.fromJson(e))
              .toList();
        } catch (e) {
          debugPrint(e);
        }
        return new List<HistoryDataModel>();
      } else {
        debugPrint(response.statusCode.toString());
        //throw Exception('Failed to load post');
      }
    } on SocketException catch (_) {
      _noInternetConnectionDialog(getAllHistoryEvents);
    }
  }

  Future<List<CapsuleDataModel>> getAllCapsules(
      {Function retryFunction}) async {
    try {
      final response = await http.get(AppConstants.SERVER_ULR +
          AppConstants.API_VERSION +
          AppConstants.API_GET_ALL_CAPSULES);

      if (response.statusCode == 200) {
        try {
          var js = json.decode(response.body);
          return (js as List)
              .map((e) => new CapsuleDataModel.fromJson(e))
              .toList();
        } catch (e) {
          debugPrint(e);
        }
        return new List<CapsuleDataModel>();
      } else {
        throw Exception('Failed to load post');
      }
    } on SocketException catch (_) {
      _noInternetConnectionDialog(retryFunction);
    }
  }

  Future<List<DragonDataModel>> getAllDragons({Function retryFunction}) async {
    try {
      final response = await http.get(AppConstants.SERVER_ULR +
          AppConstants.API_VERSION +
          AppConstants.API_GET_ALL_DRAGONS);

      if (response.statusCode == 200) {
        try {
          var js = json.decode(response.body);
          return (js as List)
              .map((e) => new DragonDataModel.fromJson(e))
              .toList();
        } catch (e) {
          debugPrint(e);
        }
        return new List<DragonDataModel>();
      } else {
        throw Exception('Failed to load post');
      }
    } on SocketException catch (_) {
      _noInternetConnectionDialog(retryFunction);
    }
  }

  Future<List<LaunchpadDataModel>> getAllLaunchPads(
      {Function retryFunction}) async {
    try {
      final response = await http.get(AppConstants.SERVER_ULR +
          AppConstants.API_VERSION +
          AppConstants.API_GET_ALL_LAUNCHPADS);

      if (response.statusCode == 200) {
        try {
          var js = json.decode(response.body);
          return (js as List)
              .map((e) => new LaunchpadDataModel.fromJson(e))
              .toList();
        } catch (e) {
          debugPrint(e);
        }
        return new List<LaunchpadDataModel>();
      } else {
        throw Exception('Failed to load post');
      }
    } on SocketException catch (_) {
      _noInternetConnectionDialog(retryFunction);
    }
  }

  Future<List<LandpadDataModel>> getAllLandpads(
      {Function retryFunction}) async {
    try {
      final response = await http.get(AppConstants.SERVER_ULR +
          AppConstants.API_VERSION +
          AppConstants.API_GET_ALL_LANDPADS);

      if (response.statusCode == 200) {
        try {
          var js = json.decode(response.body);
          return (js as List)
              .map((e) => new LandpadDataModel.fromJson(e))
              .toList();
        } catch (e) {
          debugPrint(e);
        }
        return new List<LandpadDataModel>();
      } else {
        throw Exception('Failed to load post');
      }
    } on SocketException catch (_) {
      _noInternetConnectionDialog(retryFunction);
    }
  }

  void _noInternetConnectionDialog(Function retryFunc) {
    // flutter defined function
    showDialog(
      context: _buildContext,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return WillPopScope(
            onWillPop: () {},
            child: AlertDialog(
              title: new Text("Error"),
              content: new Text(AppConstants.NO_INTERNET_CONNECTION),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                new FlatButton(
                  child: new Text("Retry"),
                  onPressed: () {
                    Navigator.pop(_buildContext);
                    if (null != retryFunc) {
                      retryFunc();
                    }
                  },
                ),
              ],
            ));
      },
    );
  }
}
