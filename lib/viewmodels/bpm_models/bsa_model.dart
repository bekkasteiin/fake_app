import 'dart:io';
import 'package:get/get.dart';
import 'package:hse/core/model/bsa/bsa.dart';
import 'package:hse/core/model/bsa/observation.dart';
import 'package:hse/core/model/message/message_dictionary.dart';
import 'package:hse/core/service/local/group_by.dart';
import 'package:hse/core/service/rest_services.dart';
import 'package:hse/pageviews/bsa/forms/bsa_form_edit.dart';
import 'package:hse/pageviews/bsa/forms/bsa_form_view.dart';
import 'package:hse/pageviews/bsa/forms/bsa_planed_form_edit.dart';
import 'package:hse/pageviews/bsa/widgets/bsa_result_status.dart';
import 'package:provider/provider.dart';
import '../user_info.dart';
import 'abstracn_bpm_model.dart';
import 'package:hse/generated/l10n.dart';

class BsaModel extends AbstractBpmModel<BehaviorAudit> {
  List<AbstractDictionary> observationsList;
  Map<DateTime, List<BehaviorAudit>> behaviorEvents = {};
  List<AbstractDictionary> kindSituation;
  List<AbstractDictionary> kindConsequences;
  List<AbstractDictionary> kindDanger;

  @override
  Future<List<BehaviorAudit>> getEntities() async {
    entities = await RestServices.getBehavior();
    entities.sort((a, b) =>
        b.date.microsecondsSinceEpoch.compareTo(a.date.microsecondsSinceEpoch));
    //Группировка по дата инитиализация
    behaviorEvents = groupBy(entities, (bsa) => getTime(bsa.date));
    return entities;
  }

  @override
  Future createEntity() async {
    entity = BehaviorAudit();
    entity.id = null;
    entity.date = DateTime.now();
    entity.observations = [];
    entity.files = [];
    entity.responsibles = [];
    await Get.to(ChangeNotifierProvider.value(
      value: this,
      child: BsaFormEdit(),
    ));
  }

  Future getDictionaries({bool isBusy = false}) async {
    // if (!isBusy) {
    //   setBusy(true, true);
    // }
    await observations(isBusy: isBusy);
    await kindSituations(isBusy: isBusy);
    await consequences(isBusy: isBusy);
    await danger(isList: isBusy);
    // if (!isBusy) {
    //   setBusy(false, true);
    // }
  }

  Future<List<AbstractDictionary>> observations({bool isBusy}) async {
    observationsList = await RestServices.getObservationsCategory(isBusy);
    return observationsList;
  }

  Future<List<AbstractDictionary>> kindSituations({bool isBusy}) async {
    kindSituation = await RestServices.getKindSituations(isBusy);
    return kindSituation;
  }

  Future<List<AbstractDictionary>> consequences({bool isBusy}) async {
    kindConsequences = await RestServices.getKindConsequences(isBusy);
    return kindConsequences;
  }

  Future<List<AbstractDictionary>> danger({bool isList}) async {
    kindDanger = await RestServices.getKindDanger(isList);
    return kindDanger;
  }

  @override
  Future saveEntity({bool update}) async {
    var check = await validateRequiredFields();
    if (!check) {
      return;
    }
    setBusy(true, true);
    var result = await RestServices.createBsa(entity, update);
    setBusy(false, true);

    if (result == null) {
      await Get.to(BsaResultStatus(this, false));
    } else if (result) {
      await Get.to(BsaResultStatus(this, result));
    } else {
      Get.snackbar('Серверные ошибки', 'обратитесь к администратору');
    }
  }

  @override
  Future<void> openEntity(BehaviorAudit behavior) async {
    entity = behavior;

    if (entity?.category?.code == 'PLANNED' && !entity.isDone) {
      var filled = entity.filled ?? false;
      if(!filled) {
        entity.observations = [];
      }
      await Get.to(ChangeNotifierProvider.value(
        value: this,
        child: BsaPlanedForm(
          update: true,
        ),
      ));
    } else if (entity.id != null) {
      await Get.to(ChangeNotifierProvider.value(
        value: this,
        child: BsaFormView(),
      ));
    } else {
      await Get.to(ChangeNotifierProvider.value(
        value: this,
        child: BsaFormEdit(update: true),
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

  Future<bool> validateObservation(Observation model) async {
    if (model.observationKindDanger == null ||
        model.observationKindSitutation == null ||
        model.observationSevirityConsequences == null) {
      Get.snackbar(S.current.attention, 'Заполните поля');
      return false;
    }
    return true;
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
    } else if (entity.responsibles == null || entity.responsibles.isEmpty) {
      Get.snackbar(S.current.attention, 'Добавьте аудиторов');
      return false;
    } else if (entity.duration == null) {
      Get.snackbar(S.current.attention, 'Укажите продолжительность аудита');
      return false;
    } else if (entity.observations == null || entity.observations.isEmpty) {
      Get.snackbar(S.current.attention, 'Выберите категорий');
      return false;
    } else if (entity.actionDescription == null || entity.actionDescription.isEmpty) {
      Get.snackbar(S.current.attention, 'Заполните описание корректирующего мероприятия');
      return false;
    } else if (entity.files == null || entity.files.isEmpty) {
      Get.snackbar(S.current.attention, 'Прикрепите файл');
      return false;
    }
    return true;
  }

  Future synchronize(UserInfoModel userModel) async {
    setBusy(true, true);
    await RestServices.synchronizeBehavior().then((value) async {
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
        Get.snackbar(S.current.attention, 'ПАБ успешно синхронизирован');
        //choose getOrg or cancel
        // await RestServices.getOrganization(true).then((value) {
        //   print('getOrg');
        //   userModel.organization = value.first;
        // });
        // await userModel.organizations;
      } else if (!value) {
        setBusy(false, true);
        Get.snackbar(S.current.error, 'ПАБ несинхронизирован');
      }
    });
  }

  Future cancelBsa(String id) async {
    setBusy(true, true);
    var result = await RestServices.cancelBsa(id);
    if (result == null) {
      setBusy(false, true);
      Get.snackbar(S.current.attention, 'Нету интернета');
    }
    if (result) {
      await getEntities();
    }
    setBusy(false, true);
  }

  dynamic chekObservation(AbstractDictionary category,
      [bool withEditObs = false]) {
    if (entity.observations.isEmpty) {
      return false;
    }

    for (var obs in entity.observations) {
      if (obs.observationCategory.id == category.id) {
        if (withEditObs) {
          return obs;
        } else {
          if (obs.isChecked) {
            return true;
          } else {
            return false;
          }
        }
      }
    }
    return false;
  }

  int getIndexByObservationCategory(AbstractDictionary category) {
    for (var i = 0; i < entity.observations.length; i++) {
      if (entity.observations[i].observationCategory.id == category.id) {
        return i;
      }
    }
    return null;
  }

  Future delete() async {
    await entity.delete();
    await getEntities();
    Get.back();
    Get.snackbar(S.current.attention, 'ПАБ успешно удалено');
  }
}
