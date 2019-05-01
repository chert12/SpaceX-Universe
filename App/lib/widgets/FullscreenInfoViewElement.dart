import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:spacex_universe/services/AppConstants.dart';
import 'package:spacex_universe/services/Utilities.dart';

abstract class FullscreenInfoViewElement extends StatelessWidget {

  const FullscreenInfoViewElement({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    return SizedBox.shrink();
  }

  @protected
  Widget buildImage(String imageUrl, String heroTag, BuildContext context) {
    if (null == imageUrl || imageUrl.isEmpty) {
      return Hero(
          tag: heroTag,
          child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                image: AssetImage(AppConstants.ROCKET_IMAGE_PATH),
              )))));
    } else {
      return Hero(
          tag: heroTag,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            placeholder: (context, url) => new CircularProgressIndicator(),
            errorWidget: (context, url, error) => new Icon(Icons.error),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
          ));
    }
  }

  @protected
  Widget buildListElement(String title, String value) {
    if (title == null || value == null) {
      return SizedBox.shrink();
    }
    return new Padding(
      padding: new EdgeInsets.all(7),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              Text(
                value,
                style: TextStyle(color: Colors.black38, fontSize: 16),
              ),
            ],
          ),
          new Padding(
              padding: new EdgeInsets.only(top: 5),
              child: Container(height: 1.0, color: Colors.black12))
        ],
      ),
    );
  }

  @protected
  Widget buildListTitle(String title) {
    return new Padding(
      padding: new EdgeInsets.all(7),
      child: Column(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          new Padding(
              padding: new EdgeInsets.only(top: 5),
              child: Container(height: 2.0, color: Colors.black12))
        ],
      ),
    );
  }

  @protected
  Widget buildLinkElement(String title, String link, BuildContext context) {
    if (title == null || link == null || title.isEmpty || link.isEmpty) {
      return SizedBox.shrink();
    }
    return new Padding(
      padding: new EdgeInsets.all(7),
      child: Column(
        children: <Widget>[
          InkWell(
              onTap: () {
                Utilities.launchUrl(link);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  Icon(
                    Icons.arrow_right,
                    color: Colors.black87,
                  ),
                ],
              )),
          new Padding(
              padding: new EdgeInsets.only(top: 5),
              child: Container(height: 1.0, color: Colors.black12))
        ],
      ),
    );
  }

  @protected
  Widget buildElementWithDescription(String description, String text) {
    if (text == null) {
      return SizedBox.shrink();
    }
    return new Padding(
      padding: new EdgeInsets.all(7),
      child: Column(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                description,
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              new Padding(
                  padding: new EdgeInsets.only(top: 5),
                  child: Text(
                    text,
                    style: TextStyle(color: Colors.black, fontSize: 13),
                  ))
            ],
          ),
          new Padding(
              padding: new EdgeInsets.only(top: 5),
              child: Container(height: 2.0, color: Colors.black12))
        ],
      ),
    );
  }
}
