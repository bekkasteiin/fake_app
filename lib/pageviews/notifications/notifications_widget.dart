import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getflutter/getflutter.dart';
import 'package:hse/core/model/notification/Notification.dart';
import 'package:hse/core/model/util_models.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/viewmodels/notifications_model.dart';
import 'package:provider/provider.dart';

import '../../core/utils/UI_Helpers.dart';

class NotificationsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<NotificationsModel>(context);
    return FutureProvider<List<Notifications>>(
        create: (BuildContext context) => counter.notification,
        initialData: null,
        child: Consumer<List<Notifications>>(builder: (context, model, _) {
          if (model == null) {
            return GFLoader(
              type: GFLoaderType.ios,
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                ...model.map((e) => buildBox(e, counter, context)).toList()
              ],
            ),
          );
        }));
  }

  Widget buildBox(
      Notifications e, NotificationsModel counter, BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.2, color: appBlueColor))),
      child: ExpansionTile(
        // expandedCrossAxisAlignment: CrossAxisAlignment.start,
        leading: getIconStatus(e.status),
        title: Text(
          e.title ?? '_',
          style: namingStyle,
        ),
        onExpansionChanged: (val) => counter.setIsReaded(e, val),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              formatNamedDate(e.createTs ?? '_'),
              style: captionStyle,
            )
          ],
        ),
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.fromLTRB(25, 0, 25, 20),
            child: Text(
              e.notification ?? S().noData, //'Нет данных',
              style: captionStyle,
              textAlign: TextAlign.left,
            ),
          ),
          counter.checkIsButtonRequired(e)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.2, color: appGreenColor),
                          borderRadius: BorderRadius.circular(10)),
                      height: GFSize.LARGE * 1.2,
                      width: GFSize.LARGE * 4,
                      child: GFButton(
                        text: S().approved, //'УТВЕРДИТЬ',
                        textStyle: generalFontStyle.copyWith(
                            fontSize: defaultFontSize + 2,
                            fontWeight: FontWeight.bold),
                        color: appGreenColor,
                        onPressed: () => counter.submitCarOrder(e, true),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.2, color: appGreenColor),
                          borderRadius: BorderRadius.circular(10)),
                      height: GFSize.LARGE * 1.2,
                      width: GFSize.LARGE * 4,
                      child: GFButton(
                        text: S().reject, //'ОТКЛОНИТЬ',
                        color: appGreenColor,
                        textStyle: generalFontStyle.copyWith(
                            fontSize: defaultFontSize + 2,
                            fontWeight: FontWeight.bold,
                            color: appRedColor),
                        type: GFButtonType.outline,
                        onPressed: () => counter.submitCarOrder(e, false),
                      ),
                    ),
                  ],
                )
              : SizedBox(),
          e.status == 'APPROVED' || e.status == 'UNAPPROVED'
              ? Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: e.status == 'APPROVED'
                              ? appGreenColor
                              : appRedColor,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    height: GFSize.LARGE * 1.2,
                    width: GFSize.LARGE * 4,
                    child: GFButton(
                      text: getCodeLang(e.status),
                      textStyle: generalFontStyle.copyWith(
                          fontSize: defaultFontSize + 2,
                          fontWeight: FontWeight.bold),
                      color:
                          e.status == 'APPROVED' ? appGreenColor : appRedColor,
                      onPressed: () {},
                    ),
                  ),
                )
              : SizedBox(),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}

//Desktop Widgets
class NotificationsDesktopList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<NotificationsModel>(context);
    return FutureProvider<List<Notifications>>(
        create: (BuildContext context) => counter.notification,
        initialData: null,
        child: Consumer<List<Notifications>>(builder: (context, model, _) {
          if (model == null) {
            return GFLoader(
              type: GFLoaderType.ios,
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                ...model.map((e) => buildBox(e, counter, context)).toList()
              ],
            ),
          );
        }));
  }

  Widget buildBox(
      Notifications e, NotificationsModel counter, BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0)),
      child: ExpansionTile(
          title: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      FontAwesomeIcons.bell,
                      color: appBlueColor,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      e.title ?? '_',
                      style: namingStyle,
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      FontAwesomeIcons.clock,
                      color: appBlueColor,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      formatNamedDate(e.createTs ?? '_'),
                      style: namingStyle,
                    )
                  ],
                ),
              ),
            ],
          ),
          onExpansionChanged: (val) => counter.setIsReaded(e, val),
          children: [
            Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(56, 5, 0, 0),
                    height: GFSize.LARGE * 3,
                    width: GFSize.LARGE * 9,
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        child: Text(
                          e.notification ?? '   ',
                          style: namingStyle,
                        ),
                      ),
                    ),
                  ),
                  counter.checkIsButtonRequired(e)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GFButton(
                              text: S().affirm,
                              onPressed: () => counter.submitCarOrder(e, true),
                            ),
                            GFButton(
                              text: S().canceling,
                              color: appFiledBorderColor,
                              textColor: hexToColor('#95989A'),
                              onPressed: () => counter.submitCarOrder(e, false),
                            ),
                          ],
                        )
                      : SizedBox(),
                  e.status == 'APPROVED' || e.status == 'UNAPPROVED'
                      ? Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Text(getCodeLang(e.status)))
                      : SizedBox()
                ]),
              ],
            ),
          ]),
    );
  }
}
