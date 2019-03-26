class LaunchSiteDataModel {
  LaunchSiteDataModel();

  String siteId;
  String siteName;
  String siteNameLong;

  factory LaunchSiteDataModel.fromJson(Map<String, dynamic> json) {
    LaunchSiteDataModel result = new LaunchSiteDataModel();

    result.siteId = json['site_id'];
    result.siteName = json['site_name'];
    result.siteNameLong = json['site_name_long'];

    return result;
  }
}
