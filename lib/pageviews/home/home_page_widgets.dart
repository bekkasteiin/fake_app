import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getflutter/components/avatar/gf_avatar.dart';
import 'package:getflutter/components/loader/gf_loader.dart';
import 'package:getflutter/getflutter.dart';
import 'package:getflutter/shape/gf_avatar_shape.dart';
import 'package:getflutter/types/gf_loader_type.dart';
import 'package:hse/core/model/assignment/Assignment.dart';
import 'package:hse/core/model/assignment/rating_new.dart';
import 'package:hse/core/model/utils/ToDoList.dart';
import 'package:hse/core/utils/local_icon_data.dart';
import 'package:hse/core/utils/routes.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/core/service/local/AccessCategoryService.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:hse/viewmodels/bpm_models/event_model.dart';
import 'package:hse/viewmodels/bpm_models/bsa_model.dart';
import 'package:hse/viewmodels/bpm_models/message_model.dart';
import 'package:hse/viewmodels/bpm_models/risks_model.dart';
import 'package:hse/viewmodels/bpm_models/ticket_model.dart';
import 'package:hse/viewmodels/home_model.dart';
import 'package:hse/viewmodels/user_info.dart';
import 'package:kinfolk/kinfolk.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

// тело основной страницы
class CounterLabel extends StatelessWidget {
  const CounterLabel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<Home>(context);
    var desktop = isDesktop(context);
    var size = MediaQuery.of(context).size;
    var width = size.width;
    if (desktop) {
      width = width * 1;
    }
    return Consumer<UserInfoModel>(builder: (context, value, child) {
      return FutureProvider<bool>(
          initialData: null,
          create: (BuildContext context) => counter.notification,
          child: Consumer<bool>(builder: (context, model, _) {
            return  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        UserProfileWindow(),
                        Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: MenuTile(),
                        )
                      ],
                    ),
                  );
          }));
    });
  }
}

// формирование плитки модулей
class MenuTile extends StatelessWidget {
  const MenuTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<Home>(context);
    return Consumer<UserInfoModel>(
      builder: (context, value, child) {
        return FutureProvider<ToDoList>(
            initialData: null,
            create: (BuildContext context) => counter.toDoList,
            child: Consumer<ToDoList>(builder: (context, model, _) {
              return model == null
                  ? GFLoader()
                  : Center(
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: getCards(todo: counter.toDoListCurrent),
                      ),
                    );
            }));
      },
    );
  }
}

// создание плитки
List getCards({ToDoList todo, bool isDrawer = false, BuildContext context}) {
  var list = <Widget>[];

  todo = todo ?? ToDoList.getDefault();

    list.add(isDrawer
        ? DrawerNav(LocalIconData.message, 'ОПОВЕЩЕНИЕ', Routes.message)
        : ModuleCard(
      LocalIconData.message,
      'ОПОВЕЩЕНИЕ',
      Routes.message,
    ));
    list.add(isDrawer
        ? DrawerNav(
        LocalIconData.behavioralAudit, 'ПАБ', Routes.behavioralAudit)
        : ModuleCard(
      LocalIconData.behavioralAudit,
      'ПАБ',
      Routes.behavioralAudit,
    ));
    list.add(
      isDrawer
          ? DrawerNav(LocalIconData.risk, 'СУР', Routes.risksManagement)
          : ModuleCard(
        LocalIconData.risk,
        'СУР',
        Routes.risksManagement,
      ),
    );

    list.add(isDrawer
        ? DrawerNav(LocalIconData.audit, 'АУДИТ', Routes.auditManagement)
        : ModuleCard(LocalIconData.audit, 'АУДИТ', Routes.auditManagement));

    list.add(isDrawer
        ? DrawerNav(LocalIconData.auditGov, 'ГОС АУДИТ', Routes.auditGovManagement)
        : ModuleCard(LocalIconData.auditGov, 'ГОС АУДИТ', Routes.auditGovManagement));

    list.add(isDrawer
        ? DrawerNav(LocalIconData.ticket, 'ТАЛОНЫ', Routes.ticketManagement)
        : ModuleCard(LocalIconData.ticket, 'ТАЛОНЫ', Routes.ticketManagement));

    list.add(isDrawer
        ? DrawerNav(
        LocalIconData.events, 'МЕРОПРИЯТИЯ', Routes.eventsManagement)
        : ModuleCard(
      LocalIconData.events,
      'МЕРОПРИЯТИЯ',
      Routes.eventsManagement,
    ));


    list.add(isDrawer
        ? DrawerNav(LocalIconData.control, 'КПР', Routes.productionControl)
        : ModuleCard(
      LocalIconData.control,
      'КПР',
      Routes.productionControl,
    ));



    list.add(isDrawer
        ? DrawerNav(LocalIconData.covid, 'COVID-19', Routes.covid)
        : ModuleCard(LocalIconData.covid, 'COVID-19', Routes.covid));

  return list;
}

class DrawerNav extends StatelessWidget {
  final String iconImageURL;
  final String label;
  final String route;
  final int count;

  const DrawerNav(this.iconImageURL, this.label, this.route,
      {this.count = 0, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var homeProvider = Provider.of<Home>(context);
    var defaultFontSize = 16.0;
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
          child: Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Colors.white, width: 0.3))),
            child: ListTile(
              leading: Padding(
                padding: const EdgeInsets.all(5.0),
                child: GFImageOverlay(
                  height: GFSize.LARGE * 0.9,
                  width: GFSize.LARGE * 0.8,
                  colorFilter:
                      ColorFilter.mode(Colors.transparent, BlendMode.color),
                  image: AssetImage(iconImageURL),
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  label,
                  style: generalFontStyle.copyWith(
                      color: Colors.white, fontSize: defaultFontSize + 5),
                ),
              ),
              onTap: () async {
                await Get.toNamed(route);
                await homeProvider.toDoList;
                homeProvider.setBusy(false);
              },
            ),
          ),
        ),
      ],
    );
  }
}

// генерация плитки
class ModuleCard extends StatelessWidget {
  final String iconImageURL;
  final String label;
  final String route;
  final int count;

  const ModuleCard(this.iconImageURL, this.label, this.route,
      {this.count = 0, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var homeProvider = Provider.of<Home>(context);
    return InkWell(
      onTap: () async {
        await Get.toNamed(route);
        await homeProvider.toDoList;
        homeProvider.setBusy(false);
      },
      child: Stack(
        children: <Widget>[
          getCard(context),
          count == null || count == 0
              ? SizedBox()
              : Positioned(
                  right: 0,
                  child: Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: appRedColor,
                      border: Border.all(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          width: 3),
                    ),
                    child: Center(
                        child: Text(
                      '$count',
                      style: generalFontStyle.copyWith(
                          color: appWhiteColor, fontSize: defaultFontSize),
                    )),
                  ),
                ),
        ],
      ),
    );
  }

  // сборка плики
  Widget getCard(BuildContext context) {
    var deviceInfo = getDeviceInfo(context);
    var imgSize = GFSize.LARGE;
    var size = MediaQuery.of(context).size.width * 0.28; //115.0; RML
    if (deviceInfo == DeviceScreenType.desktop) {
      size = imgSize * 0.28;
      imgSize = imgSize * 0.2;
    }
    return Container(
      margin: EdgeInsets.all(8.0),
      constraints: BoxConstraints.tightFor(width: size, height: size),
      decoration: BoxDecoration(
        color: appBlueColor,
        border: Border.all(color: appFiledBorderColor, width: 0.5),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: appGreyColor.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(2, 2), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            padding: EdgeInsets.only(top: 15.0),
            child: GFImageOverlay(
              height: deviceInfo == DeviceScreenType.desktop ? imgSize : 47,
              width: deviceInfo == DeviceScreenType.desktop ? imgSize : 47,
              colorFilter:
                  ColorFilter.mode(Colors.transparent, BlendMode.color),
              image: AssetImage(iconImageURL),
            ),
          ),
          Container(
            padding: deviceInfo == DeviceScreenType.desktop
                ? EdgeInsets.only(top: 20.0)
                : EdgeInsets.only(top: 10.0),
            //width: GFSize.LARGE * 2.2,
            child: Center(
              child: Text(
                label,
                style: deviceInfo == DeviceScreenType.desktop
                    ? generalFontStyle.copyWith(
                        color: appWhiteColor, fontSize: defaultFontSize + 8)
                    : generalFontStyle.copyWith(
                        color: appWhiteColor, fontSize: defaultFontSize - 2),
                maxLines: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Профиль пользователя
class UserProfileWindow extends StatelessWidget {
  final bool canRedirect;
  final Assignment assignment;

  const UserProfileWindow({Key key, this.canRedirect, this.assignment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var deviceInfo = getDeviceInfo(context);
    var size = MediaQuery.of(context).size;
    var isDesktop = false;
    //var width = size.width * 0.65;
    var width = size.width;
    if (deviceInfo == DeviceScreenType.desktop) {
      isDesktop = true;
      width = size.width * 0.7;
    }
    final counter = Provider.of<UserInfoModel>(context);
    final messageModel = Provider.of<MessageModel>(context);
    final bsaModel = Provider.of<BsaModel>(context);
    final risksModel = Provider.of<RisksModel>(context);
    final eventModel = Provider.of<EventModel>(context);
    final ticketModel = Provider.of<TicketModel>(context);
    return assignment != null
        ? buildContainer(isDesktop, size, assignment, width, context)
        : FutureProvider<Assignment>(
            create: (BuildContext context) =>
                counter.assignment(messageModel, bsaModel, risksModel,eventModel, ticketModel),
            initialData: null,
            child: Consumer<Assignment>(builder: (context, model, _) {
              //var isLoading = model == null;
              //if (isLoading) return GFLoader(type: GFLoaderType.circle);
              return buildContainer(isDesktop, size, model, width, context);
            }),
          );
  }

  // формирование профиля
  Widget buildContainer(bool isDesktop, Size size, Assignment model,
      double width, BuildContext context) {
    return Container(
      //color: Theme.of(context).scaffoldBackgroundColor,
      margin: isDesktop ? EdgeInsets.fromLTRB(0, 20, 0, 20) : null,
      child: GestureDetector(
        onTap: (canRedirect ?? true) ? () => Get.toNamed('/profile') : null,
        child: Card(
          color: Theme.of(context).scaffoldBackgroundColor,
          elevation: isDesktop ? 10 : 0,
          child: Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            margin: isDesktop
                ? EdgeInsets.fromLTRB(10, 10, 10, 10)
                : EdgeInsets.fromLTRB(100, 5, 5, 5),
            constraints: BoxConstraints.tightFor(
                width: isDesktop ? size.width * 0.82 : size.width),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.0),
                    GFAvatar(
                        borderRadius: BorderRadius.circular(10),
                        size: GFSize.LARGE * 1.96,
                        backgroundImage:
                            AssetImage('assets/images/business-man.png'),
                        shape: GFAvatarShape.square),
                  ],
                ),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                    flex: 1,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Сериков Нуржан',
                            style: generalFontStyle.copyWith(
                              fontSize: defaultFontSize + 5,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Container(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Водитель автомашины КрАЗ-256',
                                    style: generalFontStyle.copyWith(
                                        fontSize: defaultFontSize - 2,
                                        color: appBlackColor),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Text(
                                    'TOO "Kazakhmys Maintenance Services"',
                                    style: captionStyle,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StarsRating extends StatelessWidget {
  final double percent;

  const StarsRating({Key key, this.percent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GFRating(
      value: (((percent) / 100.0) * 5.0) - 0.1,
      color: appOrangeColor,
      itemCount: 5,
      allowHalfRating: true,
      size: GFSize.SMALL,
    );
  }
}

class RatingProgressBar extends StatelessWidget {
  final PercentilePojo percentile;
  final double percent;

  const RatingProgressBar({Key key, this.percentile, this.percent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var lineHeight = 20.0;
    var headType = GFProgressHeadType.square;
    var width = kIsWeb
        ? MediaQuery.of(context).size.width * 0.75
        : MediaQuery.of(context).size.width * 0.8;
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            GFProgressBar(
              width: width,
              lineHeight: lineHeight,
              progressBarColor: appGreenColor,
              //hexToColor('#BEE0B8'),
              backgroundColor: Colors.transparent,
              percentage: 1,
              progressHeadType: GFProgressHeadType.circular,
            ),
            GFProgressBar(
              width: width,
              lineHeight: lineHeight,
              progressBarColor: appYellowColor,
              backgroundColor: Colors.transparent,
              percentage:
                  percentile.highestScore / percentile.totalNumberOfScores,
              progressHeadType: GFProgressHeadType.circular,
            ),
            GFProgressBar(
              width: width,
              lineHeight: lineHeight,
              progressBarColor: appRedColor,
              //hexToColor('#ECABAB'),
              backgroundColor: Colors.transparent,
              percentage:
                  percentile.lowestScore / percentile.totalNumberOfScores,
              progressHeadType: GFProgressHeadType.circular,
            ),
            RatingDot(
              percent:
                  percentile.currentEmpRank / percentile.totalNumberOfScores,
              width: width,
            )
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        Center(
          child: Text(
            getText(),
            style: Theme.of(context).textTheme.caption,
          ),
        )
      ],
    );
  }

  String getText() {
    if (percentile.currentEmpRank <= percentile.lowestScore) {
      return S.current.greatKeepItUp;
    }
    if (percentile.currentEmpRank < percentile.highestScore) {
      return S.current.okButYouCanDoBetter;
    }
    return S.current.youCanDoBetter;
  }
}

class RatingDot extends StatefulWidget {
  final double percent;
  final double width;

  const RatingDot({
    Key key,
    this.percent,
    this.width,
  }) : super(key: key);

  @override
  _RatingDotState createState() => _RatingDotState();
}

class _RatingDotState extends State<RatingDot> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      width: 19,
      height: 19,
      left: (widget.width * (1 - widget.percent)),
      top: 0,
      child: Container(
        decoration: BoxDecoration(
          color: appBlackColor,
          border: Border.all(
            color: appGreyColor,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
