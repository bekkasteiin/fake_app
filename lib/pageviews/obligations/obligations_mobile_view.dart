import 'package:flutter/material.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/generated/l10n.dart';

import '../../core/utils/UI_Helpers.dart';
import 'obligations_widgets.dart';

class ObligationsMobileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              S().commitmentsMade,
              style: generalFontStyle.copyWith(fontSize: defaultFontSize + 5),
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Column(
                children: [ObligationAmountWidget(), ObligationButtons()])));
  }
}
