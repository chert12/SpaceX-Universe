import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
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
    w.add(buildUrlImage(model.images[0], model.rocketId, context));
    w.add(buildListTitle(model.rocketName.toString()));
    w.add(buildListElement("Rocket type", model.rocketType));
    w.add(buildListElement(
        "First flight:", DateFormat('dd MMMM yyyy').format(model.firstFlight)));
    w.add(buildListElement("Country:", model.country));
    w.add(buildListElement("Company:", model.company));
    w.add(buildListElement("Active", Utilities.boolToString(model.active)));
    FlutterMoneyFormatter fmf = FlutterMoneyFormatter(
        amount: model.launchCost.toDouble()
    );
    w.add(buildListElement("Launch cost:", fmf.output.compactSymbolOnRight));
    w.add(buildListElement("Stages:", model.stages.toString()));
    w.add(buildListElement("Boosters:", model.boosters.toString()));
    w.add(buildListElement("Success rate:", "${model.successRate} %"));
    w.add(buildElementWithDescription("Description:", model.description));
    if(null != model.height) {
      w.add(buildListTitle("Height"));
      w.add(buildListElement("Meters:", "${model.height.meters} m"));
      w.add(buildListElement("Feet:", "${model.height.feet} ft"));
    }
    if(null != model.diameter) {
      w.add(buildListTitle("Diameter"));
      w.add(buildListElement("Meters:", "${model.diameter.meters} m"));
      w.add(buildListElement("Feet:", "${model.diameter.feet} ft"));
    }
    if(null != model.mass) {
      w.add(buildListTitle("Mass"));
      w.add(buildListElement("Kg:", "${model.mass.kg} kg"));
      w.add(buildListElement("Lb:", "${model.mass.lb} lb"));
    }
    if(null != model.payloads && model.payloads.length > 0)
      {
        model.payloads.forEach((p) =>
        {
          w.add(buildListTitle("Payload #${model.payloads.indexOf(p)}")),
          w.add(buildListElement("Orbit:", p.name)),
          w.add(buildListElement("Mass:", p.massToString()))
        });
      }
    if(null != model.firstStage)
      {
        var f = model.firstStage;
        w.add(buildListTitle("First stage"));
        w.add(buildListElement("Reusable:", Utilities.boolToString(f.reusable)));
        w.add(buildListElement("Engines:", f.engines.toString()));
        w.add(buildListElement("Fuel amount:", "${f.fuelAmount} tons"));
        w.add(buildListElement("Burn time:", "${f.burnTime} sec"));
      }
    if(null != model.secondStage)
    {
    var s = model.secondStage;
    w.add(buildListTitle("Second stage"));
    w.add(buildListElement("Reusable:", Utilities.boolToString(s.reusable)));
    w.add(buildListElement("Engines:", s.engines.toString()));
    w.add(buildListElement("Fuel amount:", "${s.fuelAmount} tons"));
    w.add(buildListElement("Burn time:", "${s.burnTime} sec"));
    if(null != s.payloads.option_1 && s.payloads.option_1.isNotEmpty)
      {
        w.add(buildListElement("Payload #1", s.payloads.option_1));
      }
    if(null != s.payloads.option_2 && s.payloads.option_2.isNotEmpty)
    {
    w.add(buildListElement("Payload #2", s.payloads.option_2));
    }
  }

    if(null != model.engines)
      {
        var e = model.engines;
        w.add(buildListTitle("Engines"));
        w.add(buildListElement("Count:", e.count.toString()));
        w.add(buildListElement("Type:", e.type));
        w.add(buildListElement("Version:", e.version));
        w.add(buildListElement("Fisrt propellant:", e.propellant_1));
        w.add(buildListElement("Second propellant:", e.propellant_2));
      }

    w.add(buildListTitle("Other"));
    w.add(buildListElement("Landing legs:", model.landingLegs.toString()));
    w.add(buildImageGallery(model.images, context));

    return ListView(children: w);
  }
}
