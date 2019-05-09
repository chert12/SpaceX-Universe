import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spacex_universe/dataModels/CapsuleDataModel.dart';
import 'package:spacex_universe/dataModels/LandpadDataModel.dart';
import 'package:spacex_universe/dataModels/LaunchpadDataModel.dart';
import 'package:spacex_universe/services/Utilities.dart';
import 'package:spacex_universe/widgets/FullscreenInfoViewElement.dart';

class LandpadViewWidget extends FullscreenInfoViewElement {
  final List<LandpadDataModel> models;

  const LandpadViewWidget({Key key, this.models}) : super(key: key);

  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext ctxt, int index) => _buildPad(ctxt, index),
      itemCount: models.length,
    );
  }

  Widget _buildPad(BuildContext context, int index) {
    var pad = models[index];
    var w = List<Widget>();
    w.add(buildListElement("Full name:", pad.fullName));
    w.add(buildListElement("Status:", pad.status));
    w.add(buildListElement("Site ID:", pad.id.toString()));
    w.add(buildListElement("Attempted launches:", pad.attemptedLandings.toString()));
    w.add(buildListElement("Successful launches:", pad.successfulLandings.toString()));
    w.add(buildListElement("Landing type:", pad.landingType));
    w.add(buildListElement("Location:", "${pad.location.name},${pad.location.region}"));
    w.add(buildLinkElement("Wikipedia:", pad.wikipedia, context));
    w.add(buildLinkElement("Map:", Utilities.createMapsUrl(pad.location.latitude, pad.location.longitude), context));
    w.add(Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          pad.details,
          style: new TextStyle(
              fontStyle: FontStyle.italic, fontSize: 16, color: Colors.black54),
          textAlign: TextAlign.center,
        )));


    return ExpansionTile(title: Text(pad.location.name), children: w);
  }
}
