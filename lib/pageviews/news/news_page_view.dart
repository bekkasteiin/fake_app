import 'package:flutter/material.dart';
import 'package:hse/pageviews/news/news_mobile_view.dart';
import 'package:hse/viewmodels/news_model.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'news_desktop_view.dart';

class NewsViewPage extends StatelessWidget {
  const NewsViewPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => NewsModel()),
          ChangeNotifierProvider(create: (_) => ArchiveModel())
        ],
        child: Consumer<NewsModel>(builder: (context, counter, _) {
          return SafeArea(
              top: false,
              child: ScreenTypeLayout(
                mobile: NewsMobileView(),
                tablet: NewsMobileView(),
                desktop: NewsDesktopView(),
              ));
        }));
  }
}
