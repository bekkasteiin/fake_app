import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hse/core/companents/widgets/loader_widget.dart';
import 'package:hse/core/model/util_models.dart';
import 'package:hse/core/service/local/calendar/calendar_widgets.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/pageviews/bsa/widgets/bsa_item.dart';
import 'package:hse/pageviews/ticket/widgets/content_tile.dart';
import 'package:hse/viewmodels/bpm_models/bsa_model.dart';
import 'package:hse/viewmodels/bpm_models/ticket_model.dart';
import 'package:hse/viewmodels/user_info.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:provider/provider.dart';

class TicketMain extends StatefulWidget {
  final TicketModel model;

  const TicketMain(this.model);

  @override
  _TicketMainState createState() => _TicketMainState();
}

class _TicketMainState extends State<TicketMain> {
  var color;

  @override
  Widget build(BuildContext context) {
    // final userModel = Provider.of<UserInfoModel>(context);
    color = widget.model.myTicket == null || !widget.model.myTicket.status
        ? appDarkGrayColor.withOpacity(0.4)
        : widget.model.myTicket.ticket.type == 'RED'
        ? appRedColor
        : widget.model.myTicket.ticket.type == 'YELLOW'
        ? appYellowColor
        : appGreenColor;
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Center(
          child: Container(
              margin: EdgeInsets.symmetric(vertical: 32),
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 2,
              height: MediaQuery
                  .of(context)
                  .size
                  .width / 2,
              decoration:
              BoxDecoration(border: Border.all(width: 5, color: color)),
              child: widget.model.myTicket != null && widget.model.myTicket.status
                  ? InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      barrierColor: Colors.black38.withOpacity(0.7),
                      builder: (context) {
                        return AlertDialog(
                          contentPadding: EdgeInsets.zero,
                          insetPadding:
                          EdgeInsets.symmetric(horizontal: 16),
                          content: Padding(
                            padding: EdgeInsets.all(16),
                            child: Image.asset(
                              'assets/fake/qr-code.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        );
                      });
                },
                child: widget.model.myTicket.status ? Padding(
                  padding: EdgeInsets.all(8),
                  child: Image.asset(
                    'assets/fake/qr-code.png',
                    fit: BoxFit.cover,
                  ),
                ) : SizedBox(),
              )
                  : SizedBox()),
        ),
        ExpansionTile(
          expandedAlignment: Alignment.centerLeft,
          childrenPadding: EdgeInsets.symmetric(horizontal: 24),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          initiallyExpanded: true,
          title: Text(
            'Информация',
            style: generalFontStyle.copyWith(
                fontSize: defaultAccordionTitleFontSize,
                fontWeight: FontWeight.bold),
          ),
          children: [
            ContentTile(
                title: 'Номер талона',
                content: widget.model.myTicket.status
                    ?
                '${widget.model.myTicket.ticket.ticketNumber + ", "}'
                    : 'нет талона',
                type: widget.model.myTicket.status
                    ? widget.model.myTicket.ticket.type
                    : null),
            ContentTile(
              title: 'Документ основания',
              content: widget.model.myTicket.status ? '${widget.model.myTicket.ticket
                  .incident}' : '',
            ),
            ContentTile(
              title: 'Дата выдачи',
              content: widget.model.myTicket.status
                  ? formatFullRestNotMilSec(widget.model.myTicket.ticket.issuedDate)
                  : '',
            ),
            ContentTile(
              title: 'Кто выдал',
              content: widget.model.myTicket.status
                  ? '${widget.model.myTicket.ticket.issuedBy.firstName + ' ' +
                  widget.model.myTicket.ticket.issuedBy.lastName[0] + "." +
                  widget.model.myTicket.ticket.issuedBy.middleName[0] + '.'}'
                  : '',
            ),
          ],
        ),
        // Text('${widget.model.myCard?.issuedBy?.firstName ?? ''}'),
      ]),
    );

  }
}
