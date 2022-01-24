import 'package:flutter/material.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:hse/core/utils/globals.dart';

Widget buildEventsMarkerNum(List events) {
  return Container(
      padding: EdgeInsets.symmetric(horizontal: 3, vertical: 1),
      child: Text(
        '${events.length}',
        style: generalFontStyle.copyWith(
            fontSize: 10, color: Colors.white, height: 1.4),
      ),
      color: events.isEmpty ? Colors.white : appOrangeColor);
}

List getEventsByDay(DateTime date, Map map) {
  for (var key in map.keys) {
    if (date.year == key.year &&
        date.month == key.month &&
        date.day == key.day) {
      return map[key];
    }
  }

  return [];
}
