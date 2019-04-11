import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:spacex_universe/dataModels/launch/LaunchDataModel.dart';
import 'package:spacex_universe/services/AppConstants.dart';
import 'package:spacex_universe/services/NetworkAdapter.dart';
import 'package:spacex_universe/services/Utilities.dart';

class AllLaunchesRoute extends StatefulWidget {
  AllLaunchesRoute({Key key}) : super(key: key);

  @override
  _AllLaunchesRouteState createState() => _AllLaunchesRouteState();
}

class _AllLaunchesRouteState extends State<AllLaunchesRoute> {
//  Future<LaunchDataModel> launchModel;
  NetworkAdapter networkAdapter;
//
  @override
  void initState() {
    super.initState();
    networkAdapter = new NetworkAdapter();
  }

  Widget _buildCompleteUi(List<LaunchDataModel> model) {
    return ListView(
      children: <Widget>[
        _buildCard(model[0]),
        _buildCard(model[5])
      ],
    );
  }

  Widget _buildCard(LaunchDataModel model)
  {
    return new Container(
      height: 170,
      padding: new EdgeInsets.all(10),
      child: InkWell(
        onTap: ()
          {
            debugPrint("tap ${model.flightNumber}");
          },
        child: Card(
          child: Row(
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: model.links.missionPatch,
                placeholder: (context, url) => new CircularProgressIndicator(),
                errorWidget: (context, url, error) => new Icon(Icons.error),
                width: MediaQuery.of(context).size.width * 0.3,
              ),
            ],
          ),
        ),
      )
    );
  }

  Widget _buildFutureBuilder(Future<List<LaunchDataModel>> modelFuture) {
    return new FutureBuilder<List<LaunchDataModel>>(
      future: modelFuture,
      builder: (BuildContext context, AsyncSnapshot<List<LaunchDataModel>> snapshot) {
        if (snapshot.hasData) {
          return _buildCompleteUi(snapshot.data);
        } else {
          return new Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppConstants.APPBAR_TITLE_LAUNCHES),
        ),
        body: _buildFutureBuilder(networkAdapter.getAllLaunches()));
  }
}
