import 'package:flutter/material.dart';
import 'package:spacex_universe/dataModels/CapsuleDataModel.dart';
import 'package:spacex_universe/dataModels/companyInfo/CompanyInfoDataModel.dart';
import 'package:spacex_universe/dataModels/rocket/RocketDataModel.dart';
import 'package:spacex_universe/services/AppConstants.dart';
import 'package:spacex_universe/services/NetworkAdapter.dart';
import 'package:spacex_universe/widgets/AboutSpacexWidget.dart';
import 'package:spacex_universe/widgets/CapsulesViewWidget.dart';
import 'package:spacex_universe/widgets/RocketCard.dart';

class CapsulesRoute extends StatefulWidget {
  CapsulesRoute({Key key}) : super(key: key);

  @override
  _CapsulesState createState() => _CapsulesState();
}

class _CapsulesState extends State<CapsulesRoute> {
  List<CapsuleDataModel> _models;

  @override
  void initState() {
    super.initState();
    var networkAdapter = new NetworkAdapter();

    var d = networkAdapter.getAllCapsules();
    var tmp = (List<CapsuleDataModel> value) {
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
      body = CapsulesViewWidget(models: _models);
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(AppConstants.APPBAR_TITLE_CAPSULES),
        ),
        body: body);
  }


}
