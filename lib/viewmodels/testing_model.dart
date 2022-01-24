import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hse/core/model/test/Test.dart';
import 'package:hse/core/service/rest_services.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/pageviews/loading_page.dart';
import 'package:hse/viewmodels/base_model.dart';

class TestingModel extends BaseModel {
  TabController controller;
  bool isButtonNeeded = false;
  List<Test> list;
  Test selectedTest;
  int testIndex = 0;
  bool isResult;
  final Map<int, dynamic> answersForCheck = {};

  Future<List<Test>> get tests async {
    list ??= await RestServices.getTests();
    return list;
  }

  void select(Test e) {
    selectedTest = e;
    isButtonNeeded = true;
    isResult = e.result != null;
    answersForCheck.clear();
    setBusy(false);
  }

  void openSelected() {}

  void currentIndex(int index) {
    isButtonNeeded = false;
    setBusy(false);
  }

  void next() {
    if (testIndex == selectedTest.answers.length - 1) {
      if (isResult) {
        testIndex = 0;
        setBusy(false);
        Get.back();
        return;
      }

      commitTest();
      return;
    }

    testIndex++;
    setBusy(false);
  }

  void back() {
    if (testIndex == 0) {
      return;
    }

    testIndex--;
    setBusy(false);
  }

  void commitTest() async {
    Get.back();
    Get.dialog(LoadingPage());
    selectedTest.endTime = DateTime.now();
    var result = await RestServices.setDailyTest(selectedTest);
    selectedTest = null;
    testIndex = 0;
    isButtonNeeded = false;
    list = await RestServices.getTests();
    Get.back();
    if (!(result == 'Ok')) {
      Get.snackbar(S().attention, S().serverError + ' ' + S().errorToAdmin);
    } else {
     // Get.dialog(TestingConfirmationView());
      Get.snackbar(S().attention, S().successfully);
    }
    setBusy(false);
    return;
  }

  void timerEnd() {
    testIndex = selectedTest.answers.length - 1;
    next();
  }
}
