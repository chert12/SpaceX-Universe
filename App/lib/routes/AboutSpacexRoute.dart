import 'package:flutter/material.dart';
import 'package:spacex_universe/dataModels/companyInfo/CompanyInfoDataModel.dart';
import 'package:spacex_universe/dataModels/rocket/RocketDataModel.dart';
import 'package:spacex_universe/services/AppConstants.dart';
import 'package:spacex_universe/services/NetworkAdapter.dart';
import 'package:spacex_universe/widgets/AboutSpacexWidget.dart';
import 'package:spacex_universe/widgets/RocketCard.dart';

class AboutSpacexRoute extends StatefulWidget {
  AboutSpacexRoute({Key key}) : super(key: key);

  @override
  _AboutSpacexState createState() => _AboutSpacexState();
}

class _AboutSpacexState extends State<AboutSpacexRoute> {
  CompanyInfoDataModel _info;

  NetworkAdapter _networkAdapter;

  @override
  void initState() {
    super.initState();
    _networkAdapter = new NetworkAdapter(context);
    _initData();
  }

  void _initData()
  {
    var d = _networkAdapter.getCompanyInfo(retryFunction: _initData);
    var tmp = (CompanyInfoDataModel value) {
      setState(() {
        _info = value;
      });
    };

    d.then(tmp);
  }

  @override
  Widget build(BuildContext context) {
    Widget body = Center(child: CircularProgressIndicator());
    if (_info != null) {
      body = AboutSpacexWidget(model: _info);
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(AppConstants.APPBAR_TITLE_ABOUT),
        ),
        body: body);
  }


}
