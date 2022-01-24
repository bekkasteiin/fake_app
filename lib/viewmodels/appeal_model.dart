import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hse/core/model/BaseResult.dart';
import 'package:hse/core/model/appeals/appeals.dart';
import 'package:hse/core/model/appeals/appel_topic.dart';
import 'package:hse/core/service/rest_services.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/pageviews/appeals/appeals_confirm_page.dart';
import 'package:hse/viewmodels/base_model.dart';

class AppealModel extends BaseModel {
  TabController controller;
  TextEditingController commController = TextEditingController();
  List<Appeals> _appeals = [];
  Appeals appeal = Appeals();
  bool update = false;
  String selected = '';
  String step = '/description';
  int index;
  List<Duo> listTypes = [
    Duo(S().complaint, 'complaint'),
    Duo(S().idea, 'suggestion'),
  ];

  Future<List<Appeals>> get appeals async {
    _appeals = await RestServices.getAppeals();
    return _appeals;
  }

  String get header {
    switch (step) {
      case '/description':
        return S().appealText;
      case '/type':
        return S().appealType;
      case '/topic':
        return S().appealTopic;
      case '/info':
        return S().appeal;
      default:
        return S().comment;
    }
  }

  next() async {
    if (step == '/description') {
      step = '/type';
      index = 2;
      setBusy(false);
      return;
    }
    if (step == '/type') {
      step = '/topic';
      index = 3;
      setBusy(false);
      return;
    }
    if (step == '/topic') {
      step = '/info';
      index = 4;
      setBusy(false);
      return;
    }
    if (step == '/info') {
      var result = await sendOrder();
      if (!result.success) {
        Get.snackbar(S().attention, result.errorDescription);
      } else {
        await Get.dialog(AppealsConfirmationView());
        Get.snackbar(S().attention, S().successfully);
        controller.animateTo(1);
        appeal = emptyAppeal();
        step = '/description';
        index = 1;
        setBusy(false);
        return;
      }
    }
  }

  back() {
    if (step == '/description') {
      appeal = emptyAppeal();
      setBusy(false);
      return;
    }
    if (step == '/type') {
      step = '/description';
      index = 1;
      setBusy(false);
      return;
    }
    if (step == '/topic') {
      step = '/type';
      index = 2;
      setBusy(false);
      return;
    }
    if (step == '/info') {
      step = '/topic';
      index = 3;
      setBusy(false);
      return;
    }
  }

  Appeals emptyAppeal() => Appeals();

  Future<BaseResult> sendOrder() async {
    if (appeal.description == null || appeal.description.isEmpty) {
      return BaseResult(success: false, errorDescription: S().appealText);
    }
    if (appeal.topic == null) {
      return BaseResult(success: false, errorDescription: S().appealTopic);
    }
    if (appeal.type == null) {
      return BaseResult(success: false, errorDescription: S().appealType);
    }
    appeal.appealLocalDateTime ??= DateTime.now();
    var result = await RestServices.setAppeals(appeal);
    return result;
  }

  Future<List<AppealTopic>> getTopics() async {
    var topics = await RestServices.getAppealsTopic();
    return topics;
  }
}

class Duo {
  String carOrder;
  String s;

  Duo(this.carOrder, this.s);
}
