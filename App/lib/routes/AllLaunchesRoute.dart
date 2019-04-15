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

//
  @override
  void initState() {
    super.initState();
    networkAdapter = new NetworkAdapter();

    var d = networkAdapter.getAllLaunches();
    var tmp = (List<LaunchDataModel> launches) {
      setState(() {
        _models = launches;
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

  Widget _buildCardTextRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
              color: Colors.black87,
              fontFamily: "Roboto",
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        Text(
          value,
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          style: TextStyle(
              color: Colors.black38, fontFamily: "Roboto", fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildCardText(LaunchDataModel model) {
    var res = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          model.missionName,
          style: TextStyle(
              color: Colors.black,
              fontFamily: "Roboto",
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
      ],
    );
    res.children.add(_buildCardTextRow("Flight", "#${model.flightNumber}"));
    res.children.add(_buildCardTextRow("Launch date:",
        DateFormat('dd MMM yyyy \n kk:mm').format(model.launchDateLocal)));
    if (model.launchDateLocal.millisecondsSinceEpoch >
        DateTime.now().millisecondsSinceEpoch) {
      res.children.add(_buildCardTextRow("Successful:", "Upcoming"));
    } else {
      res.children.add(_buildCardTextRow(
          "Successful:", Utilities.boolToString(model.launchSuccess)));
    }
    res.children.add(RaisedButton(
      color: Colors.blue,
      textColor: Colors.white,
      onPressed: () => {},
      child: Text("View full info"),
    ));
    return Padding(
      padding: EdgeInsets.all(10),
      child: res,
    );
  }

  Widget _buildCard(LaunchDataModel model) {
    return new Container(
        height: 200,
        padding: new EdgeInsets.all(10),
        child: Card(
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: CachedNetworkImage(
                  imageUrl: model.links.missionPatch,
                  placeholder: (context, url) =>
                      new CircularProgressIndicator(),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                  width: MediaQuery.of(context).size.width * 0.3,
                ),
              ),
              Expanded(flex: 6, child: _buildCardText(model))
            ],
          ),
        ));
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
        length: 3,
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

  Widget _buildFutureBuilder(Future<List<LaunchDataModel>> modelFuture) {
    return new FutureBuilder<List<LaunchDataModel>>(
      future: modelFuture,
      builder: (BuildContext context,
          AsyncSnapshot<List<LaunchDataModel>> snapshot) {
        if (snapshot.hasData) {
          _models = snapshot.data;
          //return _buildRefreshView();
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
