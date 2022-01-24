import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:hse/core/model/util_models.dart';
import 'package:hse/core/utils/UI_Helpers.dart';
import 'package:hse/core/utils/globals.dart';
import 'package:hse/pageviews/bsa/widgets/bsa_item.dart';
import 'package:hse/pageviews/ticket/widgets/content_tile.dart';
import 'package:hse/pageviews/ticket/widgets/event_item.dart';
import 'package:hse/viewmodels/bpm_models/bsa_model.dart';
import 'package:hse/viewmodels/bpm_models/ticket_model.dart';
import 'package:hse/viewmodels/user_info.dart';

class TicketHistory extends StatefulWidget {
  final TicketModel ticketModel;
  final UserInfoModel userModel;

  const TicketHistory(this.ticketModel, this.userModel);

  @override
  _TicketHistoryState createState() => _TicketHistoryState();
}

class _TicketHistoryState extends State<TicketHistory> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Scrollbar(
          child: ListView.separated(
              itemBuilder: (_, i) => InkWell(
                    child: EventItem(widget.ticketModel.histories[i]),
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          elevation: 0.6,
                          // isDismissible: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                          ),
                          backgroundColor: Colors.white,
                          builder: (context) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Stack(
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 16),
                                        child: Text(
                                          'Информация',
                                          style: generalFontStyle.copyWith(
                                              fontSize:
                                                  defaultAccordionTitleFontSize,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      ContentTile(
                                          title: 'Номер талона',
                                          content:
                                              '${widget.ticketModel.histories[i].ticketNumber + ", "}',
                                          type: widget
                                              .ticketModel.histories[i].type),
                                      ContentTile(
                                        title: 'Документ основания',
                                        content:
                                            '${widget.ticketModel.histories[i].incident}',
                                      ),
                                      ContentTile(
                                        title: 'Дата выдачи',
                                        content: formatFullRestNotMilSec(widget
                                            .ticketModel
                                            .histories[i]
                                            .actionDate),
                                      ),
                                      ContentTile(
                                          title: 'Кто выдал',
                                          content: widget
                                                  .ticketModel
                                                  .histories[i]
                                                  ?.issuedBy
                                                  ?.fullName ??
                                              ''),
                                    ],
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 0,
                                    child: IconButton(
                                      icon: Icon(Icons.close),
                                      onPressed: () => Get.back(),
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                      // showDialog(
                      //     context: context,
                      //     barrierColor: Colors.black38.withOpacity(0.7),
                      //     builder: (context) {
                      //       return AlertDialog(
                      //         contentPadding: EdgeInsets.zero,
                      //         title: Text(
                      //           'Информация',
                      //           style: generalFontStyle.copyWith(
                      //               fontSize: defaultAccordionTitleFontSize),
                      //         ),
                      //         insetPadding:
                      //             EdgeInsets.symmetric(horizontal: 16),
                      //         content: Column(
                      //           children: [
                      //             ContentTile(
                      //                 title: 'Номер талона',
                      //                 content:
                      //                     '${widget.ticketModel.histories[i].ticketNumber + ", "}',
                      //                 type:
                      //                     widget.ticketModel.histories[i].type),
                      //             ContentTile(
                      //               title: 'Документ основания',
                      //               content:
                      //                   '${widget.ticketModel.histories[i].incident}',
                      //             ),
                      //             ContentTile(
                      //               title: 'Дата выдачи',
                      //               content: formatFullRestNotMilSec(widget
                      //                   .ticketModel.histories[i].actionDate),
                      //             ),
                      //             ContentTile(
                      //                 title: 'Кто выдал',
                      //                 content: widget.ticketModel.histories[i]
                      //                     .issuedBy.fullName),
                      //           ],
                      //         ),
                      //       );
                      //     });
                      // await widget.ticketModel
                      //     .openEntity(widget.ticketModel.entities[i])
                      //     .then((_) => setState(() {
                      //   print('back2');
                      // }));
                    },
                  ),
              separatorBuilder: (context, index) {
                return Divider(height: 1);
              },
              itemCount: widget.ticketModel?.histories?.length ?? 0),
        )),
      ],
    );
  }
}
