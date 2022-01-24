import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getflutter/getflutter.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/core/service/rest_services.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/viewmodels/login_model.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/UI_Helpers.dart';

class UrlPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => Login()),
        ],
        child: Consumer<Login>(builder: (context, counter, _) {
          return SafeArea(top: false, child: UrlMobileView());
        }));
  }
}

class UrlMobileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var defaultFontSize = 16.0;
    return Consumer<Login>(builder: (context, counter, _) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                S().initSettings,
                style: generalFontStyle.copyWith(fontSize: defaultFontSize + 5),
              )),
        ),
        body: Center(
          child: Container(
            constraints: BoxConstraints.tightFor(
                width: MediaQuery.of(context).size.width * 0.85),
            child: Padding(
              padding: const EdgeInsets.only(top: 65.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.only(bottom: 67.0),
                      //   child: Text(
                      //     S().initSettings,
                      //     style: generalFontStyle.copyWith(
                      //         fontSize: 25, fontWeight: FontWeight.w500),
                      //   ),
                      // ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: S().enterAddress,
                            labelStyle: generalFontStyle.copyWith(
                                fontSize: defaultFontSize + 2,
                                color: appGreyColor),
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black54))),
                        initialValue: counter.url,
                        onSaved: (val) => counter.url = val,
                        onChanged: (val) => counter.url = val,
                        validator: (val) =>
                            (val.isEmpty ? S().loginValidate : null),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 120,
                  ),
                  buildButton(counter)
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

Widget buildButton(Login counter) {
  return FutureProvider<bool>(
      create: (BuildContext context) => RestServices.checkConnection(),
      initialData: null,
      child: Consumer<bool>(builder: (context, value, child) {
        if (value == null) {
          return GFLoader(
            type: GFLoaderType.ios,
          );
        }
        return SnackButtons(
          leftText: S().save,
          rightText: S().cancel,
          functionLeft: () {
            counter.saveUrl();
          },
          functionRight: () => Get.back(),
        );
      }));
}
