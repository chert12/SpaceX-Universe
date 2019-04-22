import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spacex_universe/dataModels/launch/LaunchDataModel.dart';
import 'package:spacex_universe/dataModels/launch/RocketDataModel.dart';
import 'package:spacex_universe/services/AppConstants.dart';
import 'package:spacex_universe/services/Utilities.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class LaunchViewWidget extends StatelessWidget {
  const LaunchViewWidget({Key key, this.model}) : super(key: key);

  final LaunchDataModel model;

  Widget build(BuildContext context) {
    return _buildCompleteUi(context);
  }

  Widget _buildCompleteUi(BuildContext context) {
    var w = List<Widget>();
    w.add(_buildImage(context));
    w.add(_buildListTitle(model.missionName));
    w.add(_buildListElement(
        "Flight number:", "#${model.flightNumber.toString()}"));
    w.add(_buildListElement("Mission name:", model.missionName));
    w.add(_buildElementWithDescription("Description:", model.details));
    w.add(_buildListElement("Launch date:",
        DateFormat('dd MMMM yyyy').format(model.launchDateUnix)));
    w.add(_buildListElement(
        "Success:", Utilities.boolToString(model.launchSuccess)));

    if (model.rocket != null) {
      var rocket = model.rocket;
      w.add(_buildListTitle("Rocket"));
      w.add(_buildListElement("Name:", rocket.rocketName));
      w.add(_buildListElement("Type:", rocket.rocketType));
      w.add(_buildListElement("ID:", rocket.rocketId));
      if (null != rocket.firstStage) {
        var fs = rocket.firstStage;
        if (fs.cores != null) {
          for (int i = 0; i < fs.cores.length; i++) {
            var core = fs.cores[i];
            w.add(_buildListTitle("Core #$i"));
            w.add(_buildListElement("Serial:", core.coreSerial));
            w.add(_buildListElement(
                "Reused:", Utilities.boolToString(core.reused)));
            w.add(_buildListElement("Flight:", "#${core.flight.toString()}"));
            w.add(_buildListElement(
                "Land success:", Utilities.boolToString(core.landSuccess)));
            w.add(_buildListElement("Land type:", core.landingType));
            w.add(_buildListElement("Land vehicle:", core.landingVehicle));
          }
        }
      }
      if (null != rocket.secondStage) {
        var ss = rocket.secondStage;
        if (null != ss.payloads && ss.payloads.length > 0) {
          w.add(_buildListTitle("Second stage"));
          for (int i = 0; i < ss.payloads.length; i++) {
            var p = ss.payloads[i];
            w.add(_buildListTitle("Payload #${i + 1}"));
            w.add(_buildListElement("ID", p.payloadId));
            for (int j = 0; j < p.customers.length; j++) {
              w.add(_buildListElement(
                  "Customer #${i + 1}", p.customers[i].toString()));
            }
            w.add(_buildListElement("Payload type:", p.payloadType));
            w.add(_buildListElement("Nationality:", p.nationality));
            w.add(_buildListElement("Manufacturer:", p.manufacturer));
            w.add(_buildListElement("Orbit:", p.orbit));
            w.add(_buildListElement("Payload mass:",
                "${p.payloadMassLbs} lb/ ${p.payloadMassKg} kg"));
          }
        }
      }
    }
    w.add(_buildListTitle("Other info"));
    w.add(_buildListElement("Launch site:", model.launchSite.siteName));
    w.add(_buildLinkElement("Telemetry:", model.telemetryLink, context));
    if (null != model.links) {
      var links = model.links;
      w.add(_buildLinkElement("Article:", links.article, context));
      w.add(_buildLinkElement("Wikipedia:", links.wikipedia, context));
      w.add(_buildLinkElement("Presskit:", links.pressKit, context));
      w.add(_buildLinkElement("Youtube:", links.video, context));
      w.add(_buildLinkElement("Reddit:", links.redditCampaign, context));
      if (null != links.flickrImages) {
        w.add(Container(
            child: PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: AssetImage(links.flickrImages[index]),
                  initialScale: PhotoViewComputedScale.contained * 0.8,
                  heroTag: links.flickrImages[index],
                );
              },
              itemCount: links.flickrImages.length,
              //loadingChild: widget.loadingChild,
              //backgroundDecoration: widget.backgroundDecoration,
              //pageController: widget.pageController,
              //onPageChanged: onPageChanged,
            )
        ));
      }
    }

    return ListView(children: w);
  }

  Widget _buildImage(BuildContext context) {
    if (null == model.links.missionPatch) {
      return Hero(
          tag: model.flightNumber,
          child: SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.3,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppConstants.ROCKET_IMAGE_PATH),
                      )))));
    } else {
      return Hero(
          tag: model.flightNumber,
          child: CachedNetworkImage(
            imageUrl: model.links.missionPatch,
            placeholder: (context, url) => new CircularProgressIndicator(),
            errorWidget: (context, url, error) => new Icon(Icons.error),
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .height * 0.3,
          ));
    }
  }

  Widget _buildListElement(String title, String value) {
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

  Widget _buildListTitle(String title) {
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

  Widget _buildLinkElement(String title, String link, BuildContext context) {
    if (title.isEmpty || link.isEmpty) {
      return null;
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

  Widget _buildElementWithDescription(String description, String text) {
    if (text == null) {
      text = "";
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
