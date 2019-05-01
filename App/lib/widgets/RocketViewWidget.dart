import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spacex_universe/dataModels/rocket/RocketDataModel.dart';
import 'package:spacex_universe/services/AppConstants.dart';
import 'package:spacex_universe/services/Utilities.dart';
import 'package:spacex_universe/widgets/FullscreenInfoViewElement.dart';

class RocketViewWidget extends FullscreenInfoViewElement {
  const RocketViewWidget({Key key, this.model}) : super(key: key);

  final RocketDataModel model;

  @override
  Widget build(BuildContext context) {
    return _buildCompleteUi(context);
  }

  Widget _buildCompleteUi(BuildContext context) {
    var w = List<Widget>();
    w.add(buildImage(model.images[0], model.rocketId, context));
    w.add(buildListTitle(model.rocketName.toString()));
    w.add(buildListElement("Rocket type", model.rocketType));
    w.add(buildListElement(
        "First flight:", DateFormat('dd MMMM yyyy').format(model.firstFlight)));
    w.add(buildListElement("Country:", model.country));
    w.add(buildListElement("Company:", model.company));
    w.add(buildListElement("Active", Utilities.boolToString(model.active)));
    w.add(buildListElement("Launch cost:", "${model.launchCost} \$"));
    w.add(buildListElement("Stages:", model.stages.toString()));
    w.add(buildListElement("Boosters:", model.boosters.toString()));
    w.add(buildListElement("Success rate:", "${model.successRate} %"));
    w.add(buildElementWithDescription("Description:", model.description));
    w.add(buildListTitle("Height"));
    w.add(buildListElement("Meters:", "${model.height.meters} m"));
    w.add(buildListElement("Feet:", "${model.height.feet} ft"));
    w.add(buildListTitle("Diameter"));
    w.add(buildListElement("Meters:", "${model.diameter.meters} m"));
    w.add(buildListElement("Feet:", "${model.diameter.feet} ft"));
    w.add(buildListTitle("Mass"));
    w.add(buildListElement("Kg:", "${model.mass.kg} kg"));
    w.add(buildListElement("Lb:", "${model.mass.lb} lb"));

    return ListView(children: w);
  }
}
