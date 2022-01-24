import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getflutter/components/accordian/gf_accordian.dart';
import 'package:getflutter/components/loader/gf_loader.dart';
import 'package:getflutter/getflutter.dart';
import 'package:hse/core/model/anthropometry/Anthropometry.dart';
import 'package:hse/core/model/assignment/Assignment.dart';
import 'package:hse/core/model/assignment/Rating.dart';
import 'package:hse/core/model/placement/Placement.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/pageviews/home/home_page_widgets.dart';
import 'package:hse/viewmodels/profile_model.dart';
import 'package:hse/viewmodels/user_info.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/user_info.dart';
import '../../core/utils/UI_Helpers.dart';

//назначение заголовок в профиле Сотрудника
class AssignmentCard extends StatelessWidget {
  const AssignmentCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<UserInfoModel>(context);
    return Container(
      margin: kIsWeb
          ? EdgeInsets.fromLTRB(100, 20, 100, 5)
          : EdgeInsets.fromLTRB(0, 10, 0, 10),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: appBlueColor, width: 0.2))),
      child: GFAccordion(
        contentbackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        collapsedTitlebackgroundColor:
            Theme.of(context).scaffoldBackgroundColor,
        collapsedIcon: Icon(
          FontAwesomeIcons.chevronRight,
          color: appBlueColor,
          size: GFSize.SMALL * 0.6,
        ),
        expandedIcon: Icon(
          FontAwesomeIcons.chevronUp,
          color: appBlueColor,
          size: GFSize.SMALL * 0.6,
        ),
        textStyle: generalFontStyle.copyWith(
            color: appBlueColor,
            fontWeight: FontWeight.normal,
            fontSize: defaultAccordionTitleFontSize),
        title: S().assignment,
        titlePadding: kIsWeb
            ? EdgeInsets.fromLTRB(10, 0, 10, 10)
            : EdgeInsets.fromLTRB(5, 0, 5, 10),
        contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 10),
        expandedTitlebackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        contentChild: buildFutureProvider(counter),
      ),
    );
  }

  //назначение контект в профиле Сотрудника
  FutureProvider<Assignment> buildFutureProvider(UserInfoModel counter) {
    return FutureProvider<Assignment>(
        create: (BuildContext context) => counter.assignment(),
        initialData: null,
        child: Consumer<Assignment>(builder: (context, model, _) {
          var isLoading = model == null;
          const edgeInsets = EdgeInsets.fromLTRB(10, 10, 0, 10);
          return isLoading
              ? GFLoader(
                  type: GFLoaderType.ios,
                )
              : Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: edgeInsets,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${S().employer}:',
                              style: captionStyle,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              model.organization.organizationName,
                              style: namingStyle,
                            ),
                          ]),
                    ),
                    Padding(
                      padding: edgeInsets,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${S().aDocumentBase}:',
                              style: captionStyle,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              model.orderNumber,
                              style: namingStyle,
                            ),
                          ]),
                    ),
                    Padding(
                      padding: edgeInsets,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${S().post}:',
                              style: captionStyle,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              model.job.jobName,
                              style: namingStyle,
                            ),
                          ]),
                    ),
                    Padding(
                      padding: edgeInsets,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${S().department}:',
                              style: captionStyle,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              model.department.departmentName,
                              style: namingStyle,
                            ),
                          ]),
                    ),
                  ],
                );
        }));
  }
}

//антропометрия заголовок в профиле Сотрудника
class AnthropometryCard extends StatelessWidget {
  const AnthropometryCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<Profile>(context);
    // if (isDesktop(context)) {
    //   return buildFutureProvider(counter);
    // }
    return Container(
      margin: kIsWeb
          ? EdgeInsets.fromLTRB(100, 20, 100, 5)
          : EdgeInsets.fromLTRB(0, 10, 0, 10),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: appBlueColor, width: 0.2))),
      child: GFAccordion(
        contentbackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        collapsedTitlebackgroundColor:
            Theme.of(context).scaffoldBackgroundColor,
        collapsedIcon: Icon(
          FontAwesomeIcons.chevronRight,
          color: appBlueColor,
          size: GFSize.SMALL * 0.6,
        ),
        expandedIcon: Icon(
          FontAwesomeIcons.chevronUp,
          color: appBlueColor,
          size: GFSize.SMALL * 0.6,
        ),
        title: S().anthropometry,
        textStyle: generalFontStyle.copyWith(
            color: appBlueColor,
            fontWeight: FontWeight.normal,
            fontSize: defaultAccordionTitleFontSize),
        titlePadding: kIsWeb
            ? EdgeInsets.fromLTRB(10, 0, 10, 10)
            : EdgeInsets.fromLTRB(5, 0, 5, 10),
        contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 10),
        expandedTitlebackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        contentChild: buildFutureProvider(counter),
      ),
    );
  }

  FutureProvider<Anthropometry> buildFutureProvider(Profile counter) {
    return FutureProvider<Anthropometry>(
        create: (BuildContext context) => counter.anthropometry,
        initialData: null,
        child: Consumer<Anthropometry>(builder: (context, model, _) {
          var isLoading = model == null;
          return isLoading
              ? GFLoader(
                  type: GFLoaderType.ios,
                )
              : Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.all(0),
                      leading: GFImageOverlay(
                        margin: EdgeInsets.only(left: 10.0),
                        height: GFSize.SMALL,
                        width: GFSize.SMALL,
                        colorFilter: ColorFilter.mode(
                            Colors.transparent, BlendMode.color),
                        image: AssetImage('assets/images/helmet.png'),
                      ),
                      title: Text(
                        '${S().headSize}:',
                        style: captionStyle,
                      ),
                      subtitle: Text(
                        model.headSize ?? '',
                        style: namingStyle,
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.all(0),
                      leading: GFImageOverlay(
                        margin: EdgeInsets.only(left: 10.0),
                        height: GFSize.SMALL,
                        width: GFSize.SMALL,
                        colorFilter: ColorFilter.mode(
                            Colors.transparent, BlendMode.color),
                        image: AssetImage('assets/images/cloth.png'),
                      ),
                      title: Text(
                        '${S().clothingSize}:',
                        style: captionStyle,
                      ),
                      subtitle: Text(
                        model.clothingSize ?? '',
                        style: namingStyle,
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.all(0),
                      leading: GFImageOverlay(
                        margin: EdgeInsets.only(left: 10.0),
                        height: GFSize.SMALL,
                        width: GFSize.SMALL,
                        colorFilter: ColorFilter.mode(
                            Colors.transparent, BlendMode.color),
                        image: AssetImage('assets/images/shoe.png'),
                      ),
                      title: Text(
                        '${S().shoeSize}:',
                        style: captionStyle,
                      ),
                      subtitle: Text(
                        model.shoeSize ?? '',
                        style: namingStyle,
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.all(0),
                      leading: GFImageOverlay(
                        margin: EdgeInsets.only(left: 10.0),
                        height: GFSize.SMALL,
                        width: GFSize.SMALL,
                        colorFilter: ColorFilter.mode(
                            Colors.transparent, BlendMode.color),
                        image: AssetImage('assets/images/hand.png'),
                      ),
                      title: Text(
                        '${S().handSize}:',
                        style: captionStyle,
                      ),
                      subtitle: Text(
                        model.handSize ?? '',
                        style: namingStyle,
                      ),
                    )
                  ],
                );
        }));
  }
}

//антропометрия контент в профиле Сотрудника
class PlacementCard extends StatelessWidget {
  const PlacementCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<Profile>(context);
    var desktop = isDesktop(context);
    // if (desktop) {
    //   return buildFutureProvider(counter, isDesktop: desktop);
    // }
    return Container(
      margin: kIsWeb
          ? EdgeInsets.fromLTRB(100, 20, 100, 5)
          : EdgeInsets.fromLTRB(0, 10, 0, 10),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: appBlueColor, width: 0.2))),
      child: GFAccordion(
        contentbackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        collapsedTitlebackgroundColor:
            Theme.of(context).scaffoldBackgroundColor,
        collapsedIcon: Icon(
          FontAwesomeIcons.chevronRight,
          color: appBlueColor,
          size: GFSize.SMALL * 0.6,
        ),
        expandedIcon: Icon(
          FontAwesomeIcons.chevronUp,
          color: appBlueColor,
          size: GFSize.SMALL * 0.6,
        ),
        textStyle: generalFontStyle.copyWith(
            color: appBlueColor,
            fontWeight: FontWeight.normal,
            fontSize: defaultAccordionTitleFontSize),
        title: S().placement,
        contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 10),
        titlePadding: kIsWeb
            ? EdgeInsets.fromLTRB(10, 0, 10, 10)
            : EdgeInsets.fromLTRB(5, 0, 5, 10),
        expandedTitlebackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        contentChild: buildFutureProvider(counter),
      ),
    );
  }

  FutureProvider<Placement> buildFutureProvider(Profile counter,
      {isDesktop = false}) {
    return FutureProvider<Placement>(
        create: (BuildContext context) => counter.placement,
        initialData: null,
        child: Consumer<Placement>(builder: (context, model, _) {
          var isLoading = model == null;
          return isLoading
              ? GFLoader(
                  type: GFLoaderType.ios,
                )
              : Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Container(
                        constraints: BoxConstraints.tightForFinite(
                            width: kIsWeb
                                ? MediaQuery.of(context).size.width * 0.4
                                : MediaQuery.of(context).size.width * 0.4),
                        child: Column(
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              title: Text(
                                S().hotel,
                                style: captionStyle,
                              ),
                              subtitle: Text(
                                model.hotel ?? '',
                                style: namingStyle,
                              ),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              title: Text(
                                S().disposition,
                                style: captionStyle,
                              ),
                              subtitle: Text(
                                model.location ?? '',
                                style: namingStyle,
                              ),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              title: Text(
                                S().number,
                                style: captionStyle,
                              ),
                              subtitle: Text(
                                model.room ?? '',
                                style: namingStyle,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: GFSize.LARGE * 4.5,
                      margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                  color: appButtonGreyColor, width: 1))),
                    ),
                    Container(
                      constraints: BoxConstraints.tightForFinite(
                          width: MediaQuery.of(context).size.width * 0.4),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              S().dateFrom,
                              style: captionStyle,
                            ),
                            subtitle: Text(
                              formatDate(model.startDate),
                              style: namingStyle,
                            ),
                          ),
                          ListTile(
                            title: Text(
                              S().dateBy,
                              style: captionStyle,
                            ),
                            subtitle: Text(
                              formatDate(model.endDate),
                              style: namingStyle,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
        }));
  }
}

//антропометрия контент в профиле Сотрудника
class DesktopCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<Profile>(context);
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      child: Column(
        children: [
          buildGfButton(counter, '/assignment', S().assignment),
          buildGfButton(counter, '/anthropometry', S().anthropometry),
          buildGfButton(counter, '/placement', S().placement),
          buildGfButton(counter, '/rating', S().rating),
        ],
      ),
    );
  }

  Container buildGfButton(Profile counter, index, label) {
    return Container(
      margin: EdgeInsets.fromLTRB(50, 20, 50, 10),
      child: GFButton(
        blockButton: true,
        padding: EdgeInsets.all(10),
        type: GFButtonType.outline,
        color: counter.index == index ? appBlueColor : appGreyColor,
        onPressed: () {
          counter.index = index;
          counter.setBusy(false);
        },
        text: label,
      ),
    );
  }
}

//рейтинг в профиле Сотрудника
class RatingCard extends StatelessWidget {
  const RatingCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<UserInfoModel>(context);
    // if (isDesktop(context)) {
    //   return buildFutureProvider(counter);
    // }
    return Container(
      margin: kIsWeb
          ? EdgeInsets.fromLTRB(100, 20, 100, 5)
          : EdgeInsets.fromLTRB(0, 10, 0, 10),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: appBlueColor, width: 0.2))),
      child: GFAccordion(
        contentbackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        collapsedTitlebackgroundColor:
            Theme.of(context).scaffoldBackgroundColor,
        collapsedIcon: Icon(
          FontAwesomeIcons.chevronRight,
          color: appBlueColor,
          size: GFSize.SMALL * 0.6,
        ),
        expandedIcon: Icon(
          FontAwesomeIcons.chevronUp,
          color: appBlueColor,
          size: GFSize.SMALL * 0.6,
        ),
        textStyle: generalFontStyle.copyWith(
            color: appBlueColor,
            fontWeight: FontWeight.normal,
            fontSize: defaultAccordionTitleFontSize),
        title: S.of(context).rating,
        contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 10),
        titlePadding: kIsWeb
            ? EdgeInsets.fromLTRB(10, 0, 10, 10)
            : EdgeInsets.fromLTRB(5, 0, 5, 10),
        expandedTitlebackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        contentChild: buildFutureProvider(counter),
      ),
    );
  }

  FutureProvider<Assignment> buildFutureProvider(UserInfoModel counter) {
    return FutureProvider<Assignment>(
        create: (BuildContext context) => counter.assignment(),
        initialData: null,
        child: Consumer<Assignment>(builder: (context, model, _) {
          var isLoading = model == null;
          const edgeInsets = EdgeInsets.fromLTRB(15, 10, 0, 10);
          Rating rating;
          if (!isLoading) {
            rating = model.rating;
          }
          if (isLoading) {
            return GFLoader(
              type: GFLoaderType.ios,
            );
          } else {
            var percentilePojo = model.percentilePojo;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Flexible(
                        flex: 2,
                        child: Padding(
                          padding: edgeInsets,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  S.of(context).yourRating,
                                  style: captionStyle,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  model?.percentilePojo?.currentEmpRating
                                          ?.toString() ??
                                      '',
                                  style: namingStyle,
                                ),
                              ]),
                        )),
                    Spacer(
                      flex: 1,
                    ),
                    Flexible(
                        flex: 2,
                        child: Padding(
                          padding: edgeInsets,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  S.of(context).yourRank,
                                  style: captionStyle,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '${model?.percentilePojo?.currentEmpRank?.toInt() ?? 0} из ${model?.percentilePojo?.totalNumberOfScores?.toInt() ?? 0}',
                                  style: namingStyle,
                                ),
                              ]),
                        )),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                RatingProgressBar(
                  percentile: model.percentilePojo,
                  percent: (percentilePojo?.currentEmpRank?.toDouble() ?? 0.0) /
                      (percentilePojo?.totalNumberOfScores?.toDouble() ?? 0.0),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Text(
                  '    ' + S.of(context).ratingDetailsCaption,
                  style: namingStyle,
                ),
                buildPadding(edgeInsets, rating.testRating, S().dailyTesting),
                buildPadding(
                    edgeInsets, rating.wasteRating, S().damageToEmployer),
                buildPadding(
                    edgeInsets, rating.safetyRating, S().productivityRating),
                buildPadding(
                    edgeInsets, rating.safetyRating, '${S().safetyTechnique}:'),
                buildPadding(
                    edgeInsets, rating.disciplineRating, S().disciplineOfLabor),
              ],
            );
          }
        }));
  }

  Padding buildPadding(EdgeInsets edgeInsets, double rating, String caption) {
    return Padding(
      padding: edgeInsets,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          caption,
          style: captionStyle,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          rating.toStringAsFixed(1),
          style: namingStyle,
        ),
      ]),
    );
  }
}
