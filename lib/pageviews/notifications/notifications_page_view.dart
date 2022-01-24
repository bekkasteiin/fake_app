import 'package:flutter/material.dart';
import 'package:hse/pageviews/notifications/notifications_mobile_view.dart';
import 'package:hse/viewmodels/notifications_model.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'notifications_desktop_view.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => NotificationsModel()),
        ],
        child: ScreenTypeLayout(
          mobile: NotificationsMobileView(),
          tablet: NotificationsMobileView(),
          desktop: NotificationsMobileView(), //NotificationsDesktopView(),
        ));
  }
}
