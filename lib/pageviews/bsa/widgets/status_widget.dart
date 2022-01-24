import 'package:flutter/material.dart';
import 'package:hse/core/model/message/message_dictionary.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/generated/l10n.dart';

class BsaStatusWidget extends StatelessWidget {
  final AbstractDictionary status;

  const BsaStatusWidget(this.status);

  @override
  Widget build(BuildContext context) {
    Color color;
    if (status?.code == null) {
      color = appBlueColor;
    } else if (status.code == 'CLOSED') {
      color = appGreenColor;
    } else if (status.code == 'CANCELED') {
      color = appRedColor;
    } else {
      color = appBlueColor;
    }

    return Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 8, top: 8),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(color: color.withOpacity(0.3)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(S.current.status, style: generalFontStyle,),
            Text(status?.langValue ?? 'Новый',
              style: generalFontStyle.copyWith(
                  fontSize: 16,
                  height: 2,
                  fontWeight: FontWeight.bold,
                  color: color),
            ),
          ],),
    );
  }
}