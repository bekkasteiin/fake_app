import 'package:flutter/material.dart';
import 'package:hse/pageviews/ppe/calendar_events/calendar_widget.dart';
import 'package:hse/viewmodels/calendar_model.dart';
import 'package:provider/provider.dart';

class CalendarEventsPage extends StatelessWidget {
  final bool isInspect;
  final String barcode;

  const CalendarEventsPage({Key key, this.isInspect, this.barcode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CalendarModel()),
        ],
        child: Consumer<CalendarModel>(builder: (context, events, _) {
          return CalendarEventsWidget(
            barcode: barcode,
            isInspect: isInspect,
          );
        }));
  }
}
