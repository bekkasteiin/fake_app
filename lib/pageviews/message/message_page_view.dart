import 'package:flutter/material.dart';
import 'package:hse/pageviews/message/message_mobile_view.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MessagePageView extends StatelessWidget {
  const MessagePageView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        top: false,
        child: ScreenTypeLayout(
          mobile: MessageMobileView(),
          tablet: MessageMobileView(),
          desktop: MessageMobileView(), //FoodDesktopView(),
        ));
  }
}
