import 'package:flutter/material.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/viewmodels/login_model.dart';
import 'package:provider/provider.dart';

import 'pin_widgets.dart';

class PinMobileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<Login>(context);
    return FutureProvider<String>(
        create: (BuildContext context) => counter.pin,
        initialData: 'default',
        child: Consumer<Login>(builder: (context, model, _) {
          return Consumer<String>(builder: (context, pinModel, _) {
            return Scaffold(
              body: PinCode(
                backgroundColor: Colors.white,
                codeTextStyle: generalFontStyle.copyWith(
                    color: Colors.black12,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold),
                subTitle: Text(
                  S().enterPinTitle,
                  style: generalFontStyle.copyWith(fontSize: 18,),
                  textAlign: TextAlign.center,
                ),
                error: model.pinInCorrect ? S().incorrectPin : '',
                codeLength: 4,
                obscurePin: true,
                correctPin: pinModel,
                onCodeSuccess: (code) async {
                  await model.regFromSaved();
                },
                onCodeFail: (code) {
                  model.pinInCorrect = true;
                  model.setBusy(false);
                },
              ),
            );
          });
        }));
  }
}
