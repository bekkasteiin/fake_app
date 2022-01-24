import 'dart:core';

import 'package:get/get.dart';
import 'package:hse/core/model/event/event.dart';
import 'package:hse/core/model/ticket/check_person_response.dart';
import 'package:hse/core/model/ticket/ticket.dart';
import 'package:hse/core/model/ticket/ticket_history.dart';
import 'package:hse/core/service/rest_services.dart';
import 'package:hse/pageviews/ticket/widgets/event_result_status.dart';
import 'package:hse/viewmodels/bpm_models/abstracn_bpm_model.dart';

class TicketModel extends AbstractBpmModel<EventEntity> {
  int index = 1;

  // Map<DateTime, List<EventEntity>> behaviorEvents = {};
  TicketResponse myTicket;
  List<TicketHistory> histories;
  CheckPersonResponse checkPersonResponse;

  @override
  Future createEntity() async {
    entity = EventEntity();
    var eventType = EventType();
    eventType.code = 'TICKET_WITHDRAWAL_TW';
    entity.eventType = eventType;
    entity.initDate = DateTime.now();
  }

  Future<CheckPersonResponse> checkPersonByNId() async {
    setBusy(true, true);
    await Future.delayed(Duration(seconds: 1));
    if (entity.nationalId == '111111111111') {
      setBusy(false, true);
      checkPersonResponse = CheckPersonResponse(status: false);
      return checkPersonResponse;
    }
    checkPersonResponse =
        await RestServices.checkPersonByNId(int.parse(entity.nationalId));
    setBusy(false, true);
    return checkPersonResponse;
  }

  @override
  Future<List<EventEntity>> getEntities() async {
    await getMyTicket();
    entities = await RestServices.getMyEventHistory();
    return entities;
  }

  Future getMyTicketHistory() async {
    // await saveTicketHistories();
    await getMyTicket();
    histories = await RestServices.getMyTicketHistory();
    return histories;
  }

  Future saveTicketHistories() async {
    await RestServices.synchronizeTicketEvents();
  }

  Future<List<TicketHistory>> getTicketHistoryByPGId() async {
    return await RestServices.getTicketHistoryByPGId(entity.issuedTo.id);
  }

  Future<List<EventEntity>> getEventsByPGId() async {
    return await RestServices.getEventsById(entity.issuedTo.id);
  }

  Future getMyTicket() async {
    myTicket = await RestServices.getMyTicket();
  }

  @override
  Future<void> openEntity(EventEntity entity) {
    // TODO: implement openEntity
    throw UnimplementedError();
  }

  @override
  Future saveEntity() async {
    // var check = await validateRequiredFields();
    // if (!check) {
    //   //ошибка
    //   return;
    // }

    setBusy(true, true);

    var result = await RestServices.createEventForTicket(entity);
    setBusy(false, true);
    if (result == null) {
      index = 1;
      await createEntity();
      await Get.to(MessageResultStatus(true));
    } else if (result) {
      index = 1;
      await createEntity();
      await Get.to(MessageResultStatus(result));
    } else {
      Get.snackbar('Серверные ошибки', 'обратитесь к администратору');
    }
  }

  @override
  Future<bool> validateRequiredFields() {
    // TODO: implement validateRequiredFields
    throw UnimplementedError();
  }
}
