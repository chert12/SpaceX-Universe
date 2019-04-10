import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:spacex_universe/dataModels/LaunchDataModel.dart';
import 'package:spacex_universe/services/AppConstants.dart';
import 'package:spacex_universe/services/NetworkAdapter.dart';
import 'package:spacex_universe/services/Utilities.dart';

class LastLaunchRoute extends StatefulWidget {
  LastLaunchRoute({Key key}) : super(key: key);

  @override
  _LastLaunchRouteState createState() => _LastLaunchRouteState();
}

class _LastLaunchRouteState extends State<LastLaunchRoute> {
//  Future<LaunchDataModel> launchModel;
  NetworkAdapter networkAdapter;

//
  @override
  void initState() {
    super.initState();
    networkAdapter = new NetworkAdapter();
  }

  Widget _buildCompleteUi(LaunchDataModel model) {
    return ListView(
      children: <Widget>[
        CachedNetworkImage(
          imageUrl: model.links.missionPatch,
          placeholder: (context, url) => new CircularProgressIndicator(),
          errorWidget: (context, url, error) => new Icon(Icons.error),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.3,
        ),
        _buildListElement("Flight number", model.flightNumber.toString()),
        _buildListElement("Mission name", model.missionName),
        _buildElementWithDescription("Description", model.details),
        _buildListElement("Launch date", DateFormat('dd MMMM yyyy - kk:mm').format(model.launchDateLocal)),
        _buildListElement("Success", Utilities.boolToString(model.launchSuccess)),
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
                style: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
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

  Widget _buildFutureBuilder(Future<LaunchDataModel> modelFuture) {
    return new FutureBuilder<LaunchDataModel>(
      future: modelFuture,
      builder: (BuildContext context, AsyncSnapshot<LaunchDataModel> snapshot) {
        if (snapshot.hasData) {
          return _buildCompleteUi(snapshot.data);
        } else {
          return new Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppConstants.APPBAR_TITLE_LAST_LAUNCH),
        ),
        body: _buildFutureBuilder(networkAdapter.getLastLaunch()));
  }
}
