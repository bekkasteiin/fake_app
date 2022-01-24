import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hse/core/model/bsa/bsa.dart';
import 'package:hse/core/model/util_models.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:hse/core/utils/globals.dart';

class BsaItem extends StatelessWidget {
  final BehaviorAudit behavior;

  const BsaItem(this.behavior);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    behavior?.empComment ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: generalFontStyle.copyWith(
                        fontSize: 14, color: appBlackColor),
                  ),
                ),
                Text(behavior?.objectName?.langValue ?? '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: generalFontStyle.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: appBlackColor.withOpacity(0.6))),
                Text(behavior?.workType ?? '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: generalFontStyle.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: appBlackColor.withOpacity(0.6))),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 140,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: getColorByStatus(behavior.status.code),
                  ),
                  child: Text('${behavior?.status?.langValue ?? 'Незарегистрирован'}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                      style: generalFontStyle.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: appWhiteColor)),
                ),
                Text(formatFullRestNotMilSec(behavior.regDateTime),
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: generalFontStyle.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: appBlackColor.withOpacity(0.6))),
                behavior?.category?.code == 'PLANNED'
                    ? getSyncIcon(behavior.filled && !behavior.isDone)
                    : getSyncIcon(behavior.id == null)
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget getStatus() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration:
      BoxDecoration(
          borderRadius: BorderRadius.circular(8.0), color: appBlueColor),
      child: Text(
        behavior.category.code == 'PLANNED' ? 'ПЛ' : 'ВП',
        style: generalFontStyle.copyWith(
            color: appWhiteColor, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget getSyncIcon(bool async) {
    return  !async
        ? SizedBox()
        : Icon(
      Icons.report_gmailerrorred_outlined,
      size: 24,
      color: appRedColor,
    );
  }

  Color getColorByStatus(String code) {
    return behavior.status?.code == 'CLOSED'
        ? appGreenColor
        : behavior.status?.code == 'CANCELED'
        ? appRedColor
        : behavior.status?.code == 'APPROVED'
        ? appDarkYellowColor
        : appBlueColor;
  }
}
