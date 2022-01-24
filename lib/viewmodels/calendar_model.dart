import 'package:hse/core/model/calendarevents/CalendarEvents.dart';
import 'package:hse/core/model/calendarevents/Event.dart';
import 'package:hse/core/service/rest_services.dart';
import 'package:hse/viewmodels/base_model.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarModel extends BaseModel {
  List<CalendarEvents> _calendarEvents;
  CalendarController controller;
  Map<DateTime, List<Event>> mapFetch = {};

  Future<Map<DateTime, List<Event>>> get events async {
    _calendarEvents ??= await RestServices.getCalendarEvents();
    mapFetch.clear();
    _calendarEvents.forEach((element) {
      mapFetch.putIfAbsent(element.date, () => element.events);
    });
    return mapFetch;
  }

  Future<Map<DateTime, List<Event>>> eventsInspect(String barcode) async {
    List<CalendarEvents> calendarEvents =
        await RestServices.getEventsByPpeCode(barcode);
    var map = <DateTime, List<Event>>{};
    calendarEvents.forEach((element) {
      map.putIfAbsent(element.date, () => element.events);
    });
    return map;
  }
}
