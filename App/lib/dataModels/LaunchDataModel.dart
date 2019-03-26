import 'package:spacex_universe/dataModels/LaunchSiteDataModel.dart';
import 'package:spacex_universe/dataModels/RocketDataModel.dart';

class LaunchDataModel {
  LaunchDataModel();

  int flightNumber;
  String missionName;
  List<String> missionIds;
  String launchYear;
  DateTime launchDateUnix;
  DateTime launchDateLocal;
  bool isTentative;
  String tentativeMaxPrecision;
  bool tbd;
  int launchWindow;
  RocketDataModel rocket;
  List<String> ships;
  String telemetryLink;
  LaunchSiteDataModel launchSite;
  bool launchSuccess;
  LaunchLinksDataModel links;
  String details;
  DateTime staticFireDate;
  bool upcoming;

  factory LaunchDataModel.fromJson(Map<String, dynamic> json) {
    LaunchDataModel result = new LaunchDataModel();

    result.flightNumber = json['flight_number'];
    result.missionName = json['mission_name'];
    result.missionIds = (json['mission_id'] as List<dynamic>).cast<String>();
    result.launchYear = json['launch_year'];
    result.launchDateUnix =
        new DateTime.fromMillisecondsSinceEpoch(json['launch_date_unix']);
    result.launchDateLocal = DateTime.parse(json['launch_date_local']);
    result.isTentative = json['is_tentative'];
    result.tentativeMaxPrecision = json['tentative_max_precision'];
    result.tbd = json['tbd'];
    result.launchWindow = json['launch_window'];
    result.rocket = RocketDataModel.fromJson(json['rocket']);
    result.ships = (json['ships'] as List<dynamic>).cast<String>();
    var tmpTelemetry = json['telemetry'];
    result.telemetryLink = tmpTelemetry['flight_club'];
    result.launchSite = LaunchSiteDataModel.fromJson(json['launch_site']);
    result.launchSuccess = json['launch_success'];
    result.links = LaunchLinksDataModel.fromJson(json['links']);
    result.details = json['details'];
    result.upcoming = json['upcoming'];
    result.staticFireDate = new DateTime.fromMillisecondsSinceEpoch(json['static_fire_date_unix']);

    return result;
  }
}

class LaunchLinksDataModel
{
  LaunchLinksDataModel();
  String missionPatch;
  String missionPatchSmall;
  String redditCampaign;
  String redditLaunch;
  String redditRecovery;
  String redditMedia;
  String pressKit;
  String article;
  String wikipedia;
  String video;
  String youtubeId;
  List<String> flickrImages;

  factory LaunchLinksDataModel.fromJson(Map<String, dynamic> json)
  {
    LaunchLinksDataModel result = new LaunchLinksDataModel();

    result.missionPatch = json['mission_patch'];
    result.missionPatchSmall = json['mission_patch_small'];
    result.redditCampaign = json['reddit_campaign'];
    result.redditLaunch = json['reddit_launch'];
    result.redditRecovery = json['reddit_recovery'];
    result.redditMedia = json['reddit_media'];
    result.pressKit = json['presskit'];
    result.article = json['article_link'];
    result.wikipedia = json['wikipedia'];
    result.video = json['video_link'];
    result.youtubeId = json['youtube_id'];
    result.flickrImages = (json['flickr_images'] as List<dynamic>).cast<String>();

    return result;
  }

}
