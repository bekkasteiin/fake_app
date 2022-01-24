import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:getflutter/types/gf_button_type.dart';
import 'package:hive/hive.dart';
import 'package:hse/core/model/BaseResult.dart';
import 'package:hse/core/model/auth/register_request.dart';
import 'package:hse/core/model/utils/UserInfo.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/core/service/hive_service.dart';
import 'package:hse/core/service/rest_services.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:hse/pageviews/loading_page.dart';
import 'package:hse/viewmodels/base_model.dart';
import 'package:kinfolk/kinfolk.dart';
import 'package:mobile_number/sim_card.dart';

class Login extends BaseModel {
  String login;
  String password;
  bool isAgree = false;
  bool pinInCorrect = false;
  String pin1 = "";
  String pin2 = "";
  bool pinRepeat = false;
  String pinVertify;
  String url;
  String iin;
  String email;
  bool obscure = true;
  var registrationMessage = '';
  var success = false;

  Future<String> get pin async {
    Box box = await HiveService.getBox('settings');
    var info = userInfoFromJson(box.get('info'));
    await box.close();
    pinVertify = info.pin;
    return pinVertify;
  }

  firebase({needSave = true}) async {
    if (needSave) {
      var info = UserInfo();
      info.login = login;
      info.password = password;

      Box settings = await HiveService.getBox("settings");
      await settings.put('info', userInfoToJson(info));
      await settings.close();
    }
    if (Hive.isBoxOpen("settings")) {
      Box settings = await HiveService.getBox("settings");
      await settings.close();
    }

    // var res = await RestServices.tryToRegister();

    // if (!res) {
    //   return;
    // }

    // BaseResult tokenSend =
    //     await RestServices.sendToken(await FirebaseMessaging().getToken());
  }

  void singIn({bool fromPin = false}) async {
    https: //dev.uco.kz/krj
    Get.dialog(LoadingPage());
    var conn = await RestServices.checkConnection();
    var defaultFontSize = 16.0;
    if (!conn && fromPin) {
      await Get.offNamedUntil('/home', ModalRoute.withName('/'));
      return;
    }
    // var client = await Kinfolk().getToken(login.trim(), password.trim());
    // if (client is String) {
    //   Get.back();
    //   var text;
    //   switch (client) {
    //     case 'ACCESS_ERROR':
    //       text = S().incorrectSignIn;
    //       break;
    //     case 'CONNECTION_TIME_OUT':
    //       text = S().timeOut;
    //       break;
    //     default:
    //       text = client;
    //   }
    //   await Get.defaultDialog(
    //     title: S().attention,
    //     middleText: text,
    //   );
    // } else {
      if (kIsWeb) {
        await Get.offNamedUntil('/home', ModalRoute.withName('/'));
        return;
      }
      if (fromPin) {
        // firebase(needSave: false);
        Get.offNamedUntil('/home', ModalRoute.withName('/'));
      } else {
        await Get.dialog(AlertDialog(
          title: Text(S().pinCreate),
          content: Text(S().wantPin),
          actions: [
            GFButton(
              size: 52,
              text: S().no,
              textStyle: generalFontStyle.copyWith(
                  fontSize: defaultFontSize + 2,
                  fontWeight: FontWeight.bold,
                  color: appGreenColor),
              color: appGreenColor,
              type: GFButtonType.outline,
              onPressed: () =>
                  Get.offNamedUntil('/home', ModalRoute.withName('/')),
            ),
            GFButton(
              size: 52,
              text: S().yes,
              textStyle: generalFontStyle.copyWith(
                  fontSize: defaultFontSize + 2,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              color: appGreenColor,
              onPressed: () {
                firebase();
                Get.offNamed('/pin_create');
              },
            )
          ],
        ));
      }
    // }
  }

  void saveUrl() async {
    var settings = await Hive.openBox('settings');
    if (url == null) {
      Get.snackbar(S().attention, S().errorOnFilling);
      return;
    }
    await settings.put('url', url);
    Kinfolk().initializeBaseVariables(
        url == 'default' ? endpointUrl : url, endpointClient, endpointSecret);
    Get.back();
    Get.snackbar(S().initSettings, S().successfully);
  }

  void resetPassword() async {
    Get.dialog(LoadingPage());
    BaseResult result =
        await RestServices.resetPassword(login: login, upi: iin);
    Get.back();
    if (result.success) {
      Get.snackbar(S().successfully, S().resetEmailWasSend);
      Get.back();
    } else {
      await Get.dialog(AlertDialog(
        title: Text(S().attention),
        content: Text(result.errorDescription),
      ));
    }
  }

  void regFromSaved() async {
    var box = await HiveService.getBox('settings');
    var info = userInfoFromJson(box.get('info'));
    login = info.login;
    password = info.password;
    await singIn(fromPin: true);
    await box.close();
  }

  void setPin() async {
    var box = await HiveService.getBox('settings');
    var info = userInfoFromJson(box.get('info'));
    info.pin = pin1;
    await box.put('info', userInfoToJson(info));
    await box.put('authorized', true);
    await box.close();
  }

  Future<bool> register(List<SimCard> list) async {
    var request = RegisterRequest();
    var numberList = <PhoneNumber>[];
    for(var simCard in list){
      var number = PhoneNumber();
      number.phone = simCard.number;
      numberList.add(number);
    }
    request.phoneNumbers = numberList;
    var res = await RestServices.register(request: request);
    success = res?.success;
    if (res != null) {
      registrationMessage = res.message;
      if(success) {
        login = res.user;
        password = res.password;
      }
    }
    return success ?? false;
  }
}
