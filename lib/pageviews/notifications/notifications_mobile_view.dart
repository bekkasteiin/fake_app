import 'package:flutter/material.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/pageviews/notifications/notifications_widget.dart';
import 'package:hse/viewmodels/notifications_model.dart';
import 'package:provider/provider.dart';

import '../../core/utils/UI_Helpers.dart';

class NotificationsMobileView extends StatelessWidget {
  NotificationsMobileView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationsModel>(builder: (context, counter, _) {
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                S().notification,
                style: generalFontStyle.copyWith(fontSize: defaultFontSize + 5),
              )),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                child: NotificationsList(),
              ),
            ],
          ),
        ),
      );
    });
  }
}
