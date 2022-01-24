import 'package:flutter/material.dart';
import 'package:hse/core/model/event/event.dart';
import 'package:hse/core/model/ticket/ticket_history.dart';
import 'package:hse/core/model/util_models.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:hse/core/utils/globals.dart';

class EventItem extends StatelessWidget {
  final TicketHistory history;
  const EventItem(this.history);

  @override
  Widget build(BuildContext context) {
    // var title = eventEntity.id == null
    //     ? 'Не сохранено ' + dateFormatFullToNumeric(eventEntity.date)
    //     : eventEntity.regNumber == null ||
    //     eventEntity.regNumber.isEmpty ||
    //     eventEntity.regNumber == ' '
    //     ? 'Не зарегистрирован' ', ' + dateFormatFullToNumeric(eventEntity.date)
    //     : '№' +
    //     eventEntity.regNumber.toString() +
    //     ', ' +
    //     dateFormatFullToNumeric(eventEntity.date);
    // var planedTtl = eventEntity?.category?.code == null ? '' : eventEntity?.category?.code == 'PLANNED' ? ',' : '';
    return Container(
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
                formatFullRestNotMilSec(history.actionDate),
                style: generalFontStyle.copyWith(
                    fontSize: 16, height: 1.6, color: appBlackColor),
              ),
              Text('${history.type} (${getColorByCode(history.color)})',
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
          // eventEntity?.category?.code == 'PLANNED'
          //     ? getSyncIcon(eventEntity.filled && !eventEntity.isDone)
          //     : getSyncIcon(eventEntity.id == null)
        ],
      ),
    );
  }

  Widget getStatus() {
    return Icon(
      // eventEntity.status?.code == 'CLOSED'
      //     ? Icons.check_circle_outline
      //     : eventEntity.status?.code == 'CANCELED'
      //         ? eventEntity.status?.code == 'APPROVED'
      //             ? Icons.check_circle_outline
      //             : Icons.not_interested
      //         :
      Icons.watch_later_outlined,
      color:
      // eventEntity.status?.code == 'CLOSED'
      //     ? appGreenColor
      //     : eventEntity.status?.code == 'CANCELED'
      //         ? appRedColor
      //         : eventEntity.status?.code == 'APPROVED'
      //             ? appDarkYellowColor
      //             :
      appBlueColor,
      size: 40,
    );
  }

  Widget getSyncIcon(bool async) {
    return !async
        ? SizedBox()
        : Icon(
            Icons.report_gmailerrorred_outlined,
            size: 32,
            color: appRedColor,
          );
  }

  String getColorByCode(String code) {
    return code == 'GREEN' ? 'Зеленый' : code == 'YELLOW' ? 'Желтый' : 'Красный';
  }
}
