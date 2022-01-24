import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart' as web;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getflutter/getflutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hse/core/model/car_order/CarOrder.dart';
import 'package:hse/core/model/util_models.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/core/service/rest_services.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/pageviews/car_order/address_list/AddressListPage.dart';
import 'package:hse/viewmodels/car_model.dart';
import 'package:hse/viewmodels/user_info.dart';
import 'package:provider/provider.dart';

import '../../core/utils/UI_Helpers.dart';
import 'car_order_info.dart';

class OrderStepper extends StatelessWidget {
  OrderStepper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<CarModel>(context);
    var desktop = isDesktop(context);
    if (!model.fromNode.hasListeners) {
      model.fromNode.addListener(() {
        if (model.fromNode.hasFocus) {
          model.toFrom = true;
        }
      });
    }
    if (!model.toNode.hasListeners) {
      model.toNode.addListener(() {
        if (model.toNode.hasFocus) {
          model.toFrom = false;
        }
      });
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        desktop
            ? SizedBox()
            : Padding(
                padding: const EdgeInsets.all(10.0),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 15.0,
                  ),
                  child: Text(
                    model.header,
                    style: generalFontStyle.copyWith(
                        fontSize: defaultFontSize + 8),
                  ),
                ),
              ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: CustomStepper(
            functions: [
              () {
                model.step = '/address';
                model.index = 1;
                model.setBusy(false);
              },
              () {
                model.step = '/dateTime';
                model.index = 2;
                model.setBusy(false);
              },
              () {
                model.step = '/passagers';
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
        ),
        !desktop
            ? SizedBox()
            : Padding(
                padding: const EdgeInsets.all(10.0),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 15.0,
                  ),
                  child: Text(
                    model.header,
                    style: generalFontStyle.copyWith(
                        fontSize: defaultFontSize + 8),
                  ),
                ),
              ),
        desktop
            ? SizedBox()
            : (model.step != '/address' || kIsWeb
                ? SizedBox()
                : buildEmergencyButton(context, model)),
      ],
    );
  }

  Container buildEmergencyButton(BuildContext context, CarModel model) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
      width: MediaQuery.of(context).size.width * 0.75,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Text(
              S().emergencyOrder,
              style: generalFontStyle.copyWith(
                  color: appBlueColor,
                  fontSize: defaultFontSize,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50.0, 0.0, 0.0, 10.0),
            child: Transform.scale(
              scale: 1.3,
              child: GFToggle(
                type: GFToggleType.ios,
                onChanged: (val) {
                  model.order.isEmergency = val;
                  model.setBusy(false);
                },
                enabledTrackColor: appBlueColor,
                value:
                    model.order.isEmergency != null && model.order.isEmergency,
              ),
            ),
          )
        ],
      ),
    );
  }
}

//выбор типа автомашины RML**
class ShowSelectedPlaces extends StatelessWidget {
  const ShowSelectedPlaces({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var counter = Provider.of<CarModel>(context);
    var borderRadius = Radius.circular(5);
    return Container(
      //height: MediaQuery.of(context).size.height * 0.45,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black,
              offset: Offset(1.0, 4.0),
              blurRadius: 15.0,
            ),
          ],
          color: Colors.white,
          borderRadius:
              BorderRadius.only(topLeft: borderRadius, topRight: borderRadius)),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Center(
              child: Container(
                width: 50,
                child: Divider(
                  height: 10,
                  thickness: 5,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 55.0, 0.0),
            child: PlacePicker(
              isEnabled: false,
              placeHolder: counter.order.fromAddress ?? '',
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 55.0, 10.0),
            child: PlacePicker(
              isEnabled: false,
              placeHolder: counter.order.toAddress ?? '',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: OrderTypeSelect(),
          )
        ],
      ),
    );
  }
}

//выбор типа поездки
class OrderTypeSelect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var counter = Provider.of<CarModel>(context);
    var order = counter.order;
    var typeOfCar = order.typeOfCar;
    var buttonStyle = generalFontStyle.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: defaultFontSize,
        color: appBlueColor);
    var buttonStyle2 = generalFontStyle.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: defaultFontSize,
        color: appWhiteColor);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
            child: Container(
              width: GFSize.MEDIUM * 3,
              height: GFSize.MEDIUM * 1.2,
              child: GFButton(
                shape: GFButtonShape.pills,
                color: appBlueColor,
                type: typeOfCar == 'ECONOMY' || typeOfCar == null
                    ? GFButtonType.solid
                    : GFButtonType.outline,
                onPressed: () {
                  counter.order.typeOfCar = 'ECONOMY';
                  counter.setBusy(false);
                },
                text: S().ECONOMY,
                textStyle: typeOfCar == 'ECONOMY' || typeOfCar == null
                    ? buttonStyle2
                    : buttonStyle,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: Container(
              width: GFSize.MEDIUM * 3,
              height: GFSize.MEDIUM * 1.2,
              child: GFButton(
                shape: GFButtonShape.pills,
                color: appBlueColor,
                type: typeOfCar == 'COMFORT'
                    ? GFButtonType.solid
                    : GFButtonType.outline,
                onPressed: () {
                  counter.order.typeOfCar = 'COMFORT';
                  counter.setBusy(false);
                },
                text: S().COMFORT,
                textStyle: typeOfCar == 'COMFORT' ? buttonStyle2 : buttonStyle,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: Container(
              width: GFSize.MEDIUM * 3,
              height: GFSize.MEDIUM * 1.2,
              child: GFButton(
                shape: GFButtonShape.pills,
                color: appBlueColor,
                type: typeOfCar == 'FREIGHT'
                    ? GFButtonType.solid
                    : GFButtonType.outline,
                onPressed: () {
                  counter.order.typeOfCar = 'FREIGHT';
                  counter.setBusy(false);
                },
                text: S().FREIGHT,
                textStyle: typeOfCar == 'FREIGHT' ? buttonStyle2 : buttonStyle,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(5, 0, 20, 0),
            child: Container(
              width: GFSize.MEDIUM * 3,
              height: GFSize.MEDIUM * 1.2,
              child: GFButton(
                shape: GFButtonShape.pills,
                color: appBlueColor,
                type: typeOfCar == 'VIP'
                    ? GFButtonType.solid
                    : GFButtonType.outline,
                onPressed: () {
                  counter.order.typeOfCar = 'VIP';
                  counter.setBusy(false);
                },
                text: 'VIP',
                textStyle: typeOfCar == 'VIP' ? buttonStyle2 : buttonStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OrderMap extends StatefulWidget {
  @override
  _OrderMapState createState() => _OrderMapState();
}

class _OrderMapState extends State<OrderMap> {
  final _key = GlobalKey<web.GoogleMapStateBase>();

  static final CameraPosition _initialCamera = CameraPosition(
    target: LatLng(43.22777040504407, 76.90411616116762),
    zoom: 16,
  );

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<CarModel>(context);
    var mapSize = MediaQuery.of(context).size; //GFSize.LARGE * 10;
    var icon = Icon(
      FontAwesomeIcons.search,
      color: appBlackColor,
      size: GFSize.SMALL * 0.7,
    );

    var textStyle = generalFontStyle.copyWith(
        color: appGreyColor, fontSize: defaultFontSize);

    //первый шаг
    return Container(
      //height: isDesktop(context) ? null : mapSize.height * 0.45,
      //width: isDesktop(context) ? null : mapSize.width * 1,
      child: Stack(
        children: [
          kIsWeb
              ? (model.step == '/address' &&
                      model.order?.fromAddress == null &&
                      model.order?.toAddress == null
                  ? buildWebGoogleMap()
                  : buildPlaces(model))
              : SizedBox(
                  height: isDesktop(context) ? null : mapSize.height * 0.512,
                  width: isDesktop(context) ? null : mapSize.width * 1,
                  child: GoogleMap(
                    myLocationEnabled: true,
                    zoomGesturesEnabled: true,
                    myLocationButtonEnabled: true,
                    mapType: MapType.normal,
                    initialCameraPosition: _initialCamera,
                  ),
                ),
          Positioned(
            bottom: MediaQuery.of(context).size.width * (1 - 0.85), //5,
            right: MediaQuery.of(context).size.width * 0.6,
            child: Row(
              children: <Widget>[
                buildToWhereButton(textStyle, icon, model),
                /* Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GFButton(
                      color: Colors.white,
                      elevation: 10,
                      text: '${S().fromWhere}?',
                      textStyle: textStyle,
                      icon: icon,
                      onPressed: () {},
                    ),
                  ),*/
              ],
            ),
          )
        ],
      ),
    );
  }

  web.GoogleMap buildWebGoogleMap() {
    return web.GoogleMap(
      key: _key,
      initialZoom: 12,
      initialPosition: web.GeoCoord(43.27750, 76.89583),
      // Los Angeles, CA
      mapType: web.MapType.roadmap,
      interactive: true,
      markers: {},
      webPreferences: web.WebMapPreferences(
        fullscreenControl: false,
        zoomControl: true,
      ),
    );
  }

  FutureProvider<bool> buildToWhereButton(
      TextStyle textStyle, Icon icon, CarModel model) {
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
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: GFSize.MEDIUM * 1.5,
              width: GFSize.MEDIUM * 3,
              child: GFButton(
                color: appWhiteColor,
                elevation: 10,
                text: '${S().toWhere}?',
                textStyle: textStyle,
                icon: icon,
                onPressed: !value
                    ? null
                    : () {
                        try {
                          model.fromController.text = model.order?.fromAddress;
                        } catch (e) {}
                        try {
                          model.toController.text = model.order?.toAddress;
                        } catch (e) {}
                        showDialog(
                            context: context,
                            builder: (context) => ChangeNotifierProvider.value(
                                  value: model,
                                  builder: (context, child) =>
                                      PlaceSelectDialog(),
                                ));
                      },
              ),
            ),
          );
        }));
  }

  Widget buildPlaces(CarModel counter) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: appWhiteColor,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: PlacePicker(
              isEnabled: false,
              placeHolder: counter.order.fromAddress ?? '',
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 25.0),
            child: PlacePicker(
              isEnabled: false,
              placeHolder: counter.order.toAddress ?? '',
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
            width: MediaQuery.of(context).size.width * 0.63,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    S().emergencyOrder,
                    style: generalFontStyle.copyWith(
                        color: appBlueColor,
                        fontSize: defaultFontSize,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50.0, 0.0, 0.0, 10.0),
                  child: Transform.scale(
                    scale: 1.3,
                    child: GFToggle(
                      type: GFToggleType.ios,
                      onChanged: (val) {
                        counter.order.isEmergency = val;
                        counter.setBusy(false);
                      },
                      enabledTrackColor: appBlueColor,
                      value: counter.order.isEmergency != null &&
                          counter.order.isEmergency,
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: OrderTypeSelect(),
          )
        ],
      ),
    );
  }
}

// выбор адресов Откуда. Куда RML ***
class PlaceSelectDialog extends StatelessWidget {
  PlaceSelectDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<CarModel>(context);
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => Get.back(),
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 45,
              ),
              Card(
                color: Theme.of(context).scaffoldBackgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                margin: EdgeInsets.only(top: 25, bottom: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Center(
                        child: Container(
                          width: 50,
                          child: Divider(
                            height: 10,
                            thickness: 5,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: appFiledBorderColor),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            PlacePicker(
                              textController: model.fromController,
                              focus: model.fromNode,
                              isFrom: true,
                            ),
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                width: isDesktop(context)
                                    ? size.width * 0.8
                                    : GFSize.LARGE * 8,
                                child: Divider(
                                  thickness: 1,
                                )),
                            PlacePicker(
                              textController: model.toController,
                              focus: model.toNode,
                              isFrom: false,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: size.height * 0.45,
                      margin: EdgeInsets.only(top: 10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            //height: 30,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            alignment: Alignment.topLeft,
                            child: Text(
                              S.of(context).MyAddresses,
                              style: namingStyle,
                            ),
                          ),
                          Container(
                            //height: 300,
                            child: FutureBuilder(
                                future: Hive.openBox(
                                  'addressesBox',
                                ),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    if (snapshot.hasError) {
                                      return Text(snapshot.error.toString(),
                                          style: captionStyle);
                                    } else {
                                      return ContactPage(
                                        isBody: true,
                                      );
                                    }
                                  } else {
                                    return SizedBox();
                                  }
                                }),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        height: size.height * 0.2,
                        child: buildButton(context, model.order.fromAddress))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//кнопки навигации
Widget buildButton(context, String addressValue) {
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
          leftText: S.current.select,
          rightText: S.current.back,
          functionLeft: () => Get.back(),
          functionRight: () => Get.back(),
        );
      }));
}

//подтверждение маршрута
class PlacePicker extends StatelessWidget {
  final TextEditingController textController;
  final FocusNode focus;
  final bool isFrom;
  final bool isEnabled;
  final String placeHolder;

  const PlacePicker(
      {Key key,
      this.textController,
      this.isFrom = false,
      this.isEnabled = true,
      this.placeHolder,
      this.focus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<CarModel>(context);
    var desktop = isDesktop(context);

    return Container(
      //height: MediaQuery.of(context).size.height * 0.125,
      padding: const EdgeInsets.fromLTRB(15, 10, 0, 10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: isEnabled
                ? null
                : () {
                    showDialog(
                        context: context,
                        builder: (context) => ChangeNotifierProvider.value(
                              value: model,
                              builder: (context, child) => PlaceSelectDialog(),
                            ));
                  },
            child: Icon(isFrom ? Icons.my_location : Icons.search,
                size: desktop ? GFSize.LARGE * 1.3 : GFSize.SMALL * 1,
                color: appBlueColor),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Container(
                width: desktop
                    ? MediaQuery.of(context).size.width * 0.6
                    : GFSize.LARGE * 5.9,
                child: TextFormField(
                  controller: textController,
                  //autovalidate: true,
                  focusNode: focus,
                  enabled: isEnabled,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText:
                          placeHolder ?? (isFrom ? S().fromWhere : S().toWhere),
                      hintStyle: captionStyle),
                  onChanged: (val) {
                    if (isFrom) {
                      model.order.fromAddress = val;
                      model.setBusy(false);
                    } else {
                      model.order.toAddress = val;
                      model.setBusy(false);
                    }
                  },
                  /*   validator: (val) {
                    var isFromCheck = (isFrom
                        ? (val == model.order.toAddress)
                        : (val == model.order.fromAddress));
                    return (val.isEmpty
                        ? (isFrom ? S().fromAddress : S().toAddress)
                        : (isFromCheck ? S().different_addresses : null));
                  },*/
                ),
              ),
            ),
          ),
          isEnabled
              ? Expanded(
                  child: Padding(
                    padding: desktop
                        ? EdgeInsets.fromLTRB(50, 0, 0, 0)
                        : EdgeInsets.fromLTRB(25, 0, 0, 0),
                    child: GFButton(
                      type: desktop
                          ? GFButtonType.solid
                          : GFButtonType.transparent,
                      icon: Icon(
                        FontAwesomeIcons.mapMarkerAlt,
                        size: GFSize.SMALL * 1,
                        color: appBlueColor,
                      ),
                      text: '',
                      color: desktop ? appBlueColor : appGreyColor,
                      onPressed: () =>
                          model.pickFromMap(textController, isFrom: isFrom),
                    ),
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}

//выбор даты и времени
class OrderDateTime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var model = Provider.of<CarModel>(context);
    var currentDate = DateTime.now();
    return Container(
      constraints: BoxConstraints(
          maxHeight: GFSize.LARGE * 5, minHeight: GFSize.LARGE * 3),
      child: CupertinoDatePicker(
        initialDateTime: model.order.isEmergency == true
            ? DateTime.now()
            : DateTime(
                currentDate.year, currentDate.month, currentDate.day + 1),
        onDateTimeChanged: (DateTime value) {
          model.order.requestedDate = value;
          model.setBusy(false);
        },
        use24hFormat: true,
        minimumDate: currentDate,
        maximumDate: currentDate.add(Duration(days: 3)),
        mode: CupertinoDatePickerMode.dateAndTime,
      ),
    );
  }
}

//выбор пассажиров
class OrderPassagers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mapSize = GFSize.LARGE * 9.5;
    var model = Provider.of<CarModel>(context);
    return Container(
        width: isDesktop(context) ? 760.0 : mapSize,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: PassegersCounter(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
              child: Container(
                height: GFSize.MEDIUM * 2.8,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: appFiledBorderColor),
                  color: appYellowColor,
                ),
                child: ListTile(
                  leading: Container(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Icon(
                      FontAwesomeIcons.radiationAlt,
                      color: appRedColor,
                      size: GFSize.SMALL,
                    ),
                  ),
                  title: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      S().passCountLess4,
                      style: generalFontStyle.copyWith(
                          fontSize: defaultFontSize, color: appBlackColor),
                      maxLines: 2,
                    ),
                  ),
                ),

                // child: Row(
                //   children: <Widget>[
                //     Container(
                //       child: Image.asset(
                //         'assets/images/attentionIcon.png',
                //         color: appBlueColor,
                //       ),
                //       margin: EdgeInsets.only(left: 10, right: 10),
                //     ),
                //     Container(
                //       margin: EdgeInsets.fromLTRB(10, 25, 8, 0),
                //       height: 70,
                //       width: MediaQuery.of(context).size.width * 0.65,
                //       child: Column(
                //         children: [
                //           Expanded(
                //             child: Text(
                //               S().passCountLess4,
                //               style: generalFontStyle.copyWith(fontSize: defaultFontSize, color: appGreyColor),
                //             ),
                //           ),
                //         ],
                //       ),
                //     )
                //   ],
                // ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                height: GFSize.MEDIUM * 2.8,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: appFiledBorderColor),
                ),
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: TextField(
                    style: generalFontStyle.copyWith(
                        fontSize: defaultFontSize + 2, color: appBlackColor),
                    maxLines: 6,
                    onChanged: (val) {
                      model.order.comment = val;
                      model.setBusy(false);
                    },
                    decoration: InputDecoration.collapsed(
                        hintText: S().comment,
                        hintStyle: generalFontStyle.copyWith(
                            fontSize: defaultFontSize + 2,
                            color: appGreyColor)),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}

class PassegersCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var model = Provider.of<CarModel>(context);
    var boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.white,
      border: Border.all(width: 1.0, color: appFiledBorderColor),
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
          child: GestureDetector(
            onTap: () {
              if (int.parse(model.order.count ?? '0') == 0) return;
              var count = int.parse(model.order.count ?? '0') - 1;
              model.order.count = count.toString();
              model.setBusy(false);
            },
            child: Container(
              width: 45.0,
              height: 45.0,
              decoration: boxDecoration,
              child: Center(
                child: Text(
                  '-',
                  style: generalFontStyle.copyWith(
                      fontSize: defaultFontSize + 5, color: appBlackColor),
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
              model.order.count ?? '1',
              style: generalFontStyle.copyWith(
                  color: appBlueColor, fontSize: defaultFontSize + 5),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Padding(
            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: GestureDetector(
              onTap: () {
                if (int.parse(model.order.count ?? '0') == 4) return;
                var count = int.parse(model.order.count ?? '0') + 1;
                model.order.count = count.toString();
                model.setBusy(false);
              },
              child: Container(
                width: 45.0,
                height: 45.0,
                decoration: boxDecoration,
                child: Center(
                  child: Text(
                    '+',
                    style: generalFontStyle.copyWith(
                        fontSize: defaultFontSize + 5, color: appBlackColor),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ))
      ],
    );
  }
}

class OrderInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var model = Provider.of<CarModel>(context);
    return Container(
      margin: EdgeInsets.fromLTRB(10, 5, 10, 40),
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 15, 15, 0),
              child: Container(
                alignment: Alignment.topLeft,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  '${S().fromWhere}:',
                  style: captionStyle,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 5, 15, 0),
              child: Container(
                alignment: Alignment.topLeft,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  model.order.fromAddress ?? '',
                  style: namingStyle,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 15, 15, 0),
              child: Container(
                alignment: Alignment.topLeft,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  '${S().toWhere}:',
                  style: captionStyle,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 5, 15, 0),
              child: Container(
                alignment: Alignment.topLeft,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  model.order.toAddress ?? '',
                  style: namingStyle,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 15, 15, 0),
              child: Container(
                alignment: Alignment.topLeft,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  '${S().dateAndTime}:',
                  style: captionStyle,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 5, 15, 0),
              child: Container(
                alignment: Alignment.topLeft,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  formatDate(model.order.requestedDate),
                  style: namingStyle,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 15, 15, 0),
              child: Container(
                alignment: Alignment.topLeft,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  '${S().count}:',
                  style: captionStyle,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 5, 15, 0),
              child: Container(
                alignment: Alignment.topLeft,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  model.order.count ?? '1',
                  style: namingStyle,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 15, 15, 0),
              child: Container(
                alignment: Alignment.topLeft,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  '${S().comment}:',
                  style: captionStyle,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 5, 15, 0),
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 0, 25, 0),
                padding: EdgeInsets.fromLTRB(5, 3, 25, 25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: appFiledBorderColor),
                ),
                alignment: Alignment.topLeft,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  model.order.comment ?? '-',
                  style: namingStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// История Заказ на авто
class OrderHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<CarModel>(context);
    final userInfo = Provider.of<UserInfoModel>(context);
    return FutureProvider<List<CarOrder>>(
        create: (BuildContext context) => counter.history,
        initialData: null,
        child: Consumer<List<CarOrder>>(builder: (context, model, _) {
          if (model == null) {
            return GFLoader(
              type: GFLoaderType.ios,
            );
          }
          return Container(
            child: ListView(
              children: [
                ...model
                    .map((e) => GestureDetector(
                          onTap: () {
                            counter.orderToShow = e;
                            counter.setBusy(false);
                            Get.to(ChangeNotifierProvider.value(
                              value: counter,
                              builder: (context, child) => CarOrderInfo(),
                            ));
                          },
                          child: Stack(
                            children: <Widget>[
                              isDesktop(context)
                                  ? buildBox(e,
                                      userInfo) //buildDesktopBox(e, userInfo)
                                  : buildBox(e, userInfo),
                              /*  Positioned(
                                child: buildCap(e),
                                right: 10,
                                top: 13,
                              ),*/
                            ],
                          ),
                        ))
                    .toList()
              ],
            ),
          );
        }));
  }

  Widget buildBox(CarOrder e, UserInfoModel userInfo) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10.0, 10.0, 0.0),
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(color: appBlueColor, width: 0.2),
      )),
      child: Container(
        margin: EdgeInsets.only(top: 0, bottom: 5),
        child: ListTile(
          leading: e.status == 'UNAPPROVED' || e.status == 'CANCELED'
              ? Icon(
                  FontAwesomeIcons.ban,
                  color: appRedColor,
                  size: GFSize.LARGE * 0.85,
                )
              : e.status == 'APPROVED' || e.status == 'CLOSED'
                  ? Icon(
                      FontAwesomeIcons.checkCircle,
                      color: appGreenColor,
                      size: GFSize.LARGE * 0.85,
                    )
                  : e.status == 'ON_DISTRIBUTION'
                      ? Icon(
                          FontAwesomeIcons.car,
                          color: appGreyColor,
                          size: GFSize.LARGE * 0.85,
                        )
                      : e.status == 'EXPECTATION'
                          ? Icon(
                              FontAwesomeIcons.bolt,
                              color: appYellowColor,
                              size: GFSize.LARGE * 0.85,
                            )
                          : e.status == 'IS_NEW'
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
                  '${formatDate(e.requestedDate)}',
                  style: namingStyle,
                ),
                Text(
                  //userInfo.formatCash(e.cost) ?? '',
                  userInfo.formatCash(e.cost).isEmpty
                      ? getCodeLang(e.status)
                      : userInfo.formatCash(e.cost),
                  style: userInfo.formatCash(e.cost).isEmpty
                      ? captionStyle
                      : generalFontStyle.copyWith(
                          fontSize: defaultFontSize + 2, color: appBlackColor),
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
                'Откуда: ' + '${e.fromAddress}' ?? '',
                style: captionStyle,
                maxLines: 1,
              ),
              SizedBox(
                height: 2.0,
              ),
              Text('Куда: ' + '${e.toAddress}' ?? '',
                  style: captionStyle, maxLines: 1),
            ],
          ),
        ),
      ),
    );
  }

  Color disabledColor(CarOrder e) {
    return e.status == 'COMPLETED' ||
            e.status == 'CANCELED' ||
            e.status == 'UNAPPROVED' ||
            e.status == 'CLOSED'
        ? Colors.grey
        : Colors.black;
  }

  buildCap(CarOrder e) {
    return Container(
      width: GFSize.LARGE * 2.8,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: GFButton(
        onPressed: () {},
        color: getStatusColor(e.status),
        text: getCodeLang(e.status),
        //   textStyle: generalFontStyle.copyWith(fontSize: 14),
      ),
    );
  }

  buildDesktopBox(CarOrder e, UserInfoModel userInfo) {
    return Container(
        margin: EdgeInsets.fromLTRB(25, 35.0, 25.0, 0.0),
        padding: const EdgeInsets.only(top: 30.0, bottom: 30),
        decoration: BoxDecoration(
            border: Border.all(
                color: disabledColor(e) == Colors.black
                    ? appBlueColor
                    : Colors.grey),
            borderRadius: BorderRadius.circular(5)),
        child: Container(
            margin: EdgeInsets.only(top: 25, bottom: 10),
            child: Row(children: [
              Padding(
                padding: const EdgeInsets.only(left: 250.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  width: 400,
                  decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(
                    width: 1,
                    color: appGreyColor,
                  ))),
                  child: Text(
                    formatDate(e.requestedDate),
                    style: generalFontStyle.copyWith(
                        fontSize: 37,
                        fontWeight: FontWeight.w500,
                        color: disabledColor(e) == Colors.black
                            ? appBlueColor
                            : Colors.grey),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.clock,
                          color: disabledColor(e) == Colors.black
                              ? appOrangeColor
                              : appGreyColor,
                          size: 21,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          formatHour(e.requestedDate),
                          style: generalFontStyle.copyWith(
                              color: disabledColor(e) == Colors.black
                                  ? appBlackColor
                                  : Colors.grey,
                              fontSize: defaultFontSize),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.calendar,
                          color: disabledColor(e) == Colors.black
                              ? appOrangeColor
                              : appGreyColor,
                          size: 21,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          e.toAddress,
                          style: generalFontStyle.copyWith(
                              color: disabledColor(e) == Colors.black
                                  ? appBlackColor
                                  : Colors.grey,
                              fontSize: defaultFontSize),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 500,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 100.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      userInfo.formatCash(e.cost) ?? '0000',
                      style: generalFontStyle.copyWith(
                          color: disabledColor(e),
                          fontSize: defaultFontSize + 8,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ]),
              ),
            ])));
  }
}

Widget buildEmojiButton({borderRadius, icon, function, color}) {
  return ButtonTheme(
    shape: RoundedRectangleBorder(
      borderRadius: borderRadius,
    ),
    child: MaterialButton(
      elevation: 0,
      minWidth: GFSize.LARGE * 1.9,
      height: GFSize.LARGE * 1.1,
      disabledColor: color,
      color: color,
      child: Icon(
        icon,
        color: function == null ? Colors.white : Colors.white,
        size: GFSize.SMALL / 1.2,
      ),
      onPressed: function,
    ),
  );
}

class MyAddressesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<CarModel>(context);
    return FutureProvider<List<CarOrder>>(
        create: (BuildContext context) => counter.history,
        initialData: null,
        child: Consumer<List<CarOrder>>(builder: (context, model, _) {
          if (model == null) {
            return GFLoader(
              type: GFLoaderType.ios,
            );
          }
          return Container(
            child: AdrList(),
          );
        }));
  }
}
