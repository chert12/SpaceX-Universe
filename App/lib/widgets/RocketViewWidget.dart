import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spacex_universe/dataModels/rocket/RocketDataModel.dart';
import 'package:spacex_universe/services/AppConstants.dart';
import 'package:spacex_universe/services/Utilities.dart';

class RocketViewWidget extends StatelessWidget {
  const RocketViewWidget({Key key, this.model}) : super(key: key);

  final RocketDataModel model;

  Widget build(BuildContext context) {
    return _buildCompleteUi(context);
  }

  Widget _buildCompleteUi(BuildContext context) {
    var w = List<Widget>();
    w.add(_buildImage(context));
    w.add(_buildListElement(
        model.rocketName.toString(), ""));
    w.add(_buildListElement("Rocket type", model.rocketType));
    w.add(_buildListElement("First flight:",
        DateFormat('dd MMMM yyyy').format(model.firstFlight)));
    w.add(_buildListElement(
        "Active", Utilities.boolToString(model.active)));
    w.add(_buildElementWithDescription("Description:", model.description));


    return ListView(children: w);
  }

  Widget _buildImage(BuildContext context) {
    if (null == model.images) {
      return Hero(
          tag: model.rocketId,
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
          tag: model.rocketId,
          child: CachedNetworkImage(
            imageUrl: model.images[0],
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
