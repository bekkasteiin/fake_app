import 'package:flutter/material.dart';
import 'package:hse/pageviews/obligations/obligations_mobile_view.dart';
import 'package:hse/viewmodels/obligations_model.dart';
import 'package:hse/viewmodels/ppe_model.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ObligationsPageView extends StatelessWidget {
  const ObligationsPageView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ObligationsViewModel()),
          ChangeNotifierProvider(create: (_) => PpeViewModel()),
        ],
        child: ScreenTypeLayout(
          mobile: ObligationsMobileView(),
          tablet: ObligationsMobileView(),
          desktop: ObligationsMobileView(), //ObligationsDesktopView(),
        ));
  }
}
