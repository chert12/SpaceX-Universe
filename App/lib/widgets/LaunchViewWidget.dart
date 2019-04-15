import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spacex_universe/dataModels/launch/LaunchDataModel.dart';
import 'package:spacex_universe/services/AppConstants.dart';
import 'package:spacex_universe/services/Utilities.dart';

class LaunchViewWidget extends StatelessWidget {
  const LaunchViewWidget({Key key, this.model}) : super(key: key);

  final LaunchDataModel model;

  Widget build(BuildContext context) {
    return _buildCompleteUi(context);
  }

  Widget _buildCompleteUi(BuildContext context) {
    var w = List<Widget>();
    w.add(_buildImage(context));
    w.add(_buildListElement(
        "Flight number", "#${model.flightNumber.toString()}"));
    w.add(_buildListElement("Mission name", model.missionName));
    w.add(_buildElementWithDescription("Description", model.details));
    w.add(_buildListElement("Launch date",
        DateFormat('dd MMMM yyyy - kk:mm').format(model.launchDateLocal)));
    w.add(_buildListElement(
        "Success", Utilities.boolToString(model.launchSuccess)));

    return ListView(children: w);
  }

  Widget _buildImage(BuildContext context) {
    if (null == model.links.missionPatch) {
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
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
          ));
    }
  }

  Widget _buildListElement(String title, String value) {
    return new Padding(
      padding: new EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              Text(
                value,
                style: TextStyle(color: Colors.black38, fontSize: 16),
              ),
            ],
          ),
          new Padding(
              padding: new EdgeInsets.only(top: 7),
              child: Container(height: 2.0, color: Colors.black12))
        ],
      ),
    );
  }

  Widget _buildElementWithDescription(String description, String text) {
    if (text == null) {
      text = "";
    }
    return new Padding(
      padding: new EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                description,
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              new Padding(
                  padding: new EdgeInsets.only(top: 5),
                  child: Text(
                    text,
                    style: TextStyle(color: Colors.black, fontSize: 13),
                  ))
            ],
          ),
          new Padding(
              padding: new EdgeInsets.only(top: 7),
              child: Container(height: 2.0, color: Colors.black12))
        ],
      ),
    );
  }
}
