
import 'package:flutter/material.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:hse/core/utils/globals.dart';

class ContentTile extends StatelessWidget {
  final String title;
  final String content;
  final String type;
  final Function onTaped;
  const ContentTile({this.content, this.title, this.type, this.onTaped});

  @override
  Widget build(BuildContext context) {
    var color = type == 'RED'
        ? appRedColor
        : type == 'YELLOW'
        ? appYellowColor
        : appGreenColor;
    var typeText = type == 'RED'
        ? 'Красный'
        : type == 'YELLOW'
        ? 'Желтый'
        : 'Зеленый';
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: generalFontStyle.copyWith(
                  color: appDarkGrayColor)),
          type != null
              ? Row(
            children: [
              Text(content,
                  style: generalFontStyle.copyWith(
                      color: appBlackColor,
                      fontSize: defaultFontSize + 2)),
              Text(typeText,
                  style: generalFontStyle.copyWith(
                      color: color, fontSize: defaultFontSize + 2)),
            ],
          )
              : Text(content,
              style: generalFontStyle.copyWith(
                  color: appBlackColor, fontSize: defaultFontSize + 2)),
        ],
      ),
    );
  }


}
