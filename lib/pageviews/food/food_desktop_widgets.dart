import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:getflutter/getflutter.dart';
import 'package:hse/core/model/course_eating/CourseEatingHistory.dart';
import 'package:hse/core/model/eating_menu/EatingMenus.dart';
import 'package:hse/core/model/history_eating_order/HistoryEatingOrder.dart';
import 'package:hse/core/model/util_models.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/core/service/rest_services.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/pageviews/car_order/car_order_widgets.dart';
import 'package:hse/viewmodels/food_model.dart';
import 'package:hse/viewmodels/user_info.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:provider/provider.dart';

import '../../core/utils/UI_Helpers.dart';
import 'food_widgets.dart';

class MenuDesktopWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var model = Provider.of<FoodModel>(context);
    return Column(
      children: [
        Container(alignment: Alignment.centerLeft, child: buildDaysRow(model)),
        SizedBox(
          height: 5,
        ),
        Expanded(
          child: Container(
            alignment: Alignment.centerLeft,
            child: SingleChildScrollView(
              child: Column(
                children: [buildMenu(model)],
              ),
            ),
          ),
        ),
      ],
    );
  }

  SingleChildScrollView buildDaysRow(FoodModel model) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ...model.daysOfWeek.map((e) {
            return Container(
              width: GFSize.LARGE,
              height: GFSize.LARGE,
              margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
              child: GFButton(
                onPressed: () {
                  model.setBusy(true);
                  model.currentDay = e;
                  model.setBusy(false);
                },
                color: appBlueColor,
                type: model.currentDay == e
                    ? GFButtonType.solid
                    : GFButtonType.outline,
                text: DateFormat('EEE')
                    .format(model.firstDate.add(Duration(days: e))),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  FutureProvider<List<EatingMenus>> buildMenu(FoodModel model) {
    var list = <Widget>[];
    return FutureProvider<List<EatingMenus>>(
        create: (BuildContext context) => model.menu,
        initialData: null,
        child: Consumer<List<EatingMenus>>(builder: (context, menu, _) {
          if (menu == null || model.busy) {
            return GFLoader(
              type: GFLoaderType.ios,
            );
          }
          list.addAll(fillElements(menu, model, context));
          return Wrap(
            children: list,
          );
        }));
  }

  Iterable<Widget> fillElements(
      List<EatingMenus> menu, FoodModel model, BuildContext context) {
    var list = <Widget>[];
    model.menuToShow.forEach((element) {
      var daysCheck =
          (element) => element.dayOfWeek.compareTo(model.currentDay) == 0;
      element.products.where(daysCheck).forEach((product) {
        list.add(ElementBox(
            description: product.name,
            name: product.name,
            amount: product.amount,
            image: product.image,
            location: element.location,
            mealtime: product.mealtime));
      });
      element.complexes.where(daysCheck).forEach((complex) {
        list.add(ElementBox(
            description: complex.products.fold(
                '',
                (previousValue, element) =>
                    previousValue += ' ${element.name}, '),
            name: complex.name,
            amount: complex.amount,
            image: complex.image ?? complex.products.last.image,
            location: element.location,
            mealtime: complex.mealtime));
      });
    });
    return list;
  }
}

class HistoryDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<FoodModel>(context);
    final userInfo = Provider.of<UserInfoModel>(context);
    return FutureProvider<List<HistoryEatingOrder>>(
        create: (BuildContext context) => counter.orderHistory,
        initialData: null,
        child:
            Consumer<List<HistoryEatingOrder>>(builder: (context, orders, _) {
          if (orders == null || counter.busy) {
            return GFLoader(
              type: GFLoaderType.ios,
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: orders.map((e) {
                var string = e?.eatingMenus?.first?.products?.fold(
                    0.0,
                    (previousValue, element) =>
                        previousValue += element.amount ?? 0.0);
                if (e?.eatingMenus?.first?.products?.isNotEmpty ?? false) {
                  string = e?.eatingMenus?.first?.products?.fold(
                      0.0,
                      (previousValue, element) =>
                          previousValue += element.amount ?? 0.0);
                } else {
                  string = e?.eatingMenus?.first?.complexes?.fold(
                      0.0,
                      (previousValue, element) => previousValue +=
                          element.products.fold(
                              0.0,
                              (previousValue, element) =>
                                  previousValue += element.amount ?? 0.0));
                }
                return GestureDetector(
                  onTap: () => Get.to(FoodDesktopOrderInfo(
                    order: e,
                  )),
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 30, 10, 5),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: disabledColor(e) == Colors.black
                                    ? appBlueColor
                                    : appFiledBorderColor),
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  250.0, 25.0, 25.0, 25.0),
                              child: Text(
                                '${formatOnlyDate(e.orderDateTime)}',
                                style: generalFontStyle.copyWith(
                                    fontSize: 25,
                                    color: disabledColor(e) == Colors.black
                                        ? appBlueColor
                                        : appGreyColor),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  350.0, 25.0, 25.0, 25.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.pin_drop,
                                        color: appOrangeColor,
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Container(
                                        child: Text(
                                          e.locationName ?? '',
                                          style: generalFontStyle.copyWith(
                                              fontSize: 16,
                                              color: disabledColor(e)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_today,
                                        color: appOrangeColor,
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Container(
                                        child: Text(
                                          formatHour(e.orderDateTime) ?? '',
                                          style: generalFontStyle.copyWith(
                                              fontSize: 16,
                                              color: disabledColor(e)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 50,
                        top: 75,
                        child: Text(
                          userInfo.formatCash(string) ?? '',
                          style: generalFontStyle.copyWith(
                              color: disabledColor(e)),
                        ),
                      ),
                      Positioned(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.09,
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5)),
                          child: GFButton(
                            onPressed: () {},
                            text: getCodeLang(e.status),
                            color: getStatusColor(e.status),
                          ),
                        ),
                        right: 1,
                        top: -2,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          );
        }));
  }
}

class HistoryDesktopFact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<FoodModel>(context);
    final userInfo = Provider.of<UserInfoModel>(context);
    return FutureProvider<List<CourseEatingHistory>>(
        create: (BuildContext context) => counter.factHistory,
        initialData: null,
        child:
            Consumer<List<CourseEatingHistory>>(builder: (context, orders, _) {
          if (orders == null || counter.busy) {
            return GFLoader(
              type: GFLoaderType.ios,
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: orders.map((e) {
                return GestureDetector(
                  onTap: () => Get.to(ChangeNotifierProvider.value(
                      value: counter,
                      builder: (context, child) => FactDesktopInfo(e))),
                  child: Container(
                    margin: EdgeInsets.fromLTRB(10, 30, 10, 5),
                    decoration: BoxDecoration(
                        border: Border.all(color: appFiledBorderColor),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                              250.0, 25.0, 25.0, 25.0),
                          child: Text(
                            '${formatOnlyDate(e.courseEatingDate)}',
                            style: generalFontStyle.copyWith(
                              fontSize: 25,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                              350.0, 25.0, 25.0, 25.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.pin_drop,
                                    color: appOrangeColor,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Container(
                                    child: Text(
                                      e.location ?? '',
                                      style: generalFontStyle.copyWith(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    color: appOrangeColor,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Container(
                                    child: Text(
                                      formatHour(e.courseEatingDate) ?? '',
                                      style: generalFontStyle.copyWith(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        }));
  }
}

class FoodDesktopOrderInfo extends StatelessWidget {
  final HistoryEatingOrder order;

  const FoodDesktopOrderInfo({Key key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userInfo = Provider.of<UserInfoModel>(context);
    var productsList = order.eatingMenus.first.products.map((e) {
      return buildListTile(e.name, e.amount, e.calories ?? '', e.quantity,
          e.uom, userInfo, context);
    }).toList();
    var complexList = order.eatingMenus.first.complexes.map((e) {
      return buildListTile(
          e.name,
          e.products.fold(
              0, (previousValue, element) => previousValue += element.amount),
          e.products.fold(
              0,
              (previousValue, element) =>
                  previousValue += element.calories ?? 0),
          1,
          '',
          userInfo,
          context);
    }).toList();
    productsList.addAll(complexList);
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(S().food)),
      ),
      body: Container(
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${S().eating} ${formatDate(order.orderDateTime)}\n${S().number}:${order.code}',
                    style: generalFontStyle.copyWith(
                        color: appBlueColor, fontSize: 30),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.mapPin,
                        color: appOrangeColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${order.locationName}',
                        style: generalFontStyle.copyWith(fontSize: 20),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Expanded(
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: Column(
                    children: productsList,
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.12,
                    child: ListTile(
                      title: Text(S().status),
                      subtitle: GFButton(
                        size: GFSize.MEDIUM * 1.0,
                        onPressed: () {},
                        color: getStatusColor(order.status),
                        text: getCodeLang(order.status),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  ListTile buildListTile(name, amount, calories, quantity, uom,
      UserInfoModel userInfo, BuildContext context) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.only(bottom: 25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: GFSize.LARGE * 5.5,
                child: Text(
                  name,
                  style: generalFontStyle.copyWith(fontSize: 30),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Text(
                userInfo.formatCash(amount),
                style: generalFontStyle.copyWith(
                    fontSize: 25, fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).portion + ': ${quantity ?? ''} ${uom ?? ''}',
            style: generalFontStyle.copyWith(fontSize: 20),
          ),
          Text(
            '${S().calorificValue}: ${calories}',
            style: generalFontStyle.copyWith(fontSize: 20),
          ),
          Divider()
        ],
      ),
    );
  }
}

class FactDesktopInfo extends StatelessWidget {
  final CourseEatingHistory e;

  FactDesktopInfo(this.e);

  @override
  Widget build(BuildContext context) {
    var userInfo = Provider.of<UserInfoModel>(context);
    var counter = Provider.of<FoodModel>(context);
    var radius = Radius.circular(20);
    var productsList = e.dishes.map((e) {
      return buildListTile(e.name, e.amount, e.calories ?? '', e.quantity,
          e.quantityUom, userInfo, context);
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(S().food)),
      ),
      body: Container(
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${S().eating} ${formatDate(e.courseEatingDate)}',
                    style: generalFontStyle.copyWith(
                        color: appBlueColor, fontSize: 30),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.mapPin,
                        color: appOrangeColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${e.location}',
                        style: generalFontStyle.copyWith(fontSize: 20),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Expanded(
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: Column(
                    children: productsList,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 25.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: buildAssesment(radius, counter),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildAssesment(Radius radius, FoodModel counter) {
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
          var percent = e?.assessment;
          var isRated = percent == null;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 75.0, 0.0),
                child: Container(
                  child: Text(
                    S().rateLunch,
                    style: captionStyle,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 5.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    buildEmojiButton(
                      borderRadius: BorderRadius.only(
                          topLeft: radius, bottomLeft: radius),
                      icon: Icons.sentiment_dissatisfied,
                      function: value && isRated
                          ? () => counter.setAssessment(20.0, e)
                          : (percent < 50 ? () {} : null),
                      color: isRated
                          ? appRedColor
                          : (!(percent < 50) ? appDisabledColor : appRedColor),
                    ),
                    buildEmojiButton(
                        borderRadius: BorderRadius.zero,
                        icon: Icons.sentiment_neutral,
                        function: value && isRated
                            ? () => counter.setAssessment(50.0, e)
                            : (percent < 80 && percent >= 50 ? () {} : null),
                        color: isRated
                            ? hexToColor('#FB9764')
                            : (!(percent < 80 && percent >= 50)
                                ? appDisabledColor
                                : hexToColor('#FB9764'))),
                    buildEmojiButton(
                        borderRadius: BorderRadius.only(
                            topRight: radius, bottomRight: radius),
                        icon: Icons.sentiment_satisfied,
                        function: value && isRated
                            ? () => counter.setAssessment(80.0, e)
                            : (percent >= 80 ? () {} : null),
                        color: isRated
                            ? appGreenColor
                            : (!(percent >= 80)
                                ? appDisabledColor
                                : appGreenColor))
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  ListTile buildListTile(name, amount, calories, quantity, uom,
      UserInfoModel userInfo, BuildContext context) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.only(bottom: 25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: GFSize.LARGE * 5.5,
                child: Text(
                  name,
                  style: generalFontStyle.copyWith(fontSize: 30),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Text(
                userInfo.formatCash(amount),
                style: generalFontStyle.copyWith(fontSize: 25),
              ),
            )
          ],
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).portion + ': ${quantity ?? ''} ${uom ?? ''}',
            style: generalFontStyle.copyWith(fontSize: 20),
          ),
          Text(
            '${S().calorificValue}: ${calories}',
            style: generalFontStyle.copyWith(fontSize: 20),
          ),
          Divider()
        ],
      ),
    );
  }
}
