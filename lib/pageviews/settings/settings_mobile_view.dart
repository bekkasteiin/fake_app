import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/core/service/rest_services.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:provider/provider.dart';

import 'settings_widgets.dart' as widgets;

class SettingsMobileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        //appBar: AppBar(title: const components.Title()),
        appBar: AppBar(
            title: Container(
          alignment: Alignment.centerLeft,
          child: Text(
            S().settings,
            style: generalFontStyle.copyWith(fontSize: defaultFontSize + 5),
          ),
        )),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(child: widgets.LangLabel()),
                // widgets.Email(),
                // widgets.ChangePassword(),
                buildButton()
              ],
            ),
          ),
        ));
  }
}

Widget buildButton() {
  return FutureProvider<bool>(
      create: (BuildContext context) => RestServices.checkConnection(),
      initialData: null,
      child: Consumer<bool>(builder: (context, value, child) {
        if (value == null) {
          return GFLoader(
            type: GFLoaderType.ios,
          );
        }
        return SnackButtons(
          leftText: S().save,
          rightText: S().cancel,
          functionLeft: () => Navigator.pop(context),
          functionRight: () => Navigator.pop(context),
        );
      }));
}
