
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hse/core/utils/UI_Helpers.dart';

class LoaderWidget extends StatelessWidget {
  final bool isPop;

  const LoaderWidget({Key key, this.isPop = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          height: 60,
          width: 60,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: isPop ? appWhiteColor : Colors.transparent,
              borderRadius: BorderRadius.circular(10)),
          child: Platform.isIOS
              ? CupertinoActivityIndicator(
            radius: 10,
          )
              : CircularProgressIndicator(
            strokeWidth: 5.0,
            // color: appBlueColor,
            backgroundColor: appWhiteColor,
            // valueColor:
          )),
    );
  }
}