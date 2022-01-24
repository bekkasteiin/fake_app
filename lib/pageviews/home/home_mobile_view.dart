import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getflutter/size/gf_size.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/layout/main_widgets.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:hse/pageviews/home/home_page_widgets.dart' as widgets;
import 'package:hse/viewmodels/user_info.dart';
import 'package:provider/provider.dart';

class HomeMobileView extends StatelessWidget {
  const HomeMobileView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserInfoModel>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: LeadingDrawerIcon(),
        title: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              S().mainInfo,
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
                  onTap: () => Get.toNamed('/settings'),
                  child: Icon(
                    Icons.settings,
                    size: GFSize.MEDIUM,
                  )),
              SizedBox(
                width: 15.0,
              ),
              GestureDetector(
                  onTap: () {
                    //Вы хотите выйти?
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            'Вы хотите выйти?',
                            style: generalFontStyle.copyWith(
                                fontSize: defaultFontSize,
                                fontWeight: FontWeight.bold),
                          ),
                          actions: [
                            FlatButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: Text(
                                  'Отмена',
                                  style: generalFontStyle.copyWith(
                                      color: appBlueColor),
                                )),
                            FlatButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: Text('Выйти'),
                              color: appRedColor,
                            )
                          ],
                          elevation: 24,
                        );
                      },
                    ).then((exit) async {
                      if (exit == null || !exit) return;
                      if (exit) {
                        //yes
                        user.exit();
                      }
                    });
                  },
                  child: Icon(
                    Icons.exit_to_app,
                    size: GFSize.MEDIUM,
                  )),
              SizedBox(
                width: 15.0,
              )
            ],
          )),
        ],
        centerTitle: true,
      ),
      // drawer: AppDrawer(),
      body: widgets.CounterLabel(),
    );
  }
}
