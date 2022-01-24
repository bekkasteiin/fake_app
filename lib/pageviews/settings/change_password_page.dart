import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/core/service/rest_services.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/pageviews/home/home_page_widgets.dart';
import 'package:hse/viewmodels/user_info.dart';
import 'package:provider/provider.dart';

import '../../core/utils/UI_Helpers.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  String _old = '';
  String _first = '';
  String _second = '';
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var counter = Provider.of<UserInfoModel>(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              S().resetPasswordTitle,
              style: generalFontStyle.copyWith(fontSize: defaultFontSize + 5),
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 0.0),
              child: UserProfileWindow(),
            ),
            Form(
                key: formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      buildInput(context, (val) => _old = val,
                          S().enterTheCurrentPassword),
                      buildInput(
                          context, (val) => _first = val, S().enterANewPassword,
                          valFunc: (val) {
                        String str = counter.validatePass(_first, _second);
                        counter.setBusy(false);
                        return str;
                      }),
                      buildInput(context, (val) => _second = val,
                          S().repeatNewPassword, valFunc: (val) {
                        String str = counter.validatePass(_first, _second);
                        counter.setBusy(false);
                        return str;
                      }),
                    ])),
            Padding(
              padding: const EdgeInsets.only(top: 150.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  buildButton(counter, _old, _first, _second),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //форматирования ввода
  Container buildInput(BuildContext context, Function function, String label,
      {obs = false, valFunc}) {
    return Container(
        margin: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width * 0.8,
        child: TextFormField(
          decoration: InputDecoration(
            hintText: label,
            hintStyle: generalFontStyle.copyWith(
                fontSize: defaultFontSize + 2, color: appGreyColor),
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black54)),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.remove_red_eye,
                //color: counter.obscure ? Colors.grey[550] : Theme.of(context).accentColor,
                size: 30,
              ),
              onPressed: () {
                // counter.obscure = !counter.obscure;
                // counter.setBusy(false);
              },
            ),
          ),
          keyboardType: TextInputType.text,
          obscureText: obs,
          obscuringCharacter: '*',
          onChanged: function,
          autovalidate: true,
          textAlign: TextAlign.start,
          validator: valFunc,
          //style: generalFontStyle.copyWith(fontSize: 20, color: Colors.black12),
        ));
  }
}

Widget buildButton(UserInfoModel counter, String old, String first, String second) {
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
            counter.changePassword(old, first, second);
          },
          functionRight: () => Navigator.pop(context),
        );
      }));
}
