import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:intl/intl.dart';
import 'package:spacex_universe/dataModels/rocket/RocketDataModel.dart';
import 'package:spacex_universe/routes/SingleRocketRoute.dart';
import 'package:spacex_universe/services/Utilities.dart';
import 'package:spacex_universe/widgets/CommonCardView.dart';

class RocketCard extends CommonCardView {
  const RocketCard({Key key, this.model})
      : super(key: key);

  final RocketDataModel model;

  @override
  Widget build(BuildContext context) {
    return _buildCard(context);
  }

  Widget _buildCard(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Card(
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: buildImage(model.images[0], model.rocketId, context)
              ),
              Expanded(flex: 6, child: _buildCardText(context))
            ],
          ),
        ));
  }

  Widget _buildCardText(BuildContext context) {
    var w = List<Widget>();

    w.add(Padding(
      padding: EdgeInsets.only(bottom: 5),
        child: Text(
      model.rocketName,
      style: TextStyle(
          color: Colors.black87,
          fontFamily: "Roboto",
          fontWeight: FontWeight.bold,
          fontSize: 18),
    )));
    w.add(buildCardTextRow("First flight:", DateFormat('dd MMM yyyy').format(model.firstFlight)));
    w.add(buildCardTextRow("Active:", Utilities.boolToString(model.active)));
    FlutterMoneyFormatter fmf = FlutterMoneyFormatter(
        amount: model.launchCost.toDouble()
    );
    w.add(buildCardTextRow("Launch cost:", fmf.output.compactSymbolOnRight));
    w.add(buildCardTextRow("Stages:", model.stages.toString()));
    w.add(buildCardTextRow("Boosters:", model.boosters.toString()));
    w.add(RaisedButton(
      color: Colors.blue,
      textColor: Colors.white,
      onPressed: () =>
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SingleRocketRoute(
                      rocketModel: model,
                    )),
          ),
      child: Text("View full info"),
    ));

    return Padding(
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          children: w,
        ),
      ),
    );
  }

}
