class LaunchpadDataModel {
  LaunchpadDataModel() {}

  int id;
  String status;
  int attemptedLaunches;
  int successfulLaunches;
  String wikipedia;
  String details;
  String siteId;
  String siteNameLong;
  List<String> launchedVehicles;
  LaunchpadLocationDataModel location;

  factory LaunchpadDataModel.fromJson(Map<String, dynamic> json) {
    var result = LaunchpadDataModel();

    result.id = json['id'];
    result.status = json['status'];
    result.attemptedLaunches = json['attempted_launches'];
    result.successfulLaunches = json['successful_launches'];
    result.wikipedia = json['wikipedia'];
    result.details = json['details'];
    result.siteId = json['site_id'];
    result.siteNameLong = json['site_name_long'];
    result.launchedVehicles = (json['vehicles_launched'] as List<dynamic>).cast<String>();
    result.location = LaunchpadLocationDataModel.fromJson(json['location']);


    return result;
  }
}

class LaunchpadLocationDataModel {
  LaunchpadLocationDataModel() {}

  String name;
  String region;
  double latitude;
  double longitude;

  factory LaunchpadLocationDataModel.fromJson(Map<String, dynamic> json) {
    var result = LaunchpadLocationDataModel();

    result.name = json['name'];
    result.region = json['region'];
    num long = json['longitude'] ?? 0;
    num lat = json['latitude'] ?? 0;
    result.latitude = lat.toDouble();
    result.longitude = long.toDouble();

    return result;
  }
}
