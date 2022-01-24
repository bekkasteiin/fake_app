import 'package:flutter/material.dart';
import 'package:hse/pageviews/obligations/obligations_items/items_list_view.dart';
import 'package:hse/viewmodels/obligations_model.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ObligationsPageView extends StatelessWidget {
  const ObligationsPageView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ObligationsViewModel()),
        ],
        child: ScreenTypeLayout(
          mobile: ItemsPage(),
          tablet: ItemsPage(),
          desktop: ItemsPage(), //ItemsDesktopPage(),
        ));
  }
}
