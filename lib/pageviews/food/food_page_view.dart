import 'package:flutter/material.dart';
import 'package:hse/viewmodels/food_model.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'food_desktop_view.dart';
import 'food_mobile_view.dart';

class FoodPageView extends StatelessWidget {
  const FoodPageView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => FoodModel()),
        ],
        child: Consumer<FoodModel>(builder: (context, counter, _) {
          return SafeArea(
              top: false,
              child: ScreenTypeLayout(
            mobile: FoodMobileView(),
            tablet: FoodMobileView(),
            desktop: FoodMobileView(), //FoodDesktopView(),
          ));
        }));
  }
}
