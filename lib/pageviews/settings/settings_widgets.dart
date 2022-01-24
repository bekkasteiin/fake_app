import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:getflutter/getflutter.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/viewmodels/user_info.dart';
import 'package:provider/provider.dart';

import '../../core/utils/UI_Helpers.dart';

class Title extends StatelessWidget {
  const Title({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserInfoModel>(
      builder: (BuildContext context, UserInfoModel value, Widget child) {
        return Text(S().settings);
      },
    );
  }
}

//языковые предпочтения пользователя
class LangLabel extends StatelessWidget {
  const LangLabel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<UserInfoModel>(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text(S().mainLanguage, style: captionStyle)),
            Container(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    width: 110,
                    margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: GFButton(
                      size: GFSize.LARGE * 1.2,
                      shape: GFButtonShape.pills,
                      type: type(userInfo, 'kk'),
                      child: Text(
                        S().kz,
                        style: generalFontStyle.copyWith(
                            fontSize: defaultFontSize,
                            fontWeight: FontWeight.w500),
                      ),
                      color: color(userInfo, 'kk'),
                      onPressed: () => userInfo.changeLanguage('kk'),
                    ),
                  ),
                  Container(
                    width: 110,
                    margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: GFButton(
                      size: GFSize.LARGE * 1.2,
                      shape: GFButtonShape.pills,
                      type: type(userInfo, 'en'),
                      child: Text(
                        S().en,
                        style: generalFontStyle.copyWith(
                            fontSize: defaultFontSize,
                            fontWeight: FontWeight.w500),
                      ),
                      color: color(userInfo, 'en'),
                      onPressed: () => userInfo.changeLanguage('en'),
                    ),
                  ),
                  Container(
                    width: 110,
                    margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: GFButton(
                      size: GFSize.LARGE * 1.2,
                      shape: GFButtonShape.pills,
                      type: type(userInfo, 'ru'),
                      child: Text(
                        S().ru,
                        style: generalFontStyle.copyWith(
                            fontSize: defaultFontSize,
                            fontWeight: FontWeight.w500),
                      ),
                      color: color(userInfo, 'ru'),
                      onPressed: () => userInfo.changeLanguage('ru'),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Divider(
              thickness: 1,
            )
          ],
        ),
      ),
    );
  }

  GFButtonType type(UserInfoModel userInfo, String code) =>
      userInfo.localeCode == code ? GFButtonType.solid : GFButtonType.outline;

  Color color(UserInfoModel userInfo, String code) =>
      userInfo.localeCode == code ? appBlueColor : appBlueColor;
}

// Изменение email адреса
class Email extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var counter = Provider.of<UserInfoModel>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // FutureProvider<TextEditingController>(
        //     create: (BuildContext context) => counter.getPreference(),
        //     initialData: null,
        //     child:
        //         Consumer<TextEditingController>(builder: (context, model, _) {
        //       return Container(
        //         width: MediaQuery.of(context).size.width * 0.9,
        //         child: TextFormField(
        //           controller: model,
        //           decoration: InputDecoration(
        //               hintText: S().enterEmail,
        //               hintStyle: generalFontStyle.copyWith(
        //                   fontSize: defaultFontSize + 2, color: appGreyColor),
        //               border: UnderlineInputBorder(
        //                   borderSide: BorderSide(color: Colors.black54))),
        //           // decoration: InputDecoration(
        //           //     labelText: S().enterEmail,
        //           //     labelStyle: generalFontStyle.copyWith(
        //           //         fontSize: 20,
        //           //         fontWeight: FontWeight.w500,
        //           //         color: appGreyColor),
        //           //     disabledBorder: UnderlineInputBorder(
        //           //         borderSide: BorderSide(
        //           //             color: counter.emailSaved
        //           //                 ? appBlueColor
        //           //                 : appGreyColor)),
        //           //     focusedBorder: UnderlineInputBorder(
        //           //         borderSide: BorderSide(
        //           //             color: counter.emailSaved
        //           //                 ? appBlueColor
        //           //                 : appGreyColor))),
        //           keyboardType: TextInputType.emailAddress,
        //           textAlign: TextAlign.start,
        //           style:
        //               generalFontStyle.copyWith(fontSize: defaultFontSize + 2),
        //           //fontWeight: FontWeight.bold),
        //           onChanged: (val) => counter.setPreference(val),
        //           autovalidate: true,
        //           textInputAction: TextInputAction.next,
        //           validator: (val) => counter.isValueCorrect(val),
        //         ),
        //       );
        //     }))
      ],
    );
  }
}

//изменить пароль
class ChangePassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //width: MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.only(top: 50.0),
      child: GFButton(
        color: appGreenColor,
        hoverColor: appWhiteColor,
        splashColor: appWhiteColor,
        highlightColor: appWhiteColor,
        text: S().resetPassword,
        textStyle: generalFontStyle.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: defaultButtonTextFontSize,
            color: appGreenColor),
        size: 52,
        type: GFButtonType.outline,
        blockButton: true,
        onPressed: () => Get.toNamed('/changePassword'),
      ),
    );
  }
}
