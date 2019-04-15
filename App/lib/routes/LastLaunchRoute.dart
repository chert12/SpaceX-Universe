import 'package:flutter/material.dart';
import 'package:spacex_universe/dataModels/launch/LaunchDataModel.dart';
import 'package:spacex_universe/services/AppConstants.dart';
import 'package:spacex_universe/services/NetworkAdapter.dart';
import 'package:spacex_universe/widgets/LaunchViewWidget.dart';

class LastLaunchRoute extends StatefulWidget {
  LastLaunchRoute({Key key}) : super(key: key);

  @override
  _LastLaunchRouteState createState() => _LastLaunchRouteState();
}

class _LastLaunchRouteState extends State<LastLaunchRoute> {
  NetworkAdapter networkAdapter;

//
  @override
  void initState() {
    super.initState();
    networkAdapter = new NetworkAdapter();
  }

  Widget _buildCompleteUi(LaunchDataModel model) {
    return LaunchViewWidget(model:model);
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
