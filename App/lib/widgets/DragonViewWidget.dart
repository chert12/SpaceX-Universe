import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spacex_universe/dataModels/CapsuleDataModel.dart';
import 'package:spacex_universe/dataModels/DragonDataModel.dart';
import 'package:spacex_universe/services/Utilities.dart';
import 'package:spacex_universe/widgets/FullscreenInfoViewElement.dart';

class DragonViewWidget extends FullscreenInfoViewElement {
  final DragonDataModel model;

  const DragonViewWidget({Key key, this.model}) : super(key: key);

  Widget build(BuildContext context) {
    return _buildDragon(context);
  }

  Widget _buildDragon(BuildContext context) {
    var w = List<Widget>();
    w.add(buildUrlImage(model.flickrImages[0], model.id, context));
    w.add(buildListElement("ID", model.id));
    w.add(buildListElement(
        "First flight:", DateFormat('dd MMMM yyyy').format(model.firstFlight)));
    w.add(buildListElement("Type:", model.type));
    w.add(buildListElement("Active", Utilities.boolToString(model.isActive)));

    w.add(buildListElement("Crew capacity:", model.crewCapacity.toString()));
    w.add(buildListElement("Sidewall angle:", "${model.sideWallAngle} degrees"));
    w.add(buildListElement("Orbit duration:", "${model.orbitDuration} years"));
    w.add(buildElementWithDescription("Description:", model.description));

    w.add(buildListTitle("Heat shield"));
    w.add(buildListElement("Material:", model.heatShield.material));
    w.add(buildListElement("Size:", "${model.heatShield.sizeMeters} m"));
    w.add(buildListElement("Temperature:", "${model.heatShield.temperature}°"));
    w.add(buildListElement("Development partner:", model.heatShield.devPartner));

    if(model.thrusters != null)
      {
        model.thrusters.forEach((t) => {
          w.add(buildListTitle("Thruster #${model.thrusters.indexOf(t)}")),
    w.add(buildListElement("Type:", t.type)),
    w.add(buildListElement("Amount:", t.amount.toString())),
    w.add(buildListElement("Pods:", t.pods.toString())),
    w.add(buildListElement("Fuel 1:", t.fuel1)),
    w.add(buildListElement("Fuel 2:", t.fuel2)),
    w.add(buildListElement("Thrust:", "${t.thrustKn} kn/${t.thrustLbf} lbf")),
        });
      }

    w.add(buildImageGallery(model.flickrImages, context));

    return ListView(children: w);
  }
}
