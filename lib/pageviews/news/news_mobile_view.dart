import 'package:flutter/material.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:hse/pageviews/news/news_widgets.dart';
import 'package:hse/viewmodels/news_model.dart';
import 'package:provider/provider.dart';

class NewsMobileView extends StatelessWidget {
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
          body: Padding(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
            child: TabView(canScroll: true, tabs: [
              Tab(
                child: Text(S().actualNews,
                    style:
                        generalFontStyle.copyWith(fontSize: defaultFontSize)),
              ),
              Tab(
                child: Text(S().archivedNews,
                    style:
                        generalFontStyle.copyWith(fontSize: defaultFontSize)),
              ),
            ], tabBar: [
              NewsList(),
              ArchiveList(),
            ]),
          ));
    });
  }
}
