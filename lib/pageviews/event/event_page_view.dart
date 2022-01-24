import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'event_mobile_view.dart';

class EventPageView extends StatelessWidget {
  const EventPageView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        top: false,
        child: ScreenTypeLayout(
          mobile: EventMobileView(),
          tablet: EventMobileView(),
          desktop: EventMobileView(),
        ),);
  }
}
