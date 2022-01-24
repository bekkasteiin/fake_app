import 'dart:io';
import 'package:hse/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/viewmodels/bpm_models/message_model.dart';

class MessageResultStatus extends StatelessWidget {
  final bool success;
  final MessageModel model;

  const MessageResultStatus(this.model, [this.success = true]);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            !Platform.isIOS ? Icons.arrow_back : Icons.arrow_back_ios,
          ),
          onPressed: back,
        ),
        title: Text(S.current.messageRegistration),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width / 4,
            ),
            Text(
              success
                  ? S.current.messageRegistered
                  : S.current.messageUnregistered,
              textAlign: TextAlign.center,
              style: generalFontStyle.copyWith(
                fontSize: defaultFontSize + 10,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width / 6,
            ),
            Text(
              success
                  ? S.current.followMessageStatus
                  : S.current.messageLocallySaved,
              style: generalFontStyle.copyWith(fontSize: defaultFontSize + 2),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        child: GFButton(
          onPressed: back,
          text: S.current.clear.toUpperCase(),
          textStyle: generalFontStyle.copyWith(
              color: Colors.white,
              fontSize: defaultFontSize + 10,
              fontWeight: FontWeight.bold),
          color: success ? appGreenColor : appRedColor,
          size: 52,
          blockButton: true,
        ),
      ),
      resizeToAvoidBottomInset: true,
    );
  }

  Future<void> back() async {
    await model.getEntities();
    // print('size: ${model.entities.length}');
    Get.back();
    Get.back();
  }
}
