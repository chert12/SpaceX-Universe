import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spacex_universe/dataModels/history/HistoryDataModel.dart';
import 'package:spacex_universe/services/AppConstants.dart';
import 'package:spacex_universe/services/Utilities.dart';

class HistoryViewWidget extends StatelessWidget {
  const HistoryViewWidget({Key key, this.model}) : super(key: key);

  final HistoryDataModel model;

  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        child: Card(
            child: Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  children: <Widget>[
                    Text(
                      model.title,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    _buildEventInfoRow(),
                    Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          model.details,
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        )),
                    _buildLinksRow()
                  ],
                ))));
  }

  Widget _buildEventInfoRow() {
    Widget _buildEventInfoColumn(IconData icon, String text) {
      return Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(children: <Widget>[
                Icon(
                  icon,
                  color: Colors.grey,
                ),
                Text(text, style: TextStyle(color: Colors.grey, fontSize: 12))
              ]))
        ],
      );
    }

    var w = List<Widget>();
    w.add(_buildEventInfoColumn(
        Icons.date_range, DateFormat('dd MMM yyyy').format(model.eventDate)));

    if (null != model.flightNumber) {
      w.add(_buildEventInfoColumn(
          Icons.flight, "#${model.flightNumber.toString()}"));
    }

    return Padding(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: w,
        ));
  }

  Widget _buildLinksRow() {
    Widget _buildLinkButton(String link, String title) {
      return Padding(
          padding: EdgeInsets.only(left: 5, right: 5),
          child: GestureDetector(
              onTap: () {
                Utilities.launchUrl(link);
              },
              child: Column(children: <Widget>[
                Icon(
                  Icons.open_in_browser,
                  color: Colors.blue,
                ),
                Text(title,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blue, fontSize: 12))
              ])));
    }

    var w = List<Widget>();

    if (null != model.links.article) {
      if (model.links.article.isNotEmpty) {
        w.add(_buildLinkButton(
            model.links.article, AppConstants.READ_MORE_SPACEX));
      }
    }
    if (null != model.links.wikipedia) {
      if (model.links.wikipedia.isNotEmpty) {
        w.add(_buildLinkButton(
            model.links.wikipedia, AppConstants.READ_MORE_WIKIPEDIA));
      }
    }
    if (null != model.links.reddit) {
      if (model.links.reddit.isNotEmpty) {
        w.add(_buildLinkButton(
            model.links.reddit, AppConstants.READ_MORE_REDDIT));
      }
    }

    return Padding(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: w,
        ));
  }
}
