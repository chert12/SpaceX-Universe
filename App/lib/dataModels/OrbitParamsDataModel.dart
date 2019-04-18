class OrbitParamsDataModel {
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
    if (json.containsKey('epoch') && json['epoch'] != null) {
      result.epoch = DateTime.parse(json['epoch']);
    }

    num longitude = json['longitude'] ?? 0;
    num semiMajorAxisKm = json['semi_major_axis_km'] ?? 0;
    num eccentricity = json['eccentricity'] ?? 0;
    num periapsisKm = json['periapsis_km'] ?? 0;
    num apoapsisKm = json['apoapsis_km'] ?? 0;
    num inclinationDeg = json['inclination_deg'] ?? 0;
    num periodMin = json['period_min'] ?? 0;
    num lifespanYears = json['lifespan_years'] ?? 0;
    num meanMotion = json['mean_motion'] ?? 0;
    num raan = json['raan'] ?? 0;
    num argOfPericenter = json['arg_of_pericenter'] ?? 0;
    num meanAnomaly = json['mean_anomaly'] ?? 0;

    result.longitude = longitude.toDouble();
    result.semiMajorAxisKm = semiMajorAxisKm.toDouble();
    result.eccentricity = eccentricity.toDouble();
    result.periapsisKm = periapsisKm.toDouble();
    result.apoapsisKm = apoapsisKm.toDouble();
    result.inclinationDeg = inclinationDeg.toDouble();
    result.periodMin = periodMin.toDouble();
    result.lifespanYears = lifespanYears.toDouble();
    result.meanMotion = meanMotion.toDouble();
    result.raan = raan.toDouble();
    result.argOfPericenter = argOfPericenter.toDouble();
    result.meanAnomaly = meanAnomaly.toDouble();

    return result;
  }
}
