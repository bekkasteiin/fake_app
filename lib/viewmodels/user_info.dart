import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hse/core/model/BaseResult.dart';
import 'package:hse/core/model/assignment/Assignment.dart';
import 'package:hse/core/model/assignment/Organization.dart';
import 'package:hse/core/model/car_order/CarAddress.dart';
import 'package:hse/core/model/utils/UserInfo.dart' as uinf;
import 'package:hse/core/service/hive_service.dart';
import 'package:hse/core/service/rest_services.dart';
import 'package:hse/core/utils/box_name_store.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/pageviews/loading_page.dart';
import 'package:hse/viewmodels/base_model.dart';
import 'package:hse/viewmodels/bpm_models/message_model.dart';
import 'package:hse/viewmodels/bpm_models/risks_model.dart';
import 'package:intl/intl.dart' show DateFormat, NumberFormat;

import 'bpm_models/event_model.dart';
import 'bpm_models/bsa_model.dart';
import 'bpm_models/ticket_model.dart';

class UserInfoModel extends BaseModel {
  String route = '/';
  uinf.UserInfo userInfo;
  Assignment _assignment;
  bool auth;
  final DateFormat _dateFormat = DateFormat('dd.MM.yyyy HH:mm');
  final NumberFormat _cashFormat =
      NumberFormat.currency(locale: 'kk', symbol: "⍑", decimalDigits: 1);
  Locale locale = Locale('ru');
  String localeCode = 'ru';
  bool emailSaved = false;
  TextEditingController emailController;
  Organization organization;

  Future get organizations async {
    var list =
        await HiveService.getOfflineListBox(BoxNameStore.getOrganization);
    if (list.isNotEmpty) {
      organization = list.cast<Organization>().first;
      return organization;
    }

    var response = await RestServices.getOrganization(false);
    organization = response.first;

    return organization;
  }

  Assignment get assign => _assignment;

  Future<Assignment> assignment(
      [MessageModel model,
      BsaModel bsaModel,
      RisksModel risksModel,
        EventModel eventModel,
        TicketModel ticketModel]) async {
    try {
      if (_assignment == null && auth == null) {
        return null;
      }

      _assignment ??= await RestServices.getAssignment();
      if (bsaModel != null) {
        print('2');
        await bsaModel.getDictionaries();
      }
      if (risksModel != null) {
        print('3');
        await risksModel.getDictionaries();
      }
      if (model != null) {
        print('4');
        await model.getDictionaries();
      }
      if (eventModel != null) {
        print('7');
        await eventModel.getDictionaries();
      }
      if (ticketModel != null) {
        print('5');
        // await ticketModel.saveTicketHistories();
        setBusy(true, true);
        await organizations;
        setBusy(false, false);
      }
      print('6');
      final contactsBox = await HiveService.getBox('addressesBox');
      if(contactsBox.values.isEmpty) {
        var contact = CarAddress('Бегалиева 72/2', 0);
        var contact1  = CarAddress('Габдулина 177', 1);
        await contactsBox.add(contact);
        await contactsBox.add(contact1);
      }

      return _assignment;
    } catch (e) {
      print(e);
      return null;
    }
  }

  exit() async {
    _assignment = null;
    userInfo = null;
    organization = null;
    auth = false;
    var box = await HiveService.getBox('settings');
    await HiveService.getClearBox(BoxNameStore.getOrganization);
    await box.clear();
    await Hive.deleteFromDisk();
    await Get.offNamedUntil('/hello', ModalRoute.withName('/'));
  }

  void goTo(String tag) {
    route = tag;
    notifyListeners();
  }

  changeLanguage(String lang) async {
    Box settings = await HiveService.getBox('settings');
    await settings.put('locale', lang);
    locale = Locale(lang);
    localeCode = lang;
    await S.load(locale);
    setBusy(false);
  }

  String formatDate(DateTime date) => _dateFormat.format(date);

  String formatCash(var data) {
    if (!(data is num)) return '';
    if (data == null) return '';
    return _cashFormat.format(data);
  }

  Future<TextEditingController> getPreference() async {
    emailSaved = false;
    var day = TextEditingController(text: _assignment.person.email ?? '');
    setBusy(false);
    return day;
  }

  void setPreference(val) async {
    var date = isValueCorrect(val);
    if (date != null) {
      return;
    }
    var res = await RestServices.changeEmail(val);
    if (res.success) {
      _assignment = await RestServices.getAssignment();
      emailSaved = _assignment.person.email == val;
    } else {
      emailSaved = false;
    }
    setBusy(false);
  }

  String isValueCorrect(String val) {
    var emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(val);
    return !emailValid ? '' : null;
  }

  Future<void> changePassword(String old, String first, String second) async {
    Get.dialog(LoadingPage());
    old = old.trim();
    first = first.trim();
    second = second.trim();
    if (first != second) {
      Get.back();
      Get.snackbar(S().error, S().mustBeSame);
      return;
    }
    BaseResult res = await RestServices.changePassword(
        currentPassword: old, newPassword: first, passwordConfirmation: second);
    Get.back();
    if (res.success) {
      await Get.offNamedUntil('/login', ModalRoute.withName('/'));
    } else {
      Get.snackbar(S().error, res.errorDescription);
    }
  }

  validatePass(String first, String second) {
    return first != second ? S().mustBeSame : null;
  }
}
