import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getflutter/getflutter.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/core/service/rest_services.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/viewmodels/appeal_model.dart';
import 'package:provider/provider.dart';

import '../../core/utils/UI_Helpers.dart';

class AppealsConfirmationView extends StatelessWidget {
  const AppealsConfirmationView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AppealModel()),
        ],
        child: Consumer<AppealModel>(builder: (context, counter, _) {
          return SafeArea(top: false, child: AppealConfirm());
        }));
  }
}

class AppealConfirm extends StatelessWidget {
  final String answer;

  const AppealConfirm({Key key, this.answer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureProvider(
        create: (BuildContext context) => RestServices.checkConnection(),
        initialData: null,
        child: Consumer<bool>(builder: (context, value, child) {
          if (value == null) {
            return GFLoader(
              type: GFLoaderType.ios,
            );
          }
          return Scaffold(
              appBar: AppBar(
                title: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Text(
                        S().AppealRequest, //'Обращение',
                        style: generalFontStyle.copyWith(
                            fontSize: defaultFontSize + 4),
                      ),
                    ],
                  ),
                ),
                centerTitle: true,
              ),
              body: Center(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        S().AppealConfirm, //'Ваше обращение принято!',
                        style: generalFontStyle.copyWith(
                            fontSize: defaultFontSize + 8,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      Container(
                        width: GFSize.LARGE * 7,
                        height: GFSize.MEDIUM * 2.7,
                        child: Text(
                          S().AppealStatusInfo,
                          //'Следите за статусом обращения',
                          style: generalFontStyle.copyWith(
                              fontSize: defaultFontSize + 4,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 150,
                      ),
                      Container(
                        width: GFSize.LARGE * 9,
                        height: GFSize.MEDIUM * 1.5,
                        child: GFButton(
                          onPressed: () => Get.back(),
                          text: S().clear,
                          //'ПОНЯТНО',
                          textStyle: generalFontStyle.copyWith(
                              fontSize: defaultFontSize + 8,
                              fontWeight: FontWeight.bold),
                          color: appGreenColor,
                          size: GFSize.LARGE * 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        }));
  }
}
