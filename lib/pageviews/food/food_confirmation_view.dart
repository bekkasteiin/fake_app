import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getflutter/getflutter.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/core/service/rest_services.dart';
import 'package:hse/viewmodels/food_model.dart';
import 'package:provider/provider.dart';

import '../../core/utils/UI_Helpers.dart';

class FoodConfirmationView extends StatelessWidget {
  const FoodConfirmationView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => FoodModel()),
        ],
        child: Consumer<FoodModel>(builder: (context, counter, _) {
          return SafeArea(top: false, child: FoodConfirm());
        }));
  }
}

class FoodConfirm extends StatelessWidget {
  final String answer;

  const FoodConfirm({Key key, this.answer}) : super(key: key);

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
                        'Питание',
                        style: generalFontStyle.copyWith(fontSize: 20),
                      ),
                      Spacer(),
                      Image.asset('assets/images/limitsIcon.png'),
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
                        'Ваш заказ принят!',
                        style: generalFontStyle.copyWith(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      Container(
                        width: GFSize.LARGE * 7,
                        height: GFSize.MEDIUM * 2.7,
                        child: Text(
                          'Ожидаем Вас\n' + 'Просим не опаздывать',
                          style: generalFontStyle.copyWith(
                              fontSize: 20, fontWeight: FontWeight.w400),
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
                          text: 'ПОНЯТНО',
                          textStyle: generalFontStyle.copyWith(
                              fontSize: 25, fontWeight: FontWeight.bold),
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
