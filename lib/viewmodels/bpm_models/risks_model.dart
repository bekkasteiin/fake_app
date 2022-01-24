import 'dart:io';
import 'package:get/get.dart';
import 'package:hse/core/model/message/message_dictionary.dart';
import 'package:hse/core/model/risks/risks.dart';
import 'package:hse/core/service/local/group_by.dart';
import 'package:hse/core/service/rest_services.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/pageviews/risks/forms/risks_form_edit.dart';
import 'package:hse/pageviews/risks/forms/risks_form_view.dart';
import 'package:hse/pageviews/risks/widgets/risks_result_status.dart';
import 'package:hse/viewmodels/user_info.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'abstracn_bpm_model.dart';

class RisksModel extends AbstractBpmModel<RisksManagement> {
  List<AbstractDictionary> riskManageabilities;
  List<AbstractDictionary> riskProbabilities;
  List<AbstractDictionary> riskActionType;
  List<AbstractDictionary> riskDangerousCategories;
  List<AbstractDictionary> riskDangerousSources;
  List<AbstractDictionary> riskConsequences;
  CalendarController controller;
  Map<DateTime, List<RisksManagement>> risksEvents = {};

  @override
  Future<List<RisksManagement>> getEntities() async {
    entities = await RestServices.getRisks();
    entities.sort((a, b) => b.initDate.microsecondsSinceEpoch
        .compareTo(a.initDate.microsecondsSinceEpoch));
    //Группировка по дата инитиализация
    risksEvents = groupBy(entities, (risk) => getTime(risk.initDate));
    return entities;
  }

  Future<Map<DateTime, List<RisksManagement>>> get events async {
    if (entities == null) {
      await getEntities();
    }
    risksEvents.putIfAbsent(
        DateTime.now().add(Duration(days: 1)), () => entities);
    return risksEvents;
  }

  @override
  Future createEntity() async {
    entity = RisksManagement();
    entity.id = null;
    entity.initDate = DateTime.now();
    entity.files = [];
    entity.riskManageability = [];
    await Get.to(ChangeNotifierProvider.value(
      value: this,
      child: RisksManagementFormEdit(),
    ));
  }

  Future getDictionaries({bool withLocal = true, bool isBusy = false}) async {
    // if (!isBusy) {
    //   setBusy(true, true);
    // }
    await risksManageability(isBusy: isBusy);
    await risksProbabilities(isBusy: isBusy);
    await risksActionType(isBusy: isBusy);
    await risksDangerousCategories(isBusy: isBusy);
    await risksDangerousSources(isBusy: isBusy);
    await risksConsequences(isBusy: isBusy);
    // if (!isBusy) {
    //   setBusy(false, true);
    // }
  }

  Future<List<AbstractDictionary>> risksManageability({bool isBusy}) async {
    riskManageabilities = await RestServices.getRiskManageability(isBusy);
    return riskManageabilities;
  }

  Future<List<AbstractDictionary>> risksProbabilities({bool isBusy}) async {
    riskProbabilities = await RestServices.getRiskProbabilities();
    return riskProbabilities;
  }

  Future<List<AbstractDictionary>> risksActionType({bool isBusy}) async {
    riskActionType = await RestServices.getRiskActionType(isBusy);
    return riskActionType;
  }

  Future<List<AbstractDictionary>> risksDangerousCategories({bool isBusy}) async {
    riskDangerousCategories = await RestServices.getRiskDangerousCategories(isBusy);
    return riskDangerousCategories;
  }

  Future<List<AbstractDictionary>> risksDangerousSources({bool isBusy}) async {
    riskDangerousSources = await RestServices.getRiskDangerousSources(isBusy);
    return riskDangerousSources;
  }

  Future<List<AbstractDictionary>> risksConsequences({bool isBusy}) async {
    riskConsequences = await RestServices.getRiskConsequences(isBusy);
    return riskConsequences;
  }

  @override
  Future saveEntity({bool update}) async {
    var check = await validateRequiredFields();
    if (!check) {
      return;
    }
    setBusy(true, true);
    var result = await RestServices.createRisk(entity, update);
    setBusy(false, true);
    if (result == null) {
      await Get.to(RisksResultStatus(this, false));
    } else if (result) {
      await Get.to(RisksResultStatus(this, result));
    } else {
      Get.snackbar('Серверные ошибки', 'обратитесь к администратору');
    }
  }

  @override
  Future<void> openEntity(RisksManagement behavior) async {
    entity = behavior;
    if (entity.id != null) {
      await Get.to(ChangeNotifierProvider.value(
        value: this,
        child: RisksManagementFormView(),
      ));
    } else {
      await Get.to(ChangeNotifierProvider.value(
        value: this,
        child: RisksManagementFormEdit(update: true),
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
    if (entity.organization == null) {
      Get.snackbar(S.current.attention, 'Укажите организацию');
      return false;
    } else if (entity.department == null) {
      Get.snackbar(S.current.attention, 'Укажите департамент');
      return false;
    } else if (entity.objectName == null) {
      Get.snackbar(S.current.attention, 'Выберите объект');
      return false;
    } else if (entity.actionType == null) {
      Get.snackbar(S.current.attention, 'Выберите вид выполняемой работы');
      return false;
    } else if (entity.dangerousCategory == null) {
      Get.snackbar(S.current.attention, 'Выберите категорию источника опасности');
      return false;
    } else if (entity.dangerousSource == null) {
      Get.snackbar(S.current.attention, 'Выберите источник опасности');
      return false;
    } else if (entity.consequences == null) {
      Get.snackbar(S.current.attention, 'Выберите оценку последствий риска');
      return false;
    } else if (entity.probability == null) {
      Get.snackbar(S.current.attention, 'Выберите оценку вероятности');
      return false;
    } else if (entity.riskManageability == null || entity.riskManageability.isEmpty) {
      Get.snackbar(S.current.attention, 'Добавьте управляемость риска');
      return false;
    } else if (entity.files == null || entity.files.isEmpty) {
      Get.snackbar(S.current.attention, 'Прикрепите файл');
      return false;
    }
    return true;
  }

  Future synchronize(UserInfoModel userModel) async {
    setBusy(true, true);
    await RestServices.synchronizeRisks().then((value) async {
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
        Get.snackbar(S.current.attention, 'Оценка успешно синхронизирована');
        //choose getOrg or cancel
        // await RestServices.getOrganization(true).then((value) {
        //   print('getOrg');
        //   userModel.organization = value.first;
        // });
        // await userModel.organizations;
      } else if (!value) {
        setBusy(false, true);
        Get.snackbar(S.current.error, 'Оценка несинхронизирована');
      }
    });
     setBusy(false, false);
  }

  Future cancelRisk(String id, [bool toBack = false]) async {
    setBusy(true, true);
    var result = await RestServices.cancelRisk(id);
    if (result == null) {
      setBusy(false, true);
      Get.snackbar(S.current.attention, 'Нету интернета');
    }
    if (result) {
      await getEntities();
    }
    setBusy(false, true);
    if (toBack) {
      Get.back();
    }
    Get.snackbar(S.current.attention, 'Оценка успешно отменено');
  }


  Future delete() async {
    await entity.delete();
    await getEntities();
    Get.back();
    Get.snackbar(S.current.attention, 'Оценка успешно удалено');
  }
}
