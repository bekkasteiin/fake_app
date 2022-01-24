import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:getflutter/getflutter.dart';
import 'package:hse/core/model/assignment/Assignment.dart';
import 'package:hse/core/model/course_eating/CourseEatingHistory.dart';
import 'package:hse/core/model/course_eating/Dish.dart';
import 'package:hse/core/model/eating_menu/Complex.dart';
import 'package:hse/core/model/eating_menu/EatingMenus.dart';
import 'package:hse/core/model/eating_menu/Mealtime.dart';
import 'package:hse/core/model/eating_menu/Product.dart';
import 'package:hse/core/model/history_eating_order/HistoryEatingOrder.dart';
import 'package:hse/core/model/place/Place.dart';
import 'package:hse/core/model/util_models.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/core/service/rest_services.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/pageviews/car_order/car_order_widgets.dart';
import 'package:hse/viewmodels/food_model.dart';
import 'package:hse/viewmodels/user_info.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:kinfolk/kinfolk.dart';
import 'package:provider/provider.dart';

import '../../core/utils/UI_Helpers.dart';

class MenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var model = Provider.of<FoodModel>(context);
    return Column(
      children: [
        Center(
          //padding: const EdgeInsets.only(left: 8.0),
          child: buildDaysRow(model),
        ),
        SizedBox(
          height: 15,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [buildMenu(model)],
            ),
          ),
        ),
      ],
    );
  }

  // дни недели в меню
  Widget buildDaysRow(FoodModel model) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ...model.daysOfWeek.map((e) {
            return Container(
              width: GFSize.LARGE * 1.125,
              height: GFSize.LARGE * 1.125,
              margin: EdgeInsets.fromLTRB(0, 20, 4, 0),
              child: GFButton(
                onPressed: () {
                  model.setBusy(true);
                  model.currentDay = e;
                  model.setBusy(false);
                },
                size: GFSize.LARGE * 1.5,
                color: appBlueColor,
                type: model.currentDay == e
                    ? GFButtonType.solid
                    : GFButtonType.outline,
                text: DateFormat('EEE')
                    .format(model.firstDate.add(Duration(days: e)))
                    .toUpperCase(),
                textStyle: generalFontStyle.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: defaultFontSize + 2,
                  color: model.currentDay == e ? Colors.white : appBlueColor,
                ),
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

// ignore: must_be_immutable
class ElementBox extends StatelessWidget {
  var location;
  var description;
  var name;
  var image;
  var mealtime;
  var amount;

  ElementBox(
      {this.description,
      this.name,
      this.image,
      this.location,
      this.mealtime,
      this.amount});

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<UserInfoModel>(context);
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
      width: MediaQuery.of(context).size.width * 0.4,
      //180,//RML
      margin: EdgeInsets.all(5.0),
      padding: EdgeInsets.all(5.0),
      child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text(
                  name,
                  style: generalFontStyle.copyWith(
                      color: appBlackColor, fontSize: defaultFontSize + 2),
                  maxLines: 2,
                )),
            GFImageOverlay(
              borderRadius: BorderRadius.circular(10),
              height: 105,
              width: 120,
              colorFilter:
                  ColorFilter.mode(Colors.transparent, BlendMode.color),
              image: AssetImage('assets/images/images.jpeg'),
            ),
            Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on,
                          size: GFSize.SMALL * 0.65,
                          color: appGreyColor,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Text(
                            location,
                            style: generalFontStyle.copyWith(fontSize: 12),
                            maxLines: 1,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: GFSize.SMALL * 0.65,
                          color: appGreyColor,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          child: Text(
                            mealtime.split('').sublist(0, 5).join('') +
                                ' - ' +
                                mealtime.split('').sublist(6, 11).join(""),
                            style: generalFontStyle.copyWith(fontSize: 12),
                          ),
                        )
                      ],
                    ),
                  ],
                )),
            Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text(
                  counter.formatCash(amount),
                  style: generalFontStyle.copyWith(
                      fontSize: defaultFontSize + 5,
                      color: appBlackColor,
                      fontWeight: FontWeight.bold),
                )),
            Container(
              child: SingleChildScrollView(
                  child: Text(
                description,
                style: generalFontStyle.copyWith(
                    color: appBlackColor, fontSize: defaultFontSize - 2),
              )),
            ),
            SizedBox(
              height: 10,
            )
          ]),
    );
  }
}

class OrderWidget extends StatelessWidget {
  final Map map = {
    '/places': PlacesWidget(),
    '/time': TimeSelector(),
    '/dishes': DishesAdder(),
    '/info': OrderInfo()
  };

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<FoodModel>(context);
    return Stack(
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FoodStepper(),
            map[counter.step],
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [buildButton(counter, context)],
        ),
      ],
    );
  }

  Widget buildButton(FoodModel counter, BuildContext context) {
    return FutureProvider<bool>(
        create: (BuildContext context) => RestServices.checkConnection(),
        initialData: null,
        child: Consumer<bool>(builder: (context, value, child) {
          if (value == null) {
            return GFLoader(
              type: GFLoaderType.ios,
            );
          }
          return SnackButtons(
            leftText: S().select,
            rightText: counter.step == '/places' ? S().cancel : S().back,
            functionLeft: !value ? null : () => counter.next(),
            functionRight: !value ? null : () => counter.back(),
          );
        }));
  }
}

class FoodStepper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var model = Provider.of<FoodModel>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 25),
          child: Text(
            model.header,
            style: generalFontStyle.copyWith(
                fontSize: defaultFontSize + 10, fontWeight: FontWeight.w300),
          ),
        ),
        CustomStepper(
          functions: [
            () {
              model.step = '/places';
              model.index = 1;
              model.setBusy(false);
            },
            () {
              model.step = '/time';
              model.index = 2;
              model.setBusy(false);
            },
            () {
              model.step = '/dishes';
              model.index = 3;
              model.setBusy(false);
            },
            () {
              model.step = '/info';
              model.index = 4;
              model.setBusy(false);
            },
          ],
          current: model.index ?? 1,
        ),
      ],
    );
  }
}

class PlacesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<FoodModel>(context);
    return Expanded(
      child: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: buildPlaceSelector(context, counter),
              ),
              counter.placeStep == '/foodplace'
                  ? PlacesList(context, counter)
                  : DeliveryList(context, counter)
            ],
          ),
        ),
      ),
    );
  }

  // кнопка выбора места питания
  Widget PlacesList(BuildContext context, FoodModel counter) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.fromLTRB(15, 25, 15, 0),
      child: SingleChildScrollView(
          child: FutureProvider<List<Place>>(
              create: (BuildContext context) => counter.place,
              initialData: null,
              child: Consumer<List<Place>>(builder: (context, model, _) {
                if (model == null) {
                  return Center(
                    child: GFLoader(
                      type: GFLoaderType.ios,
                    ),
                  );
                }
                var list = model.map((e) {
                  return GestureDetector(
                    onTap: () => counter.selectPlace(e),
                    child: Visibility(
                      visible: e.name == 'Доставка' ? false : true,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: counter.order.location == e.id
                                    ? appBlueColor
                                    : appFiledBorderColor),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                          child: ListTile(
                            leading: Icon(
                              FontAwesomeIcons.utensils,
                              color: appBlueColor,
                              size: GFSize.SMALL,
                            ),
                            title: Text(e.name,
                                style: generalFontStyle.copyWith(
                                    fontSize: defaultFontSize + 4,
                                    color: counter.order.location == e.id
                                        ? appBlackColor
                                        : appGreyColor)),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList();
                list.add(GestureDetector(
                    child: SizedBox(
                  height: GFSize.LARGE * 2,
                )));
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: list,
                );
              }))),
    );
  }

  Widget DeliveryList(BuildContext context, FoodModel counter) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.fromLTRB(15, 25, 15, 0),
      child: SingleChildScrollView(
          child: FutureProvider<List<Place>>(
              create: (BuildContext context) => counter.place,
              initialData: null,
              child: Consumer<List<Place>>(builder: (context, model, _) {
                if (model == null) {
                  return Center(
                    child: GFLoader(
                      type: GFLoaderType.ios,
                    ),
                  );
                }
                var list = model.map((e) {
                  return GestureDetector(
                    onTap: () => counter.selectPlace(e),
                    child: Visibility(
                      visible: e.name == 'Доставка' ? true : false,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: counter.order.location == e.id
                                    ? appBlueColor
                                    : appFiledBorderColor),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                          child: ListTile(
                            leading: Icon(
                              FontAwesomeIcons.truck,
                              color: appBlueColor,
                              size: GFSize.SMALL,
                            ),
                            title: Text(e.name,
                                style: generalFontStyle.copyWith(
                                    fontSize: defaultFontSize + 4,
                                    color: counter.order.location == e.id
                                        ? appBlackColor
                                        : appGreyColor)),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList();
                list.add(GestureDetector(
                    child: SizedBox(
                  height: GFSize.LARGE * 2,
                )));
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: list,
                );
              }))),
    );
  }

  // кнопка выбора места питания
  Row buildPlaceSelector(BuildContext context, FoodModel counter) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.height * 0.07,
          child: GFButton(
            size: 52.0,
            onPressed: () {
              counter.placeStep = '/foodplace';
              counter.setBusy(false);
            },
            type: counter.placeStep == '/foodplace'
                ? GFButtonType.solid
                : GFButtonType.outline,
            text: S().foodLocation,
            textStyle: generalFontStyle.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: defaultFontSize,
              color: counter.placeStep == '/foodplace'
                  ? Colors.white
                  : appBlueColor,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          width: MediaQuery.of(context).size.width * 0.45,
          height: MediaQuery.of(context).size.height * 0.07,
          child: GFButton(
            onPressed: () {
              counter.placeStep = '/delivery';
              counter.setBusy(false);
            },
            type: counter.placeStep == '/delivery'
                ? GFButtonType.solid
                : GFButtonType.outline,
            text: S().foodDelivery,
            textStyle: generalFontStyle.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: defaultFontSize,
              color: counter.placeStep == '/delivery'
                  ? Colors.white
                  : appBlueColor,
            ),
          ),
        ),
      ],
    );
  }
}

// кнопка выбор времени питания
class TimeSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<FoodModel>(context);
    var screenSize = MediaQuery.of(context).size;
    var currentDate = DateTime.now();
    return Expanded(
        child: Container(
            width: screenSize.width * 0.8,
            margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxHeight: GFSize.LARGE * 3,
                      minHeight: GFSize.LARGE * 2,
                    ),
                    child: CupertinoDatePicker(
                      onDateTimeChanged: (DateTime value) {
                        counter.order.orderDateTime = value;
                        counter.setBusy(false);
                      },
                      minimumDate: currentDate,
                      initialDateTime: currentDate,
                      maximumDate: currentDate.add(Duration(days: 3)),
                      mode: CupertinoDatePickerMode.date,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  buildMealtimeSelector(counter, screenSize),
                ],
              ),
            )));
  }

  FutureProvider<List<Mealtime>> buildMealtimeSelector(
      FoodModel counter, Size screenSize) {
    return FutureProvider<List<Mealtime>>(
        create: (BuildContext context) => counter.mealtime,
        initialData: null,
        child: Consumer<List<Mealtime>>(builder: (context, model, _) {
          if (model == null) {
            return Center(
              child: GFLoader(
                type: GFLoaderType.ios,
              ),
            );
          }
          return Container(
            width: screenSize.width,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ...model.map((e) {
                    return GestureDetector(
                      onTap: () => counter.selectMealtime(e),
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                                color: counter.order.mealtimeId == e.id
                                    ? appBlueColor
                                    : appFiledBorderColor)),
                        width: screenSize.width * 0.8,
                        child: ListTile(
                          leading: Icon(
                            counter.order.mealtimeId == e.id
                                ? FontAwesomeIcons.checkSquare
                                : FontAwesomeIcons.square,
                            color: appBlueColor,
                            size: GFSize.SMALL,
                          ),
                          title: Text(e.langValue1,
                              style: generalFontStyle.copyWith(
                                fontSize: defaultFontSize + 4,
                                fontWeight: counter.order.mealtimeId == e.id
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              )),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text('${e.startTime}-${e.endTime}',
                                style: generalFontStyle.copyWith(
                                    color: counter.order.mealtimeId == e.id
                                        ? appBlackColor
                                        : appGreyColor,
                                    fontWeight: counter.order.mealtimeId == e.id
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    fontSize: defaultFontSize)),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  SizedBox(
                    height: GFSize.LARGE * 2,
                  )
                ],
              ),
            ),
          );
        }));
  }
}

// Добавление блюда в Заказ
class DishesAdder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<FoodModel>(context);
    if ((counter?.mealtimeList ?? []).isEmpty ||
        counter.order.mealtimeId == null) {
      return Container();
    }
    var mealtime = counter?.mealtimeList
        ?.where((element) => element.id == counter.order.mealtimeId)
        ?.first;
    var eatingMenus2 = counter?.order?.eatingMenus;
    var cost = eatingMenus2.isNotEmpty
        ? (eatingMenus2?.first?.complexes?.isNotEmpty ?? false
            ? eatingMenus2?.first?.complexes?.fold(0.0,
                (previousValue, element) {
                if (element.amount == null || previousValue == null) {
                  previousValue += 0;
                  return previousValue;
                } else {
                  previousValue += element.amount;
                  return previousValue;
                }
              })
            : eatingMenus2?.first?.products?.fold(0.0,
                (previousValue, element) {
                if (element.amount == null || previousValue == null) {
                  previousValue += 0;
                  return previousValue;
                } else {
                  previousValue += element.amount;
                  return previousValue;
                }
              }))
        : [];
    final userInfo = Provider.of<UserInfoModel>(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0, bottom: 10),
          child: buildDishSelector(context, counter),
        ),
        FutureProvider<List<EatingMenus>>(
            create: (BuildContext context) => counter.selectMenu,
            initialData: null,
            child: Consumer<List<EatingMenus>>(builder: (context, menu, _) {
              if (menu == null) {
                return Center(
                  child: GFLoader(
                    type: GFLoaderType.ios,
                  ),
                );
              }
              if (menu.isEmpty) {
                return Text(S().anotherPlaceDate,
                    style: namingStyle); //'Попробуйте другое время/место');
              }
              return Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: menu
                            .map((e) => Row(
                                  children: counter.dishStep == '/complex'
                                      ? fillComplexesSelect(
                                          menu, userInfo, counter)
                                      : fillProductsSelect(
                                          context, menu, userInfo, counter),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                  // RML !!!
                  // (cost != null) && (cost > 0.0)
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context).InTotal,
                          style: generalFontStyle.copyWith(
                              fontSize: defaultFontSize + 3,
                              color: appBlackColor),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          userInfo.formatCash(cost),
                          style: generalFontStyle.copyWith(
                              fontSize: defaultFontSize + 3,
                              color: appBlackColor),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }))
      ],
    );
  }
}

Row buildDishSelector(BuildContext context, FoodModel counter) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height * 0.07,
        child: GFButton(
          onPressed: () {
            counter.dishStep = '/complex';
            counter.setBusy(false);
          },
          type: counter.dishStep == '/complex'
              ? GFButtonType.solid
              : GFButtonType.outline,
          text: S().complex,
          textStyle: generalFontStyle.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: defaultFontSize,
            color:
                counter.dishStep == '/complex' ? appWhiteColor : appBlueColor,
          ),
        ),
      ),
      Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        width: MediaQuery.of(context).size.width * 0.45,
        height: MediaQuery.of(context).size.height * 0.07,
        child: GFButton(
          onPressed: () {
            counter.dishStep = '/dish';
            counter.setBusy(false);
          },
          type: counter.dishStep == '/dish'
              ? GFButtonType.solid
              : GFButtonType.outline,
          text: S().dish,
          textStyle: generalFontStyle.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: defaultFontSize,
            color: counter.dishStep == '/dish' ? appWhiteColor : appBlueColor,
          ),
        ),
      ),
    ],
  );
}

Iterable<Widget> fillComplexesSelect(
    List<EatingMenus> menu, UserInfoModel userInfo, FoodModel model) {
  var list = <Widget>[];
  menu.forEach((element) {
    element.complexes.toSet().forEach((complex) {
      list.add(buildComplexBox(complex, model, userInfo, element));
    });
  });
  return list;
}

//список комплекса при выборе в заказ
Widget buildComplexBox(Complex complex, FoodModel model, UserInfoModel userInfo,
    EatingMenus singleMenu) {
  var whereChecker = (element) => element.id == singleMenu.id;
  var count = getComplexCount(model, whereChecker, complex);
  var size = GFSize.LARGE;
  var boxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(10.0),
    color: appWhiteColor,
    border: Border.all(width: 0.2, color: appBlueColor),
  );
  return Container(
    margin: EdgeInsets.all(8),
    padding: EdgeInsets.all(8),
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
    child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 67,
              width: 67,
              //height: GFSize.LARGE * 2.5,
              //width: GFSize.LARGE * 2.5,
              child: Wrap(
                children: complex.products.map((e) {
                  return GFImageOverlay(
                    borderRadius: BorderRadius.circular(10),
                    height: 67 / 2,
                    width: 67 / 2,
                    //height: (GFSize.LARGE * 2.5) / 3,
                    //width: (GFSize.LARGE * 2.5) / 3,
                    colorFilter:
                        ColorFilter.mode(Colors.transparent, BlendMode.color),
                    image: AssetImage('assets/images/images.jpeg'),
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              width: 250,
              height: GFSize.LARGE * 3.9,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      complex.name,
                      style: generalFontStyle.copyWith(
                        color: appBlackColor,
                        fontSize: defaultFontSize,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    S().description,
                    style: captionStyle,
                  ),
                  Expanded(
                    //width: GFSize.LARGE * 8,
                    //child: SingleChildScrollView(
                    child: Text(
                      complex.products.fold(
                          '',
                          (previousValue, element) =>
                              previousValue += ' ${element.name}, '),
                      style: generalFontStyle.copyWith(
                          fontSize: defaultFontSize - 2, color: appGreyColor),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    //),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    userInfo.formatCash(complex.amount ??
                        complex.products.fold(
                            0,
                            (previousValue, element) =>
                                previousValue += element.amount)),
                    style: generalFontStyle.copyWith(
                        fontSize: defaultFontSize + 2,
                        fontWeight: FontWeight.bold),
                    //  style: generalFontStyle.copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                height: size,
                width: size,
                decoration: BoxDecoration(
                    border: Border.all(color: appBlueColor),
                    borderRadius: BorderRadius.circular(2)),
                child: RaisedButton(
                  color: Colors.white,
                  elevation: 0,
                  child: Text(
                    '-',
                    style: generalFontStyle.copyWith(
                      fontSize: defaultFontSize + 5,
                      color: appBlackColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () =>
                      model.substractComplexFromOrder(complex, singleMenu),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                height: size,
                width: size * 1.5,
                decoration: BoxDecoration(
                    border: Border.all(color: appBlueColor),
                    borderRadius: BorderRadius.circular(2)),
                child: RaisedButton(
                  color: Colors.white,
                  elevation: 0,
                  child: Text(
                    count ?? '0',
                    style: generalFontStyle.copyWith(
                      fontSize: defaultFontSize,
                      color: appBlueColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {},
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                height: size,
                width: size,
                decoration: BoxDecoration(
                    border: Border.all(color: appBlueColor),
                    borderRadius: BorderRadius.circular(2)),
                child: RaisedButton(
                  color: Colors.white,
                  elevation: 0,
                  child: Text(
                    '+',
                    style: generalFontStyle.copyWith(
                      fontSize: defaultFontSize + 5,
                      color: appBlackColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () => model.addComplexToOrder(complex, singleMenu),
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}

// список блюд при выборе в заказ
Container buildProductBox(Product product, UserInfoModel userInfo, double size,
    FoodModel model, EatingMenus singleMenu) {
  var whereChecker = (element) => element.id == singleMenu.id;
  var count = getProductCount(model, whereChecker, product);
  var boxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(10.0),
    color: appWhiteColor,
    border: Border.all(width: 0.2, color: appBlueColor),
  );
  return Container(
    margin: EdgeInsets.all(8),
    padding: EdgeInsets.all(8),
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
    child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GFImageOverlay(
              borderRadius: BorderRadius.circular(10),
              height: 67,
              width: 67,
              colorFilter:
                  ColorFilter.mode(Colors.transparent, BlendMode.color),
              image: AssetImage('assets/images/images.jpeg'),
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              height: GFSize.LARGE * 2.9,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      product.name,
                      style: generalFontStyle.copyWith(
                        color: appBlackColor,
                        fontSize: defaultFontSize,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    S().description,
                    style: captionStyle,
                  ),
                  Expanded(
                    child: Text(
                      product.name,
                      style: generalFontStyle.copyWith(
                          fontSize: defaultFontSize - 2, color: appGreyColor),
                      maxLines: 2,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    userInfo.formatCash(product.amount),
                    style: generalFontStyle.copyWith(
                        fontSize: defaultFontSize + 2,
                        fontWeight: FontWeight.bold),
                    //textAlign: TextAlign.right,
                    //    style: generalFontStyle.copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: GestureDetector(
                  onTap: () =>
                      model.substractProductFromOrder(product, singleMenu),
                  child: Container(
                    width: 45.0,
                    height: 45.0,
                    decoration: boxDecoration,
                    child: Center(
                      child: Text(
                        '-',
                        style: generalFontStyle.copyWith(
                          fontSize: defaultFontSize + 5,
                          color: appBlackColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: 45.0,
                height: 45.0,
                decoration: boxDecoration,
                child: Center(
                  child: Text(
                    count ?? '0',
                    style: generalFontStyle.copyWith(
                      fontSize: defaultFontSize + 5,
                      color: appBlueColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: GestureDetector(
                    onTap: () => model.addProductToOrder(product, singleMenu),
                    child: Container(
                      width: 45.0,
                      height: 45.0,
                      decoration: boxDecoration,
                      child: Center(
                        child: Text(
                          '+',
                          style: generalFontStyle.copyWith(
                            fontSize: defaultFontSize + 5,
                            color: appBlackColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ],
    ),
  );
}

String getComplexCount(
    FoodModel model, bool whereChecker(dynamic element), Complex complex) {
  try {
    return model?.order?.eatingMenus
        ?.where(whereChecker)
        ?.first
        ?.complexes
        ?.where((element) => element?.id == complex?.id)
        ?.length
        ?.toString();
  } catch (e) {
    return null;
  }
}

// формирование списка выбора в заказ
Iterable<Widget> fillProductsSelect(BuildContext context,
    List<EatingMenus> menu, UserInfoModel userInfo, FoodModel model) {
  var list = <Widget>[];
  var size = GFSize.LARGE;
  menu.forEach((singleMenu) {
    singleMenu.products.toSet().forEach((product) {
      list.add(buildProductBox(product, userInfo, size, model, singleMenu));
    });
  });
  return list;
}

String getProductCount(
    FoodModel model, bool whereChecker(dynamic element), Product product) {
  try {
    return model?.order?.eatingMenus
        ?.where(whereChecker)
        ?.first
        ?.products
        ?.where((element) => element?.id == product?.id)
        ?.length
        ?.toString();
  } catch (e) {
    return null;
  }
}

class OrderInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<FoodModel>(context);
    final userInfo = Provider.of<UserInfoModel>(context);
    if ((counter?.mealtimeList ?? []).isEmpty ||
        counter.order.mealtimeId == null) {
      return Container();
    }
    var mealtime = counter?.mealtimeList
        ?.where((element) => element.id == counter.order.mealtimeId)
        ?.first;
    var eatingMenus2 = counter?.order?.eatingMenus;
    var cost = eatingMenus2.isNotEmpty
        ? (eatingMenus2?.first?.complexes?.isNotEmpty ?? false
            ? eatingMenus2?.first?.complexes?.fold(0.0,
                (previousValue, element) {
                if (element.amount == null || previousValue == null) {
                  previousValue += 0;
                  return previousValue;
                } else {
                  previousValue += element.amount;
                  return previousValue;
                }
              })
            : eatingMenus2?.first?.products?.fold(0.0,
                (previousValue, element) {
                if (element.amount == null || previousValue == null) {
                  previousValue += 0;
                  return previousValue;
                } else {
                  previousValue += element.amount;
                  return previousValue;
                }
              }))
        : [];
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
              left: 10, top: 10.0, right: 10.0, bottom: 10.0),
          child: buildPlace(context, counter, mealtime, cost),
        ),
        Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: eatingMenus2.isNotEmpty
                        ? (eatingMenus2?.first?.complexes?.isNotEmpty ?? false
                            ? fillComplexesSelect(
                                counter.order.eatingMenus, userInfo, counter)
                            : fillProductsSelect(context,
                                counter.order.eatingMenus, userInfo, counter))
                        : [])))
      ],
    );
  }

  //предупреждение перед заказом
  Container buildPlace(
      BuildContext context, FoodModel counter, Mealtime mealtime, cost) {
    var userInfo = Provider.of<UserInfoModel>(context);
    return Container(
      margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
      decoration: BoxDecoration(
          color: appYellowColor,
          border: Border.all(color: appFiledBorderColor),
          borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(
          FontAwesomeIcons.radiationAlt,
          color: appRedColor,
          size: GFSize.SMALL,
        ),
        title: Text(counter?.order?.locationName ?? '', style: namingStyle),
        subtitle: Text(
            '${mealtime?.startTime ?? ''} - ${mealtime?.endTime ?? ''}',
            style: captionStyle),
        trailing: Text(
          userInfo.formatCash(cost),
          style: generalFontStyle.copyWith(
              fontSize: defaultFontSize + 5, color: appBlackColor),
        ),
        // title: Row(
        //   children: [
        //     Padding(
        //       padding: const EdgeInsets.only(top: 10.0, right: 10),
        //       child:
        //     Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         // Container(
        //         //   width: 250,
        //         //   child: Row(
        //         //     children: [
        //         //       Text(
        //         //         S.of(context).placeAndTimeEating,
        //         //         style: captionStyle
        //         //       ),
        //         //       Spacer(),
        //         //       Text(
        //         //         S.of(context).InTotal,
        //         //         style: generalFontStyle.copyWith(fontSize: 14, color: appGreyColor),
        //         //       ),
        //         //     ],
        //         //   ),
        //         // ),
        //         // SizedBox(
        //         //   height: 3,
        //         // ),
        //         Container(
        //           width: 250,
        //           // child: Row(
        //           //   children: [
        //           //     Text(counter?.order?.locationName ?? '',
        //           //         style: generalFontStyle.copyWith(fontSize: 16, color: appBlackColor)),
        //           //     Spacer(),
        //           //     Text(
        //           //       userInfo.formatCash(cost),
        //           //       style: generalFontStyle.copyWith(fontSize: 16, color: appBlackColor),
        //           //     ),
        //           //   ],
        //           // ),
        //         ),
        //         SizedBox(
        //           height: 3,
        //         ),
        //       ],
        //     ),
        //   ],),
        //),
      ),
    );
  }
}

class History extends StatelessWidget {
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
                      (previousValue, element) =>
                          previousValue += element.amount ?? 0.0);
                }
                return GestureDetector(
                  onTap: () => Get.to(FoodOrderInfo(
                    order: e,
                  )),
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border(
                          bottom: BorderSide(color: appBlueColor, width: 0.2),
                        )),
                        child: ListTile(
                          leading: Icon(
                            disabledColor(e) == appGreenColor
                                ? FontAwesomeIcons.checkCircle
                                : disabledColor(e) == appRedColor
                                    ? FontAwesomeIcons.ban
                                    : FontAwesomeIcons.bolt,
                            color: disabledColor(e),
                            size: GFSize.SMALL,
                          ),
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '${formatOnlyDate(e.orderDateTime)}',
                                  style: generalFontStyle.copyWith(
                                      fontSize: defaultFontSize + 2,
                                      color: disabledColor(e) == Colors.black
                                          ? appBlackColor
                                          : appBlackColor),
                                ),
                                Text(
                                  userInfo.formatCash(string) ?? '',
                                  style: generalFontStyle.copyWith(
                                      fontSize: defaultFontSize + 2,
                                      color: disabledColor(e) == Colors.black
                                          ? appBlackColor
                                          : appBlackColor),
                                )
                              ],
                            ),
                          ),
                          subtitle: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                e.locationName ?? '',
                                style: generalFontStyle.copyWith(
                                    color: appGreyColor,
                                    fontSize: defaultFontSize),
                              ),
                            ],
                          ),
                        ),
                      ),
                      /*  Positioned(
                        child: GFButton(
                          onPressed: () {},
                          text: getCodeLang(e.status),
                          color: getStatusColor(e.status),
                        ),
                        right: 1,
                        top: -5,
                      ),*/
                    ],
                  ),
                );
              }).toList(),
            ),
          );
        }));
  }
}

//История питания
class HistoryFact extends StatelessWidget {
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
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: orders.map((e) {
                var amountSum = 0.0;
                for (var dish in e.dishes) {
                  amountSum += dish.amount * dish.quantity;
                }
                return GestureDetector(
                  onTap: () => Get.to(ChangeNotifierProvider.value(
                      value: counter,
                      builder: (context, child) => FactInfo(e))),
                  child: Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(color: appBlueColor, width: 0.2),
                    )),
                    child: ListTile(
                      leading: Icon(
                        FontAwesomeIcons.checkCircle,
                        color: appGreenColor,
                        size: GFSize.SMALL,
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${formatOnlyDate(e.courseEatingDate)}',
                              style: generalFontStyle.copyWith(
                                  fontSize: defaultFontSize + 2,
                                  color: appBlackColor),
                            ),
                            Text(
                              userInfo.formatCash(amountSum) ?? '',
                              style: generalFontStyle.copyWith(
                                  fontSize: defaultFontSize + 2,
                                  color: appBlackColor),
                            )
                          ],
                        ),
                      ),
                      subtitle: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            e.location ?? '',
                            style: generalFontStyle.copyWith(
                                color: appGreyColor, fontSize: defaultFontSize),
                          ),
                          Text(
                            e.dayLimitOverrun > 0.0
                                ? userInfo.formatCash(e.dayLimitOverrun)
                                : '',
                            style: generalFontStyle.copyWith(color: Colors.red),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        }));
  }
}

Color disabledColor(HistoryEatingOrder e) {
  return e.status == 'COMPLETED' || e.status == 'CLOSED'
      ? appGreenColor
      : e.status == 'CANCELED' || e.status == 'REJECTED'
          ? appRedColor
          : e.status == 'UNAPPROVED'
              ? appYellowColor
              : appOrangeColor;
}

class FoodOrderInfo extends StatelessWidget {
  final HistoryEatingOrder order;

  const FoodOrderInfo({Key key, this.order}) : super(key: key);

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
          e.amount,
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
        automaticallyImplyLeading: true,
        title: Container(
          alignment: Alignment.centerLeft,
          child: Text(
            S().food,
            style: generalFontStyle.copyWith(fontSize: defaultFontSize + 5),
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              //Order history details
              leading: Icon(
                  disabledColor(order) == appGreenColor
                      ? FontAwesomeIcons.checkCircle
                      : disabledColor(order) == appRedColor
                          ? FontAwesomeIcons.ban
                          : FontAwesomeIcons.bolt,
                  //disabledColor(order) == Colors.black ? FontAwesomeIcons.clock : FontAwesomeIcons.checkCircle,
                  color: disabledColor(order),
                  size: GFSize.SMALL),
              title: Padding(
                padding: const EdgeInsets.only(bottom: 0.0),
                child: Text(
                    //'${S().eating} ${formatDate(order.orderDateTime)}\n${S().number}:${order.code}',
                    '${formatDate(order.orderDateTime)}, № ${order.code}',
                    style: namingStyle),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Row(
                  children: [
                    Text(order.locationName, style: captionStyle),
                  ],
                ),
              ),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(S().status, style: captionStyle)),
                        ),
                        subtitle: GFButton(
                          onPressed: () {},
                          color: getStatusColor(order.status),
                          text: getCodeLang(order.status),
                          textStyle: generalFontStyle.copyWith(
                              fontSize: defaultFontSize - 2),
                        ),
                      ),
                    ),
                  ],
                ),
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
      leading: Padding(
        padding: EdgeInsets.only(left: 20.0, right: 0.0, top: 0.0),
        child: Icon(
          FontAwesomeIcons.solidCircle,
          color: appBlueColor,
          size: GFSize.SMALL * 0.5,
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(name,
                  style: namingStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
            ),
            SizedBox(width: 2.0),
            Text(
              userInfo.formatCash(amount),
              style: namingStyle,
            )
          ],
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(left: 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('${S().calorificValue} (ккал) ', style: captionStyle),
                Text('${calories}', style: captionStyle),
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
                Text(S.of(context).portion + ' (${uom ?? ''})',
                    style: captionStyle),
                Text('${quantity ?? ''}', style: captionStyle)
              ],
            ),
            Divider()
          ],
        ),
      ),
    );
  }
}

class FactInfo extends StatelessWidget {
  final CourseEatingHistory e;

  FactInfo(this.e);

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
        automaticallyImplyLeading: true,
        title: Container(
          alignment: Alignment.centerLeft,
          child: Text(
            S().food,
            style: generalFontStyle.copyWith(fontSize: defaultFontSize + 5),
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.only(bottom: 0.0),
                child: Icon(
                  FontAwesomeIcons.checkCircle,
                  color: appGreenColor,
                  size: GFSize.SMALL,
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.only(bottom: 0.0),
                child: Text('${formatDate(e.courseEatingDate)}',
                    style: namingStyle),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(bottom: 0.0),
                child: Row(
                  children: [
                    Text(e.location, style: captionStyle),
                  ],
                ),
              ),
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
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              child: buildAssesment(radius, counter),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(S().rateLunch, style: captionStyle),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 40.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
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

  //RML
  ListTile buildListTile(name, amount, calories, quantity, uom,
      UserInfoModel userInfo, BuildContext context) {
    return ListTile(
      leading: Padding(
        padding: EdgeInsets.only(left: 20.0, right: 0.0, top: 0.0),
        child: Icon(
          FontAwesomeIcons.solidCircle,
          color: appBlueColor,
          size: GFSize.SMALL * 0.5,
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(name,
                  style: namingStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
            ),
            SizedBox(width: 2.0),
            Text(
              userInfo.formatCash(amount),
              style: namingStyle,
            )
          ],
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(left: 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('${S().calorificValue} (ккал)', style: captionStyle),
                Text('${calories}', style: captionStyle),
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
                Text(S.of(context).portion + ' (${uom ?? ''})',
                    style: captionStyle),
                Text('${quantity ?? ''}', style: captionStyle)
              ],
            ),
            Divider()
          ],
        ),
      ),
    );
  }
}

class LimitsDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userInfo = Provider.of<UserInfoModel>(context);
    var size2 = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: !isDesktop(context) ? Colors.white : Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Container(
          height: size2.height * 0.7,
          width: size2.width * (isDesktop(context) ? 0.4 : 0.9),
          decoration: !isDesktop(context)
              ? null
              : BoxDecoration(
                  color: const Color(0xffffffff),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x2e000000),
                      offset: Offset(0, 14),
                      blurRadius: 48,
                    ),
                  ],
                ),
          child: FutureProvider<Assignment>(
              create: (BuildContext context) => userInfo.assignment(),
              initialData: null,
              child: Consumer<Assignment>(builder: (context, model, _) {
                if (model == null) {
                  return GFLoader(
                    type: GFLoaderType.ios,
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: isDesktop(context) ? 50 : 10,
                    ),
                    SizedBox(
                      width: 228.0,
                      child: Text.rich(
                        TextSpan(
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 17,
                            color: const Color(0xff292724),
                            letterSpacing: -0.34,
                            height: 1.75,
                          ),
                          children: [
                            TextSpan(
                                text: '${S().monthLimit}\n',
                                style: generalFontStyle.copyWith(
                                    fontSize: defaultFontSize + 2,
                                    color: appBlackColor)),
                            TextSpan(
                                text: userInfo
                                    .formatCash(model?.limits?.monthLimit),
                                style: generalFontStyle.copyWith(
                                    fontSize: defaultFontSize + 5,
                                    color: appBlackColor,
                                    fontWeight: FontWeight.w500)),
                            TextSpan(
                              text: ' ',
                              style: TextStyle(
                                fontSize: 16,
                                color: const Color(0xff000000),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    buildContent(context, [
                      Text(S().spent, style: captionStyle),
                      Text(userInfo.formatCash(model?.limits?.spent),
                          style: namingStyle),
                    ]),
                    buildContainer(context),
                    buildContent(context, [
                      Text(S().left, style: captionStyle),
                      Text(userInfo.formatCash(model?.limits?.left),
                          style: namingStyle),
                    ]),
                    buildContainer(context),
                    buildContent(context, [
                      Text(S().dailyLimit, style: captionStyle),
                      Text(userInfo.formatCash(model?.limits?.dayLimit),
                          style: namingStyle),
                    ]),
                    buildContainer(context),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: 140,
                      height: 52,
                      child: GFButton(
                        size: 52,
                        color: appGreenColor,
                        fullWidthButton: true,
                        text: 'ОК',
                        textStyle: generalFontStyle.copyWith(
                            color: appWhiteColor,
                            fontSize: defaultFontSize + 4,
                            fontWeight: FontWeight.bold),
                        type: GFButtonType.solid,
                        onPressed: () => Get.back(),
                      ),
                    )
                  ],
                );
              })),
        ),
      ),
    );
  }

  Container buildContent(BuildContext context, List<Text> children2) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
      width: MediaQuery.of(context).size.width *
          (isDesktop(context) ? 0.25 : 0.54),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children2,
      ),
    );
  }

  Container buildContainer(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.5, child: Divider());
  }
}

class LimitsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var desktop = isDesktop(context);
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 25, 0),
      child: Center(
        child: GestureDetector(
          onTap: () => Get.dialog(LimitsDialog()),
          child: kIsWeb
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(2, 2, 10, 2),
                  child: Icon(
                    FontAwesomeIcons.tags,
                    size: GFSize.SMALL * 0.7,
                  ),
                )
              : Icon(
                  FontAwesomeIcons.tags,
                  size: GFSize.SMALL * 0.7,
                ), //Image.asset('assets/images/limitsIcon.png'),
        ),
      ),
    );
  }
}
