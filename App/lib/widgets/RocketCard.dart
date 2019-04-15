import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spacex_universe/dataModels/rocket/RocketDataModel.dart';
import 'package:spacex_universe/routes/SingleRocketRoute.dart';
import 'package:spacex_universe/services/Utilities.dart';

class RocketCard extends StatelessWidget {
  const RocketCard({Key key, this.model})
      : super(key: key);

  final RocketDataModel model;

  Widget build(BuildContext context) {
    return _buildCard(context);
  }

  Widget _buildCard(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Card(
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: new Hero(
                    tag: model.id,
                    child: CachedNetworkImage(
                      imageUrl: model.images[0],
                      placeholder: (context, url) =>
                      new CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                      new Icon(Icons.error),
                    )),
              ),
              Expanded(flex: 6, child: _buildCardText(context))
            ],
          ),
        ));
  }

  Widget _buildCardText(BuildContext context) {
    var w = List<Widget>();

    w.add(Padding(
      padding: EdgeInsets.only(bottom: 5),
        child: Text(
      model.rocketName,
      style: TextStyle(
          color: Colors.black87,
          fontFamily: "Roboto",
          fontWeight: FontWeight.bold,
          fontSize: 18),
    )));
    w.add(_buildCardTextRow("First flight:", DateFormat('dd MMM yyyy').format(model.firstFlight)));
    w.add(_buildCardTextRow("Active:", Utilities.boolToString(model.active)));
    w.add(_buildCardTextRow("Launch cost:", "${model.launchCost}\$"));
    w.add(_buildCardTextRow("Stages:", model.stages.toString()));
    w.add(_buildCardTextRow("Boosters:", model.boosters.toString()));
    w.add(RaisedButton(
      color: Colors.blue,
      textColor: Colors.white,
      onPressed: () =>
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SingleRocketRoute(
                      rocketModel: model,
                    )),
          ),
      child: Text("View full info"),
    ));

    return Padding(
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          children: w,
        ),
      ),
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
}
