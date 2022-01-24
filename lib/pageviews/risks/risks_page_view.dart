import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'risks_mobile_view.dart';

class RisksManagementPageView extends StatelessWidget {
  const RisksManagementPageView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        top: false,
        child: ScreenTypeLayout(
          mobile: RisksManagementMobileView(),
          tablet: RisksManagementMobileView(),
          desktop: RisksManagementMobileView(),
        ),);
  }
}
