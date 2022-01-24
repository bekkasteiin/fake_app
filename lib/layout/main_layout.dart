import 'package:flutter/material.dart';
import 'package:hse/pageviews/home/home_page_view.dart';
import 'package:hse/pageviews/settings/settings_page_view.dart';
import 'package:hse/viewmodels/user_info.dart';
import 'package:provider/provider.dart';

class MainLayout extends StatefulWidget {
  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  final Map<String, Widget> _children = {
    "/": MyHomePage(),
    "/setting": SettingsPage()
  };

  @override
  Widget build(BuildContext context) {
    return Consumer<UserInfoModel>(builder: (context, counter, _) {
      return SafeArea(
        bottom: false,
        top: false,
        child: Scaffold(
          body: _children[counter.route],
        ),
      );
    });
  }
}
