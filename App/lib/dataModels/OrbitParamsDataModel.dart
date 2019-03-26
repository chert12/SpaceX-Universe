class OrbitParamsDataModel
{
  OrbitParamsDataModel();

  String referenceSystem;
  String regime;
  double longitude;
  double semiMajorAxisKm;
  double eccentricity;
  double periapsisKm;
  double apoapsisKm;
  double inclinationDeg;
  double periodMin;
  double lifespanYears;
  DateTime epoch;
  double meanMotion;
  double raan;
  double argOfPericenter;
  double meanAnomaly;

  factory OrbitParamsDataModel.fromJson(Map<String, dynamic> json) {
    OrbitParamsDataModel result = new OrbitParamsDataModel();

    result.referenceSystem = json['reference_system'];
    result.regime = json['regime'];
    result.longitude = json['longitude'];
    result.semiMajorAxisKm = json['semi_major_axis_km'];
    result.eccentricity = json['eccentricity'];
    result.periapsisKm = json['periapsis_km'];
    result.apoapsisKm = json['apoapsis_km'];
    result.inclinationDeg = json['inclination_deg'];
    result.periodMin = json['period_min'];
    result.lifespanYears = json['lifespan_years'];
    result.epoch = json['epoch'];
    result.meanMotion = json['mean_motion'];
    result.raan = json['raan'];
    result.argOfPericenter = json['arg_of_pericenter'];
    result.meanAnomaly = json['mean_anomaly'];

    return result;
  }

}