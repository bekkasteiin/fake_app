import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:hse/pageviews/home/home_page_widgets.dart';
import 'package:hse/pageviews/ppe/calendar_events/calendar_event_pageview.dart';
import 'package:hse/pageviews/ppe/calendar_events/calendar_widget.dart';
import 'package:hse/pageviews/ppe/ppe_widgets.dart';
import 'package:hse/viewmodels/ppe_model.dart';
import 'package:provider/provider.dart';

class PpeMobileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PpeViewModel>(builder: (context, counter, _) {
      return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: Padding(
              padding: isDesktop(context)
                  ? EdgeInsets.only(bottom: 0)
                  : EdgeInsets.only(bottom: 0),
              child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    S().ppe,
                    style: generalFontStyle.copyWith(
                        fontSize: defaultFontSize + 5),
                  )),
            ),
            centerTitle: true,
            actions: [buildScanButton(context)],
          ),
          bottomNavigationBar: isDesktop(context)
              ? null
              : BottomButton(
                  function: () => Get.toNamed('/ppeFullList'),
                  caption: S().fullList,
                ),
          body: SingleChildScrollView(
              child: Column(children: [
            UserProfileWindow(),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: TabView(
                  canScroll: true,
                  height: MediaQuery.of(context).size.height * 0.7,
                  tabs: [
                    Tab(
                      child: Text(
                        S().ppeList,
                        style: generalFontStyle.copyWith(
                            fontSize: defaultFontSize),
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
                    PpeList(),
                    counter.calIndex == '/calendar'
                        ? Container(
                            margin: isDesktop(context)
                                ? EdgeInsets.fromLTRB(200, 0, 200, 0)
                                : null,
                            child: CalendarEventsPage())
                        : EventList(
                            date: counter.calDate,
                            events: counter.events,
                          )
                  ]),
            )
          ])));
    });
  }
}
