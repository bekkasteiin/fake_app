import 'package:flutter/material.dart';
import 'package:hse/pageviews/message/message_mobile_view.dart';
import 'package:hse/pageviews/ticket/ticket_mobile_page.dart';
import 'package:responsive_builder/responsive_builder.dart';

class TicketManagementPageView extends StatelessWidget {
  const TicketManagementPageView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        top: false,
        child: ScreenTypeLayout(
          mobile: TicketMobilePage(),
          tablet: TicketMobilePage(),
          desktop: TicketMobilePage(), //FoodDesktopView(),
        ));
  }
}
