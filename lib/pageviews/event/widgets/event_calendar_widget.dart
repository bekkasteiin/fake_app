import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:intl/intl.dart';
import 'package:hse/generated/l10n.dart';
import 'event_custom_calendar.dart';

class CalendarPopupView extends StatefulWidget {
  CalendarPopupView(
      {Key key,
      this.initialStartDate,
      this.initialEndDate,
      this.onApplyClick,
      this.onCancelClick,
      this.barrierDismissible = true,
      this.minimumDate,
      this.maximumDate,
      Locale locale})
      : super(key: key);

  final DateTime minimumDate;
  final DateTime maximumDate;
  final bool barrierDismissible;
  final DateTime initialStartDate;
  final DateTime initialEndDate;
  final Function(DateTime, DateTime) onApplyClick;
  final Function onCancelClick;
  @override
  _CalendarPopupViewState createState() => _CalendarPopupViewState();
}

class _CalendarPopupViewState extends State<CalendarPopupView>
    with TickerProviderStateMixin {
  DateTime startDate;
  DateTime endDate;

  @override
  void initState() {
    if (widget.initialStartDate != null) {
      startDate = widget.initialStartDate;
    }
    if (widget.initialEndDate != null) {
      endDate = widget.initialEndDate;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                color: appWhiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 5.0),
                    height: 5.0,
                    width: 140.0,
                    decoration: BoxDecoration(
                      color: appDarkBlueColor,
                      borderRadius: BorderRadius.circular(333.0),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: Text(
                      'Выберите пероид',
                      style: generalFontStyle.copyWith(color: appDarkBlueColor, fontSize: defaultFontSize, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          startDate != null
                              ? DateFormat('dd.MM.yyyy')
                                  .format(startDate)
                                  .toString()
                              : '--/--',
                          style: generalFontStyle.copyWith(color: appBlueColor, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Text(
                        ' - ',
                        style: generalFontStyle.copyWith(color: appBlueColor, fontWeight: FontWeight.w700)),
                      Text(
                        endDate != null
                            ? DateFormat('dd.MM.yyyy')
                                .format(endDate)
                                .toString()
                            : '--/--',
                        style: generalFontStyle.copyWith(color: appBlueColor, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  Container(height: 1, color: appDarkBlueColor),
                  CustomCalendarView(
                    minimumDate: widget.minimumDate,
                    maximumDate: widget.maximumDate,
                    initialEndDate: widget.initialEndDate,
                    initialStartDate: widget.initialStartDate,
                    startEndDateChange:
                        (DateTime startDateData, DateTime endDateData) {
                      setState(() {
                        startDate = startDateData;
                        endDate = endDateData;
                      });
                    },
                  ),
                  Container(height: 1, color: appDarkBlueColor),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      padding: EdgeInsets.symmetric(
                          horizontal: 60.0, vertical: 15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11.0),
                      ),
                      color: appWhiteColor,
                      onPressed: () {
                        try {
                          widget.onApplyClick(startDate, endDate);
                          Navigator.pop(context);
                        } catch (_) {}
                      },
                      child: Text(
                        S.current.confirm,
                        textAlign: TextAlign.center,
                        style: generalFontStyle.copyWith(color: appBlueColor, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
            Container(
              color: appWhiteColor,
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }
}
