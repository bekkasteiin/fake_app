import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getflutter/getflutter.dart';
import 'package:hse/core/model/appeals/appeals.dart';
import 'package:hse/core/model/appeals/appel_topic.dart';
import 'package:hse/core/model/util_models.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/viewmodels/appeal_model.dart';
import 'package:provider/provider.dart';

import '../../core/utils/UI_Helpers.dart';

class AppealStepper extends StatelessWidget {
  AppealStepper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<AppealModel>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: Text(
            model.header,
            style: generalFontStyle.copyWith(fontSize: defaultFontSize + 8),
          ),
        ),
        CustomStepper(
          functions: [
            () {
              model.step = '/description';
              model.index = 1;
              model.setBusy(false);
            },
            () {
              model.step = '/type';
              model.index = 2;
              model.setBusy(false);
            },
            () {
              model.step = '/topic';
              model.index = 3;
              model.setBusy(false);
            },
            () {
              model.step = '/info';
              model.index = 4;
              model.setBusy(false);
            }
          ],
          current: model.index ?? 1,
        ),
      ],
    );
  }
}

class DescriptionField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var model = Provider.of<AppealModel>(context);
    return Container(
      width: isDesktop(context) ? 600 : null,
      height: isDesktop(context) ? 300 : GFSize.LARGE * 4,
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: TextField(
          maxLines: null,
          controller: model.commController,
          onChanged: (val) {
            model.appeal.description = val;
            model.setBusy(false);
          },
          decoration: InputDecoration.collapsed(
              hintText: S().comment,
              hintStyle: generalFontStyle.copyWith(
                  fontSize: defaultFontSize, color: appGreyColor)),
        ),
      ),
    );
  }
}

class AppealTypes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var model = Provider.of<AppealModel>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: Container(
        child: Wrap(
          children: [
            ...model.listTypes.map((e) {
              return Container(
                width:
                    isDesktop(context) ? GFSize.LARGE * 6 : GFSize.LARGE * 4.5,
                padding: const EdgeInsets.all(8.0),
                child: GFButton(
                  shape: GFButtonShape.pills,
                  size: isDesktop(context)
                      ? GFSize.LARGE * 2
                      : GFSize.LARGE * 1.2,
                  type: model.appeal.type == e.s
                      ? GFButtonType.solid
                      : GFButtonType.outline,
                  onPressed: () {
                    model.appeal.type = e.s;
                    model.setBusy(false);
                  },
                  text: e.carOrder,
                  textStyle: generalFontStyle.copyWith(
                      fontSize: defaultFontSize,
                      color: model.appeal.type == e.s
                          ? appWhiteColor
                          : appBlueColor),
                ),
              );
            }).toList()
          ],
        ),
      ),
    );
  }
}

class AppealTopics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var counter = Provider.of<AppealModel>(context);
    return FutureProvider<List<AppealTopic>>(
        create: (BuildContext context) => counter.getTopics(),
        initialData: null,
        child: Consumer<List<AppealTopic>>(builder: (context, model, _) {
          if (model == null) {
            return GFLoader(
              type: GFLoaderType.ios,
            );
          }
          return Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Container(
              child: Wrap(
                children: [
                  ...model.map((e) {
                    return Container(
                      width: GFSize.LARGE * 4.5,
                      height: GFSize.LARGE * 1.5,
                      padding: const EdgeInsets.all(8.0),
                      child: GFButton(
                        shape: GFButtonShape.pills,
                        size: isDesktop(context)
                            ? GFSize.LARGE * 2
                            : GFSize.LARGE,
                        type: counter.appeal.topic == e.code
                            ? GFButtonType.solid
                            : GFButtonType.outline,
                        onPressed: () {
                          counter.appeal.topic = e.code;
                          counter.setBusy(false);
                        },
                        text: e.getName(context),
                        textStyle: generalFontStyle.copyWith(
                          fontSize: defaultFontSize - 4,
                          color: counter.appeal.topic == e.code
                              ? appWhiteColor
                              : appBlueColor,
                        ),
                      ),
                    );
                  }).toList()
                ],
              ),
            ),
          );
        }));
  }
}

class OrderInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var model = Provider.of<AppealModel>(context);
    return Container(
      width: isDesktop(context) ? 600 : null,
      height: isDesktop(context) ? 300 : null,
      margin: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  S().appealText,
                  style: captionStyle,
                ),
                subtitle: Container(
                  height: 125,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: appFiledBorderColor),
                  ),
                  child: Text(
                    model.appeal.description ?? '',
                    style: namingStyle,
                    maxLines: null,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  '${S().appealType}:',
                  style: captionStyle,
                ),
                subtitle: Text(
                  getCodeLang(model.appeal.type),
                  style: namingStyle,
                ),
              ),
              ListTile(
                title: Text(
                  '${S().appealTopic}:',
                  style: captionStyle,
                ),
                subtitle: Text(
                  getCodeLang(model.appeal.topic),
                  style: namingStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppealsHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<AppealModel>(context);
    return FutureProvider<List<Appeals>>(
        create: (BuildContext context) => counter.appeals,
        initialData: null,
        child: Consumer<List<Appeals>>(builder: (context, model, _) {
          if (model == null) {
            return GFLoader(
              type: GFLoaderType.ios,
            );
          }
          return Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: Container(
              child: ListView(
                children: [
                  ...model.map((e) => buildBox(e, context, counter)).toList()
                ],
              ),
            ),
          );
        }));
  }

  Widget buildBox(Appeals e, BuildContext context, AppealModel counter) {
    return Stack(
      children: [
        isDesktop(context)
            ? buildMobileListItem(e) //buildDesktopItem(e, counter)
            : buildMobileListItem(e),
        // isDesktop(context)
        //     ? Positioned(
        //         child: Padding(
        //           padding: const EdgeInsets.only(right: 10.0, top: 0),
        //           child: Container(
        //             width: GFSize.LARGE * 2.7,
        //             height: GFSize.MEDIUM * 1,
        //             child: GFButton(
        //               onPressed: () {},
        //               text: getCodeLang(e.status),
        //               textStyle:
        //                   generalFontStyle.copyWith(fontSize: defaultFontSize-2, color: Colors.white),
        //               color: getStatusColor(e.status),
        //             ),
        //           ),
        //         ),
        //         right: isDesktop(context) ? 95 : 1,
        //       )
        //     : Container()
      ],
    );
  }

  GestureDetector buildDesktopItem(Appeals e, AppealModel counter) {
    return GestureDetector(
      onTap: () {
        if (counter.selected == e.id) {
          counter.selected = '';
        } else {
          counter.selected = e.id;
        }
        counter.setBusy(false);
      },
      child: Container(
          margin: EdgeInsets.fromLTRB(100, 10, 100, 0),
          decoration: BoxDecoration(
              border: Border.all(
                color: disabledColor(e) == Colors.black
                    ? appBlueColor
                    : appFiledBorderColor,
              ),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 300,
                    child: ListTile(
                      title: Text(
                        getCodeLang(e.topic),
                        style: generalFontStyle.copyWith(
                            fontSize: defaultFontSize + 14),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        height: GFSize.LARGE * 2,
                        decoration: BoxDecoration(
                            border: Border(
                                right:
                                    BorderSide(color: appGreyColor, width: 1))),
                      ),
                      Icon(
                        Icons.calendar_today,
                        color: hexToColor('#FB9764'),
                        size: GFSize.MEDIUM,
                      ),
                      Text(
                          formatNamedDate(
                            e.appealLocalDateTime,
                          ),
                          style: generalFontStyle.copyWith(
                              fontSize: defaultFontSize - 2))
                    ],
                  )
                ],
              ),
              counter.selected == e.id
                  ? Container(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(e.description ?? ''),
                      ),
                    )
                  : SizedBox()
            ],
          )),
    );
  }

  Container buildMobileListItem(Appeals e) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: appBlueColor, width: 0.2)),
      ),
      child: ExpansionTile(
        leading: Container(
          width: 30,
          alignment: Alignment.centerLeft,
          child: Icon(
            disabledColor(e) == Colors.black
                ? FontAwesomeIcons.clock
                : FontAwesomeIcons.checkCircle,
            color:
                disabledColor(e) == Colors.black ? appRedColor : appGreenColor,
            size: GFSize.LARGE * 0.85,
          ),
        ),
        title: Text(
          getCodeLang(e.topic),
          style: generalFontStyle.copyWith(
              fontSize: defaultFontSize + 2,
              color: disabledColor(e) == Colors.black
                  ? appBlackColor
                  : appBlackColor),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Text(
            formatOnlyDate(e.appealLocalDateTime) ?? '',
            style: generalFontStyle.copyWith(
                color: appGreyColor, fontSize: defaultFontSize - 2),
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(25.0, 15, 5, 0),
            child: Container(
              alignment: Alignment.topLeft,
              child: Text(
                S().appealText,
                style: captionStyle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25.0, 5, 5, 0),
            child: Container(
              alignment: Alignment.topLeft,
              child: Text(
                e.description ?? S().noData,
                style: namingStyle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25.0, 25, 5, 0),
            child: Container(
              alignment: Alignment.topLeft,
              child: Text(
                S().resolution,
                style: captionStyle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25.0, 5, 5, 0),
            child: Container(
              alignment: Alignment.topLeft,
              child: Text(e.decision ?? S().noData, style: namingStyle),
            ),
          ),
          SizedBox(
            height: 25,
          )
        ],
      ),
    );
  }

  Color disabledColor(Appeals e) {
    return e.status == 'COMPLETED' ||
            e.status == 'CANCELED' ||
            e.status == 'UNAPPROVED' ||
            e.status == 'CLOSED'
        ? appGreyColor
        : Colors.black;
  }
}
