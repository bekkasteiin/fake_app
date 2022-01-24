import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/pageviews/login/pin/pin_widgets.dart';
import 'package:hse/viewmodels/login_model.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/UI_Helpers.dart';

class PinMobileCreate extends StatelessWidget {
  var defaultFontSize = 16.0;
  var errorTextStyle =
      generalFontStyle.copyWith(color: appRedColor, fontSize: 16.0);
  var keyTextStyle =
      generalFontStyle.copyWith(color: Colors.black, fontSize: 25.0);
  var codeTextStyle = generalFontStyle.copyWith(
      color: appGreyColor, fontSize: 25.0, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Consumer<Login>(builder: (context, model, _) {
      return Scaffold(
        body: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Expanded(child: Container()),
                    CodeView(
                      codeTextStyle: codeTextStyle,
                      code: (!model.pinRepeat ? model.pin1 : model.pin2),
                      obscurePin: false,
                      length: 4,
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            ),
            Text(
              model.pinRepeat ? S().repeatePin : S().enterPin,
              style: generalFontStyle.copyWith(
                  fontSize: 17, fontWeight: FontWeight.w300),
            ),
            model.pinInCorrect
                ? Text(
                    S().doesntMatchPin,
                    style: errorTextStyle,
                    textAlign: TextAlign.center,
                  )
                : SizedBox(),
            SizedBox(
              height: 45,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: CustomKeyboard(
                textStyle: keyTextStyle,
                onPressedKey: (key) {
                  var length =
                      (!model.pinRepeat ? model.pin1 : model.pin2).length;
                  if (length < 4) {
                    if (!model.pinRepeat) {
                      model.pin1 += key;
                      model.setBusy(false);
                    } else {
                      model.pin2 += key;
                      model.setBusy(false);
                    }
                  }
                  if (length == 3) {
                    if (model.pin1 == model.pin2) {
                      model.setPin();
                      Get.offNamedUntil('/home', ModalRoute.withName('/'));
                      return;
                    }
                    if (model.pin1 != model.pin2 && model.pinRepeat) {
                      model.pinRepeat = false;
                      model.pinInCorrect = true;
                      model.pin1 = '';
                      model.pin2 = '';
                      return;
                    }
                    model.pinRepeat = true;
                    model.setBusy(false);
                  }
                },
                onBackPressed: () {
                  var codeLength =
                      (!model.pinRepeat ? model.pin1 : model.pin2).length;
                  if (codeLength > 0) {
                    if (!model.pinRepeat) {
                      model.pin1 = model.pin1.substring(0, codeLength - 1);
                      model.setBusy(false);
                    } else {
                      model.pin2 = model.pin2.substring(0, codeLength - 1);
                      model.setBusy(false);
                    }
                  }
                },
              ),
            ),
          ]),
        ),
      );
    });
  }
}
