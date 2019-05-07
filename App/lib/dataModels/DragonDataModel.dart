import 'package:flutter/material.dart';

class DragonDataModel {
  DragonDataModel() {}

  String id;
  String name;
  String type;
  bool isActive;
  int crewCapacity;
  int sideWallAngle;
  int orbitDuration;
  int dryMassKg;
  int dryMassLb;
  DateTime firstFlight;
  DragonHeatShieldDataModel heatShield;
  List<DragonThrusterDataModel> thrusters;
  double launchPayloadMassKg;
  double launchPayloadMassLb;
  double launchPayloadVolM; //cubic meters
  double launchPayloadVolF; // cubic feets
  double returnPayloadMassKg;
  double returnPayloadMassLb;
  double returnPayloadVolM; //cubic meters
  double returnPayloadVolF; // cubic feets
  DragonPressurizedCapsuleDataModel capsule;
  DragonTrunkDataModel trunk;
  double heightWithTrunkM; //meters
  double heightWithTrunkF; // feets
  double diameterM; //meters
  double diameterF; // feets
  List<String> flickrImages;
  String wikipediaLink;
  String description;

  factory DragonDataModel.fromJson(Map<String, dynamic> json) {
    DragonDataModel result = new DragonDataModel();

    try {
      result.id = json['id'];
      result.name = json['name'];
      result.type = json['type'];
      result.isActive = json['active'];
      result.crewCapacity = json['crew_capacity'];
      result.sideWallAngle = json['sidewall_angle_deg'];
      result.orbitDuration = json['orbit_duration_yr'];
      result.dryMassKg = json['dry_mass_kg'];
      result.dryMassLb = json['dry_mass_lb'];
      if (null != json['first_flight']) {
        result.firstFlight = DateTime.parse(json['first_flight']);
      }
      result.heatShield =
          DragonHeatShieldDataModel.fromJson(json['heat_shield']);
      result.thrusters = (json['thrusters'] as List)
          .map((e) => new DragonThrusterDataModel.fromJson(e))
          .toList();

      result.capsule = DragonPressurizedCapsuleDataModel.fromJson(
          json['pressurized_capsule']);
      result.trunk = DragonTrunkDataModel.fromJson(json['trunk']);
      result.flickrImages =
          (json['flickr_images'] as List<dynamic>).cast<String>();
      result.wikipediaLink = json['wikipedia'];
      result.description = json['description'];

      List launchPayloadMass =
          _parsePairedDoubleData(json['launch_payload_mass'], 'kg', 'lb');
      result.launchPayloadMassKg = launchPayloadMass[0];
      result.launchPayloadMassLb = launchPayloadMass[1];

      List launchPayloadVol = _parsePairedDoubleData(
          json['launch_payload_vol'], 'cubic_meters', 'cubic_feet');
      result.launchPayloadVolM = launchPayloadVol[0];
      result.launchPayloadVolF = launchPayloadVol[1];

      List returnPayloadMass =
          _parsePairedDoubleData(json['return_payload_mass'], 'kg', 'lb');
      result.returnPayloadMassKg = returnPayloadMass[0];
      result.returnPayloadMassKg = returnPayloadMass[1];

      List returnPayloadVol = _parsePairedDoubleData(
          json['return_payload_vol'], 'cubic_meters', 'cubic_feet');
      result.returnPayloadVolM = returnPayloadVol[0];
      result.returnPayloadVolF = returnPayloadVol[1];

      List heightWithTrunk =
          _parsePairedDoubleData(json['height_w_trunk'], 'meters', 'feet');
      result.heightWithTrunkM = heightWithTrunk[0];
      result.heightWithTrunkF = heightWithTrunk[1];

      List diameter =
          _parsePairedDoubleData(json['diameter'], 'meters', 'feet');
      result.diameterM = diameter[0];
      result.diameterF = diameter[1];
    } catch (e) {
      debugPrint(e);
    }

    return result;
  }
}

class DragonHeatShieldDataModel {
  DragonHeatShieldDataModel() {}

  String material;
  double sizeMeters;
  double temperature;
  String devPartner;

  factory DragonHeatShieldDataModel.fromJson(Map<String, dynamic> json) {
    DragonHeatShieldDataModel result = new DragonHeatShieldDataModel();

    num size = json['size_meters'] ?? 0;
    num temp = json['temp_degrees'] ?? 0;
    result.sizeMeters = size.toDouble();
    result.temperature = temp.toDouble();
    result.material = json['material'];
    result.devPartner = json['dev_partner'];

    return result;
  }
}

class DragonThrusterDataModel {
  DragonThrusterDataModel() {}

  String type;
  int amount;
  int pods;
  String fuel1;
  String fuel2;
  double thrustKn;
  double thrustLbf;

  factory DragonThrusterDataModel.fromJson(Map<String, dynamic> json) {
    DragonThrusterDataModel result = new DragonThrusterDataModel();

    result.type = json['type'];
    result.amount = json['amount'];
    result.pods = json['pods'];
    result.fuel1 = json['fuel_1'];
    result.fuel2 = json['fuel_2'];
    Map<String, dynamic> thrust = json['thrust'];
    num kN = thrust['kN'] ?? 0;
    num lbf = thrust['lbf'] ?? 0;
    result.thrustKn = kN.toDouble();
    result.thrustLbf = lbf.toDouble();

    return result;
  }
}

class DragonPressurizedCapsuleDataModel {
  DragonPressurizedCapsuleDataModel() {}

  double payloadVolM; //cubic meters
  double payloadVolF; // cubic feets

  factory DragonPressurizedCapsuleDataModel.fromJson(
      Map<String, dynamic> json) {
    var result = new DragonPressurizedCapsuleDataModel();

    List returnPayloadVol = _parsePairedDoubleData(
        json['payload_volume'], 'cubic_meters', 'cubic_feet');
    result.payloadVolM = returnPayloadVol[0];
    result.payloadVolF = returnPayloadVol[1];

    return result;
  }
}

class DragonTrunkDataModel {
  DragonTrunkDataModel() {}

  double trunkVolM; //cubic meters
  double trunkVolF; // cubic feets
  int solarArray;
  bool unpressurizedCargo;

  factory DragonTrunkDataModel.fromJson(Map<String, dynamic> json) {
    var result = new DragonTrunkDataModel();

    List returnPayloadVol = _parsePairedDoubleData(
        json['trunk_volume'], 'cubic_meters', 'cubic_feet');
    result.trunkVolM = returnPayloadVol[0];
    result.trunkVolF = returnPayloadVol[1];

    Map<String, dynamic> cargo = json['cargo'];
    result.solarArray = cargo['solar_array'];
    result.unpressurizedCargo = cargo['unpressurized_cargo'];

    return result;
  }
}

List _parsePairedDoubleData(
    Map<String, dynamic> json, String firstData, String secondData) {
  if (null == json || firstData.isEmpty || secondData.isEmpty) {
    return [0, 0];
  }
  num fv = json[firstData] ?? 0;
  num sv = json[secondData] ?? 0;
  return [fv.toDouble(), sv.toDouble()];
}