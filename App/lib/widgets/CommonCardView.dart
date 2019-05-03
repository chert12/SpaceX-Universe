import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spacex_universe/dataModels/rocket/RocketDataModel.dart';
import 'package:spacex_universe/routes/SingleRocketRoute.dart';
import 'package:spacex_universe/services/AppConstants.dart';
import 'package:spacex_universe/services/Utilities.dart';

class CommonCardView extends StatelessWidget {
  const CommonCardView({Key key})
      : super(key: key);

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
            placeholder: (context, url) => new Center(child:CircularProgressIndicator()),
            errorWidget: (context, url, error) => new Icon(Icons.error),
          ));
    }
  }

  @protected
  Widget buildCardTextRow(String title, String value) {
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
