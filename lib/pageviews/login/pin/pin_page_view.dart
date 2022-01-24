import 'package:flutter/material.dart';
import 'package:hse/viewmodels/login_model.dart';
import 'package:provider/provider.dart';

import 'pin_mobile_view.dart';
import 'pin_vertify.dart';

class PinPage extends StatelessWidget {
  final bool toCreate;

  PinPage(this.toCreate);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => Login()),
        ],
        child: Consumer<Login>(builder: (context, counter, _) {
          return SafeArea(
              bottom: false,
              top: false,
              child: toCreate ? PinMobileCreate() : PinMobileView());
        }));
  }
}
