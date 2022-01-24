import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hse/core/model/event/events.dart';
import 'package:hse/core/model/util_models.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:hse/core/utils/globals.dart';

class EventItem extends StatelessWidget {
  final EventManagement event;
  const EventItem(this.event);

  @override
  Widget build(BuildContext context) {
    var title = event.id == null
        ? event.supportDocument.supportDocNumber + ' Не сохранено '
        : event.regNumber == null ||
        event.regNumber.isEmpty ||
        event.regNumber == ' '
        ? event?.supportDocument?.supportDocNumber ?? "" + ', ' +  'Не зарегистрирован'
        : event?.supportDocument?.supportDocNumber ?? ""+ ' ' + event.regNumber.toString();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          getStatus(),
          SizedBox(
            width: 8,
          ),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dateFormatFullToNumeric(event.initDate),
                    style: generalFontStyle.copyWith(
                        fontSize: 16, height: 1.6, color: appBlackColor),
                  ),
                  Text(title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      softWrap: false,
                      style: generalFontStyle.copyWith(
                          fontSize: 14,
                          height: 1.5,
                          fontWeight: FontWeight.w300,
                          color: appBlackColor.withOpacity(0.6))),
                ],
              )),
          getSyncIcon(event.id != null)
        ],
      ),
    );
  }

  Widget getStatus() {
    return Icon(
      event.status?.code == 'CLOSED'
          ? Icons.check_circle_outline
          : event.status?.code == 'CANCELED'
          ? event.status?.code == 'APPROVED'
          ? Icons.check_circle_outline
          : Icons.not_interested
          : Icons.watch_later_outlined,
      color: event.status?.code == 'CLOSED'
          ? appGreenColor
          : event.status?.code == 'CANCELED'
          ? appRedColor
          : event.status?.code == 'APPROVED'
          ? appDarkYellowColor
          : appBlueColor,
      size: 40,
    );
  }

  Widget getSyncIcon(bool async) {
    return async
        ? SizedBox()
        : Icon(Icons.report_gmailerrorred_outlined,
      size: 32,
      color: appRedColor,);
  }
}