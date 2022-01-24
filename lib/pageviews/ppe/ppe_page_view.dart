import 'package:flutter/material.dart';
import 'package:hse/viewmodels/calendar_model.dart';
import 'package:hse/viewmodels/ppe_model.dart';
import 'package:provider/provider.dart';

import 'ppe_mobile_view.dart';

class PpePage extends StatelessWidget {
  const PpePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => PpeViewModel()),
      ChangeNotifierProvider(create: (_) => CalendarModel()),
    ], child: PpeMobileView());
  }
}
