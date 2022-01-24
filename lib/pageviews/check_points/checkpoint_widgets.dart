import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getflutter/getflutter.dart';
import 'package:hse/core/model/check_points/CheckPoint.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/generated/l10n.dart';

import '../../core/utils/UI_Helpers.dart';

Widget checkPointDesktopItems(
    CheckPoint e, BuildContext context, TextStyle dateTextStyle) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.5,
    margin: EdgeInsets.all(10),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Image(
                image: AssetImage(e.direction == 'ENTRANCE'
                    ? 'assets/images/login.png'
                    : 'assets/images/logout.png'),
                width: GFSize.MEDIUM,
                height: GFSize.MEDIUM,
                color: e.direction != 'EXIT'
                    ? hexToColor('#FB9764')
                    : appBlueColor,
              ),
            ),
            Text(
              e.direction == 'ENTRANCE' ? S().ENTRANCE : S().EXIT,
              style: generalFontStyle.copyWith(
                  color: e.direction == 'ENTRANCE'
                      ? hexToColor('#FB9764')
                      : appBlueColor,
                  fontSize: 22),
            ),
          ],
        ),
        Container(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  FontAwesomeIcons.calendar,
                  size: 20,
                  color: appBlueColor,
                ),
              ),
              Container(
                child: Text(
                  formatDate(e.dateAndTime),
                  style: dateTextStyle,
                ),
              ),
            ],
          ),
        ),
        Container(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  FontAwesomeIcons.mapMarkerAlt,
                  size: 20,
                  color: appBlueColor,
                ),
              ),
              Container(
                child: Text(
                  e.controlPoint,
                  style: dateTextStyle,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
