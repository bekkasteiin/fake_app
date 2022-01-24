import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/viewmodels/bpm_models/event_model.dart';

class EventResultStatus extends StatelessWidget {
  final bool success;
  final EventModel model;

  const EventResultStatus(this.model, [this.success = true]);

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
        title: Text('Изменения мероприятия'),
      ),
      body: Center(child: Padding(
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
                  ? 'Изменение мероприятие сохранено'
                  : 'Изменение мероприятие \nнезарегистрировано',
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
                  ? 'Следите за статусом Мероприятия'
                  : 'Мероприятие сохранено локально.\nПри появлении  интернета, небходимо синхронизовать',

              textAlign: TextAlign.center,
              style: generalFontStyle.copyWith(fontSize: defaultFontSize + 2),
            ),
          ],
        ),
      ),),
      bottomSheet: Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        child: GFButton(
          onPressed: back,
          text: 'Понятно'.toUpperCase(),
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

  void back() async {
    await model.getEntities();
    Get.back();
    Get.back();
  }
}