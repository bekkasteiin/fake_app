import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getflutter/getflutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hse/core/model/news/News.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/core/service/rest_services.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
//import 'package:hse/pageviews/profile/profile_widgets.dart';
import 'package:hse/viewmodels/news_model.dart';
import 'package:kinfolk/kinfolk.dart';
import 'package:provider/provider.dart';

import '../../core/utils/UI_Helpers.dart';

// список актуальных новостей мобильная версия
class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsModel = Provider.of<NewsModel>(context);
    return Consumer<NewsModel>(builder: (context, counter, _) {
      return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SingleChildScrollView(
            child: FutureProvider<List<News>>(
                create: (BuildContext context) => counter.news,
                initialData: null,
                child: Consumer<List<News>>(builder: (context, model, _) {
                  if (model == null) {
                    return GFLoader(
                      type: GFLoaderType.ios,
                    );
                  }
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ...model.map((e) {
                          return GestureDetector(
                            onTap: () async {
                              //RestServices.setNewsRead(e.id);
                              await Get.to(
                                ChangeNotifierProvider.value(
                                  value: newsModel,
                                  builder: (context, child) =>
                                      NewsDetailsPageView(
                                    e.newsDate,
                                    e.image,
                                    e.text,
                                    e.title,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: appFiledBorderColor,
                                ),
                                borderRadius: BorderRadius.circular(10),
                                color: appWhiteColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: appGreyColor.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: Offset(
                                        2, 2), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          topLeft: Radius.circular(10)),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage('assets/images/img.png')),
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Container(
                                            //child: Scrollbar(
                                            //  child: SingleChildScrollView(
                                            child: Text(
                                              e.text,
                                              style: generalFontStyle.copyWith(
                                                  fontSize: defaultFontSize - 2,
                                                  fontWeight: FontWeight.w300),
                                              maxLines: 4,
                                            ),
                                            //  ),
                                            //),
                                            height: GFSize.LARGE * 2,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 10.0,
                                              top: 10.0,
                                              right: 5),
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              formatNamedDate(e.newsDate),
                                              style: generalFontStyle.copyWith(
                                                  fontSize: defaultFontSize,
                                                  color: appBlackColor),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                        SizedBox(
                          height: 100,
                        )
                      ],
                    ),
                  );
                })),
          ));
    });
  }
}

// список актуальных новостей desktop версия
class NewsDesktopList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsModel = Provider.of<NewsModel>(context);
    var namingStyle = Theme.of(context).textTheme.subtitle1;
    return Consumer<NewsModel>(builder: (context, counter, _) {
      return Scaffold(
        body: SingleChildScrollView(
          child: FutureProvider<List<News>>(
              create: (BuildContext context) => counter.news,
              initialData: null,
              child: Consumer<List<News>>(builder: (context, model, _) {
                if (model == null) {
                  return GFLoader(
                    type: GFLoaderType.ios,
                  );
                }
                return Wrap(
                  children: [
                    ...model.map((e) {
                      return GestureDetector(
                        onTap: () => Get.to(ChangeNotifierProvider.value(
                            value: newsModel,
                            builder: (context, child) => NewsDetailsPageView(
                                  e.newsDate,
                                  e.image,
                                  e.text,
                                  e.title,
                                ))),
                        child: Container(
                          width: 400,
                          height: 300,
                          margin: EdgeInsets.all(5),
                          //padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: appWhiteColor,
                            border:
                                Border.all(color: appFiledBorderColor, width: 0.5),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: appGreyColor.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset:
                                    Offset(2, 2), // changes position of shadow
                              ),
                            ],
                          ),

                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height *
                                    0.2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      topLeft: Radius.circular(10)),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage('assets/images/img.png')),
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(
                                        //child: Scrollbar(
                                        //  child: SingleChildScrollView(
                                        child: Text(
                                          e.text,
                                          style: generalFontStyle.copyWith(
                                              fontSize: defaultFontSize - 2,
                                              fontWeight: FontWeight.w300),
                                          maxLines: 4,
                                        ),

                                        //  ),
                                        //),
                                        height: GFSize.LARGE * 2,
                                        width:
                                            MediaQuery.of(context).size.width,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 10.0, top: 10.0, right: 5),
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          formatNamedDate(e.newsDate),
                                          style: generalFontStyle.copyWith(
                                              fontSize: defaultFontSize,
                                              color: appBlackColor),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),

                          // child: Column(
                          //   children: [
                          //     Padding(
                          //       padding: const EdgeInsets.all(12.0),
                          //       child: Row(
                          //         children: [
                          //           Container(
                          //             child: Text(
                          //               e.title ?? '_',
                          //               style: generalFontStyle.copyWith(
                          //                 fontSize: defaultFontSize+8,
                          //               ),
                          //             ),
                          //           ),
                          //           Spacer(),
                          //           dateRow(e.newsDate),
                          //         ],
                          //       ),
                          //     ),
                          //     Row(
                          //       mainAxisAlignment: MainAxisAlignment.start,
                          //       children: [
                          //         Padding(
                          //           padding: const EdgeInsets.all(8.0),
                          //           child: Image(
                          //             alignment: Alignment.topCenter,
                          //             image: NetworkImage(Kinfolk.getFileUrl(e.image)),
                          //             width: GFSize.LARGE * 5,
                          //             height: GFSize.LARGE * 5,
                          //           ),
                          //         ),
                          //         Container(
                          //           alignment: Alignment.topCenter,
                          //           child: Scrollbar(
                          //             child: SingleChildScrollView(
                          //               child: Text(
                          //                 e.text,
                          //                 style: namingStyle,
                          //               ),
                          //             ),
                          //           ),
                          //           height: GFSize.LARGE * 5,
                          //           width: GFSize.LARGE * 7,
                          //         ),
                          //       ],
                          //     ),
                          //   ],
                          // ),
                        ),
                      );
                    }).toList()
                  ],
                );
              })),
        ),
      );
    });
  }
}

class ArchiveList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsModel = Provider.of<NewsModel>(context);
    return Consumer<ArchiveModel>(builder: (context, counter, _) {
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: FutureProvider<List<News>>(
            create: (BuildContext context) => counter.archives,
            initialData: null,
            child: Consumer<List<News>>(builder: (context, model, _) {
              if (model == null) {
                return GFLoader(
                  type: GFLoaderType.ios,
                );
              }
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ...model.map((e) {
                      return GestureDetector(
                        onTap: () => Get.to(ChangeNotifierProvider.value(
                            value: newsModel,
                            builder: (context, child) => NewsDetailsPageView(
                                  e.newsDate,
                                  e.image,
                                  e.text,
                                  e.title,
                                ))),
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: appFiledBorderColor,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            color: appWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                color: appGreyColor.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset:
                                    Offset(2, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          topLeft: Radius.circular(10)),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage('assets/images/img.png')),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(
                                        //child: Scrollbar(
                                        //  child: SingleChildScrollView(
                                        child: Text(
                                          e.text,
                                          style: generalFontStyle.copyWith(
                                              fontSize: defaultFontSize - 2,
                                              fontWeight: FontWeight.w300),
                                          maxLines: 4,
                                        ),

                                        //  ),
                                        //),
                                        height: GFSize.LARGE * 2,
                                        width:
                                            MediaQuery.of(context).size.width,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 10.0, top: 10.0, right: 5),
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          formatNamedDate(e.newsDate),
                                          style: generalFontStyle.copyWith(
                                              fontSize: defaultFontSize,
                                              color: appBlackColor),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                    SizedBox(
                      height: 100,
                    )
                  ],
                ),
              );
            })),
      );
    });
  }
}

class ArchiveDesktopList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsModel = Provider.of<NewsModel>(context);
    var namingStyle = Theme.of(context).textTheme.subtitle1;
    return Consumer<ArchiveModel>(builder: (context, counter, _) {
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: FutureProvider<List<News>>(
              create: (BuildContext context) => counter.archives,
              initialData: null,
              child: Consumer<List<News>>(builder: (context, model, _) {
                if (model == null) {
                  return GFLoader(
                    type: GFLoaderType.ios,
                  );
                }
                return Wrap(
                  children: [
                    ...model.map((e) {
                      return GestureDetector(
                        onTap: () => Get.to(ChangeNotifierProvider.value(
                            value: newsModel,
                            builder: (context, child) => NewsDetailsPageView(
                                e.newsDate, e.image, e.text, e.type))),
                        child: Container(
                          width: 400,
                          height: 300,
                          margin: EdgeInsets.all(5),
                          // padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: appWhiteColor,
                            border:
                                Border.all(color: appFiledBorderColor, width: 0.5),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: appGreyColor.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset:
                                    Offset(2, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          topLeft: Radius.circular(10)),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              Kinfolk.getFileUrl(e.image))),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(
                                        //child: Scrollbar(
                                        //  child: SingleChildScrollView(
                                        child: Text(
                                          e.text,
                                          style: generalFontStyle.copyWith(
                                              fontSize: defaultFontSize - 2,
                                              fontWeight: FontWeight.w300),
                                          maxLines: 4,
                                        ),

                                        //  ),
                                        //),
                                        height: GFSize.LARGE * 2,
                                        width:
                                            MediaQuery.of(context).size.width,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 10.0, top: 10.0, right: 5),
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          formatNamedDate(e.newsDate),
                                          style: generalFontStyle.copyWith(
                                              fontSize: defaultFontSize,
                                              color: appBlackColor),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          // child: Column(
                          //   children: [
                          //     Padding(
                          //       padding: const EdgeInsets.all(12.0),
                          //       child: Row(
                          //         children: [
                          //           Container(
                          //             child: Text(
                          //               e.title ?? '_',
                          //               style: generalFontStyle.copyWith(
                          //                 fontSize: 24,
                          //               ),
                          //             ),
                          //           ),
                          //           Spacer(),
                          //           dateArchiveRow(e.newsDate),
                          //         ],
                          //       ),
                          //     ),
                          //     Row(
                          //       mainAxisAlignment: MainAxisAlignment.start,
                          //       children: [
                          //         Padding(
                          //           padding: const EdgeInsets.all(15.0),
                          //           child: Image(
                          //             alignment: Alignment.topCenter,
                          //             image: NetworkImage(Kinfolk.getFileUrl(e.image)),
                          //             width: GFSize.LARGE * 5,
                          //             height: GFSize.LARGE * 5,
                          //           ),
                          //         ),
                          //         Container(
                          //           alignment: Alignment.topCenter,
                          //           child: Scrollbar(
                          //             child: SingleChildScrollView(
                          //               child: Text(
                          //                 e.text,
                          //                 style: namingStyle,
                          //               ),
                          //             ),
                          //           ),
                          //           height: GFSize.LARGE * 5,
                          //           width: GFSize.LARGE * 7,
                          //         ),
                          //       ],
                          //     ),
                          //   ],
                          // ),
                          //
                        ),
                      );
                    }).toList()
                  ],
                );
              })),
        ),
      );
    });
  }
}

class NewsDetailsPageView extends StatelessWidget {
  final DateTime newsDate;
  final String image;
  final String text;
  final String type;

  NewsDetailsPageView(
    this.newsDate,
    this.image,
    this.text,
    this.type,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              S().news,
              style: generalFontStyle.copyWith(fontSize: defaultFontSize + 5),
            ),
          ),
          centerTitle: true,
        ),
        body: NewsDetails(newsDate, image, text, type));
  }
}

// детализация новости
class NewsDetails extends StatelessWidget {
  final DateTime newsDate;
  final String image;
  final String text;
  final String type;

  NewsDetails(
    this.newsDate,
    this.image,
    this.text,
    this.type,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0),
          child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.2,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/img.png')),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 5.0),
                  child: Text(
                    formatNamedDate(newsDate),
                    style: generalFontStyle.copyWith(
                        fontSize: defaultFontSize, color: appBlackColor),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: Container(
                    child: Text(
                      text,
                      style: generalFontStyle.copyWith(
                          fontSize: defaultFontSize - 2,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.0,
                )
              ]),
        ),
      ),
    );
  }
}

Row dateRow(DateTime newsDate) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        child: Row(
          children: [
            Icon(FontAwesomeIcons.calendar, color: hexToColor('#FB9764')),
            SizedBox(
              width: 30,
            ),
            Text(
              formatOnlyDate(newsDate),
              style: namingStyle,
            ),
          ],
        ),
      ),
    ],
  );
}

Row dateArchiveRow(DateTime newsDate) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        child: Row(
          children: [
            Icon(FontAwesomeIcons.calendar, color: hexToColor('#FB9764')),
            SizedBox(
              width: 30,
            ),
            Text(
              formatOnlyDate(newsDate),
              style: namingStyle,
            ),
          ],
        ),
      ),
    ],
  );
}
