import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getflutter/getflutter.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/core/service/rest_services.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:hse/viewmodels/login_model.dart';
import 'package:provider/provider.dart';

class ResetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => Login()),
        ],
        child: Consumer<Login>(builder: (context, counter, _) {
          return SafeArea(top: false, child: ResetMobileView());
        }));
  }
}

class ResetMobileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var defaultFontSize = 16.0;
    var size = MediaQuery.of(context).size;
    return Consumer<Login>(builder: (context, counter, _) {
      return Scaffold(
        appBar: AppBar(
          title: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                S().forgotPassword,
                style: generalFontStyle.copyWith(fontSize: defaultFontSize + 5),
              )),
        ),
        body: Center(
          child: Container(
            constraints: BoxConstraints.tightFor(width: size.width * 0.85),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 70.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: S().enterUPI,
                          labelStyle: generalFontStyle.copyWith(
                              fontSize: defaultFontSize + 2,
                              color: appGreyColor),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black54))),
                      initialValue: counter.iin,
                      onSaved: (val) => counter.iin = val,
                      onChanged: (val) => counter.iin = val,
                      validator: (val) =>
                          (val.isEmpty ? S().loginValidate : null),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: S().enterLogin,
                          labelStyle: generalFontStyle.copyWith(
                              fontSize: defaultFontSize + 2,
                              color: appGreyColor),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black54))),
                      initialValue: counter.login,
                      onSaved: (val) => counter.login = val,
                      onChanged: (val) => counter.login = val,
                      validator: (val) =>
                          (val.isEmpty ? S().loginValidate : null),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50.0,
                ),
                Column(
                  children: [buildButton(counter)],
                ),
              ],
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
          leftText: 'ВОССТАНОВИТЬ',
          rightText: 'ОТМЕНА',
          functionLeft: () {
            counter.resetPassword();
          },
          functionRight: () => Get.back(),
        );
      }));
}
