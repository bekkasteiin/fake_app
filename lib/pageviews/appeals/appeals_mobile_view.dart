import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/core/service/rest_services.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/viewmodels/appeal_model.dart';
import 'package:provider/provider.dart';

import '../../core/utils/UI_Helpers.dart';
import 'appeals_widgets.dart';

class AppealMobileView extends StatelessWidget {
  AppealMobileView({Key key}) : super(key: key);

  final Map map = {
    '/description': DescriptionField(),
    '/type': AppealTypes(),
    '/topic': AppealTopics(),
    '/info': OrderInfo()
  };

  @override
  Widget build(BuildContext context) {
    return Consumer<AppealModel>(builder: (context, counter, _) {
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Padding(
            padding: EdgeInsets.only(bottom: 0),
            child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  S().appealJornal,
                  style:
                      generalFontStyle.copyWith(fontSize: defaultFontSize + 5),
                )),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
                child: TabView(
                  height: MediaQuery.of(context).size.height * 0.88,
                  canScroll: false,
                  tabs: [
                    GestureDetector(
                      onTap: () {
                        counter.controller.animateTo(0);
                        counter.setBusy(false);
                      },
                      child: Tab(
                        child: Text(
                          S().AppealRequest,
                          style: generalFontStyle.copyWith(
                              fontSize: defaultFontSize),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        counter.controller.animateTo(1);
                        counter.setBusy(false);
                      },
                      child: Tab(
                        child: Text(
                          S().history,
                          style: generalFontStyle.copyWith(
                              fontSize: defaultFontSize),
                        ),
                      ),
                    ),
                  ],
                  tabBar: [
                    Stack(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            AppealStepper(),
                            map[counter.step],
                          ],
                        ),
                        buildButton(counter)
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: AppealsHistory(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget buildButton(AppealModel counter) {
    return FutureProvider<bool>(
        create: (BuildContext context) => RestServices.checkConnection(),
        initialData: null,
        child: Consumer<bool>(builder: (context, value, child) {
          if (value == null) {
            return GFLoader(
              type: GFLoaderType.ios,
            );
          }
          return Positioned(
              bottom: 0.1,
              child: SnackButtons(
                leftText: 'ДАЛЕЕ',
                rightText: counter.step == '/description' ? 'ОТМЕНА' : 'НАЗАД',
                functionLeft: !value ? null : () => counter.next(),
                functionRight: !value ? null : () => counter.back(),
              ));
        }));
  }
}
