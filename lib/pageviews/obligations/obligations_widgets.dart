import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getflutter/getflutter.dart';
import 'package:hse/core/model/material_obligations/MaterialObligations.dart';
import 'package:hse/core/model/ppe/PersonalProtectionEquipment.dart';
import 'package:hse/core/model/ppe/Ppe.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/viewmodels/obligations_model.dart';
import 'package:hse/viewmodels/ppe_model.dart';
import 'package:hse/viewmodels/user_info.dart';
import 'package:kinfolk/kinfolk.dart';
import 'package:provider/provider.dart';

import '../../core/utils/UI_Helpers.dart';
import 'obligations_items/obligations_items_list.dart';
import 'obligations_items/tools_list.dart';
import 'obligations_ppe_list.dart';

// список обязательств
class ObligationButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          GestureDetector(
              onTap: () => Get.to(ObligationsPageView()),
              child: getBox(context: context, title: S().equipment)),
          GestureDetector(
              onTap: () => Get.to(ToolsPageView()),
              child: getBox(context: context, title: S().tools)),
          GestureDetector(
              onTap: () => Get.to(ObligationsPpeView()),
              child: getBox(context: context, title: S().ppe)),
        ],
      ),
    );
  }

  Widget getBox({context, title}) {
    return Container(
      margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 20.0),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: appBlueColor, width: 0.2)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  title,
                  style: generalFontStyle.copyWith(
                      color: appBlueColor, fontSize: defaultFontSize + 5),
                ),
              ),
              Icon(
                FontAwesomeIcons.chevronRight,
                color: appBlueColor,
                size: GFSize.SMALL * 0.6,
              ),
            ],
          ),
          SizedBox(height: 15.0)
        ],
      ),
    );
  }
}

class ObligationAmountWidget extends StatelessWidget {
  final bool isBody;

  ObligationAmountWidget({this.isBody = false});

  @override
  Widget build(BuildContext context) {
    final oblModel = Provider.of<ObligationsViewModel>(context);
    final counter = Provider.of<UserInfoModel>(context);
    return FutureProvider<MaterialObligations>(
        create: (BuildContext context) => oblModel.mol,
        initialData: null,
        child: Consumer<MaterialObligations>(builder: (context, model, _) {
          if (model == null) {
            return Container(
              child: GFLoader(
                type: GFLoaderType.ios,
              ),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Container(
                      margin: EdgeInsets.fromLTRB(20.0, 15.0, 25.0, 20.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: appFiledBorderColor),
                          borderRadius: BorderRadius.circular(10),
                          color: appYellowColor),
                      child: ListTile(
                        leading: Icon(
                          FontAwesomeIcons.radiationAlt,
                          color: appRedColor,
                          size: GFSize.SMALL,
                        ),
                        title: Wrap(
                            // mainAxisSize: MainAxisSize.max,
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                  '${S().total}: ${model.totalAmount.toInt()} позиции ',
                                  style: namingStyle),
                              Text(counter.formatCash(model.total),
                                  style: namingStyle)
                            ]),
                        subtitle: Text(S().caseLossAssets, style: captionStyle),
                      )),
                ),
              ],
            ),
          );
        }));
  }
}

// Список СИЗ(СО) в обязательствах
class ObligationsPpeList extends StatelessWidget {
  final bool isBody;

  ObligationsPpeList({this.isBody = false});

  @override
  Widget build(BuildContext context) {
    final ppeModel = Provider.of<PpeViewModel>(context);
    final counter = Provider.of<UserInfoModel>(context);
    return FutureProvider<PersonalProtectionEquipment>(
        create: (BuildContext context) => ppeModel.ppes,
        initialData: null,
        child:
            Consumer<PersonalProtectionEquipment>(builder: (context, model, _) {
          if (model == null) {
            return Container(
              child: GFLoader(
                type: GFLoaderType.ios,
              ),
            );
          }
          var desktop = isDesktop(context);
          var length2 = model.ppes.length;
          var list = (desktop
                  ? model.ppes
                  : model.ppes.sublist(0, isBody ? length2 : 3))
              .map((e) {
            //var list = model.ppes.sublist(0, isBody ? model.ppes.length : 3).map((e) {
            return buildGestureDetector(e, context);
          }).toList();
          if (!desktop) {
            list.add(GestureDetector(
              child: SizedBox(
                height: GFSize.MEDIUM,
              ),
            ));
          }

          // list.add(GestureDetector(
          //   child: SizedBox(
          //     height: GFSize.MEDIUM,
          //   ),
          // ));
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                      decoration: BoxDecoration(
                          border: Border.all(color: appGreyColor),
                          borderRadius: BorderRadius.circular(10),
                          color: appYellowColor),
                      child: ListTile(
                        leading: Icon(
                          FontAwesomeIcons.radiationAlt,
                          color: appRedColor,
                          size: GFSize.SMALL,
                        ),
                        title: Wrap(
                            // mainAxisSize: MainAxisSize.max,
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('${S().total}: ${model.ppes.length} позиции ',
                                  style: namingStyle),
                              Text(counter.formatCash(ppeModel.totalCost),
                                  style: namingStyle)
                            ]),
                        subtitle: Text(S().caseLossAssets, style: captionStyle),
                      )),
                ),
                Container(
                  //height: MediaQuery.of(context).size.height * (isBody ? 1 : 0.4),
                  height: desktop
                      ? MediaQuery.of(context).size.height * 0.5
                      : MediaQuery.of(context).size.height *
                          (isBody ? 0.77 : 0.4),
                  padding: const EdgeInsets.all(0.0),
                  margin: EdgeInsets.only(top: 10.0),
                  child: kIsWeb
                      ? Scrollbar(
                          child: SingleChildScrollView(
                            child: Wrap(
                              children: list,
                            ),
                          ),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: list,
                          ),
                        ),
                )
              ],
            ),
          );
        }));
  }

  // построение СИЗ(СО)
  GestureDetector buildGestureDetector(Ppe e, BuildContext context) {
    var desktop = isDesktop(context);
    final counter = Provider.of<UserInfoModel>(context);
    return GestureDetector(
      onTap: null,
      //RML СИЗ в обязательствах
      child: Container(
        decoration: BoxDecoration(
          color: appWhiteColor,
          border: Border.all(color: appFiledBorderColor, width: 0.5),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: appGreyColor.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(2, 2), // changes position of shadow
            ),
          ],
        ),
        margin: kIsWeb
            ? EdgeInsets.fromLTRB(0, 5, 5, 0)
            : EdgeInsets.fromLTRB(20, 5, 20, 0),
        //margin: const EdgeInsets.fromLTRB(20, 5, 20, 0),
        padding: const EdgeInsets.all(5.0),
        width: desktop ? 400 : null,
        height: desktop ? 130 : null,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GFImageOverlay(
                  height: desktop ? GFSize.LARGE * 1.5 : 57,
                  width: desktop ? GFSize.LARGE : 57,
                  boxFit: BoxFit.contain,
                  colorFilter:
                      ColorFilter.mode(Colors.transparent, BlendMode.color),
                  image: AssetImage(e.image ?? 'assets/images/helmet.png'),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              e.langValue,
                              style: namingStyle,
                              maxLines: 2,
                            ),
                          ),
                          Icon(
                            e.issueDate != ''
                                ? FontAwesomeIcons.checkCircle
                                : FontAwesomeIcons.ban,
                            color:
                                e.issueDate != '' ? appGreenColor : appRedColor,
                            size: GFSize.SMALL,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '% ${S().wear}',
                            style: captionStyle,
                          ),
                          Text('${S().cost}', style: captionStyle),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: GFProgressBar(
                                reverse: true,
                                leading: Text('${e.perscentWear}',
                                    style: namingStyle),
                                width: 80,
                                percentage: e.perscentWear / 100,
                                backgroundColor:
                                    buildProgressColor(e.perscentWear),
                                progressBarColor: appGreyColor),
                          ),
                          Text(counter.formatCash(e.actualCost),
                              style: namingStyle),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Row(
                      //   mainAxisSize: MainAxisSize.max,
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Container(
                      //       width: 160,
                      //       child: Column(
                      //         mainAxisSize: MainAxisSize.max,
                      //         mainAxisAlignment: MainAxisAlignment.start,
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           Container(
                      //             alignment: Alignment.centerLeft,
                      //             child: Text(
                      //               '% ${S().wear}',
                      //               style: captionStyle,
                      //             ),
                      //           ),
                      //           GFProgressBar(
                      //               reverse: true,
                      //               leading: Text(
                      //                 '${e.perscentWear}',
                      //                 style: namingStyle
                      //               ),
                      //               width: 90,
                      //               percentage: e.perscentWear / 100,
                      //               backgroundColor: buildProgressColor(e.perscentWear),
                      //               progressBarColor: appGreyColor),
                      //         ],
                      //       ),
                      //     ),
                      //     Container(
                      //       child: Column(
                      //         mainAxisSize: MainAxisSize.max,
                      //         mainAxisAlignment: MainAxisAlignment.end,
                      //         crossAxisAlignment: CrossAxisAlignment.end,
                      //         children: [
                      //           Container(
                      //             child: Text(
                      //               '${S().cost}',
                      //               style: generalFontStyle.copyWith(
                      //                   fontSize: defaultFontSize,
                      //                   color: appGreyColor),
                      //             ),
                      //           ),
                      //           Container(
                      //             child: Text(
                      //               counter.formatCash(e.actualCost),
                      //               style: generalFontStyle.copyWith(
                      //                   fontSize: defaultFontSize+2,
                      //                   color: appBlackColor),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
        // child: GFListTile(
        //   title: Text(
        //     e.langValue,
        //     style: generalFontStyle.copyWith(color: appBlackColor, fontSize: 16),
        //   ),
        //   subTitle: Padding(
        //     padding: const EdgeInsets.only(top: 10.0),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.start,
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: [
        //         Container(
        //           width: 150,
        //           child: Column(
        //             children: [
        //               Container(
        //                 alignment: Alignment.centerLeft,
        //                 child: Text(
        //                   '% ${S().wear}',
        //                   style: generalFontStyle.copyWith(
        //                       fontSize: 16, color: appGreyColor),
        //                 ),
        //               ),
        //               GFProgressBar(
        //                   leading: Text(
        //                     '${e.perscentWear}',
        //                     style: generalFontStyle.copyWith(fontSize: 16),
        //                   ),
        //                   width: 85,
        //                   percentage: e.perscentWear / 100,
        //                   backgroundColor: buildProgressColor(e.perscentWear),
        //                   progressBarColor: appGreyColor),
        //             ],
        //           ),
        //         ),
        //         Spacer(),
        //         Container(
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.end,
        //             crossAxisAlignment: CrossAxisAlignment.end,
        //             children: [
        //               Container(
        //                 child: Text(
        //                   '${S().cost}',
        //                   style: generalFontStyle.copyWith(
        //                       fontSize: 16, color: appGreyColor),
        //                 ),
        //               ),
        //               Container(
        //                 child: Text(
        //                   counter.formatCash(e.actualCost),
        //                   style: generalFontStyle.copyWith(
        //                       fontSize: 16, color: appBlackColor),
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        //   avatar: GFImageOverlay(
        //     height: GFSize.LARGE * 1.2,
        //     width: GFSize.LARGE * 1.2,
        //     colorFilter: ColorFilter.mode(Colors.transparent, BlendMode.color),
        //     image: NetworkImage(Kinfolk.getFileUrl(e.image)),
        //   ),
        // ),
      ),
    );
  }

  Color buildProgressColor(double perscentWear) {
    if (perscentWear < 50) {
      return appGreenColor;
    }
    if (perscentWear < 80) {
      return appRedColor;
    }
    return GFColors.DANGER;
  }
}

class ObligationsPpePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              S().ppeList,
              style: generalFontStyle.copyWith(fontSize: defaultFontSize + 5),
            )),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: ObligationsPpeList(
          isBody: true,
        ),
      ),
    );
  }
}

//Desktop Widgets

class ObligationDesktopButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          GestureDetector(
              onTap: () => Get.to(ToolsPageView()),
              child: getBox(context: context, title: S().tools)),
          GestureDetector(
              onTap: () => Get.to(ObligationsPageView()),
              child: getBox(context: context, title: S().equipment)),
          GestureDetector(
              onTap: () => Get.to(ObligationsPpeView()),
              child: getBox(context: context, title: S().ppe)),
          getBox(context: context, title: S().other),
        ],
      ),
    );
  }

  Widget getBox({context, title}) {
    return Container(
      margin: isDesktop(context)
          ? const EdgeInsets.fromLTRB(100, 10, 100, 20)
          : null,
      padding: const EdgeInsets.all(8.0),
      height: GFSize.LARGE * 2,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(50.0, 0.0, 0.0, 0.0),
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  .copyWith(color: appBlueColor, fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 30.0, 0.0),
            child: Icon(
              FontAwesomeIcons.angleRight,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}

class ObligationDesktopAmountWidget extends StatelessWidget {
  final bool isBody;

  ObligationDesktopAmountWidget({this.isBody = false});

  @override
  Widget build(BuildContext context) {
    final oblModel = Provider.of<ObligationsViewModel>(context);
    final counter = Provider.of<UserInfoModel>(context);
    return FutureProvider<MaterialObligations>(
        create: (BuildContext context) => oblModel.mol,
        initialData: null,
        child: Consumer<MaterialObligations>(builder: (context, model, _) {
          if (model == null) {
            return Container(
              child: GFLoader(
                type: GFLoaderType.ios,
              ),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: isDesktop(context)
                      ? const EdgeInsets.fromLTRB(100, 30, 100, 20)
                      : null,
                  height: GFSize.LARGE * 1.1,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${S().total}: ${model.totalAmount}'),
                            Text(
                              counter.formatCash(model.total),
                              style: TextStyle(color: appBlueColor),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }));
  }
}

class ObligationsDesktopPpeList extends StatelessWidget {
  final bool isBody;

  ObligationsDesktopPpeList({this.isBody = false});

  @override
  Widget build(BuildContext context) {
    final ppeModel = Provider.of<PpeViewModel>(context);
    final counter = Provider.of<UserInfoModel>(context);
    return FutureProvider<PersonalProtectionEquipment>(
        create: (BuildContext context) => ppeModel.ppes,
        initialData: null,
        child:
            Consumer<PersonalProtectionEquipment>(builder: (context, model, _) {
          if (model == null) {
            return Container(
              child: GFLoader(
                type: GFLoaderType.ios,
              ),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(8.0),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black12)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${S().total}: ${model.ppes.length}'),
                            Text(counter.formatCash(ppeModel.totalCost))
                          ],
                        ),
                        ListTile(
                          leading: Image.asset(
                            'assets/images/attentionIcon.png',
                            color: appBlueColor,
                          ),
                          title: Text(
                            S().caseLossAssets,
                            style: TextStyle(fontSize: 13),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height:
                      MediaQuery.of(context).size.height * (isBody ? 1 : 0.4),
                  child: ListView(
                    children: model.ppes
                        .sublist(0, isBody ? model.ppes.length : 3)
                        .map((e) {
                      return GestureDetector(
                        onTap: null,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12)),
                          margin: const EdgeInsets.all(8.0),
                          child: GFBadge(
                            color: Colors.white,
                            size: GFSize.LARGE * 5,
                            child: Column(
                              children: [
                                GFListTile(
                                  title: Text(
                                    e.langValue
                                        .split(' ')
                                        .sublist(0, 2)
                                        .join(" "),
                                    style: TextStyle(
                                        color: appBlueColor, fontSize: 14),
                                  ),
                                  subTitle: Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Text(
                                      '${e.perscentWear}% ${S().wear}',
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ),
                                  avatar: GFImageOverlay(
                                    height: GFSize.LARGE,
                                    width: GFSize.LARGE,
                                    colorFilter: ColorFilter.mode(
                                        Colors.transparent, BlendMode.color),
                                    image: NetworkImage(
                                        Kinfolk.getFileUrl(e.image)),
                                  ),
                                ),
                                GFProgressBar(
                                    percentage: e.perscentWear / 100,
                                    backgroundColor: Colors.black26,
                                    progressBarColor:
                                        buildProgressColor(e.perscentWear)),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
          );
        }));
  }

  Color buildProgressColor(double perscentWear) {
    if (perscentWear < 50) {
      return appGreenColor;
    }
    if (perscentWear < 80) {
      return GFColors.WARNING;
    }
    return GFColors.DANGER;
  }
}

class ObligationsDesktopPpePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S().ppeList)),
      body: SingleChildScrollView(
        child: ObligationsDesktopPpeList(
          isBody: true,
        ),
      ),
    );
  }
}
