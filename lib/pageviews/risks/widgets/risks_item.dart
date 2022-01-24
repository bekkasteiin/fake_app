import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hse/core/model/risks/risks.dart';
import 'package:hse/core/model/util_models.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/generated/l10n.dart';

class RisksItem extends StatelessWidget {
  final RisksManagement risks;
  const RisksItem(this.risks);

  @override
  Widget build(BuildContext context) {
    var title = risks.id == null
        ? '${S.current.noSaved}' + dateFormatFullToNumeric(risks.initDate)
        : risks.regNumber == null ||
        risks.regNumber.isEmpty ||
        risks.regNumber == ' '
        ? S.current.notRegistered + ', ' +
        dateFormatFullToNumeric(risks.initDate)
        : '№' + risks.regNumber.toString() +
        ', ' +
        dateFormatFullToNumeric(risks.initDate);
    Color color;
    if (risks?.status == null) {
      color = appBlueColor;
    } else if (risks.status.code == 'CLOSED') {
      color = appGreenColor;
    } else if (risks.status.code == 'CANCELED') {
      color = appRedColor;
    } else if (risks.status.code == 'APPROVED') {
      color = appDarkYellowColor;
    } else {
      color = appBlueColor;
    }
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
                    title,
                    style: generalFontStyle.copyWith(
                        fontSize: 16, height: 1.6, color: appBlackColor),
                  ),
                  Row(
                    children: [
                      Text('${risks.objectName.langValue}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          softWrap: false,
                          style: generalFontStyle.copyWith(
                              fontSize: 14,
                              height: 1.5,
                              fontWeight: FontWeight.w300,
                              color: appBlackColor.withOpacity(0.6))),
                      SizedBox(width: 8,),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        color: color.withOpacity(0.3),
                        child: Text('${risks?.status?.langValue ?? ''}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            softWrap: false,
                            style: generalFontStyle.copyWith(
                                fontSize: 14,
                                height: 1.5,
                                fontWeight: FontWeight.w300,
                                color: appBlackColor.withOpacity(0.6))),
                      ),
                    ],
                  ),
                ],
              )),
          getSyncIcon(risks.id != null)
        ],
      ),
    );
  }

  Widget getStatus() {
    return Icon(
      risks.status?.code == 'CLOSED'
          ? Icons.check_circle_outline
          : risks.status?.code == 'CANCELED'
          ? risks.status?.code == 'APPROVED'
          ? Icons.check_circle_outline
          : Icons.not_interested
          : Icons.watch_later_outlined,
      color: risks.status?.code == 'CLOSED'
          ? appGreenColor
          : risks.status?.code == 'CANCELED'
          ? appRedColor
          : risks.status?.code == 'APPROVED'
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