import 'package:flutter/material.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:hse/pageviews/news/news_widgets.dart';
import 'package:hse/viewmodels/news_model.dart';
import 'package:provider/provider.dart';

class NewsDesktopView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<NewsModel>(builder: (context, counter, _) {
      return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            title: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                S().news,
                style: generalFontStyle.copyWith(fontSize: defaultFontSize + 5),
              ),
            ),
            centerTitle: true,
          ),
          //drawer: AppDrawer(),
          body: Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(5.0),
            child: TabView(canScroll: true, tabs: [
              Tab(
                child: Text(S().actualNews),
              ),
              Tab(
                child: Text(S().archivedNews),
              ),
            ], tabBar: [
              NewsDesktopList(),
              ArchiveDesktopList(),
            ]),
          ));
    });
  }
}
