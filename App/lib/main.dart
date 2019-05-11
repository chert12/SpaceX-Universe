import 'package:flutter/material.dart';
import 'package:spacex_universe/dataModels/history/HistoryDataModel.dart';
import 'package:spacex_universe/routes/AboutSpacexRoute.dart';
import 'package:spacex_universe/routes/AllLaunchesRoute.dart';
import 'package:spacex_universe/routes/CapsulesRoute.dart';
import 'package:spacex_universe/routes/DragonsRoute.dart';
import 'package:spacex_universe/routes/LandpadsRoute.dart';
import 'package:spacex_universe/routes/LastLaunchRoute.dart';
import 'package:spacex_universe/routes/LaunchpadsRoute.dart';
import 'package:spacex_universe/routes/RocketsRoute.dart';
import 'package:spacex_universe/services/AppConstants.dart';
import 'package:spacex_universe/services/NetworkAdapter.dart';
import 'package:spacex_universe/widgets/HistoryViewWidget.dart';

void main() => runApp(SpaceXUniverseApp());

class SpaceXUniverseApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.APPBAR_TITLE_MAIN,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: AppConstants.APPBAR_TITLE_MAIN),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<HistoryDataModel> _historyModels;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData()
  {
    var networkAdapter = new NetworkAdapter(context);

    var d = networkAdapter.getAllHistoryEvents(retryFunction: _initData);
    var tmp = (List<HistoryDataModel> historyEvents) {
      setState(() {
        _historyModels = historyEvents;
      });
    };

    d.then(tmp);
  }

  @override
  Widget build(BuildContext context) {
    Widget w = new Center(
      child: CircularProgressIndicator(),
    );
    if (_historyModels != null) {
      w = _buildHistoryElements();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: _buildDrawer(),
      body: w,
    );
  }

  Widget _buildHistoryElements() {
    var w = new List<Widget>();

    for (int i = _historyModels.length - 1; i >= 0; i--) {
      w.add(new HistoryViewWidget(
        model: _historyModels[i],
      ));
    }

    return ListView(
      children: w,
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Container(
          color: Colors.blue,
          alignment: Alignment.center,
          child: ListView(
            children: <Widget>[
              _buildDrawerElement("Last launch", LastLaunchRoute()),
              _buildDrawerElement("Launches", AllLaunchesRoute()),
              _buildDrawerElement("Rockets", RocketsRoute()),
              _buildDrawerElement("Capsules", CapsulesRoute()),
              _buildDrawerElement("Dragons", DragonsRoute()),
              _buildDrawerElement("Launch pads", LaunchpadsRoute()),
              _buildDrawerElement("Landing pads", LandpadsRoute()),
              _buildDrawerElement("About SpaceX", AboutSpacexRoute()),
            ],
          )),
    );
  }

  Widget _buildDrawerElement(String title, StatefulWidget widget) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => widget),
        );
      },
      trailing: Icon(
        Icons.arrow_forward,
        color: Colors.white,
      ),
    );
  }
}
