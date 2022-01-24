import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getflutter/getflutter.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/pageviews/login/login_widget.dart';
import 'package:hse/viewmodels/login_model.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../core/utils/UI_Helpers.dart';
import 'url/url_page_view.dart';

class LoginMobileView extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var deviceInfo = getDeviceInfo(context);
    var size = MediaQuery.of(context).size;
    var height = size.height * 0.95;
    var width = size.width * 0.85;
    var isDesktop = false;
    if (deviceInfo == DeviceScreenType.desktop) {
      isDesktop = true;
      height = size.height * 0.7;
      width = size.width * 0.5;
    }
    return Consumer<Login>(builder: (context, counter, _) {
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                S().personalCabinet,
                style: generalFontStyle.copyWith(fontSize: defaultFontSize + 5),
              )),
          actions: [
            Container(
                child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => Get.to(UrlPage()),
                  child: Icon(
                    Icons.settings,
                    size: GFSize.SMALL,
                  ),
                ),
                SizedBox(
                  width: 15.0,
                )
              ],
            )),
          ],
          centerTitle: true,
        ),
        body: GestureDetector(
          onTap: () {
            var currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    constraints:
                        BoxConstraints.tightFor(height: height, width: width),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          S().welcome,
                          style: generalFontStyle.copyWith(
                              fontSize: defaultFontSize + 10,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 70,
                        ),
                        Inputs(),
                        // ReqistrationButton(),
                        SizedBox(
                          height: 120,
                        ),
                        LoginButton()
                      ],
                    )),
              ),
            ),
          ),
        ),
      );
    });
  }
}
