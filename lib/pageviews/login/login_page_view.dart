import 'package:flutter/material.dart';
import 'package:hse/pageviews/login/login_mobile_view.dart';
import 'package:hse/viewmodels/login_model.dart';
import 'package:provider/provider.dart';

class LoginPageView extends StatelessWidget {
  const LoginPageView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => Login()),
        ],
        child: Consumer<Login>(builder: (context, counter, _) {
          return LoginMobileView();
        }));
  }
}
