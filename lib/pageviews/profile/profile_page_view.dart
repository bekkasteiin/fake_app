import 'package:flutter/material.dart';
import 'package:hse/viewmodels/profile_model.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'profile_mobile_view.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => Profile()),
        ],
        child: Consumer<Profile>(builder: (context, counter, _) {
          return SafeArea(
              top: false,
              child: ScreenTypeLayout(
                mobile: ProfileMobileView(),
                tablet: ProfileMobileView(),
                desktop: ProfileMobileView(), //ProfileDesktopView(),
              ));
        }));
  }
}
