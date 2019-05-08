import 'package:flutter/material.dart';
import 'package:spacex_universe/dataModels/CapsuleDataModel.dart';
import 'package:spacex_universe/dataModels/LaunchpadDataModel.dart';
import 'package:spacex_universe/dataModels/companyInfo/CompanyInfoDataModel.dart';
import 'package:spacex_universe/dataModels/rocket/RocketDataModel.dart';
import 'package:spacex_universe/services/AppConstants.dart';
import 'package:spacex_universe/services/NetworkAdapter.dart';
import 'package:spacex_universe/widgets/AboutSpacexWidget.dart';
import 'package:spacex_universe/widgets/CapsulesViewWidget.dart';
import 'package:spacex_universe/widgets/LaunchpadViewWidget.dart';
import 'package:spacex_universe/widgets/RocketCard.dart';

class LaunchpadsRoute extends StatefulWidget {
  LaunchpadsRoute({Key key}) : super(key: key);

  @override
  _LaunchpadsState createState() => _LaunchpadsState();
}

class _LaunchpadsState extends State<LaunchpadsRoute> {
  List<LaunchpadDataModel> _models;

  @override
  void initState() {
    super.initState();
    var networkAdapter = new NetworkAdapter();

    var d = networkAdapter.getAllLaunchPads();
    var tmp = (List<LaunchpadDataModel> value) {
      setState(() {
        _models = value;
      });
    };

    d.then(tmp);
  }

  @override
  Widget build(BuildContext context) {
    Widget body = Center(child: CircularProgressIndicator());
    if (_models != null) {
      body = LaunchpadViewWidget(models: _models);
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(AppConstants.APPBAR_TITLE_LAUNCHPADS),
        ),
        body: body);
  }


}
