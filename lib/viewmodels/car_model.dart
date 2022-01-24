import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hse/core/model/BaseResult.dart';
import 'package:hse/core/model/car_order/CarAddress.dart';
import 'package:hse/core/model/car_order/CarOrder.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/core/service/hive_service.dart';
import 'package:hse/core/service/map/GoogleMap.dart';
import 'package:hse/core/service/map/GoogleMapWeb.dart';
import 'package:hse/core/service/rest_services.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/pageviews/car_order/car_order_info.dart';
import 'package:hse/pageviews/loading_page.dart';

import 'base_model.dart';

class CarModel extends BaseModel {
  CarOrder order = CarOrder(
    count: '1',
    requestedDate: DateTime.now(),
    typeOfCar: 'ECONOMY',
  );
  CarOrder orderToShow;
  List<CarOrder> listOrders = [];
  String step = '/address';
  int index;
  TabController controller;
  TextEditingController fromController = TextEditingController();
  FocusNode fromNode = FocusNode();
  TextEditingController toController = TextEditingController();
  FocusNode toNode = FocusNode();
  bool toFrom = true;

  Future<List<CarOrder>> get history async {
    List _history = await RestServices.getCarOrders();
    if (listOrders == null || listOrders.isEmpty) {
      _history
          .forEach((element) => element.list.forEach((e) => listOrders.add(e)));
      listOrders.sort((a, b) => b.requestedDate.compareTo(a.requestedDate));
    }
    return listOrders;
  }

  String get header {
    if (step == '/address') {
      return S().selectRoad;
    }
    if (step == '/dateTime') {
      return S().selectDate;
    }
    if (step == '/passagers') {
      return S().passCount;
    }
    if (step == '/info') {
      return S().submitOrder;
    }
    return S().error;
  }

  void pickFromMap(var fromController, {bool isFrom = false}) async {
    var result = await Get.to(
        kIsWeb ? WebMapPicker(googleApiKey) : PlacePicker(googleApiKey));
    fromController.text = result.formattedAddress;
    if (isFrom) {
      order.fromAddress = result.formattedAddress;
    } else {
      order.toAddress = result.formattedAddress;
    }
    setBusy(false);
  }

  void next() async {
    if (step == '/address') {
      step = '/dateTime';
      index = 2;
      setBusy(false);
      return;
    }
    if (step == '/dateTime') {
      step = '/passagers';
      index = 3;
      setBusy(false);
      return;
    }
    if (step == '/passagers') {
      step = '/info';
      index = 4;
      setBusy(false);
      return;
    }
    if (step == '/info') {
      Get.dialog(LoadingPage());
      var result = await sendOrder();
      Get.back();
      if (!result.success) {
        Get.snackbar(S().attention, result.errorDescription);
      } else {
        Get.dialog(CarConfirm());
        Get.snackbar(S().attention, S().orderCompletedSuccessfully);
        controller.animateTo(1);
        order = CarOrder(count: '1');
        step = '/address';
        index = 1;
        setBusy(false);
        return;
      }
    }
  }

  void back() {
    if (step == '/address') {
      order = CarOrder();
      setBusy(false);
      return;
    }
    if (step == '/dateTime') {
      step = '/address';
      index = 1;
      setBusy(false);
      return;
    }
    if (step == '/passagers') {
      step = '/dateTime';
      index = 2;
      setBusy(false);
      return;
    }
    if (step == '/info') {
      step = '/passagers';
      index = 3;
      setBusy(false);
      return;
    }
  }

  Future<BaseResult> sendOrder() async {
    order.count ??= '1';
    if (order.requestedDate == null) {
      return BaseResult(success: false, errorDescription: S().selectDate);
    }
    if (order.toAddress == null || order.fromAddress == null) {
      return BaseResult(success: false, errorDescription: S().selectRoad);
    }
    order.createDate ??= DateTime.now();
    order.typeOfCar ??= 'ECONOMY';
    order.isEmergency ??= false;
    var result = await RestServices.sendNewRequest(order);
    return result;
  }

  void refuse() async {
    Get.dialog(LoadingPage());
    var result = await RestServices.cancelCarOrder(orderToShow);
    Get.back();
    if (!result.success) {
      Get.snackbar(S().attention, result.errorDescription);
    } else {
      Get.snackbar(S().attention, S().successfully);
      orderToShow.status = 'CANCELED';
      orderToShow.order = null;
      setBusy(false);
      return;
    }
  }

  void setAssessment(double d) async {
    Get.dialog(LoadingPage());
    var result =
        await RestServices.setTransportationOrderAssessment(orderToShow, d);
    Get.back();
    if (!result.success) {
      orderToShow.rating = d.toInt();
      Get.snackbar(S().attention, result.errorDescription);
      setBusy(false);
    } else {
      orderToShow.rating = d.toInt();
      Get.snackbar(S().attention, S().successfully);
      setBusy(false);
      return;
    }
  }

  Future<void> addContact(CarAddress contact) async {
    final contactsBox = await HiveService.getBox('addressesBox');
    await contactsBox.add(contact);
  }
}
