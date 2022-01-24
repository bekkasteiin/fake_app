import 'dart:io';
import 'package:get/get.dart';
import 'package:hse/core/model/event/events.dart';
import 'package:hse/core/model/message/message_dictionary.dart';
import 'package:hse/core/service/local/group_by.dart';
import 'package:hse/core/service/rest_services.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/pageviews/event/forms/event_form_edit.dart';
import 'package:hse/pageviews/event/forms/event_form_view.dart';
import 'package:hse/pageviews/event/widgets/event_result_status.dart';
import 'package:hse/viewmodels/user_info.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'abstracn_bpm_model.dart';

class EventModel extends AbstractBpmModel<EventManagement> {
  CalendarController controller;
  List<AbstractDictionary> sevirity;
  List<SupportDoc> supportDoc;
  Map<DateTime, List<EventManagement>> risksEvents = {};

  @override
  Future<List<EventManagement>> getEntities() async {
    entities = await RestServices.getEventList();
    entities.sort((a, b) => b.initDate.microsecondsSinceEpoch
        .compareTo(a.initDate.microsecondsSinceEpoch));
    //Группировка по дата инитиализация
    risksEvents = groupBy(entities, (risk) => getTime(risk.initDate));
    return entities;
  }

  Future<Map<DateTime, List<EventManagement>>> get events async {
    if (entities == null) {
      await getEntities();
    }
    risksEvents.putIfAbsent(
        DateTime.now().add(Duration(days: 1)), () => entities);
    return risksEvents;
  }

  @override
  Future createEntity() async {
    entity = EventManagement();
    entity.id = null;
    entity.initDate = DateTime.now();
    entity.files = [];
    await Get.to(ChangeNotifierProvider.value(
      value: this,
      child: EventFormEdit(),
    ));
  }

  Future getDictionaries({bool withLocal = false, bool isBusy = true}) async {
    if (!isBusy) {
      setBusy(true, true);
    }
    await getSevirity(isBusy: isBusy);
    await getSupportDoc(isBusy: isBusy);
    if (!isBusy) {
      setBusy(false, true);
    }
  }

  Future<List<AbstractDictionary>> getSevirity({bool isBusy}) async {
    sevirity = await RestServices.getSevirity(isBusy);
    return sevirity;
  }

  Future<List<SupportDoc>> getSupportDoc({bool isBusy}) async {
    supportDoc = await RestServices.getSupportDoc(isBusy);
    return supportDoc;
  }

  @override
  Future saveEntity({bool update}) async {
    var check = await validateRequiredFields();
    if (!check) {
      return;
    }
    setBusy(true, true);
    var result = await RestServices.createEvent(entity, update);
    setBusy(false, true);
    if (result == null) {
      await Get.to(EventResultStatus(this, false));
    } else if (result) {
      await Get.to(EventResultStatus(this, result));
    } else {
      Get.snackbar('Серверные ошибки', 'обратитесь к администратору');
    }
  }

  @override
  Future<void> openEntity(EventManagement behavior) async {
    entity = behavior;
    if (entity.id != null) {
      await Get.to(ChangeNotifierProvider.value(
        value: this,
        child: EventFormView(),
      ));
    } else {
      await Get.to(ChangeNotifierProvider.value(
        value: this,
        child: EventFormEdit(update: true),
      ));
    }
  }

  //Сохранение файла
  Future saveFile(File picker) async {
    setBusy(true, true);
    var result = await await RestServices.saveFile(file: picker);
    entity.files.add(result);
    setBusy(false, true);
  }


  @override
  Future<bool> validateRequiredFields() async {
    // if (entity.organization == null) {
    //   Get.snackbar(S.current.attention, 'Укажите организацию');
    //   return false;
    // } else if (entity.department == null) {
    //   Get.snackbar(S.current.attention, 'Укажите департамент');
    //   return false;
    // } else if (entity.objectName == null) {
    //   Get.snackbar(S.current.attention, 'Выберите объект');
    //   return false;
    // } else if (entity.actionType == null) {
    //   Get.snackbar(S.current.attention, 'Выберите вид выполняемой работы');
    //   return false;
    // } else if (entity.dangerousCategory == null) {
    //   Get.snackbar(S.current.attention, 'Выберите категорию источника опасности');
    //   return false;
    // } else if (entity.dangerousSource == null) {
    //   Get.snackbar(S.current.attention, 'Выберите источник опасности');
    //   return false;
    // } else if (entity.consequences == null) {
    //   Get.snackbar(S.current.attention, 'Выберите оценку последствий риска');
    //   return false;
    // } else if (entity.probability == null) {
    //   Get.snackbar(S.current.attention, 'Выберите оценку вероятности');
    //   return false;
    // } else if (entity.riskManageability == null || entity.riskManageability.isEmpty) {
    //   Get.snackbar(S.current.attention, 'Добавьте управляемость риска');
    //   return false;
    // } else if (entity.files == null || entity.files.isEmpty) {
    //   Get.snackbar(S.current.attention, 'Прикрепите файл');
    //   return false;
    // }
    return true;
  }

  Future synchronize(UserInfoModel userModel) async {
    setBusy(true, true);
    await RestServices.synchronizeEvent().then((value) async {
      if (value == null) {
        setBusy(false, true);
        Get.snackbar(S.current.attention, 'Нет интернета');
        return;
      } else if (value is String) {
        setBusy(false, true);
        Get.snackbar(S.current.attention, value);
      } else if (value) {
        await getEntities();
        await getDictionaries(isBusy: true);
        setBusy(false, true);
        Get.snackbar(S.current.attention, 'Мероприятие успешно синхронизировано');
        //choose getOrg or cancel
        // await RestServices.getOrganization(true).then((value) {
        //   print('getOrg');
        //   userModel.organization = value.first;
        // });
        // await userModel.organizations;
      } else if (!value) {
        setBusy(false, true);
        Get.snackbar(S.current.error, 'Мероприятие несинхронизировано');
      }
    });
    setBusy(false, false);
  }

  // Future cancelEvent(String id, [bool toBack = false]) async {
  //   setBusy(true, true);
  //   var result = await RestServices.cancelRisk(id);
  //   if (result == null) {
  //     setBusy(false, true);
  //     Get.snackbar(S.current.attention, 'Нету интернета');
  //   }
  //   if (result) {
  //     await getEntities();
  //   }
  //   setBusy(false, true);
  //   if (toBack) {
  //     Get.back();
  //   }
  //   Get.snackbar(S.current.attention, 'Мероприятие успешно отменено');
  // }


  Future delete() async {
    await entity.delete();
    await getEntities();
    Get.back();
    Get.snackbar(S.current.attention, 'Мероприятие успешно удалено');
  }
}