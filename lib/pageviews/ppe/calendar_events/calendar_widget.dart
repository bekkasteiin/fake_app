import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getflutter/getflutter.dart';
import 'package:hse/core/model/calendarevents/Event.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/viewmodels/calendar_model.dart';
import 'package:hse/viewmodels/ppe_model.dart';
import 'package:hse/viewmodels/user_info.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../core/utils/UI_Helpers.dart';

class CalendarEventsWidget extends StatelessWidget {
  final CalendarController _calendarController = CalendarController();
  final bool isInspect;
  final String barcode;

  CalendarEventsWidget({this.isInspect, this.barcode});

  @override
  Widget build(BuildContext context) {
    final calendar = Provider.of<CalendarModel>(context);
    final counter = Provider.of<UserInfoModel>(context);
    final ppeModel = Provider.of<PpeViewModel>(context);
    try {
      calendar.controller = _calendarController;
    } catch (e) {}
    return FutureProvider<Map<DateTime, List<Event>>>(
        create: (BuildContext context) => isInspect ?? false
            ? calendar.eventsInspect(barcode)
            : calendar.events,
        initialData: null,
        child:
            Consumer<Map<DateTime, List<Event>>>(builder: (context, model, _) {
          if (model == null) {
            return Container(
              child: GFLoader(
                type: GFLoaderType.ios,
              ),
            );
          }
          return SingleChildScrollView(
              child: Container(
                  child: TableCalendar(
            locale: counter.localeCode,
            events: model,
            calendarController: _calendarController,
            rowHeight: 55,
            availableGestures: AvailableGestures.horizontalSwipe,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: CalendarStyle(
              weekdayStyle:
                  generalFontStyle.copyWith(fontWeight: FontWeight.w600),
              weekendStyle: generalFontStyle.copyWith(
                  fontWeight: FontWeight.w600, color: appOrangeColor),
              selectedColor: Colors.blue[400],
              todayColor: Colors.blue[200],
              markersColor: Colors.blue[700],
              outsideDaysVisible: true,
            ),
            onDaySelected: (date, events, holidays) {
              if (isDesktop(context)) {
                ppeModel.calDate = date;
                ppeModel.events = events;
                ppeModel.calIndex = '/events';
                ppeModel.setBusy(false);
                return;
              }
              Get.to(EventList(date: date, events: events.cast<Event>())
              );
            },
            daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: generalFontStyle.copyWith(color: Colors.white),
                weekendStyle: generalFontStyle.copyWith(color: Colors.white)),
            headerStyle: HeaderStyle(
                leftChevronIcon: Icon(Icons.chevron_left, color: appGreyColor),
                leftChevronPadding: EdgeInsets.only(left: 50),
                rightChevronIcon:
                    Icon(Icons.chevron_right, color: appGreyColor),
                rightChevronPadding: EdgeInsets.only(right: 50),
                titleTextStyle: generalFontStyle.copyWith(
                    color: appOrangeColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
                centerHeaderTitle: true,
                formatButtonVisible: false),
            builders: CalendarBuilders(todayDayBuilder: (context, date, _) {
              return Container(
                decoration: BoxDecoration(
                  color: appGreyColor,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: appGreyColor.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                margin: const EdgeInsets.all(2.0),
                width: 125,
                height: 150,
                child: Center(
                    child: Text(
                  '${date.day}\n' + DateFormat('EEE').format(date),
                  textAlign: TextAlign.center,
                  style: generalFontStyle.copyWith(
                      fontWeight: FontWeight.w500, color: Colors.white),
                )),
              );
            }, selectedDayBuilder: (context, date, _) {
              return Container(
                decoration: BoxDecoration(
                  color: appBlueColor,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: appBlueColor.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                margin: const EdgeInsets.all(2.0),
                width: 125,
                height: 150,
                child: Center(
                    child: Text(
                  '${date.day}\n' + DateFormat('EEE').format(date),
                  textAlign: TextAlign.center,
                  style: generalFontStyle.copyWith(
                      fontWeight: FontWeight.w500, color: Colors.white),
                )),
              );
            }),
          )));
        }));
  }
}

class EventList extends StatelessWidget {
  final DateTime date;
  final List<Event> events;

  const EventList({Key key, this.date, this.events}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var list = events.map((e) => buildContainer(e, context)).toList();
    var desktop = isDesktop(context);
    return Scaffold(
        appBar: desktop
            ? null
            : AppBar(
                automaticallyImplyLeading: true,
                title: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    S().calendarOfEvents,
                    style: generalFontStyle.copyWith(
                        fontSize: defaultFontSize + 5),
                  ),
                ),
                centerTitle: true,
              ),
        body: desktop
            ? Container(
                margin: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Wrap(
                    children: list,
                  ),
                ),
              )
            : ListView(
                children: list,
              ));
  }

  Container buildContainer(Event e, BuildContext context) {
    return Container(
      constraints:
          isDesktop(context) ? BoxConstraints.tightFor(width: 350) : null,
      decoration: BoxDecoration(
        border: Border.all(color: appBlueColor),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
      child: Column(
        children: [
          GFListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  e.title ?? '_',
                  style: namingStyle,
                ),
                Text(
                  e.description ?? '_',
                  style: captionStyle,
                ),
              ],
            ),
            subTitle: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(formatOnlyDate(date) ?? '_', style: captionStyle),
            ),
          ),
        ],
      ),
    );
  }
}
