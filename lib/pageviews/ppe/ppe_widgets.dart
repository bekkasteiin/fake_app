import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getflutter/components/loader/gf_loader.dart';
import 'package:getflutter/getflutter.dart';
import 'package:hse/core/model/ppe/PersonalProtectionEquipment.dart';
import 'package:hse/core/model/ppe/Ppe.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/core/service/local/AccessCategoryService.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/viewmodels/ppe_model.dart';
import 'package:hse/viewmodels/user_info.dart';
import 'package:kinfolk/kinfolk.dart';
import 'package:provider/provider.dart';

import '../../core/utils/UI_Helpers.dart';
import 'ppe_info_page.dart';

//список СИЗ(СО) малый список
class PpeList extends StatelessWidget {
  final bool isBody;

  PpeList({this.isBody = false});

  @override
  Widget build(BuildContext context) {
    final ppeModel = Provider.of<PpeViewModel>(context);
    final counter = Provider.of<UserInfoModel>(context);
    return FutureProvider<PersonalProtectionEquipment>(
        create: (BuildContext context) => ppeModel.ppes,
        initialData: null,
        child: Consumer<PersonalProtectionEquipment>(builder: (context, model, _) {
          if (model == null) {
            return Container(
              child: GFLoader(
                type: GFLoaderType.ios,
              ),
            );
          }
          if (model.ppes == null || model.ppes.isEmpty) {
            return Container();
          }
          var desktop = isDesktop(context);
          var length2 = model.ppes.length;
          var filteredDataList = (desktop ? model.ppes : model.ppes.sublist(0, isBody ? length2 : (length2 >= 3 ? 3 : length2)));
          var list = filteredDataList.map((e) => buildPpeItem(ppeModel, model, e, context)).toList();
          if (!desktop) {
            list.add(GestureDetector(
              child: SizedBox(
                height: GFSize.MEDIUM,
              ),
            ));
          }
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    margin: desktop ? EdgeInsets.fromLTRB(20, 10, 20, 10) : EdgeInsets.fromLTRB(0, 10, 0, 0),
                    decoration: BoxDecoration(border: Border.all(color: appFiledBorderColor), borderRadius: BorderRadius.circular(10), color: appYellowColor),
                    child: ListTile(
                      leading: Icon(
                        FontAwesomeIcons.radiationAlt,
                        color: appRedColor,
                        size: GFSize.SMALL,
                      ),
                      title: Wrap( children: [
                        Text('${S().total}: ${length2?.toString()} позиции ', style: namingStyle),
                        Text(
                          counter.formatCash(ppeModel.totalCost),
                          style: generalFontStyle.copyWith(fontSize: defaultFontSize + 2, color: appBlackColor, fontWeight: FontWeight.w500),
                        )
                      ]),
                      subtitle: Text(S().caseLossAssets, style: captionStyle),
                    ),
                  ),
                ),
                Container(
                  height: desktop ? MediaQuery.of(context).size.height * 0.5 : MediaQuery.of(context).size.height * (isBody ? 0.7 : 0.4),
                  padding: const EdgeInsets.all(0.0),
                  margin: EdgeInsets.only(top: 10.0),
                  child: desktop
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
}

class PpeEasyList extends StatelessWidget {
  final bool isBody;
  final PersonalProtectionEquipment model;

  PpeEasyList({this.isBody = false, this.model});

  @override
  Widget build(BuildContext context) {
    final ppeModel = Provider.of<PpeViewModel>(context);
    final counter = Provider.of<UserInfoModel>(context);
    if (model.ppes == null || model.ppes.isEmpty) {
      return Container();
    }
    var desktop = isDesktop(context);
    var length2 = model.ppes.length;
    var list = (desktop ? model.ppes : model.ppes.sublist(0, isBody ? length2 : 3)).map((e) {
      return buildPpeItem(ppeModel, model, e, context);
    }).toList();
    if (!desktop) {
      list.add(GestureDetector(
        child: SizedBox(
          height: GFSize.MEDIUM,
        ),
      ));
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: desktop ? EdgeInsets.fromLTRB(150, 10, 150, 10) : EdgeInsets.fromLTRB(8, 20, 8, 8),
            decoration: BoxDecoration(border: Border.all(color: appFiledBorderColor), borderRadius: BorderRadius.circular(5)),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        child: Image.asset(
                          'assets/images/attentionIcon.png',
                          color: appBlueColor,
                        ),
                        margin: EdgeInsets.only(left: 5, right: 10),
                      ),
                      Container(
                        height: 70,
                        width: MediaQuery.of(context).size.width * 0.72,
                        child: Column(
                          children: [
                            Wrap(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${S().total}: ${length2} позиции',
                                  style: generalFontStyle.copyWith(fontSize: 15.5, fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  counter.formatCash(ppeModel.totalCost),
                                  style: generalFontStyle.copyWith(color: appBlackColor, fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Expanded(
                              child: Text(
                                S().caseLossAssets,
                                style: generalFontStyle.copyWith(fontSize: 15, color: appGreyColor),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: desktop ? MediaQuery.of(context).size.height * 0.5 : MediaQuery.of(context).size.height * (isBody ? 0.7 : 0.4),
            child: desktop
                ? Scrollbar(
                    child: SingleChildScrollView(
                      child: Wrap(
                        children: list,
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: list,
                    ),
                  ),
          )
        ],
      ),
    );
  }
}

// определение цвета % износа
Color buildProgressColor(double perscentWear) {
  if (perscentWear < 20) {
    return appGreenColor;
  }
  if (perscentWear > 21 && perscentWear < 80) {
    return appYellowColor;
  }
  if (perscentWear == 100) {
    return appGreyColor;
  }
  return appRedColor;
}

// Построение списка СИЗ(СО) RML
GestureDetector buildPpeItem(PpeViewModel ppeModel, PersonalProtectionEquipment model, Ppe e, BuildContext context) {
  var desktop = isDesktop(context);
  final counter = Provider.of<UserInfoModel>(context);
  return GestureDetector(
    onTap: () => Get.to(
      ChangeNotifierProvider.value(
        value: ppeModel,
        builder: (context, child) => PPEInfo(
          model.ppes.length,
          model.ppes.fold(0.0, (previousValue, element) => previousValue += element.actualCost),
          e.image,
          e.description,
          e.langValue,
          e.issueDate,
          e.watchDate,
          e.actualCost,
          e.perscentWear,
          e.seasonSign,
          e,
          e.sizeGrowth,
          e.size,
          e.endDate,
        ),
      ),
    ),
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
      margin: desktop ? EdgeInsets.fromLTRB(0, 5, 5, 0) : EdgeInsets.fromLTRB(0, 5, 2, 0),
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
                colorFilter: ColorFilter.mode(Colors.transparent, BlendMode.color),
                image: NetworkImage(Kinfolk.getFileUrl(e.image)),
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
                          e.issueDate != null ? FontAwesomeIcons.checkCircle : FontAwesomeIcons.ban,
                          color: e.issueDate != null ? appGreenColor : appRedColor,
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
                          child: GFProgressBar(reverse: true, leading: Text('${e.perscentWear}', style: namingStyle), width: 80, percentage: e.perscentWear / 100, backgroundColor: buildProgressColor(e.perscentWear), progressBarColor: appGreyColor),
                        ),
                        Text(counter.formatCash(e.actualCost), style: namingStyle),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    ),
  );
}

// СИЗ(СО) полный список
class PpeFullListPage extends StatelessWidget {
  const PpeFullListPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => PpeViewModel()),
    ], child: PpeFullList());
  }
}

class PpeFullList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
          title: Text(
        S().ppeList,
        style: generalFontStyle.copyWith(fontSize: defaultFontSize + 5),
      )),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15),
        child: PpeList(
          isBody: true,
        ),
      ),
    );
  }
}

Widget buildScanButton(BuildContext context) {
  if (kIsWeb) {
    return SizedBox();
  }
  var model = Provider.of<PpeViewModel>(context);
  return !AccessCategoryService.getAllowanceByName('qr_scan_button')
      ? SizedBox()
      : GFButton(
          text: 'SCAN',
          onPressed: model.scan,
        );
}
