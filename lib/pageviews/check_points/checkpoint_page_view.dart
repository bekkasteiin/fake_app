import 'package:flutter/material.dart';
import 'package:hse/pageviews/check_points/checkpoint_mobile_view.dart';
import 'package:hse/viewmodels/checkpoint_model.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CheckPointPageView extends StatelessWidget {
  const CheckPointPageView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CheckPointModel()),
        ],
        child: Consumer<CheckPointModel>(builder: (context, counter, _) {
          return SafeArea(
              top: false,
              child: ScreenTypeLayout(
                mobile: CheckPointMobileView(),
                tablet: CheckPointMobileView(),
                desktop: CheckPointMobileView(), //CheckpointDesktopView(),
              ));
        }));
  }
}
