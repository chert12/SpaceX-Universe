import 'package:flutter/material.dart';
import 'package:spacex_universe/dataModels/rocket/RocketDataModel.dart';
import 'package:spacex_universe/widgets/RocketViewWidget.dart';

class SingleRocketRoute extends StatefulWidget {
  SingleRocketRoute({Key key,  this.rocketModel}) : super(key: key);

  final RocketDataModel rocketModel;

  @override
  _SingleRocketRouteState createState() => _SingleRocketRouteState(rocketModel);
}

class _SingleRocketRouteState extends State<SingleRocketRoute> {

  final RocketDataModel rocketModel;

  _SingleRocketRouteState(this.rocketModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(rocketModel.rocketName),
        ),
        //body: LaunchViewWidget(model: launchModel,));
        body: RocketViewWidget(model: rocketModel));
  }
}
