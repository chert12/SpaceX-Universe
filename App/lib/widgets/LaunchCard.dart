import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spacex_universe/dataModels/launch/LaunchDataModel.dart';
import 'package:spacex_universe/routes/SingleLaunchRoute.dart';
import 'package:spacex_universe/services/AppConstants.dart';
import 'package:spacex_universe/services/Utilities.dart';

class LaunchCard extends StatelessWidget {
  const LaunchCard({Key key, this.model})
      : super(key: key);

  final LaunchDataModel model;

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
    res.children.add(_buildCardTextRow("Flight", "#${model.flightNumber}"));
    res.children.add(_buildCardTextRow("Launch date:",
        DateFormat('dd MMM yyyy \n kk:mm').format(model.launchDateLocal)));
    if (model.launchDateLocal.millisecondsSinceEpoch >
        DateTime
            .now()
            .millisecondsSinceEpoch) {
      res.children.add(_buildCardTextRow("Successful:", "Upcoming"));
    } else {
      res.children.add(_buildCardTextRow(
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
                child: _buildImage(context)
              ),
              Expanded(flex: 6, child: _buildCardText(model, context))
            ],
          ),
        ));
  }

  Widget _buildImage(BuildContext context) {
    if (null == model.links || null == model.links.missionPatch || model.links.missionPatch.isEmpty) {
      return Hero(
          tag: model.flightNumber,
          child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppConstants.ROCKET_IMAGE_PATH),
                      )))));
    } else {
      return Hero(
          tag: model.flightNumber,
          child: CachedNetworkImage(
            imageUrl: model.links.missionPatch,
            placeholder: (context, url) => new CircularProgressIndicator(),
            errorWidget: (context, url, error) => new Icon(Icons.error),
          ));
    }
  }
  
  Widget _buildCardTextRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
              color: Colors.black87,
              fontFamily: "Roboto",
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        Text(
          value,
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          style: TextStyle(
              color: Colors.black38, fontFamily: "Roboto", fontSize: 16),
        ),
      ],
    );
  }
}
