import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spacex_universe/dataModels/CapsuleDataModel.dart';
import 'package:spacex_universe/widgets/FullscreenInfoViewElement.dart';

class CapsulesViewWidget extends FullscreenInfoViewElement {
  final List<CapsuleDataModel> models;

  const CapsulesViewWidget({Key key, this.models}) : super(key: key);

  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext ctxt, int index) => _buildCapsule(ctxt, index),
      itemCount: models.length,
    );
  }

  Widget _buildCapsule(BuildContext context, int index) {
    var capsule = models[index];
    var w = List<Widget>();
    w.add(buildListElement("Type:", capsule.type));
    w.add(buildListElement("ID:", capsule.id));
    if (null != capsule.launchDate) {
      w.add(buildListElement("First launch:",
          DateFormat('dd MMM yyyy').format(capsule.launchDate)));
    }
    w.add(buildListElement("Status:", capsule.status));
    w.add(buildListElement("Landings:", capsule.landings.toString()));
    w.add(buildListElement("Reuse count:", capsule.reuseCount.toString()));
    if(null != capsule.details) {
     w.add(buildListElement("Note:", capsule.details));
      //w.add(Text(capsule.details, style: TextStyle(
        //  fontSize: 13, color: Colors.black, fontStyle: FontStyle.italic),));
    }
    return ExpansionTile(title: Text(capsule.serial), children: w);
  }
}
