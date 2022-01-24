import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getflutter/getflutter.dart';
import 'package:hse/core/model/car_order/CarOrder.dart';
import 'package:hse/core/model/util_models.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/core/service/rest_services.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/viewmodels/car_model.dart';
import 'package:hse/viewmodels/user_info.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/utils/UI_Helpers.dart';
import 'car_order_widgets.dart';

// Информация о Заказе на авто
class CarOrderInfo extends StatelessWidget {
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    var counter = Provider.of<CarModel>(context);
    final userInfo = Provider.of<UserInfoModel>(context);
    var model = counter.orderToShow;
    var height = MediaQuery.of(context).size.height;
    var radius = Radius.circular(20);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Container(
          alignment: Alignment.centerLeft,
          child: Text(
            S().carOrder,
            style: generalFontStyle.copyWith(fontSize: defaultFontSize + 5),
          ),
        ),
      ),
      body: //isDesktop(context)
          //? buildDesktopVersion(context, model, radius, counter)
          //:
          SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: ListTile(
                  leading: model.status == 'UNAPPROVED' ||
                          model.status == 'CANCELED'
                      ? Icon(
                          FontAwesomeIcons.ban,
                          color: appRedColor,
                          size: GFSize.LARGE * 0.85,
                        )
                      : model.status == 'APPROVED' || model.status == 'CLOSED'
                          ? Icon(
                              FontAwesomeIcons.checkCircle,
                              color: appGreenColor,
                              size: GFSize.LARGE * 0.85,
                            )
                          : model.status == 'ON_DISTRIBUTION'
                              ? Icon(
                                  FontAwesomeIcons.car,
                                  color: appGreyColor,
                                  size: GFSize.LARGE * 0.85,
                                )
                              : model.status == 'EXPECTATION'
                                  ? Icon(
                                      FontAwesomeIcons.bolt,
                                      color: appYellowColor,
                                      size: GFSize.LARGE * 0.85,
                                    )
                                  : model.status == 'IS_NEW'
                                      ? Icon(
                                          FontAwesomeIcons.calendarPlus,
                                          color: appBlueColor,
                                          size: GFSize.LARGE * 0.85,
                                        )
                                      : Icon(
                                          FontAwesomeIcons.bookmark,
                                          color: appBlueColor,
                                          size: GFSize.LARGE * 0.85,
                                        ),
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${formatDate(model.requestedDate)}',
                          style: namingStyle,
                        ),
                        Text(
                          //userInfo.formatCash(e.cost) ?? '',
                          userInfo.formatCash(model.cost).isEmpty
                              ? getCodeLang(model.status)
                              : userInfo.formatCash(model.cost),
                          style: userInfo.formatCash(model.cost).isEmpty
                              ? captionStyle
                              : generalFontStyle.copyWith(
                                  fontSize: defaultFontSize + 2,
                                  color: appBlackColor),
                        )
                      ],
                    ),
                  ),
                  subtitle: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Откуда: ' + '${model.fromAddress}' ?? '',
                        style: captionStyle,
                        maxLines: 1,
                      ),
                      SizedBox(
                        height: 2.0,
                      ),
                      Text('Куда: ' + '${model.toAddress}' ?? '',
                          style: captionStyle, maxLines: 1),
                    ],
                  ),
                ),
              ),
              Container(
                height: height * 0.62,
                margin: EdgeInsets.fromLTRB(10, 8.0, 10.0, 0.0),
                padding: EdgeInsets.all(10),
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
                  // color: appWhiteColor,
                  //   border: Border.all(color: appBorderColor),
                  //   borderRadius: BorderRadius.circular(5)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Container(
                        width: 50,
                        child: Divider(
                          thickness: 4,
                          color: appGreyColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: PageView(controller: controller, children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: buildPageOne(model),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: buildPageTwo(model),
                          )
                        ]),
                      ),
                    ),
                    Center(
                      child: SmoothPageIndicator(
                        controller: controller,
                        count: 2,
                        effect: WormEffect(
                            spacing: 8.0,
                            radius: 10.0,
                            dotWidth: 15.0,
                            dotHeight: 15.0,
                            paintStyle: PaintingStyle.stroke,
                            strokeWidth: 1.5,
                            dotColor: appBlueColor,
                            activeDotColor: appBlueColor),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /*    Container(
                            width: GFSize.LARGE * 3.5,
                            child: ListTile(
                              title: Text(
                                S().status,
                                style: captionStyle,
                              ),
                              subtitle: Container(
                                child: GFButton(
                                  onPressed: () {},
                                  color: appButtonGreyColor,
                                  child: Text(
                                    getCodeLang(model.status),
                                    style: namingStyle,
                                  ),
                                ),
                              ),
                            ),
                          ),*/
                    /*   SizedBox(
                            width: 75,
                          ),*/
                    model.status == 'CANCELED' || model.status == 'UNAPPROVED'
                        ? SizedBox()
                        : model.status == 'COMPLETED'
                            ? buildAssesment(radius, counter)
                            : buildRejectButton(counter)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDesktopVersion(
      BuildContext context, CarOrder model, Radius radius, CarModel counter) {
    return Padding(
      padding: EdgeInsets.fromLTRB(200, 50, 50, 20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${S().request} ${formatOnlyDate(model.requestedDate)}',
              style: generalFontStyle.copyWith(
                  fontSize: 30,
                  color: appBlueColor,
                  fontWeight: FontWeight.w500),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.56,
                    width: MediaQuery.of(context).size.width * 0.4,
                    margin: EdgeInsets.fromLTRB(0, 30.0, 15.0, 0.0),
                    padding: EdgeInsets.all(25),
                    decoration: BoxDecoration(
                        border: Border.all(color: appGreyColor),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: buildPageTwo(model),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.56,
                    width: MediaQuery.of(context).size.width * 0.4,
                    margin: EdgeInsets.fromLTRB(15, 30.0, 15.0, 0.0),
                    padding: EdgeInsets.all(25),
                    decoration: BoxDecoration(
                        border: Border.all(color: appGreyColor),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: buildPageOne(model),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 50, left: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: GFSize.LARGE * 3.5,
                    child: ListTile(
                      title: Text(
                        S().status,
                        style: captionStyle,
                      ),
                      subtitle: Container(
                        child: GFButton(
                          onPressed: () {},
                          color: appButtonGreyColor,
                          child: Text(
                            getCodeLang(model.status),
                            style: namingStyle,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 1250,
                  ),
                  model.status == 'CANCELED' || model.status == 'UNAPPROVED'
                      ? SizedBox()
                      : model.status == 'COMPLETED'
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 50.0),
                              child: buildAssesment(radius, counter),
                            )
                          : buildRejectButton(counter)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildRejectButton(CarModel counter) {
    return FutureProvider<bool>(
        create: (BuildContext context) => RestServices.checkConnection(),
        initialData: null,
        child: Consumer<bool>(builder: (context, value, child) {
          if (value == null) {
            return GFLoader(
              type: GFLoaderType.ios,
            );
          }
          return Padding(
            padding: const EdgeInsets.only(bottom: 9.0, top: 50),
            child: Container(
              width: GFSize.LARGE * 8.5,
              height: GFSize.LARGE * 1.3,
              child: GFButton(
                size: GFSize.LARGE,
                color: appGreenColor,
                text: S().refuseOrder,
                textStyle: generalFontStyle.copyWith(
                    fontWeight: FontWeight.bold, fontSize: 22),
                onPressed: !value ? null : counter.refuse,
              ),
            ),
          );
        }));
  }

  //RML рейтинг поездки
  Widget buildAssesment(Radius radius, CarModel counter) {
    return FutureProvider<bool>(
      create: (BuildContext context) => RestServices.checkConnection(),
      initialData: null,
      child: Consumer<bool>(
        builder: (context, value, child) {
          if (value == null) {
            return GFLoader(
              type: GFLoaderType.ios,
            );
          }
          var percent = counter?.orderToShow?.rating;
          var isRated = percent == null;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(S().rateTheQualityOfTravel, style: captionStyle),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 5.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    buildEmojiButton(
                      borderRadius: BorderRadius.only(
                          topLeft: radius, bottomLeft: radius),
                      icon: Icons.sentiment_dissatisfied,
                      function: value && isRated
                          ? () => counter.setAssessment(20.0)
                          : (percent < 50 ? () {} : null),
                      color: isRated
                          ? appRedColor
                          : (!(percent < 50) ? appDisabledColor : appRedColor),
                      //color: isRated ? appDisabledColor : appRedColor
                    ),
                    buildEmojiButton(
                        borderRadius: BorderRadius.zero,
                        icon: Icons.sentiment_neutral,
                        function: value && isRated
                            ? () => counter.setAssessment(50.0)
                            : (percent < 80 && percent >= 50 ? () {} : null),
                        color: isRated
                            ? hexToColor('#FB9764')
                            : (!(percent < 80 && percent >= 50)
                                ? appDisabledColor
                                : hexToColor('#FB9764'))
                        //color: isRated ? appDisabledColor : hexToColor('#FB9764')
                        ),
                    buildEmojiButton(
                        borderRadius: BorderRadius.only(
                            topRight: radius, bottomRight: radius),
                        icon: Icons.sentiment_satisfied,
                        function: value && isRated
                            ? () => counter.setAssessment(80.0)
                            : (percent >= 80 ? () {} : null),
                        color: isRated
                            ? appGreenColor
                            : (!(percent >= 80)
                                ? appDisabledColor
                                : appGreenColor)
                        //color: isRated ? appDisabledColor : appGreenColor
                        )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Column buildPageOne(CarOrder model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildPadding(
          title: Text(
            'Пункт отправления',
            style: captionStyle,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              model.fromAddress ?? '',
              style: namingStyle,
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        buildPadding(
          title: Text(
            'Пункт назначения',
            style: captionStyle,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              model.toAddress ?? '',
              style: namingStyle,
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        buildPadding(
          title: Text(
            'Дата и время',
            style: captionStyle,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              '${formatDate(model.requestedDate)}' ?? '',
              style: namingStyle,
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        buildPadding(
          title: Text(
            'Количество пассажиров',
            style: captionStyle,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              model.count ?? '',
              style: namingStyle,
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 0, 0, 0),
          child: Container(
            alignment: Alignment.topLeft,
            child: Text(
              '${S().comment}:',
              style: captionStyle,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 5, 0, 0),
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 0, 5, 5),
            padding: EdgeInsets.fromLTRB(5, 3, 5, 45),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: appFiledBorderColor),
            ),
            alignment: Alignment.topLeft,
            width: 400,
            child: Text(
              model.comment ?? '-',
              style: namingStyle,
            ),
          ),
        ),
      ],
    );
  }

  Column buildPageTwo(CarOrder model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildPadding(
          title: Text(
            S().stateNumber, //'Контакты водителя',
            style: captionStyle,
          ),
          subtitle: Text(
            model.order?.vehicle?.stateNumber ?? S().noData,
            //model.order?.driver?.contact ?? S().noData,
            style: namingStyle,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        buildPadding(
          title: Text(
            S().vehicleModel, //'Марка транспорта',
            style: captionStyle,
          ),
          subtitle: Text(
            model.order?.vehicle?.model ?? S().noData,
            style: namingStyle,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        buildPadding(
          title: Text(
            S().driverContact, // 'Государственный номер',
            style: captionStyle,
          ),
          subtitle: GestureDetector(
            onTap: () async {
              if (await canLaunch('tel:${model.order?.driver?.contact}')) {
                await launch('tel:${model.order?.driver?.contact}');
              } else {
                throw 'Could not launch tel:${model.order?.driver?.contact}';
              }
            },
            child: Text(
              model.order?.driver?.contact ?? S().noData,
              style: namingStyle,
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        buildPadding(
          title: Text(
            S().passCount, //'Количество пассажиров',
            style: captionStyle,
          ),
          subtitle: Text(
            model.count ?? '',
            style: namingStyle,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 5, 0, 0),
          child: Container(
            alignment: Alignment.topLeft,
            child: Text(
              '${S().comment}:',
              style: captionStyle,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 5, 0, 0),
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
            padding: EdgeInsets.fromLTRB(5, 3, 5, 40),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: appFiledBorderColor),
            ),
            alignment: Alignment.topLeft,
            width: 400,
            child: Text(
              model.comment ?? '-',
              style: namingStyle,
            ),
          ),
        ),
      ],
    );
  }
}

Padding buildPadding({subtitle, title}) {
  return Padding(
    padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      title,
      subtitle,
    ]),
  );
}

class CarConfirm extends StatelessWidget {
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Заказ автотранспорта',
              style: generalFontStyle.copyWith(fontSize: 20),
            ),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Ваша заявка принята!',
                  style: generalFontStyle.copyWith(
                      fontSize: 25, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 100,
                ),
                Container(
                  width: GFSize.LARGE * 7,
                  height: GFSize.MEDIUM * 2.7,
                  child: Text(
                    'Ваша заявка обрабатывается, дождитесь уведомления',
                    style: generalFontStyle.copyWith(
                        fontSize: 20, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 150,
                ),
                Container(
                  width: GFSize.LARGE * 9,
                  height: GFSize.MEDIUM * 1.5,
                  child: GFButton(
                    onPressed: () => Get.back(),
                    text: 'ПОНЯТНО',
                    textStyle: generalFontStyle.copyWith(
                        fontSize: 25, fontWeight: FontWeight.bold),
                    color: appGreenColor,
                    size: GFSize.LARGE * 2,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
