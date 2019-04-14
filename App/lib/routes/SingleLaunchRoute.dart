import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:spacex_universe/dataModels/launch/LaunchDataModel.dart';
import 'package:spacex_universe/services/AppConstants.dart';
import 'package:spacex_universe/services/NetworkAdapter.dart';
import 'package:spacex_universe/services/Utilities.dart';
import 'package:spacex_universe/widgets/LaunchViewWidget.dart';

class SingleLaunchRoute extends StatefulWidget {
  SingleLaunchRoute({Key key,  this.launchModel}) : super(key: key);

  LaunchDataModel launchModel;

  @override
  _SingleLaunchRouteState createState() => _SingleLaunchRouteState(launchModel);
}

class _SingleLaunchRouteState extends State<SingleLaunchRoute> {

  final LaunchDataModel launchModel;

  _SingleLaunchRouteState(this.launchModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(launchModel.missionName),
        ),
        body: LaunchViewWidget(model: launchModel,));
  }
}
