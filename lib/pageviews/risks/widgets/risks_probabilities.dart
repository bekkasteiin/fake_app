import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hse/core/model/message/message_dictionary.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/viewmodels/bpm_models/risks_model.dart';

class RisksProbabilitiesItem extends StatefulWidget {
   AbstractDictionary item;
   RisksModel model;
   bool editable;

   RisksProbabilitiesItem(this.item, this.model, [this.editable = true]);

  @override
  _RisksProbabilitiesItemState createState() => _RisksProbabilitiesItemState();
}

class _RisksProbabilitiesItemState extends State<RisksProbabilitiesItem> {
  @override
  Widget build(BuildContext context) {
    if(widget.model.entity.probability != null) {
      var c = widget.model.entity.probability;
        if (c.id == widget.item.id) {
          widget.editable = true;
        } else {
          widget.editable = false;
        }
    }
    return Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          height: 75,
          width: 60,
          color: widget.editable ? appGreenColor : appSeaBlueColor,
          alignment: Alignment.center,
          child: Text(widget.item.langValue.toUpperCase(),
              style: generalFontStyle.copyWith(color: appWhiteColor, fontSize: 16),
              textAlign: TextAlign.center),
      );
  }
}