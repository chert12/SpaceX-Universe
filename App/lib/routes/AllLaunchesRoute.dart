import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:spacex_universe/dataModels/LaunchDataModel.dart';
import 'package:spacex_universe/services/AppConstants.dart';
import 'package:spacex_universe/services/NetworkAdapter.dart';
import 'package:spacex_universe/services/Utilities.dart';

class AllLaunchesRoute extends StatefulWidget {
  AllLaunchesRoute({Key key}) : super(key: key);

  @override
  _AllLaunchesRouteState createState() => _AllLaunchesRouteState();
}

class _AllLaunchesRouteState extends State<AllLaunchesRoute> {
//  Future<LaunchDataModel> launchModel;
  NetworkAdapter networkAdapter;

//
  @override
  void initState() {
    super.initState();
    networkAdapter = new NetworkAdapter();
  }

  Widget _buildCompleteUi(LaunchesList model) {
    return ListView(
      children: <Widget>[
        _buildCard(model.launches[0]),
        _buildCard(model.launches[5])
      ],
    );
  }

  Widget _buildCard(LaunchDataModel model)
  {
    return Card(
      child: Row(
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: model.links.missionPatch,
            placeholder: (context, url) => new CircularProgressIndicator(),
            errorWidget: (context, url, error) => new Icon(Icons.error),
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.height,
          ),
        ],
      ),
    );
  }

  Widget _buildFutureBuilder(Future<LaunchesList> modelFuture) {
    return new FutureBuilder<LaunchesList>(
      future: modelFuture,
      builder: (BuildContext context, AsyncSnapshot<LaunchesList> snapshot) {
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
        body: _buildFutureBuilder(networkAdapter.getAllLaunches()));
  }
}
