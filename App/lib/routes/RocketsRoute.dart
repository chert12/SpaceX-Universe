import 'package:flutter/material.dart';
import 'package:spacex_universe/dataModels/rocket/RocketDataModel.dart';
import 'package:spacex_universe/services/AppConstants.dart';
import 'package:spacex_universe/services/NetworkAdapter.dart';
import 'package:spacex_universe/widgets/RocketCard.dart';

class RocketsRoute extends StatefulWidget {
  RocketsRoute({Key key}) : super(key: key);

  @override
  _RocketsRouteState createState() => _RocketsRouteState();
}

class _RocketsRouteState extends State<RocketsRoute> {

  List<RocketDataModel> _models;
  NetworkAdapter _networkAdapter;

  @override
  void initState() {
    super.initState();
    _networkAdapter = new NetworkAdapter(context);
    _initData();
  }

  void _initData()
  {
    var d = _networkAdapter.getAllRockets(retryFunction: _initData);
    var tmp = (List<RocketDataModel> value) {
      setState(() {
        _models = value;
      });
    };

    d.then(tmp);
  }

  Widget _buildCardList() {
    List<Widget> tmp = new List<Widget>();
    for (int i = 0; i < _models.length; i++) {
      //tmp.add(_buildCard(model[i]));
      tmp.add(RocketCard(
        model: _models[i],
      ));
    }
    return ListView(
      children: tmp,
    );
  }


  @override
  Widget build(BuildContext context) {
    if (_models == null) {
      return Scaffold(
          appBar: AppBar(
            title: Text(AppConstants.APPBAR_TITLE_ROCKETS),
          ),
          //body: _buildFutureBuilder(networkAdapter.getAllLaunches()));
          body: Center(child: CircularProgressIndicator()));
    } else {
      return Scaffold(
          appBar: AppBar(
            title: Text(AppConstants.APPBAR_TITLE_ROCKETS),
          ),
          //body: _buildFutureBuilder(networkAdapter.getAllLaunches()));
          body: _buildCardList());
    }
  }
}
