import 'package:flutter/material.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/generated/l10n.dart';

import '../../core/utils/UI_Helpers.dart';
import 'food_widgets.dart';

class FoodMobileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              S().food,
              style: generalFontStyle.copyWith(fontSize: defaultFontSize + 5),
            )),
        actions: [LimitsButton()],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15, top: 10),
        child: TabView(
          height: MediaQuery.of(context).size.height * 0.88,
          canScroll: true,
          tabs: [
            Tab(
              child: Text(
                S().menu,
                style: generalFontStyle.copyWith(
                    fontSize: defaultFontSize - 1, color: appBlackColor),
              ),
            ),
            Tab(
              child: Text(
                S().order,
                style: generalFontStyle.copyWith(
                    fontSize: defaultFontSize - 1, color: appBlackColor),
              ),
            ),
            Tab(
              child: Text(
                S().history,
                style: generalFontStyle.copyWith(
                    fontSize: defaultFontSize - 2, color: appBlackColor),
              ),
            ),
            Tab(
              child: Text(
                S().fact,
                style: generalFontStyle.copyWith(
                    fontSize: defaultFontSize - 1, color: appBlackColor),
              ),
            ),
          ],
          tabBar: [MenuWidget(), OrderWidget(), History(), HistoryFact()],
        ),
      ),
    );
  }
}
