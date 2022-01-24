import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getflutter/getflutter.dart';
import 'package:hse/core/model/check_points/CheckPoint.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:hse/viewmodels/checkpoint_model.dart';
import 'package:provider/provider.dart';

class CheckPointMobileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var dateTextStyle = Theme.of(context).textTheme.headline6;
    return Consumer<CheckPointModel>(builder: (context, counter, _) {
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              S().admissions,
              style: generalFontStyle.copyWith(fontSize: defaultFontSize + 5),
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  // height: MediaQuery.of(context).size.height * 0.8,
                  // width: MediaQuery.of(context).size.width,
                  child: FutureProvider<List<CheckPoint>>(
                      create: (BuildContext context) => counter.checkpoints,
                      initialData: null,
                      child: Consumer<List<CheckPoint>>(
                          builder: (context, model, _) {
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
                                return buildListItem(e, context, dateTextStyle);
                              }).toList()
                            ],
                          ),
                        );
                      })),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  // формирование элементов событий вход-выход
  Container buildListItem(
      CheckPoint e, BuildContext context, TextStyle dateTextStyle) {
    return Container(
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: appBlueColor, width: 0.2))),
        child: ListTile(
          leading: Icon(
            e.direction != 'ENTRANCE'
                ? FontAwesomeIcons.signOutAlt
                : FontAwesomeIcons.signInAlt,
            color: e.direction != 'ENTRANCE' ? appRedColor : appGreenColor,
            size: GFSize.SMALL,
          ),
          title: Text(
            formatDate(e.dateAndTime),
            style: namingStyle,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              e.controlPoint,
              style: captionStyle,
            ),
          ),
          trailing: Text(e.direction != 'ENTRANCE' ? S().EXIT : S().ENTRANCE,
              style: captionStyle),
        ));
  }
}
