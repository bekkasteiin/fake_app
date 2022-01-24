
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hse/core/model/message/message_dictionary.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:hse/core/utils/globals.dart';

class EventSelectItem extends StatelessWidget {
  final AbstractDictionary risk;
  final bool current;
  const EventSelectItem(this.risk, this.current);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      color:  current ? appBlueColor.withOpacity(0.2) : null,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(risk.langValue, style: generalFontStyle.copyWith(fontSize: defaultFontSize - 1),),
        trailing: current ? Icon(Icons.check_circle_outline, color: appBlueColor,) : null,
      ),
    );
  }
}
