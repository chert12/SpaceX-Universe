import 'package:flutter/material.dart';

class CapsuleDataModel {
  CapsuleDataModel() {}

  String serial;
  String id;
  String status;
  DateTime launchDate;
  int landings;
  String type;
  String details;
  int reuseCount;
  List<CapsuleMissionsDateModel> missions;

  factory CapsuleDataModel.fromJson(Map<String, dynamic> json) {
    CapsuleDataModel result = new CapsuleDataModel();

    try {
      result.serial = json['capsule_serial'];
      result.id = json['capsule_id'];
      result.status = json['status'];
      if(json['original_launch'] != null) {
        result.launchDate = DateTime.parse(json['original_launch']);
      }
      result.landings = json['landings'];
      result.type = json['type'];
      result.details = json['details'];
      result.reuseCount = json['reuse_count'];
      result.missions =
          (json['missions'] as List).map((e) => new CapsuleMissionsDateModel
              .fromJson(e)).toList();
    }
    catch(e)
    {
      debugPrint(e);
    }

    return result;
  }
}

class CapsuleMissionsDateModel
{
  CapsuleMissionsDateModel() {}

  String name;
  int flight;

  factory CapsuleMissionsDateModel.fromJson(Map<String, dynamic> json) {
    CapsuleMissionsDateModel result = new CapsuleMissionsDateModel();

    result.name = json['name'];
    result.flight = json['flight'];

    return result;
  }
}
