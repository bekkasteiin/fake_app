import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getflutter/size/gf_size.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:intl/intl.dart' show DateFormat;

class LinearSales {
  final int year;
  final String type;

  LinearSales(this.year, this.type);
}

DateFormat fullDate = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
var dateFormatFullNumeric = DateFormat('dd.MM.yyyy HH:mm');
var dateFormatFullRest = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
var dateFormatFullRestNotMilSec = DateFormat('dd.MM.yyyy');

String dateTimeToString(DateTime dateTime) {
  return fullDate.format(dateTime);
}

String dateFormatFullToNumeric(DateTime dateTime) {
  return dateFormatFullNumeric.format(dateTime);
}

stringToDateTime(String dateTime) {
  return fullDate.parse(dateTime);
}

String formatFullRest(DateTime val) {
  if (val == null) return null;
  return dateFormatFullRest.format(val);
}

String formatFullRestNotMilSec(DateTime val) {
  if (val == null) return null;
  return dateFormatFullRestNotMilSec.format(val);
}

getStatusColor(String status) {
  switch (status) {
    case ('IS_NEW'):
      return Colors.deepOrangeAccent;
    case ('DRAFT'):
      return Colors.deepOrangeAccent;
    case ('ON_APPROVAL'):
      return appBlueColor;
    case ('CLOSED'):
      return Colors.grey;
    case ('IN_PROGRESS'):
      return appBlueColor;
    case ('APPROVED'):
      return appBlueColor;
    case ('UNAPPROVED'):
      return appRedColor;
    case ('ON_DISTRIBUTION'):
      return appGreenColor;
    case ('EXPECTATION'):
      return appGreenColor;
    case ('COMPLETED'):
      return Colors.grey;
    case ('CANCELED'):
      return appRedColor;
    case ('REJECTED'):
      return appRedColor;
    case ('ONAPPROVE'):
      return Colors.deepOrangeAccent;
  }
}

String getNewsType(String type) {
  switch (type) {
    case ('OTHERS'):
      return S().others;
    case ('TEST'):
      return S().newsTest;
    case ('seasonIssue'):
      return S().seasonIssue;
    default:
      return '';
  }
}

String getCodeLang(String code) {
  switch (code) {
    case ('MOBILE'):
      return S().MOBILE;
    case ('CAR_ORDER'):
      return S().CAR_ORDER;
    case ('ALLOWANCE'):
      return S().ALLOWANCE;
    case ('WORK_ORDER'):
      return S().WORK_ORDER;
    case ('TESTING'):
      return S().TESTING;
    case ('EATING'):
      return S().EATING;
    case ('PPE'):
      return S().PPE;
    case ('IS_NEW'):
      return S().IS_NEW;
    case ('DRAFT'):
      return S().DRAFT;
    case ('ON_APPROVAL'):
      return S().ON_APPROVAL;
    case ('CLOSED'):
      return S().CLOSED;
    case ('IN_PROGRESS'):
      return S().IN_PROGRESS;
    case ('APPROVED'):
      return S().APPROVED;
    case ('UNAPPROVED'):
      return S().UNAPPROVED;
    case ('ON_DISTRIBUTION'):
      return S().ON_DISTRIBUTION;
    case ('EXPECTATION'):
      return S().EXPECTATION;
    case ('COMPLETED'):
      return S().COMPLETED;
    case ('CANCELED'):
      return S().CANCELED;
    case ('ONAPPROVE'):
      return S().ONAPPROVE;
    case ('PLAN'):
      return S().PLAN;
    case ('EXIT'):
      return S().EXIT;
    case ('ENTRANCE'):
      return S().ENTRANCE;
    case ('UNPLAN'):
      return S().UNPLAN;
    case ('UPGRADE'):
      return S().UPGRADE;
    case ('SERVICE_PLAN'):
      return S().SERVICE_PLAN;
    case ('SERVICE_UNPLAN'):
      return S().SERVICE_UNPLAN;
    case ('REJECTED'):
      return S().REJECTED;
    case ('JANUARY'):
      return S().JANUARY;
    case ('FEBRUARY'):
      return S().FEBRUARY;
    case ('MARCH'):
      return S().MARCH;
    case ('APRIL'):
      return S().APRIL;
    case ('MAY'):
      return S().MAY;
    case ('JUNE'):
      return S().JUNE;
    case ('JULY'):
      return S().JULY;
    case ('AUGUST'):
      return S().AUGUST;
    case ('SEPTEMBER'):
      return S().SEPTEMBER;
    case ('OCTOBER'):
      return S().OCTOBER;
    case ('NOVEMBER'):
      return S().NOVEMBER;
    case ('DECEMBER'):
      return S().DECEMBER;
    case ('complaint'):
      return S().complaint;
    case ('suggestion'):
      return S().idea;
    case ("ECONOMY"):
      return S().ECONOMY;
    case ("COMFORT"):
      return S().COMFORT;
    case ("FREIGHT"):
      return S().FREIGHT;
    default:
      return '';
  }
}

Widget getIconStatus(String code) {
  switch (code) {
    case ('DRAFT'):
      return Icon(
        FontAwesomeIcons.clock,
        color: appBlueColor,
        size: GFSize.LARGE * 0.9,
      );
    case ('ON_APPROVAL'):
      return Icon(
        FontAwesomeIcons.clock,
        color: appBlueColor,
        size: GFSize.LARGE * 0.9,
      );
    case ('CLOSED'):
      return Image.asset(
        'assets/images/refuseIcon.png',
        scale: 0.9,
      );
    case ('APPROVED'):
      return Image.asset(
        'assets/images/checkIcon.png',
        scale: 0.9,
      );
    case ('UNAPPROVED'):
      return Icon(
        Icons.not_interested,
        color: appRedColor,
        size: 40,
      );
    case ('ONAPPROVE'):
      return Image.asset(
        'assets/images/refuseIcon.png',
        scale: 0.9,
      );
    default:
      return Icon(
        FontAwesomeIcons.clock,
        color: appBlueColor,
        size: GFSize.LARGE * 0.9,
      );
  }
}
