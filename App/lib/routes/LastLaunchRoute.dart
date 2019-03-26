import 'package:flutter/material.dart';
import 'package:spacex_universe/services/AppConstants.dart';

class LastLaunchRoute extends StatefulWidget {
  LastLaunchRoute({Key key}) : super(key: key);

  @override
  _LastLaunchRouteState createState() => _LastLaunchRouteState();
}

class _LastLaunchRouteState extends State<LastLaunchRoute> {
//  Future<LaunchDataModel> launchModel;
//
//  @override
//  void initState() {
//    super.initState();
//    NetworkAdapter a = new NetworkAdapter();
//    launchModel = a.getLastLaunch();
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstants.APPBAR_TITLE_LAST_LAUNCH),
      ),
      body: Column(
        children: <Widget>[
          Image.network(
            'https://farm8.staticflickr.com/7899/39684491043_f0289164bd_o.jpg',
          ),
          Text('SpaceX')
        ],
      ),
    );
  }
}
