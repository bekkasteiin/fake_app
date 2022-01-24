import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getflutter/getflutter.dart';
import 'package:hse/core/model/assignment/Assignment.dart';
import 'package:hse/core/model/ppe/PersonalProtectionEquipment.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/core/service/rest_services.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/layout/main_widgets.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:hse/pageviews/home/home_page_widgets.dart';
import 'package:hse/pageviews/ppe/calendar_events/calendar_event_pageview.dart';
import 'package:hse/pageviews/ppe/calendar_events/calendar_widget.dart';
import 'package:hse/pageviews/ppe/ppe_widgets.dart';
import 'package:hse/viewmodels/ppe_model.dart';
import 'package:provider/provider.dart';

class PPEScreenInspect extends StatelessWidget {
  final String barcode;

  const PPEScreenInspect({Key key, this.barcode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PpeViewModel>(builder: (context, counter, _) {
      return Scaffold(
          appBar: AppBar(
            leading: LeadingDrawerIcon(),
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                GFImageOverlay(
                  height: GFSize.SMALL,
                  width: GFSize.SMALL,
                  colorFilter:
                      ColorFilter.mode(Colors.transparent, BlendMode.color),
                  image: AssetImage('assets/images/ppe_logo.png'),
                ),
                Text(S().ppe),
              ],
            ),
            centerTitle: true,
          ),
         // drawer: AppDrawer(),
          bottomNavigationBar: isDesktop(context)
              ? null
              : BottomButton(
                  function: () => Get.to(ChangeNotifierProvider.value(
                    value: counter,
                    builder: (context, child) => buildInspectScaffold(),
                  )),
                  caption: S().fullList,
                ),
          body: SingleChildScrollView(
              child: Column(children: [
            FutureProvider<Assignment>(
                create: (BuildContext context) =>
                    RestServices.getAssignmentByPpeCode(barcode),
                initialData: null,
                child: Consumer<Assignment>(builder: (context, model, _) {
                  if (model == null) {
                    return GFLoader(
                      type: GFLoaderType.ios,
                    );
                  }
                  return UserProfileWindow(
                    assignment: model,
                    canRedirect: false,
                  );
                })),
            TabView(
                canScroll: true,
                height: MediaQuery.of(context).size.height * 0.7,
                tabs: [
                  Tab(
                    child: Text(
                      S().ppeList,
                      style:
                          generalFontStyle.copyWith(fontSize: defaultFontSize),
                    ),
                  ),
                  GestureDetector(
                    onTap: isDesktop(context)
                        ? () {
                            counter.calIndex = '/calendar';
                            counter.setBusy(false);
                          }
                        : null,
                    child: Tab(
                      child: Text(
                        S().calendarOfEvents,
                        style: generalFontStyle.copyWith(
                            fontSize: defaultFontSize),
                      ),
                    ),
                  ),
                ],
                tabBar: [
                  FutureProvider<PersonalProtectionEquipment>(
                      create: (BuildContext context) =>
                          RestServices.getPpesByPpeCode(barcode),
                      initialData: null,
                      child: Consumer<PersonalProtectionEquipment>(
                          builder: (context, model, _) {
                        if (model == null) {
                          return GFLoader(
                            type: GFLoaderType.ios,
                          );
                        }
                        return PpeEasyList(
                          isBody: false,
                          model: model,
                        );
                      })),
                  counter.calIndex == '/calendar'
                      ? Container(
                          margin: isDesktop(context)
                              ? EdgeInsets.fromLTRB(200, 0, 200, 0)
                              : null,
                          child: CalendarEventsPage(
                            isInspect: true,
                            barcode: barcode,
                          ))
                      : EventList(
                          date: counter.calDate,
                          events: counter.events,
                        )
                ])
          ])));
    });
  }

  Scaffold buildInspectScaffold() {
    return Scaffold(
      appBar: AppBar(title: Text(S().ppeList)),
      body: FutureProvider<PersonalProtectionEquipment>(
          create: (BuildContext context) =>
              RestServices.getPpesByPpeCode(barcode),
          initialData: null,
          child: Consumer<PersonalProtectionEquipment>(
              builder: (context, model, _) {
            if (model == null) {
              return GFLoader(
                type: GFLoaderType.ios,
              );
            }
            return PpeEasyList(
              isBody: true,
              model: model,
            );
          })),
    );
  }
}
