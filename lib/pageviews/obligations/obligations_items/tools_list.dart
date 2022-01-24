import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getflutter/getflutter.dart';
import 'package:hse/core/model/material_obligations/MaterialObligations.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/layout/main_widgets.dart';
import 'package:hse/viewmodels/obligations_model.dart';
import 'package:hse/viewmodels/user_info.dart';
import 'package:kinfolk/kinfolk.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../core/utils/UI_Helpers.dart';

//генерация списка инструментов
class ToolsList extends StatelessWidget {
  final bool isBody;
  final bool isPersonal;

  ToolsList({this.isBody = false, this.isPersonal});

  @override
  Widget build(BuildContext context) {
    final toolsModel = Provider.of<ObligationsViewModel>(context);
    final counter = Provider.of<UserInfoModel>(context);
    return FutureProvider<MaterialObligations>(
        create: (BuildContext context) => toolsModel.mol,
        initialData: null,
        child: Consumer<MaterialObligations>(builder: (context, model, _) {
          if (model == null) {
            return Container(
              child: GFLoader(
                type: GFLoaderType.ios,
              ),
            );
          }
          var list =
              model.tools.where((element) => element.isPersonal == isPersonal);
          //RML инструменты
          return SingleChildScrollView(
            child: Column(children: [
              Center(
                child: Container(
                    margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
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
                                '${S().total}: ${list?.length?.toString()} позиции ',
                                style: namingStyle),
                            Text(
                                counter.formatCash(list.fold(
                                    0,
                                    (previousValue, element) =>
                                        previousValue += element.cost)),
                                style: namingStyle)
                          ]),
                      subtitle: Text(S().caseLossAssets, style: captionStyle),
                    )),
              ),
              Column(
                children: list.map((e) {
                  return Container(
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
                        : EdgeInsets.fromLTRB(0, 5, 2, 0),
                    padding: EdgeInsets.all(5.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GFImageOverlay(
                            height: 52,
                            width: 52,
                            colorFilter: ColorFilter.mode(
                                Colors.transparent, BlendMode.color),
                            image: AssetImage(e.image ?? 'assets/images/helmet.png'),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Text(
                              e.name ?? '_',
                              style: generalFontStyle.copyWith(
                                  color: appBlackColor,
                                  fontSize: defaultFontSize + 2),
                              maxLines: 4,
                            ),
                          ),
                          Text(
                            '${counter.formatCash(e.cost)}',
                            style: generalFontStyle.copyWith(
                                fontSize: defaultFontSize + 2,
                                color: appBlackColor),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ]),
            // child: Column(children: [
            //   Container(
            //     margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 30.0),
            //     decoration: BoxDecoration(
            //         border: Border.all(color: appBorderColor),
            //         borderRadius: BorderRadius.circular(5)),
            //     child: Padding(
            //       padding: const EdgeInsets.all(15.0),
            //       child: Column(
            //         children: <Widget>[
            //           Row(
            //             children: <Widget>[
            //               Container(
            //                 child: Image.asset(
            //                   'assets/images/attentionIcon.png',
            //                   color: appBlueColor,
            //                 ),
            //                 margin: EdgeInsets.only(left: 0, right: 10),
            //               ),
            //               Container(
            //                 height: 70,
            //                 width: MediaQuery.of(context).size.width * 0.72,
            //                 child: Column(
            //                   children: [
            //                     Row(
            //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                       children: [
            //                         Text(
            //                           '${S().total}: ${list?.length?.toString()} позиции',
            //                           style: generalFontStyle.copyWith(
            //                               fontSize: 15.5,
            //                               fontWeight: FontWeight.w500),
            //                         ),
            //                         Text(
            //                           counter.formatCash(list.fold(
            //                               0,
            //                               (previousValue, element) =>
            //                                   previousValue += element.cost)),
            //                           style: generalFontStyle.copyWith(
            //                               color: appBlackColor,
            //                               fontWeight: FontWeight.w500),
            //                         )
            //                       ],
            //                     ),
            //                     SizedBox(
            //                       height: 15,
            //                     ),
            //                     Expanded(
            //                       child: Text(
            //                         S().caseLossAssets,
            //                         style: generalFontStyle.copyWith(
            //                             fontSize: 15, color: appGreyColor),
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               )
            //             ],
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            //   Column(
            //     children: list.map((e) {
            //       return Container(
            //         width: MediaQuery.of(context).size.width,
            //         decoration: BoxDecoration(
            //             border: Border(
            //                 bottom:
            //                     BorderSide(color: appBlueColor, width: 0.2))),
            //         margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 30.0),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Padding(
            //               padding: const EdgeInsets.all(15.0),
            //               child: GFImageOverlay(
            //                 height: 52,
            //                 width: 52,
            //                 colorFilter: ColorFilter.mode(
            //                     Colors.transparent, BlendMode.color),
            //                 image: NetworkImage(Kinfolk.getFileUrl(e.image)),
            //               ),
            //             ),
            //             Container(
            //               width: MediaQuery.of(context).size.width * 0.4,
            //               child: Text(
            //                 e.name ?? '_',
            //                 style: generalFontStyle.copyWith(
            //                     color: appBlackColor,
            //                     fontSize: 15,
            //                     fontWeight: FontWeight.w500),
            //               ),
            //             ),
            //             Text(
            //               '${counter.formatCash(e.cost)}',
            //               style: generalFontStyle.copyWith(
            //                   fontSize: 16, color: appBlackColor),
            //             ),
            //           ],
            //         ),
            //       );
            //     }).toList(),
            //   ),
            // ]),
          );
        }));
  }
}

// формирование списка Инструментов
class ToolsPageView extends StatelessWidget {
  const ToolsPageView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ObligationsViewModel()),
        ],
        child: ScreenTypeLayout(
          mobile: ToolMobileView(),
          tablet: ToolMobileView(),
          desktop: ToolMobileView(), //ToolDesktopView(),
        ));
  }
}

//Список инструментов для мобильного
class ToolMobileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              S().tools,
              style: generalFontStyle.copyWith(fontSize: defaultFontSize + 5),
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(22.0, 0.0, 22.0, 10.0),
            child: TabView(canScroll: true, tabs: [
              Tab(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                  child: Text(
                    S().permanent,
                    style: generalFontStyle.copyWith(fontSize: defaultFontSize),
                  ),
                ),
              ),
              Tab(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                  child: Text(
                    S().temporary,
                    style: generalFontStyle.copyWith(fontSize: defaultFontSize),
                  ),
                ),
              ),
            ], tabBar: [
              ToolsList(
                isPersonal: false,
              ),
              ToolsList(
                isPersonal: true,
              ),
            ]),
          )
        ])));
  }
}

class ToolDesktopView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text(S().tools)),
        ),
        //drawer: AppDrawer(),
        body: SingleChildScrollView(
            child: Column(children: [
          Container(
            margin: isDesktop(context)
                ? const EdgeInsets.fromLTRB(100, 0, 100, 0)
                : null,
            padding: const EdgeInsets.all(8.0),
            child: TabView(canScroll: true, tabs: [
              Tab(
                child: Text(
                  S().permanent,
                  style: generalFontStyle.copyWith(fontSize: defaultFontSize),
                ),
              ),
              Tab(
                child: Text(
                  S().temporary,
                  style: generalFontStyle.copyWith(fontSize: defaultFontSize),
                ),
              ),
            ], tabBar: [
              ToolsDesktopList(
                isPersonal: false,
              ),
              ToolsDesktopList(
                isPersonal: true,
              ),
            ]),
          )
        ])));
  }
}

class ToolsDesktopList extends StatelessWidget {
  final bool isBody;
  final bool isPersonal;

  ToolsDesktopList({this.isBody = false, this.isPersonal});

  @override
  Widget build(BuildContext context) {
    final toolsModel = Provider.of<ObligationsViewModel>(context);
    final counter = Provider.of<UserInfoModel>(context);
    return FutureProvider<MaterialObligations>(
        create: (BuildContext context) => toolsModel.mol,
        initialData: null,
        child: Consumer<MaterialObligations>(builder: (context, model, _) {
          if (model == null) {
            return Container(
              child: GFLoader(
                type: GFLoaderType.ios,
              ),
            );
          }
          var list =
              model.tools.where((element) => element.isPersonal == isPersonal);
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${S().total}: ${list?.length ?? ''}'),
                          Text(
                            counter.formatCash(list.fold(
                                0,
                                (previousValue, element) =>
                                    previousValue += element.cost ?? 0)),
                            style: TextStyle(color: appBlueColor),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height:
                      MediaQuery.of(context).size.height * (isBody ? 1 : 0.4),
                  child: ListView(
                    children: list.map((e) {
                      return Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                            borderRadius: BorderRadius.circular(5)),
                        margin: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: GFListTile(
                                title: Text(
                                  e.name ?? '_',
                                  style: TextStyle(
                                      color: appBlueColor, fontSize: 14),
                                ),
                                avatar: GFImageOverlay(
                                  height: GFSize.LARGE,
                                  width: GFSize.LARGE,
                                  colorFilter: ColorFilter.mode(
                                      Colors.transparent, BlendMode.color),
                                  image:
                                      NetworkImage(Kinfolk.getFileUrl(e.image)),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '${S().cost}:\n${counter.formatCash(e.cost)}',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                          ],
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
}
