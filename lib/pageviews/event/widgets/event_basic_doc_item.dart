
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hse/core/model/event/events.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:hse/core/utils/globals.dart';

class BasicDocSelectItem extends StatelessWidget {
  final SupportDoc basicDoc;
  final bool current;
  const BasicDocSelectItem(this.basicDoc, this.current);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      color:  current ? appBlueColor.withOpacity(0.2) : null,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(basicDoc.supportDocNumber, style: generalFontStyle.copyWith(fontSize: defaultFontSize - 1),),
        trailing: current ? Icon(Icons.check_circle_outline, color: appBlueColor,) : null,
      ),
    );
  }
}
