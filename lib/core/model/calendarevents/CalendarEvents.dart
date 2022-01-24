// To parse this JSON data, do
//
//     final calendarEvents = calendarEventsFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:hse/core/model/calendarevents/Event.dart';
import 'package:intl/intl.dart' show DateFormat;

part 'CalendarEvents.g.dart';

@HiveType(typeId: 4)
class CalendarEvents {
  @HiveField(0)
  String id;
  @HiveField(1)
  DateTime date;
  @HiveField(2)
  List<Event> events;

  CalendarEvents({this.date, this.events, this.id});

  fromJson(String str) => CalendarEvents.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CalendarEvents.fromMap(Map<String, dynamic> json) => CalendarEvents(
        id: json["date"] == null
            ? null
            : DateFormat("dd.MM.yyyy").format(DateTime.parse(json["date"])),
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        events: json["events"] == null
            ? []
            : List<Event>.from(json["events"].map((x) => Event.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "date": date == null ? null : date.toIso8601String(),
        "events": events == null
            ? []
            : List<dynamic>.from(events.map((x) => x.toMap())),
      };
}
