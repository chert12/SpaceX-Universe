class LandpadDataModel {
  LandpadDataModel() {}

  String id;
  String status;
  String fullName;
  String landingType;
  int attemptedLandings;
  int successfulLandings;
  String wikipedia;
  String details;
  LandpadLocationDataModel location;

  factory LandpadDataModel.fromJson(Map<String, dynamic> json) {
    var result = LandpadDataModel();

    result.id = json['id'];
    result.status = json['status'];
    result.fullName = json['full_name'];
    result.landingType = json['landing_type'];
    result.attemptedLandings = json['attempted_landings'];
    result.successfulLandings = json['successful_landings'];
    result.wikipedia = json['wikipedia'];
    result.details = json['details'];
    result.location = LandpadLocationDataModel.fromJson(json['location']);

    return result;
  }
}

class LandpadLocationDataModel {
  LandpadLocationDataModel() {}

  String name;
  String region;
  double latitude;
  double longitude;

  factory LandpadLocationDataModel.fromJson(Map<String, dynamic> json) {
    var result = LandpadLocationDataModel();

    result.name = json['name'];
    result.region = json['region'];
    num long = json['longitude'] ?? 0;
    num lat = json['latitude'] ?? 0;
    result.latitude = lat.toDouble();
    result.longitude = long.toDouble();

    return result;
  }
}
