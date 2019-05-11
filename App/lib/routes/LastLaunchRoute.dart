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
  NetworkAdapter _networkAdapter;
  LaunchDataModel _info;

  @override
  void initState() {
    super.initState();
    _networkAdapter = new NetworkAdapter(context);
    _initData();
  }

  void _initData() {
    var d = _networkAdapter.getLastLaunch(retryFunction: _initData);
    var tmp = (LaunchDataModel value) {
      setState(() {
        _info = value;
      });
    };

    d.then(tmp);
  }

  Widget _buildCompleteUi(LaunchDataModel model) {
    return LaunchViewWidget(model: model);
  }

  @override
  Widget build(BuildContext context) {
    Widget body = Center(child: CircularProgressIndicator());
    if (_info != null) {
      body = _buildCompleteUi(_info);
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(AppConstants.APPBAR_TITLE_LAST_LAUNCH),
        ),
        body: body);
  }
}
