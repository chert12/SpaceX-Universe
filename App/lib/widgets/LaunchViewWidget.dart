import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spacex_universe/dataModels/launch/LaunchDataModel.dart';
import 'package:spacex_universe/services/Utilities.dart';

class LaunchViewWidget extends StatelessWidget {
  const LaunchViewWidget({Key key, this.model}) : super(key: key);

  final LaunchDataModel model;

  Widget build(BuildContext context) {
    return _buildCompleteUi(model, context);
  }

  Widget _buildCompleteUi(LaunchDataModel model, BuildContext context) {
    return ListView(
      children: <Widget>[
        Hero(
            tag: model.flightNumber,
            child:
            CachedNetworkImage(
              imageUrl: model.links.missionPatch,
              placeholder: (context, url) => new CircularProgressIndicator(),
              errorWidget: (context, url, error) => new Icon(Icons.error),
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.3,
            )),
        _buildListElement("Flight number", model.flightNumber.toString()),
        _buildListElement("Mission name", model.missionName),
        _buildElementWithDescription("Description", model.details),
        _buildListElement(
            "Launch date",
            DateFormat('dd MMMM yyyy - kk:mm')
                .format(model.launchDateLocal)),
        _buildListElement(
            "Success", Utilities.boolToString(model.launchSuccess)),
      ],
    );
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
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
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
