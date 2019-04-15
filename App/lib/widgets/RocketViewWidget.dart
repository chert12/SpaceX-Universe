import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:spacex_universe/dataModels/rocket/RocketDataModel.dart';

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
    return Text("fsf");
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
