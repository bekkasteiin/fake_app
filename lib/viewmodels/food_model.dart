import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:hse/core/model/BaseResult.dart';
import 'package:hse/core/model/course_eating/CourseEatingHistory.dart';
import 'package:hse/core/model/eating_menu/Complex.dart';
import 'package:hse/core/model/eating_menu/EatingMenus.dart';
import 'package:hse/core/model/eating_menu/Mealtime.dart';
import 'package:hse/core/model/eating_menu/Product.dart';
import 'package:hse/core/model/history_eating_order/HistoryEatingOrder.dart';
import 'package:hse/core/model/place/Place.dart';
import 'package:hse/core/service/rest_services.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/pageviews/food/food_confirmation_view.dart';
import 'package:hse/pageviews/food/food_widgets.dart';
import 'package:hse/pageviews/loading_page.dart';
import 'package:hse/viewmodels/base_model.dart';

class FoodModel extends BaseModel {
  int currentDay = DateTime.now().weekday - 1;
  var firstDate = DateTime.parse('2020-06-08');
  List<EatingMenus> menuToShow;
  List<EatingMenus> menuToSelect;
  List<Place> _places;
  List<Mealtime> mealtimeList;
  List<int> daysOfWeek = [0, 1, 2, 3, 4, 5, 6];
  String step = '/places';
  String dishStep = '/complex';
  String placeStep = '/delivery';
  int index;
  bool needUpdateMealtime = false;
  List<HistoryEatingOrder> _orderHistory;
  List<CourseEatingHistory> _factHistory;
  HistoryEatingOrder order = HistoryEatingOrder(
    eatingMenus: [],
    forceAccept: false,
    orderDateTime: DateTime.now(),
  );
  TabController controller;

  Future<List<HistoryEatingOrder>> get orderHistory async {
    _orderHistory ??= await RestServices.getOrderHistory();
    return _orderHistory;
  }

  Future<List<CourseEatingHistory>> get factHistory async {
    _factHistory ??= await RestServices.getHistoryCourseEating();
    return _factHistory;
  }

  Future<List<EatingMenus>> get menu async {
    menuToShow ??= await RestServices.getMenu();
    return menuToShow;
  }

  Future<List<EatingMenus>> get selectMenu async {
    if (order.mealtimeId == null) {
      return [];
    }
    menuToSelect = await RestServices.getMenu(
        locationId: order.location, mealtimeId: order.mealtimeId);
    return menuToSelect;
  }

  Future<List<Place>> get place async {
    _places ??= await RestServices.getPlaces();
    return _places;
  }

  Future<List<Mealtime>> get mealtime async {
    if (needUpdateMealtime) {
      mealtimeList =
          await RestServices.getMealtimes(locationId: order.location);
      needUpdateMealtime = false;
    }
    return mealtimeList;
  }

  void selectPlace(Place e) {
    order.locationName = e.name;
    order.locationGroupName = e.groupName;
    order.location = e.id;
    needUpdateMealtime = true;
    setBusy(false);
  }

  void selectMealtime(Mealtime e) {
    order.mealtimeId = e.id;
    setBusy(false);
  }

  String get header {
    if (step == '/places') {
      return S().chooseAPlaceOfFood;
    }
    if (step == '/time') {
      return S().chooseAFeedingTime;
    }
    if (step == '/dishes') {
      return S().chooseADish;
    }
    if (step == '/info') {
      return S().submitOrder;
    }
    return '';
  }

  next() async {
    if (step == '/places') {
      step = '/time';
      index = 2;
      setBusy(false);
      return;
    }
    if (step == '/time') {
      step = '/dishes';
      index = 3;
      setBusy(false);
      return;
    }
    if (step == '/dishes') {
      step = '/info';
      index = 4;
      setBusy(false);
      await Get.dialog(LimitsDialog());
      return;
    }
    if (step == '/info') {
      if (order.location == null || order.mealtimeId == null) {
        Get.snackbar(S.current.attention, S.current.fillInTheRequiredFields);
        return;
      }
      uploadOrder();
    }
  }

  back() {
    if (step == '/places') {
      setBusy(false);
      return;
    }
    if (step == '/time') {
      step = '/places';
      index = 1;
      setBusy(false);
      return;
    }
    if (step == '/dishes') {
      step = '/time';
      index = 2;
      setBusy(false);
      return;
    }
    if (step == '/info') {
      step = '/dishes';
      index = 3;
      setBusy(false);
      return;
    }
  }

  void substractProductFromOrder(Product product, EatingMenus singleMenu) {
    var where = getMenuByProduct(singleMenu);
    if (where?.products
            ?.where((element) => element?.id == product?.id)
            ?.isEmpty ??
        true) return;

    where?.products?.remove(product);

    setBusy(false);
  }

  EatingMenus getMenuByProduct(EatingMenus singleMenu) {
    try {
      return order?.eatingMenus
          ?.where((element) => element.id == singleMenu.id)
          ?.first;
    } catch (e) {
      return null;
    }
  }

  void addProductToOrder(Product product, EatingMenus singleMenu) {
    var menu = getMenuByProduct(singleMenu);
    if (menu == null) {
      menu = EatingMenus.fromMap(singleMenu.toMap());
      menu.products.clear();
      menu.complexes.clear();
      order.eatingMenus.add(menu);
    }
    getMenuByProduct(singleMenu).products.add(product);
    setBusy(false);
  }

  Future<BaseResult> sendOrder() async {
    if (order.mealtimeId == null) {
      return BaseResult(success: false, errorDescription: S().selectMealtime);
    }
    if (order.eatingMenus == null || order.eatingMenus.isEmpty == null) {
      return BaseResult(success: false, errorDescription: S().menuIsEmpty);
    }
    if (order.location == null) {
      return BaseResult(success: false, errorDescription: S().selectPlace);
    }
    if (order.eatingMenus.any((element) =>
        element.complexes.any((element) => element.amount == null))) {
      return BaseResult(success: false, errorDescription: S().serverError);
    }
    if (order.eatingMenus.any((element) =>
        element.products.any((element) => element.amount == null))) {
      return BaseResult(success: false, errorDescription: S().serverError);
    }
    order.orderDateTime ??= DateTime.now();
    var result = await RestServices.sendEatingOrder(order);
    return result;
  }

  substractComplexFromOrder(Complex complex, EatingMenus singleMenu) {
    var where = getMenuByProduct(singleMenu);
    if (where?.complexes
            ?.where((element) => element?.id == complex?.id)
            ?.isEmpty ??
        true) return;

    where?.complexes?.remove(complex);

    setBusy(false);
  }

  addComplexToOrder(Complex complex, EatingMenus singleMenu) {
    var menu = getMenuByProduct(singleMenu);
    if (menu == null) {
      menu = EatingMenus.fromMap(singleMenu.toMap());
      menu.products.clear();
      menu.complexes.clear();
      order.eatingMenus.add(menu);
    }
    getMenuByProduct(singleMenu).complexes.add(complex);
    setBusy(false);
  }

  setAssessment(double d, CourseEatingHistory e) async {
    Get.dialog(LoadingPage());
    var result = await RestServices.setCourseEatingAssessment(e.id, d);
    Get.back();
    if (!result.success) {
      Get.snackbar(S().attention, result.errorDescription);
      setBusy(false);
    } else {
      e.assessment = d;
      Get.snackbar(S().attention, S().successfully);
      setBusy(false);
      return;
    }
  }

  void uploadOrder() async {
    Get.dialog(LoadingPage());
    var result = await sendOrder();
    Get.back();
    var answer;
    try {
      answer = FoodAnswer.fromJson(result.errorDescription);
    } catch (e) {
      answer = null;
    }
    if (answer?.canForceAccept ?? false) {
      if (!answer.success) {
        await Get.defaultDialog(
          title: S().attention,
          middleText: answer?.information?.langValue1 ?? '',
          actions: [
            GFButton(
              onPressed: () {
                order.forceAccept = true;
                Get.back();
                uploadOrder();
              },
              text: S().yes,
            ),
            SizedBox(
              width: 10,
            ),
            GFButton(
              onPressed: () {
                order = HistoryEatingOrder(eatingMenus: [], forceAccept: false);
                step = '/places';
                index = 1;
                Get.back();
                setBusy(false);
              },
              text: S().no,
            ),
          ],
        );
      } else {}
      return;
    }
    if (!result.success && answer == null) {
      Get.snackbar(S().attention, result.errorDescription ?? S().serverError);
      return;
    }
    if (!result.success && answer != null) {
      Get.snackbar(
          S().attention, answer?.information?.langValue1 ?? S().serverError);
      return;
    }
    if (result.success) {
      order = HistoryEatingOrder(eatingMenus: [], forceAccept: false);
      step = '/places';
      index = 1;
      _orderHistory = await RestServices.getOrderHistory();
      setBusy(false);
      controller.animateTo(2);
      await Get.dialog(FoodConfirmationView());
      Get.snackbar(
          S().attention,
          (answer?.information?.langValue1 ?? '') +
              ' ${S().number}:${answer?.code ?? '12'}');
    }
  }
}
