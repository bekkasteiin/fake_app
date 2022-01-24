import 'package:flutter/material.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/layout/main_widgets.dart';
import 'package:hse/pageviews/notifications/notifications_widget.dart';
import 'package:hse/viewmodels/notifications_model.dart';
import 'package:provider/provider.dart';

import '../../core/utils/UI_Helpers.dart';

class NotificationsDesktopView extends StatelessWidget {
  NotificationsDesktopView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationsModel>(builder: (context, counter, _) {
      return Scaffold(
        appBar: AppBar(title: Center(child: Text(S().notification))),
        //drawer: AppDrawer(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: isDesktop(context)
                    ? const EdgeInsets.fromLTRB(150, 0, 150, 0)
                    : null,
                padding: const EdgeInsets.all(8.0),
                height: MediaQuery.of(context).size.height,
                child: NotificationsDesktopList(),
              ),
            ],
          ),
        ),
      );
    });
  }
}
