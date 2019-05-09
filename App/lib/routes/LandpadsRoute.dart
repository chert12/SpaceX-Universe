import 'package:flutter/material.dart';
import 'package:spacex_universe/dataModels/CapsuleDataModel.dart';
import 'package:spacex_universe/dataModels/LandpadDataModel.dart';
import 'package:spacex_universe/dataModels/LaunchpadDataModel.dart';
import 'package:spacex_universe/dataModels/companyInfo/CompanyInfoDataModel.dart';
import 'package:spacex_universe/dataModels/rocket/RocketDataModel.dart';
import 'package:spacex_universe/services/AppConstants.dart';
import 'package:spacex_universe/services/NetworkAdapter.dart';
import 'package:spacex_universe/widgets/AboutSpacexWidget.dart';
import 'package:spacex_universe/widgets/CapsulesViewWidget.dart';
import 'package:spacex_universe/widgets/LandpadViewWidget.dart';
import 'package:spacex_universe/widgets/LaunchpadViewWidget.dart';
import 'package:spacex_universe/widgets/RocketCard.dart';

class LandpadsRoute extends StatefulWidget {
  LandpadsRoute({Key key}) : super(key: key);

  @override
  _LandpadsState createState() => _LandpadsState();
}

class _LandpadsState extends State<LandpadsRoute> {
  List<LandpadDataModel> _models;

  @override
  void initState() {
    super.initState();
    var networkAdapter = new NetworkAdapter();

    var d = networkAdapter.getAllLandpads();
    var tmp = (List<LandpadDataModel> value) {
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
      body = LandpadViewWidget(models: _models);
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(AppConstants.APPBAR_TITLE_LANDPADS),
        ),
        body: body);
  }


}
