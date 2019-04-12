class HistoryDataModel
{
  HistoryDataModel();
  int id;
  String title;
  DateTime eventDate;
  int flightNumber;
  String details;
  HistoryLinksDataModel links;

  factory HistoryDataModel.fromJson(Map<String, dynamic> json)
  {
    HistoryDataModel result = new HistoryDataModel();

    result.id = json['id'];
    result.title = json['title'];
    result.eventDate =DateTime.parse(json['event_date_utc']);
    result.flightNumber = json['flight_number'];
    result.details = json['details'];
    result.links = HistoryLinksDataModel.fromJson(json['links']);

    return result;
  }
}

class HistoryLinksDataModel
{
  HistoryLinksDataModel();
  String reddit;
  String article;
  String wikipedia;

  factory HistoryLinksDataModel.fromJson(Map<String, dynamic> json) {
    HistoryLinksDataModel result = new HistoryLinksDataModel();

    result.reddit = json['reddit'];
    result.article = json['article'];
    result.wikipedia = json['wikipedia'];

    return result;
  }
}