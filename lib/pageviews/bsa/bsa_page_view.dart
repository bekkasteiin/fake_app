import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'bsa_mobile_view.dart';

class BsaPageView extends StatelessWidget {
  const BsaPageView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        top: false,
        child: ScreenTypeLayout(
          mobile: BsaMobileView(),
          tablet: BsaMobileView(),
          desktop: BsaMobileView(),
        ),);
  }
}
