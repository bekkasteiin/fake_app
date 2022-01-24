import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hse/core/model/message/message.dart';
import 'package:hse/core/model/util_models.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/core/utils/UI_Helpers.dart';

class MessageItem extends StatelessWidget {
  final Message message;
  final bool existPush;

  const MessageItem(this.message, [this.existPush = false]);

  @override
  Widget build(BuildContext context) {
    var title = message.category.code == 'DC'
        ? message.dangerousConditionCategories?.first?.langValue ?? ''
        : message.category.code == 'DA'
        ? message.dangerousActions?.first?.langValue ?? ''
        : message.category.code == 'OTHER'
        ? message?.otherViolationComment ?? ''
        : SizedBox();
    Color color;
    if (message?.status == null) {
      color = appBlueColor;
    } else if (message.status.code == 'CLOSED') {
      color = appGreenColor;
    } else if (message.status.code == 'CANCELED') {
      color = appRedColor;
    } else if (message.status.code == 'APPROVED') {
      color = appDarkYellowColor;
    } else {
      color = appBlueColor;
    }
    return Container(
      color: existPush ? appBlueColor.withOpacity(0.3) : null,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          children: [
            Row(
              children: [
                getStatus(),
                Flexible(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      message.objectName.langValue ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: generalFontStyle.copyWith(
                          fontSize: 14, color: appBlackColor),
                    ),
                  ),
                ),
                Container(
                  width: 140,
                  alignment: Alignment.center,
                  padding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: color,
                  ),
                  child: Text('${message?.status?.langValue ?? 'Незарегистрирован'}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                      style: generalFontStyle.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: appWhiteColor)),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text('$title',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: generalFontStyle.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: appBlackColor.withOpacity(0.6))),
                ),
                Row(
                  children: [
                    Text(formatFullRestNotMilSec(message.initDateTime),
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: generalFontStyle.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: appBlackColor.withOpacity(0.6))),
                    getSyncIcon(message.id != null)
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getStatus() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0), color: appBlueColor),
      child: Text(
        message.category.code == 'DC'
            ? 'ОУ'
            : message.category.code == 'DA'
            ? 'ОД'
            : message.category.code == 'OTHER'
            ? '  -  '
            : SizedBox(),
        style: generalFontStyle.copyWith(
            color: appWhiteColor, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget getSyncIcon(bool async) {
    return existPush
        ? Icon(
      Icons.notifications_active_outlined,
      color: getColorByStatus(
        message.status?.code,
      ),
      size: 24,
    )
        : !async
        ? Icon(
      Icons.report_gmailerrorred_outlined,
      size: 24,
      color: appRedColor,
    )
        : SizedBox(
      width: 24,
    );
  }

  Color getColorByStatus(String code) {
    return message.status?.code == 'CLOSED'
        ? appGreenColor
        : message.status?.code == 'CANCELED'
        ? appRedColor
        : message.status?.code == 'APPROVED'
        ? appDarkYellowColor
        : appBlueColor;
  }
}
