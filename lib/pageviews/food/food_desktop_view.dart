import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/layout/main_widgets.dart';

import '../../core/utils/UI_Helpers.dart';
import 'food_desktop_widgets.dart';
import 'food_widgets.dart';

class FoodDesktopView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: LeadingDrawerIcon(),
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GFImageOverlay(
                  height: GFSize.SMALL,
                  width: GFSize.SMALL,
                  colorFilter:
                      ColorFilter.mode(Colors.transparent, BlendMode.color),
                  image: AssetImage('assets/images/food_logo.png'),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(S().food),
              ],
            ),
          ),
        ),
        actions: [LimitsButton()],
        centerTitle: true,
      ),
      // drawer: AppDrawer(),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: TabView(
          height: MediaQuery.of(context).size.height * 0.88,
          canScroll: true,
          tabs: [
            Tab(
              child: Text(
                S().menu,
                style: generalFontStyle.copyWith(fontSize: defaultFontSize),
              ),
            ),
            Tab(
              child: Text(
                S().order,
                style: generalFontStyle.copyWith(fontSize: defaultFontSize),
              ),
            ),
            Tab(
              child: Text(
                S().history,
                style: generalFontStyle.copyWith(fontSize: defaultFontSize),
              ),
            ),
            Tab(
              child: Text(
                S().fact,
                style: generalFontStyle.copyWith(fontSize: defaultFontSize),
              ),
            ),
          ],
          tabBar: [
            MenuDesktopWidget(),
            OrderWidget(),
            HistoryDesktop(),
            HistoryDesktopFact()
          ],
        ),
      )),
    );
  }
}
