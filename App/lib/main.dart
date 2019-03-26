import 'package:flutter/material.dart';
import 'package:spacex_universe/dataModels/LaunchDataModel.dart';
import 'package:spacex_universe/routes/LastLaunchRoute.dart';
import 'package:spacex_universe/services/AppConstants.dart';
import 'package:spacex_universe/services/NetworkAdapter.dart';

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

  Future<LaunchDataModel> launchModel;

  @override
  void initState() {
    super.initState();
    NetworkAdapter a = new NetworkAdapter();
    launchModel = a.getLastLaunch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
          child:new DrawerHeader(
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: Text("Last launch", style: TextStyle(
                      color: Colors.white
                  ),),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LastLaunchRoute()),
                    );
                  },
                  trailing: Icon(Icons.arrow_forward),
                ),
                ListTile(
                  title: Text("Launches", style: TextStyle(
                      color: Colors.white
                  ),),
                  trailing: Icon(Icons.arrow_forward),
                ),
                ListTile(
                  title: Text("Rockets", style: TextStyle(
                      color: Colors.white
                  ),),
                  trailing: Icon(Icons.arrow_forward),
                ),
                ListTile(
                  title: Text("Capsules", style: TextStyle(
                      color: Colors.white
                  ),),
                  trailing: Icon(Icons.arrow_forward),
                ),
                ListTile(
                  title: Text("Dragons", style: TextStyle(
                      color: Colors.white
                  ),),
                  trailing: Icon(Icons.arrow_forward),
                ),
                ListTile(
                  title: Text("Launch pads", style: TextStyle(
                      color: Colors.white
                  ),),
                  trailing: Icon(Icons.arrow_forward),
                ),
                ListTile(
                  title: Text("Landing pads", style: TextStyle(
                      color: Colors.white
                  ),),
                  trailing: Icon(Icons.arrow_forward),
                ),
                ListTile(
                  title: Text("About SpaceX", style: TextStyle(
                      color: Colors.white
                  ),),
                  trailing: Icon(Icons.arrow_forward),
                ),
              ],
            ),
            decoration: new BoxDecoration(
                color: Colors.blue
            ),
          )
      ),
    );
  }
}
