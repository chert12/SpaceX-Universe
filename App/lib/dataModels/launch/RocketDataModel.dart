import 'package:spacex_universe/dataModels/OrbitParamsDataModel.dart';

class RocketDataModel {
  RocketDataModel();

  String rocketId;
  String rocketName;
  String rocketType;
  FirstStageDataModel firstStage;
  SecondStageDataModel secondStage;

  factory RocketDataModel.fromJson(Map<String, dynamic> json) {
    RocketDataModel result = new RocketDataModel();

    result.rocketId = json['rocket_id'];
    result.rocketName = json['rocket_name'];
    result.rocketType = json['rocket_type'];
    result.firstStage = FirstStageDataModel.fromJson(json['first_stage']);
    result.secondStage = SecondStageDataModel.fromJson(json['second_stage']);

    return result;
  }
}

class FirstStageDataModel
{
  FirstStageDataModel();
  List<RocketCoreDataModel> cores;

  factory FirstStageDataModel.fromJson(Map<String, dynamic> json) {
    FirstStageDataModel result = new FirstStageDataModel();

    //result.cores = (json['cores'] as List<dynamic>).cast<RocketCoreDataModel>();
    result.cores = (json['cores'] as List).map((e) => new RocketCoreDataModel.fromJson(e)).toList();

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
    result.payloads = (json['payloads'] as List).map((e) => new RocketPayloadDataModel.fromJson(e)).toList();
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

    result.coreSerial = json['core_serial'];
    result.flight = json['flight'];
    result.block = json['block'];
    result.gridfins = json['gridfins'];
    result.legs = json['legs'];
    result.reused = json['reused'];
    result.landSuccess = json['land_success'];
    result.landingIntent = json['landing_intent'];
    result.landingType = json['landing_type'];
    result.landingVehicle = json['landing_vehicle'];

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

    var tmpListNorad = json['norad_id'];
    result.noradIds = new List<int>.from(tmpListNorad);

    var tmpListCustomer = json['customers'];
    result.customers = new List<String>.from(tmpListCustomer);

    result.capSerial = json['cap_serial'];
    result.reused = json['reused'];
    result.nationality = json['nationality'];
    result.manufacturer = json['manufacturer'];
    result.payloadType = json['payload_type'];

    num payloadMassKg = json['payload_mass_kg'] ?? 0;
    num payloadMassLbs = json['payload_mass_lbs'] ?? 0;
    num massReturnedKg = json['mass_returned_kg'] ?? 0;
    num massReturnedLbs = json['mass_returned_lbs'] ?? 0;
    result.payloadMassKg = payloadMassKg.toDouble();
    result.payloadMassLbs = payloadMassLbs.toDouble();
    result.massReturnedKg = massReturnedKg.toDouble();
    result.massReturnedLbs = massReturnedLbs.toDouble();

    result.orbit = json['orbit'];
    result.orbitParams = OrbitParamsDataModel.fromJson(json['orbit_params']);
    result.flightTimeSec = json['flight_time_sec'];
    result.cargoManifest = json['cargo_manifest'];

    return result;
  }
}


