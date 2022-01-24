import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getflutter/getflutter.dart';
import 'package:hse/core/model/ppe/Ppe.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/viewmodels/user_info.dart';
import 'package:kinfolk/kinfolk.dart';
import 'package:provider/provider.dart';

import '../../core/utils/UI_Helpers.dart';

// детализация СИЗ для мобильного

class PPEInfo extends StatelessWidget {
  final int length;
  final num totalCost;
  final String image;
  final String description;
  final String langValue;
  final DateTime issueDate;
  final DateTime watchDate;
  final double actualCost;
  final double percentWear;
  final String seasonSign;
  final Ppe ppe;
  final sizeGrowth;
  final size;
  final endDate;

  PPEInfo(
    this.length,
    this.totalCost,
    this.image,
    this.description,
    this.langValue,
    this.issueDate,
    this.watchDate,
    this.actualCost,
    this.percentWear,
    this.seasonSign,
    this.ppe,
    this.sizeGrowth,
    this.size,
    this.endDate,
  );

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<UserInfoModel>(context);
    if (isDesktop(context)) {
      return PpeDesktopInfo(
        selectedPpe: ppe,
      );
    }
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          S().ppe,
          style: generalFontStyle.copyWith(fontSize: defaultFontSize + 5),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              //width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(0.0),
              //padding: EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
                    decoration: BoxDecoration(
                      color: appWhiteColor,
                      border: BorderDirectional(
                        bottom: BorderSide(color: appBlueColor, width: 0.2),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GFImageOverlay(
                              height: isDesktop(context) ? 157 : 57,
                              width: isDesktop(context) ? 157 : 57,
                              boxFit: BoxFit.contain,
                              colorFilter: ColorFilter.mode(Colors.transparent, BlendMode.color),
                              image: NetworkImage(Kinfolk.getFileUrl(image)),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Container(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            langValue,
                                            style: namingStyle,
                                            maxLines: 2,
                                          ),
                                        ),
                                        Icon(
                                          issueDate != null ? FontAwesomeIcons.checkCircle : FontAwesomeIcons.ban,
                                          color: issueDate != null ? appGreenColor : appRedColor,
                                          size: GFSize.SMALL,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
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
                                          child: GFProgressBar(reverse: true, leading: Text('${percentWear}', style: namingStyle), width: 80, percentage: percentWear / 100, backgroundColor: buildProgressColor(percentWear), progressBarColor: appGreyColor),
                                        ),
                                        Text(counter.formatCash(actualCost), style: namingStyle),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0, top: 20.0, right: 10.0),
                                      child: Text(
                                        S().description,
                                        style: captionStyle,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0, top: 5.0, right: 10.0),
                                      child: Text(
                                        description ?? S.of(context).noDescriptionProvided,
                                        style: namingStyle,
                                        maxLines: 2,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, top: 15.0, right: 10.0),
                    child: Text(
                      S().dateOfIssue,
                      style: captionStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, top: 5.0, right: 10.0),
                    child: Text(
                      formatOnlyDate(issueDate),
                      style: namingStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, top: 15.0, right: 10.0),
                    child: Text(
                      S().dateOfScheduledReplacement,
                      style: captionStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, top: 5.0, right: 10.0),
                    child: Text(
                      formatOnlyDate(endDate),
                      style: namingStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, top: 15.0, right: 10.0),
                    child: Text(
                      S().dateOfInterShiftIssuance,
                      style: captionStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, top: 5.0, right: 10.0),
                    child: Text(
                      formatOnlyDate(watchDate),
                      style: namingStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, top: 15.0, right: 10.0),
                    child: Text(
                      S().season,
                      style: captionStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, top: 5.0, right: 10.0),
                    child: Text(
                      seasonSign ?? '-',
                      style: namingStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, top: 15.0, right: 10.0),
                    child: Text(
                      S().size,
                      style: captionStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, top: 5.0, right: 10.0),
                    child: Text(
                      size ?? '-',
                      style: namingStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, top: 15.0, right: 10.0),
                    child: Text(
                      S().rostov,
                      style: captionStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, top: 5.0, right: 10.0),
                    child: Text(
                      sizeGrowth ?? 'Нет данных',
                      style: namingStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color buildProgressColor(double perscentWear) {
    if (perscentWear <= 20) {
      return appGreenColor;
    }
    if (perscentWear < 80) {
      return appYellowColor;
    }
    return appRedColor;
  }
}

// детализиция СИЗ для терминала
class PpeDesktopInfo extends StatelessWidget {
  final Ppe selectedPpe;

  const PpeDesktopInfo({Key key, this.selectedPpe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var counter = Provider.of<UserInfoModel>(context);
    var textStyle = generalFontStyle.copyWith(color: Colors.black, fontSize: 15);
    var tileStyle = generalFontStyle.copyWith(color: Colors.black26, fontSize: 16);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          S().ppe,
          style: generalFontStyle.copyWith(fontSize: defaultFontSize + 5),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildInfoBox(context, textStyle, counter),
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 50, 0),
                    decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(15)),
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Text(selectedPpe.description ?? ''),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 50, 0),
                    decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: buildPpeFields(tileStyle, context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // отображение отдельно СИЗ
  SingleChildScrollView buildPpeFields(TextStyle tileStyle, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            S().dateOfIssue,
            style: captionStyle,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            formatDate(selectedPpe.issueDate ?? '-'),
            style: namingStyle,
          ),
          GFListTile(
            title: Text(
              S().dateOfScheduledReplacement,
              style: tileStyle,
            ),
            subTitle: Text(
              formatDate(selectedPpe.endDate ?? '-'),
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          GFListTile(
            title: Text(
              S().dateOfInterShiftIssuance,
              style: tileStyle,
            ),
            subTitle: Text(
              formatDate(selectedPpe.watchDate ?? '-'),
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          GFListTile(
            title: Text(
              S().season,
              style: tileStyle,
            ),
            subTitle: Text(
              selectedPpe.seasonSign ?? '-',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          GFListTile(
            title: Text(
              S().size,
              style: tileStyle,
            ),
            subTitle: Text(
              selectedPpe.size ?? '-',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          GFListTile(
            title: Text(
              S().rostov,
              style: tileStyle,
            ),
            subTitle: Text(
              selectedPpe.sizeGrowth ?? '-',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          )
        ],
      ),
    );
  }

  Container buildInfoBox(BuildContext context, TextStyle textStyle, UserInfoModel counter) {
    return Container(
      margin: EdgeInsets.all(8.0),
      width: MediaQuery.of(context).size.width * 0.7,
      decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Container(
              height: GFSize.LARGE * 3,
              width: GFSize.LARGE * 1.5,
              child: GFImageOverlay(
                colorFilter: ColorFilter.mode(Colors.transparent, BlendMode.color),
                image: NetworkImage(Kinfolk.getFileUrl(selectedPpe.image)),
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${selectedPpe.langValue.split(' ').sublist(0, 2).join(" ")}',
                  style: generalFontStyle.copyWith(
                    color: appBlueColor,
                    fontSize: 18,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('\n${selectedPpe.perscentWear}% ${S().wear}', style: textStyle), Text(counter.formatCash(selectedPpe.actualCost), style: textStyle)],
                ),
              ],
            ),
            subtitle: GFProgressBar(percentage: selectedPpe.perscentWear / 100, backgroundColor: Colors.black26, progressBarColor: buildProgressColor(selectedPpe.perscentWear)),
          ),
          ListTile(
            leading: Image.asset(
              'assets/images/attentionIcon.png',
              color: appBlueColor,
            ),
            title: Text(
              S().caseLossAssets,
              style: generalFontStyle.copyWith(fontSize: 13, color: appGreyColor),
            ),
          )
        ],
      ),
    );
  }

  Color buildProgressColor(double perscentWear) {
    if (perscentWear <= 20) {
      return appGreenColor;
    }
    if (perscentWear < 80) {
      return appYellowColor;
    }
    return appRedColor;
  }
}
