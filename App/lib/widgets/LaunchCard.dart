import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spacex_universe/dataModels/launch/LaunchDataModel.dart';
import 'package:spacex_universe/routes/SingleLaunchRoute.dart';
import 'package:spacex_universe/services/AppConstants.dart';
import 'package:spacex_universe/services/Utilities.dart';
import 'package:spacex_universe/widgets/CommonCardView.dart';

class LaunchCard extends CommonCardView {
  const LaunchCard({Key key, this.model})
      : super(key: key);

  final LaunchDataModel model;

  @override
  Widget build(BuildContext context) {
    return _buildCard(model, context);
  }

  Widget _buildCardText(LaunchDataModel model, BuildContext context) {
    var res = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          model.missionName,
          style: TextStyle(
              color: Colors.black,
              fontFamily: "Roboto",
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
      ],
    );
    res.children.add(buildCardTextRow("Flight", "#${model.flightNumber}"));
    res.children.add(buildCardTextRow("Launch date:",
        DateFormat('dd MMM yyyy').format(model.launchDateLocal)));
    if (model.launchDateLocal.millisecondsSinceEpoch >
        DateTime
            .now()
            .millisecondsSinceEpoch || model.launchSuccess == null) {
      res.children.add(buildCardTextRow("Successful:", "Upcoming"));
    } else {
      res.children.add(buildCardTextRow(
          "Successful:", Utilities.boolToString(model.launchSuccess)));
    }
    res.children.add(RaisedButton(
      color: Colors.blue,
      textColor: Colors.white,
      onPressed: () =>
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SingleLaunchRoute(
                      launchModel: model,
                    )),
          ),
      child: Text("View full info"),
    ));
    return Padding(
      padding: EdgeInsets.all(10),
      child: res,
    );
  }

  Widget _buildCard(LaunchDataModel model, BuildContext context) {
    return Padding(
        padding: new EdgeInsets.all(10),
        child: Card(
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: buildImage(model.links.missionPatch, model.flightNumber.toString(), context)
              ),
              Expanded(flex: 6, child: _buildCardText(model, context))
            ],
          ),
        ));
  }
}
