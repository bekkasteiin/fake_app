import 'package:flutter/material.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/layout/main_widgets.dart';

import 'obligations_widgets.dart';

class ObligationsDesktopView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text(S().obligations)),
        ),
        //drawer: AppDrawer(),
        body: SingleChildScrollView(
            child: Column(children: [
          ObligationDesktopAmountWidget(),
          ObligationDesktopButtons()
        ])));
  }
}
