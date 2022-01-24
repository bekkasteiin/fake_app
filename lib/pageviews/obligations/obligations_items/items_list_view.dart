import 'package:flutter/cupertino.dart';
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

import '../../../core/utils/UI_Helpers.dart';

class ItemsTemporaryList extends StatelessWidget {
  final bool isBody;
  final bool isPersonal;

  ItemsTemporaryList({this.isBody = false, this.isPersonal});

  @override
  Widget build(BuildContext context) {
    final itemsModel = Provider.of<ObligationsViewModel>(context);
    final counter = Provider.of<UserInfoModel>(context);
    return FutureProvider<MaterialObligations>(
        create: (BuildContext context) => itemsModel.mol,
        initialData: null,
        child: Consumer<MaterialObligations>(builder: (context, model, _) {
          if (model == null) {
            return Container(
              child: GFLoader(
                type: GFLoaderType.ios,
              ),
            );
          }
          ;
          var list =
              model.items.where((element) => element?.isPersonal == isPersonal);
          return SingleChildScrollView(
            child: Column(children: [
              Center(
                child: Container(
                    margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 25.0),
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
                    width: MediaQuery.of(context).size.width,
                    // decoration: BoxDecoration(
                    //     border: Border(
                    //         bottom:
                    //             BorderSide(color: appBlueColor, width: 0.2))),
                    // margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 30.0),
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
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: GFImageOverlay(
                            height: 52,
                            width: 52,
                            colorFilter: ColorFilter.mode(
                                Colors.transparent, BlendMode.color),
                            image: AssetImage(e.image ?? 'assets/images/helmet.png'),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            e.name ?? '_',
                            style: generalFontStyle.copyWith(
                                color: appBlackColor,
                                fontSize: defaultFontSize,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Text(
                          '${counter.formatCash(e.cost)}',
                          style: generalFontStyle.copyWith(
                              fontSize: defaultFontSize, color: appBlackColor),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ]),
          );
        }));
  }
}

class ItemsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ObligationsViewModel>(builder: (context, counter, _) {
      return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            automaticallyImplyLeading: true,
            leading: Padding(
              padding: const EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  FontAwesomeIcons.arrowLeft,
                  size: GFSize.SMALL * 0.7,
                ),
              ),
            ),
            title: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                S().items,
                style: generalFontStyle.copyWith(fontSize: defaultFontSize + 5),
              ),
            ),
            centerTitle: true,
          ),
          //drawer: AppDrawer(),
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
                      style:
                          generalFontStyle.copyWith(fontSize: defaultFontSize),
                    ),
                  ),
                ),
                Tab(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                    child: Text(
                      S().temporary,
                      style:
                          generalFontStyle.copyWith(fontSize: defaultFontSize),
                    ),
                  ),
                ),
              ], tabBar: [
                ItemsTemporaryList(
                  isBody: true,
                  isPersonal: false,
                ),
                ItemsTemporaryList(
                  isBody: true,
                  isPersonal: true,
                ),
              ]),
            )
          ])));
    });
  }
}

//Desktop Widgets

class ItemsTemporaryDesktopList extends StatelessWidget {
  final bool isBody;
  final bool isPersonal;

  ItemsTemporaryDesktopList({this.isBody = false, this.isPersonal});

  @override
  Widget build(BuildContext context) {
    final itemsModel = Provider.of<ObligationsViewModel>(context);
    final counter = Provider.of<UserInfoModel>(context);
    return FutureProvider<MaterialObligations>(
        create: (BuildContext context) => itemsModel.mol,
        initialData: null,
        child: Consumer<MaterialObligations>(builder: (context, model, _) {
          if (model == null) {
            return Container(
              child: GFLoader(
                type: GFLoaderType.ios,
              ),
            );
          }
          ;
          var list =
              model.items.where((element) => element?.isPersonal == isPersonal);
          return SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${S().total}: ${list?.length?.toString()}'),
                            Text(
                              counter.formatCash(list.fold(
                                  0,
                                  (previousValue, element) =>
                                      previousValue += element.cost)),
                              style: TextStyle(color: appBlueColor),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: list.map((e) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
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
                              style:
                                  TextStyle(color: appBlueColor, fontSize: 14),
                            ),
                            avatar: GFImageOverlay(
                              height: GFSize.LARGE,
                              width: GFSize.LARGE,
                              colorFilter: ColorFilter.mode(
                                  Colors.transparent, BlendMode.color),
                              image: NetworkImage(Kinfolk.getFileUrl(e.image)),
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
            ]),
          );
        }));
  }
}

class ItemsDesktopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ObligationsViewModel>(builder: (context, counter, _) {
      return Scaffold(
          appBar: AppBar(
            title: Row(
              children: <Widget>[
                Text(S().items),
              ],
            ),
            centerTitle: true,
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
                ItemsTemporaryDesktopList(
                  isBody: true,
                  isPersonal: false,
                ),
                ItemsTemporaryDesktopList(
                  isBody: true,
                  isPersonal: true,
                ),
              ]),
            )
          ])));
    });
  }
}
