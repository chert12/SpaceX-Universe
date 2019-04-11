import 'package:spacex_universe/dataModels/OrbitParamsDataModel.dart';

class RocketDataModel {
  RocketDataModel();

  String rocketId;
  String rocketName;
  String rocketType;
  FirstStageDataModel firstStage;

  factory RocketDataModel.fromJson(Map<String, dynamic> json) {
    RocketDataModel result = new RocketDataModel();

    result.rocketId = json['rocket_id'];
    result.rocketName = json['rocket_name'];
    result.rocketType = json['rocket_type'];
    result.firstStage = FirstStageDataModel.fromJson(json['first_stage']);

    return result;
  }
}

class FirstStageDataModel
{
  FirstStageDataModel();
  List<RocketCoreDataModel> cores;

  factory FirstStageDataModel.fromJson(Map<String, dynamic> json) {
    FirstStageDataModel result = new FirstStageDataModel();

    result.cores = (json['cores'] as List<dynamic>).cast<RocketCoreDataModel>();

    return result;
  }
}

class SecondStageDataModel
{
  SecondStageDataModel();
  int block;
  List<RocketPayloadDataModel> payloads;
  var fairings;

  factory SecondStageDataModel.fromJson(Map<String, dynamic> json) {
    SecondStageDataModel result = new SecondStageDataModel();

    result.block = json['block'];
    result.payloads = (json['payloads'] as List<dynamic>).cast<RocketPayloadDataModel>();
    result.fairings = json['fairings'];

    return result;
  }
}

class RocketCoreDataModel
{

  RocketCoreDataModel();

  String coreSerial;
  int flight;
  int block;
  bool gridfins;
  bool legs;
  bool reused;
  bool landSuccess;
  bool landingIntent;
  String landingType;
  String landingVehicle;

  factory RocketCoreDataModel.fromJson(Map<String, dynamic> json) {
    RocketCoreDataModel result = new RocketCoreDataModel();

    result.coreSerial = json['rocket_id'];
    result.flight = json['rocket_name'];
    result.block = json['rocket_type'];
    result.gridfins = json['rocket_type'];
    result.legs = json['rocket_type'];
    result.reused = json['rocket_type'];
    result.landSuccess = json['rocket_type'];
    result.landingIntent = json['rocket_type'];
    result.landingType = json['rocket_type'];
    result.landingVehicle = json['rocket_type'];

    return result;
  }
}

class RocketPayloadDataModel
{
  RocketPayloadDataModel();

  String payloadId;
  List<int> noradIds;
  String capSerial;
  bool reused;
  List<String> customers;
  String nationality;
  String manufacturer;
  String payloadType;
  double payloadMassKg;
  double payloadMassLbs;
  String orbit;
  OrbitParamsDataModel orbitParams;
  double massReturnedKg;
  double massReturnedLbs;
  int flightTimeSec;
  var cargoManifest;

  factory RocketPayloadDataModel.fromJson(Map<String, dynamic> json) {
    RocketPayloadDataModel result = new RocketPayloadDataModel();

    result.payloadId = json['payload_id'];
    result.noradIds = (json['norad_id'] as List<dynamic>).cast<int>();
    result.capSerial = json['cap_serial'];
    result.reused = json['reused'];
    result.customers = (json['norad_id'] as List<dynamic>).cast<String>();
    result.nationality = json['nationality'];
    result.manufacturer = json['manufacturer'];
    result.payloadType = json['payload_type'];
    result.payloadMassKg = json['payload_mass_kg'];
    result.payloadMassLbs = json['payload_mass_lbs'];
    result.orbit = json['orbit'];
    result.orbitParams = OrbitParamsDataModel.fromJson(json['orbit_params']);
    result.massReturnedKg = json['mass_returned_kg'];
    result.massReturnedLbs = json['mass_returned_lbs'];
    result.flightTimeSec = json['flight_time_sec'];
    result.cargoManifest = json['cargo_manifest'];

    return result;
  }
}


