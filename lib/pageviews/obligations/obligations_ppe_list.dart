import 'package:flutter/material.dart';
import 'package:hse/pageviews/obligations/obligations_widgets.dart';
import 'package:hse/viewmodels/ppe_model.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

// Список СИЗ (в обязательствах)
class ObligationsPpeView extends StatelessWidget {
  const ObligationsPpeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => PpeViewModel()),
        ],
        child: ScreenTypeLayout(
          mobile: ObligationsPpePage(),
          tablet: ObligationsPpePage(),
          desktop: ObligationsPpePage(), //ObligationsDesktopPpePage(),
        ));
  }
}
