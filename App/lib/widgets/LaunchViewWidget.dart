import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spacex_universe/dataModels/launch/LaunchDataModel.dart';
import 'package:spacex_universe/dataModels/launch/RocketDataModel.dart';
import 'package:spacex_universe/services/AppConstants.dart';
import 'package:spacex_universe/services/Utilities.dart';
import 'package:spacex_universe/widgets/FullscreenInfoViewElement.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class LaunchViewWidget extends FullscreenInfoViewElement {
  const LaunchViewWidget({Key key, this.model}) : super(key: key);

  final LaunchDataModel model;

  @override
  Widget build(BuildContext context) {
    return _buildCompleteUi(context);
  }

  Widget _buildCompleteUi(BuildContext context) {
    var w = List<Widget>();
    w.add(buildUrlImage(
        model.links.missionPatch, model.flightNumber.toString(), context));
    w.add(buildListTitle(model.missionName));
    w.add(buildListElement(
        "Flight number:", "#${model.flightNumber.toString()}"));
    w.add(buildListElement("Mission name:", model.missionName));
    w.add(buildElementWithDescription("Description:", model.details));
    w.add(buildListElement("Launch date:",
        DateFormat('dd MMMM yyyy').format(model.launchDateUnix)));
    if (model.launchSuccess != null) {
      w.add(buildListElement(
          "Success:", Utilities.boolToString(model.launchSuccess)));
    } else {
      w.add(buildListElement("Success:", "Upcoming"));
    }

    if (model.rocket != null) {
      var rocket = model.rocket;
      w.add(buildListTitle("Rocket"));
      w.add(buildListElement("Name:", rocket.rocketName));
      w.add(buildListElement("Type:", rocket.rocketType));
      w.add(buildListElement("ID:", rocket.rocketId));
      if (null != rocket.firstStage) {
        var fs = rocket.firstStage;
        if (fs.cores != null) {
          for (int i = 0; i < fs.cores.length; i++) {
            var core = fs.cores[i];
            w.add(buildListTitle("Core #$i"));
            w.add(buildListElement("Serial:", core.coreSerial));
            if (null != core.reused) {
              w.add(buildListElement(
                  "Reused:", Utilities.boolToString(core.reused)));
              w.add(buildListElement("Flight:", "#${core.flight.toString()}"));
            } else {
              w.add(buildListElement("Reused:", "No info"));
            }
            if (null != core.landSuccess) {
              w.add(buildListElement(
                  "Land success:", Utilities.boolToString(core.landSuccess)));
            }
            w.add(buildListElement("Land type:", core.landingType));
            w.add(buildListElement("Land vehicle:", core.landingVehicle));
          }
        }
      }
      if (null != rocket.secondStage) {
        var ss = rocket.secondStage;
        if (null != ss.payloads && ss.payloads.length > 0) {
          w.add(buildListTitle("Second stage"));
          for (int i = 0; i < ss.payloads.length; i++) {
            var p = ss.payloads[i];
            w.add(buildListTitle("Payload #${i + 1}"));
            w.add(buildListElement("ID", p.payloadId));
            if (p.customers != null && p.customers.length > 0) {
              for (int j = 0; j < p.customers.length; j++) {
                w.add(buildListElement(
                    "Customer #${j + 1}", p.customers[j].toString()));
              }
            }
            w.add(buildListElement("Payload type:", p.payloadType));
            w.add(buildListElement("Nationality:", p.nationality));
            w.add(buildListElement("Manufacturer:", p.manufacturer));
            w.add(buildListElement("Orbit:", p.orbit));
            w.add(buildListElement("Payload mass:",
                "${p.payloadMassLbs} lb/ ${p.payloadMassKg} kg"));
          }
        }
      }
    }
    w.add(buildListTitle("Other info"));
    w.add(buildListElement("Launch site:", model.launchSite.siteName));
    w.add(buildLinkElement("Telemetry:", model.telemetryLink, context));
    if (null != model.links) {
      var links = model.links;
      //w.add(buildLinkElement("Article:", links.article, context));
      //w.add(buildLinkElement("Wikipedia:", links.wikipedia, context));
      //w.add(buildLinkElement("Presskit:", links.pressKit, context));
      //w.add(buildLinkElement("Youtube:", links.video, context));
      //w.add(buildLinkElement("Reddit:", links.redditCampaign, context));
      w.add(buildImageGallery(model.links.flickrImages, context));
    }

    return ListView(children: w);
  }
}
