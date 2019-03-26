import 'package:spacex_universe/dataModels/RocketDataModel.dart';

class LaunchDataModel{

  LaunchDataModel();

  int flightNumber;
  String missionName;
  List<String> missionIds;
  String launchYear;
  DateTime launchDateUnix;
  DateTime launchDateLocal;
  bool isTentative;
  String tentativeMaxPrecision;
  bool tbd;
  int launchWindow;
  RocketDataModel rocket;

  factory LaunchDataModel.fromJson(Map<String, dynamic> json) {
    LaunchDataModel result = new LaunchDataModel();

    result.flightNumber = json['flight_number'];
    result.missionName = json['mission_name'];
    result.missionIds = (json['mission_id'] as List<dynamic>).cast<String>();
    result.launchYear = json['launch_year'];
    result.launchDateUnix = new DateTime.fromMillisecondsSinceEpoch(json['launch_date_unix']);
    result.launchDateLocal = DateTime.parse(json['launch_date_local']);
    result.isTentative = json['is_tentative'];
    result.tentativeMaxPrecision = json['tentative_max_precision'];
    result.tbd = json['tbd'];
    result.launchWindow = json['launch_window'];
    result.rocket = RocketDataModel.fromJson(json['rocket']);

    return result;
  }
}