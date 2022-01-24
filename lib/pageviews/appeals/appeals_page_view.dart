import 'package:flutter/material.dart';
import 'package:hse/viewmodels/appeal_model.dart';
import 'package:provider/provider.dart';

import 'appeals_mobile_view.dart';

class AppealsPage extends StatelessWidget {
  const AppealsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AppealModel()),
        ],
        child: Consumer<AppealModel>(builder: (context, counter, _) {
          return AppealMobileView();
        }));
  }
}
