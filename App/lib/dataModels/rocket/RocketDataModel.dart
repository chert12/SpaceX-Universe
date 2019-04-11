class RocketDataModel {
  RocketDataModel();

  int id;
  bool active;
  int stages;
  int boosters;
  double launchCost;
  double successRate;
  DateTime firstFlight;
  String country;
  String company;
  RocketHeightDataModel height;
  RocketDiameterDataModel diameter;
  RocketMassDataModel mass;
  List<RocketPayloadDataModel> payloads;
  RocketStageDataModel firstStage;
  RocketStageDataModel secondStage;
  RocketEnginesDataModel engines;
  List<String> images;
  String wikipedia;
  String description;
  String rocketId;
  String rocketName;
  String rocketType;

  factory RocketDataModel.fromJson(Map<String, dynamic> json) {
    RocketDataModel result = new RocketDataModel();

    result.id = json['id'];
    result.active = json['active'];
    result.stages = json['stages'];
    result.boosters = json['boosters'];
    result.launchCost = json['cost_per_launch'];
    result.successRate = json['success_rate_pct'];
    result.successRate = json['first_flight'];
    if(json.containsKey('first_flight') && json['first_flight'] != null) {
      result.firstFlight =DateTime.parse(json['first_flight']);
    }
    result.country = json['country'];
    result.company = json['company'];
    result.height = RocketHeightDataModel.fromJson(json['height']);
    result.diameter = RocketDiameterDataModel.fromJson(json['diameter']);
    result.mass = RocketMassDataModel.fromJson(json['mass']);
    result.payloads = (json['payload_weights'] as List<dynamic>).cast<RocketPayloadDataModel>();
    result.firstStage = RocketStageDataModel.fromJson(json['first_stage']);
    result.secondStage = RocketStageDataModel.fromJson(json['second_stage']);
    result.engines = RocketEnginesDataModel.fromJson(json['engines']);
    result.images = (json['flickr_images'] as List<dynamic>).cast<String>();
    result.wikipedia = json['wikipedia'];
    result.description = json['description'];
    result.rocketId = json['rocket_id'];
    result.rocketName = json['rocket_name'];
    result.rocketType = json['rocket_type'];

    return result;
  }
}

class RocketHeightDataModel
{
  RocketHeightDataModel();

  double meters;
  double feet;

  factory RocketHeightDataModel.fromJson(Map<String, dynamic> json) {
    RocketHeightDataModel result = new RocketHeightDataModel();

    result.meters = json['meters'];
    result.feet = json['feet'];

    return result;
  }

  String toString()
  {
    return "$meters meters/ $feet feet";
  }
}

class RocketDiameterDataModel
{
  RocketDiameterDataModel();

  double meters;
  double feet;

  factory RocketDiameterDataModel.fromJson(Map<String, dynamic> json) {
    RocketDiameterDataModel result = new RocketDiameterDataModel();

    result.meters = json['meters'];
    result.feet = json['feet'];

    return result;
  }

  String toString()
  {
    return "$meters meters/ $feet feet";
  }
}

class RocketMassDataModel
{
  RocketMassDataModel();

  double kg;
  double lb;

  factory RocketMassDataModel.fromJson(Map<String, dynamic> json) {
    RocketMassDataModel result = new RocketMassDataModel();

    result.kg = json['kg'];
    result.lb = json['lb'];

    return result;
  }

  String toString()
  {
    return "$kg kg/ $lb lb";
  }
}

class RocketPayloadDataModel
{
  RocketPayloadDataModel();

  String id;
  String name;
  double kg;
  double lb;

  factory RocketPayloadDataModel.fromJson(Map<String, dynamic> json) {
    RocketPayloadDataModel result = new RocketPayloadDataModel();

    result.id = json['id'];
    result.name = json['name'];
    result.kg = json['kg'];
    result.lb = json['lb'];

    return result;
  }

  String massToString()
  {
    return "$kg kg/ $lb lb";
  }
}

class RocketStageDataModel
{
  RocketStageDataModel();
  bool reusable;
  int engines;
  double fuelAmount; // tons
  double burnTime; //sec
  List<RocketStagePayloadDataModel> payloads;

  factory RocketStageDataModel.fromJson(Map<String, dynamic> json) {
    RocketStageDataModel result = new RocketStageDataModel();

    result.reusable = json['reusable'];
    result.engines = json['engines'];
    result.fuelAmount = json['fuel_amount_tons'];
    result.burnTime = json['burn_time_sec'];
    if(json.containsKey('payloads')) {
      result.payloads = (json['payloads'] as List<dynamic>).cast<
          RocketStagePayloadDataModel>();
    }

    return result;
  }
}

class RocketStagePayloadDataModel {
  RocketStagePayloadDataModel();

  String option_1;
  String option_2;

  factory RocketStagePayloadDataModel.fromJson(Map<String, dynamic> json) {
    RocketStagePayloadDataModel result = new RocketStagePayloadDataModel();

    if (json.containsKey('option_1') && json['option_1'] != null) {
      result.option_1 = json['option_1'];
    }
    if (json.containsKey('option_2') && json['option_2'] != null) {
      result.option_2 = json['option_2'];
    }

    return result;
  }
}

class RocketEnginesDataModel
{
  RocketEnginesDataModel();
  int count;
  String type;
  String version;
  String propellant_1;
  String propellant_2;

  factory RocketEnginesDataModel.fromJson(Map<String, dynamic> json) {
    RocketEnginesDataModel result = new RocketEnginesDataModel();

    result.count = json['number'];
    result.type = json['type'];
    result.version = json['version'];
    result.propellant_1 = json['propellant_1'];
    result.propellant_2 = json['propellant_2'];

    return result;
  }

}
