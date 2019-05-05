class CompanyInfoDataModel{
  CompanyInfoDataModel();

  String name;
  String founder;
  int foundYear;
  int employees;
  int vehicles;
  int launchSites;
  int testSites;
  String ceo;
  String cto;
  String coo;
  String ctoPropulsion;
  int valuation;
  CompanyInfoAddressDataModel address;
  CompanyInfoLinksDataModel links;
  String summary;

  factory CompanyInfoDataModel.fromJson(Map<String, dynamic> json)
  {
    CompanyInfoDataModel result = new CompanyInfoDataModel();

    result.name = json['name'];
    result.founder = json['founder'];
    result.foundYear = json['founded'];
    result.employees = json['employees'];
    result.vehicles = json['vehicles'];
    result.launchSites = json['launch_sites'];
    result.testSites = json['test_sites'];
    result.ceo = json['ceo'];
    result.cto = json['cto'];
    result.coo = json['coo'];
    result.ctoPropulsion = json['cto_propulsion'];
    result.valuation = json['valuation'];
    result.summary = json['summary'];
    result.address = CompanyInfoAddressDataModel.fromJson(json['headquarters']);
    result.links = CompanyInfoLinksDataModel.fromJson(json['links']);

    return result;
  }
}

class CompanyInfoAddressDataModel
{
  CompanyInfoAddressDataModel();
  String address;
  String city;
  String state;

  String toString()
  {
    return "$address, \n$city, $state";
  }

  factory CompanyInfoAddressDataModel.fromJson(Map<String, dynamic> json)
  {
    CompanyInfoAddressDataModel result = new CompanyInfoAddressDataModel();
    result.address = json['address'];
    result.city = json['city'];
    result.state = json['state'];

    return result;
  }
}

class CompanyInfoLinksDataModel
{
  CompanyInfoLinksDataModel();
  String website;
  String flickr;
  String twitter;
  String elonTwitter;


  factory CompanyInfoLinksDataModel.fromJson(Map<String, dynamic> json)
  {
    CompanyInfoLinksDataModel result = new CompanyInfoLinksDataModel();
    result.website = json['website'];
    result.flickr = json['flickr'];
    result.twitter = json['twitter'];
    result.elonTwitter = json['elon_twitter'];

    return result;
  }
}