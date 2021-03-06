import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spacex_universe/dataModels/CapsuleDataModel.dart';
import 'package:spacex_universe/dataModels/LaunchpadDataModel.dart';
import 'package:spacex_universe/services/Utilities.dart';
import 'package:spacex_universe/widgets/FullscreenInfoViewElement.dart';

class LaunchpadViewWidget extends FullscreenInfoViewElement {
  final List<LaunchpadDataModel> models;

  const LaunchpadViewWidget({Key key, this.models}) : super(key: key);

  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext ctxt, int index) => _buildPad(ctxt, index),
      itemCount: models.length,
    );
  }

  Widget _buildPad(BuildContext context, int index) {
    var pad = models[index];
    var w = List<Widget>();
    w.add(buildListElement("Full name:", pad.siteNameLong));
    w.add(buildListElement("Status:", pad.status));
    w.add(buildListElement("Attempted launches:", pad.attemptedLaunches.toString()));
    w.add(buildListElement("Successful launches:", pad.successfulLaunches.toString()));
    w.add(buildListElement("Site ID:", pad.siteId));
    w.add(buildListElement("Location:", "${pad.location.name},${pad.location.region}"));
    var s = "";
    pad.launchedVehicles.forEach((e) => s += "$e\n");
    w.add(buildListElement("Launched vehicles:", s));
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
