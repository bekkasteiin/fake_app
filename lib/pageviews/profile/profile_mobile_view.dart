import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/pageviews/home/home_page_widgets.dart';

import '../../core/utils/UI_Helpers.dart';
import 'profile_widgets.dart';

class ProfileMobileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
          title: Container(
        alignment: Alignment.centerLeft,
        child: Text(
          S().profile,
          style: generalFontStyle.copyWith(fontSize: defaultFontSize + 5),
        ),
      )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            UserProfileWindow(canRedirect: false),
            AssignmentCard(),
            AnthropometryCard(),
            PlacementCard(),
            RatingCard()
          ],
        ),
      ),
    );
  }
}
