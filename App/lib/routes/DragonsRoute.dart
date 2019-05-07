import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:spacex_universe/dataModels/DragonDataModel.dart';
import 'package:spacex_universe/dataModels/launch/LaunchDataModel.dart';
import 'package:spacex_universe/services/AppConstants.dart';
import 'package:spacex_universe/services/NetworkAdapter.dart';
import 'package:spacex_universe/services/Utilities.dart';
import 'package:spacex_universe/widgets/DragonViewWidget.dart';
import 'package:spacex_universe/widgets/LaunchCard.dart';

class DragonsRoute extends StatefulWidget {
  DragonsRoute({Key key}) : super(key: key);

  @override
  _DragonsRouteState createState() => _DragonsRouteState();
}

class _DragonsRouteState extends State<DragonsRoute> {
//  Future<LaunchDataModel> launchModel;
  NetworkAdapter networkAdapter;
  List<DragonDataModel> _models;

//
  @override
  void initState() {
    super.initState();
    networkAdapter = new NetworkAdapter();

    var d = networkAdapter.getAllDragons();
    var tmp = (List<DragonDataModel> value) {
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

  Widget _buildPage() {

    List<Widget> tabs = new List<Widget>();
    List<Widget> pages = new List<Widget>();

    _models.forEach((model) =>{
      tabs.add(Tab(text: model.name)),
    pages.add(DragonViewWidget(model: model))
    });
    
    return DefaultTabController(
        length: _models.length,
        child: Scaffold(
            appBar: AppBar(
              title: Text(AppConstants.APPBAR_TITLE_DRAGONS),
              bottom: TabBar(
                tabs:tabs,
              ),
            ),
            body: TabBarView(
              children: pages,
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
      return _buildPage();
    }
  }
}
