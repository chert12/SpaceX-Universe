import 'package:flutter/material.dart';
import 'package:spacex_universe/dataModels/companyInfo/CompanyInfoDataModel.dart';
import 'package:spacex_universe/services/AppConstants.dart';
import 'package:spacex_universe/widgets/FullscreenInfoViewElement.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

class AboutSpacexWidget extends FullscreenInfoViewElement {
  const AboutSpacexWidget({Key key, this.model}) : super(key: key);

  final CompanyInfoDataModel model;

  @override
  Widget build(BuildContext context) {
    return _buildCompleteUi(context);
  }

  Widget _buildCompleteUi(BuildContext context) {
    var w = List<Widget>();

    w.add(buildInternalImage(AppConstants.SPACEX_LOGO_IMAGE_PATH, context));
    w.add(Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          "«${model.summary}»",
          style: new TextStyle(
              fontStyle: FontStyle.italic, fontSize: 16, color: Colors.black54),
          textAlign: TextAlign.center,
        )));
    w.add(buildListElement("Founder:", model.founder));
    w.add(buildListElement("Founded:", model.foundYear.toString()));
    w.add(buildListElement("Employees:", model.employees.toString()));
    FlutterMoneyFormatter fmf = FlutterMoneyFormatter(
        amount: model.valuation.toDouble()
    );
    w.add(buildListElement("Valuation:", fmf.output.compactSymbolOnRight));
    w.add(buildListElement("Vehicles:", model.vehicles.toString()));
    w.add(buildListElement("Launch sites:", model.launchSites.toString()));
    w.add(buildListElement("Test sites:", model.testSites.toString()));
    w.add(buildListElement("CEO:", model.ceo));
    w.add(buildListElement("COO:", model.coo));
    w.add(buildListElement("CTO:", model.cto));
    w.add(buildListElement("CTO propulsion:", model.ctoPropulsion));
    w.add(buildListElement("Headquarters:", model.address.toString()));
    w.add(buildLinkElement("Official site:", model.links.website, context));
    w.add(buildLinkElement("Flickr:", model.links.flickr, context));
    w.add(buildLinkElement("Twitter:", model.links.twitter, context));
    w.add(buildLinkElement("Elon Musk twitter:", model.links.elonTwitter, context));

    return Padding(padding: EdgeInsets.all(5), child: ListView(children: w));
  }
}
