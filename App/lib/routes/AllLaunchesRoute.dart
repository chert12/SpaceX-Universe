import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:spacex_universe/dataModels/launch/LaunchDataModel.dart';
import 'package:spacex_universe/services/AppConstants.dart';
import 'package:spacex_universe/services/NetworkAdapter.dart';
import 'package:spacex_universe/services/Utilities.dart';
import 'package:spacex_universe/widgets/LaunchCard.dart';

class AllLaunchesRoute extends StatefulWidget {
  AllLaunchesRoute({Key key}) : super(key: key);

  @override
  _AllLaunchesRouteState createState() => _AllLaunchesRouteState();
}

class _AllLaunchesRouteState extends State<AllLaunchesRoute> {
//  Future<LaunchDataModel> launchModel;
  NetworkAdapter networkAdapter;
  List<LaunchDataModel> _models;

  NetworkAdapter _networkAdapter;

  @override
  void initState() {
    super.initState();
    _networkAdapter = new NetworkAdapter(context);
    _initData();
  }

  void _initData()
  {
    var d = _networkAdapter.getAllLaunches(retryFunction: _initData);
    var tmp = (List<LaunchDataModel> value) {
      setState(() {
        _models = value;
      });
    };

    d.then(tmp);
  }

  Widget _buildCompleteUi(List<LaunchDataModel> model) {
    List<Widget> tmp = new List<Widget>();
    for (int i = model.length - 1; i > 0; i--) {
      //tmp.add(_buildCard(model[i]));
      tmp.add(LaunchCard(
        model: model[i],
      ));
    }
    return ListView(
      children: tmp,
    );
  }

  Widget _buildPage(List<LaunchDataModel> models) {
    var modelsUpcoming = List<LaunchDataModel>();
    var modelsPast = List<LaunchDataModel>();
    for (int i = 0; i < models.length; i++) {
      var md = models[i];
      if (md.launchDateLocal.millisecondsSinceEpoch >
              DateTime.now().millisecondsSinceEpoch ||
          md.launchSuccess == null) {
        modelsUpcoming.add(md);
      } else {
        modelsPast.add(md);
      }
    }

    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: Text(AppConstants.APPBAR_TITLE_LAUNCHES),
              bottom: TabBar(
                tabs: [
                  Tab(
                    text: "Upcoming",
                  ),
                  Tab(
                    text: "Past",
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                _buildCompleteUi(modelsUpcoming),
                _buildCompleteUi(modelsPast)
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    if (_models == null) {
      return Scaffold(
          appBar: AppBar(
            title: Text(AppConstants.APPBAR_TITLE_LAUNCHES),
          ),
          //body: _buildFutureBuilder(networkAdapter.getAllLaunches()));
          body: Center(child: CircularProgressIndicator()));
    } else {
      return _buildPage(_models);
    }
  }
}