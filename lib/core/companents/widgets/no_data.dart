
import 'package:flutter/material.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/core/utils/local_icon_data.dart';

class NoDataWidget extends StatelessWidget {
  var size;
  NoDataWidget([this.size]);

  @override
  Widget build(BuildContext context) {
    if(size == null) {
      size = MediaQuery.of(context).size;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          LocalIconData.noData,
          height: size.width / 8,
          width: size.width / 8,
        ),
        Text(
          'нет данных',
          style: generalFontStyle.copyWith(
              color: appDarkGrayColor,
              fontSize: defaultFontSize),
        ),
      ],
    );
  }
}
