import 'dart:io';
import 'package:get/get.dart';
import 'package:hse/core/model/message/condition_category.dart';
import 'package:hse/core/model/message/message.dart';
import 'package:hse/core/model/message/message_dictionary.dart';
import 'package:hse/core/service/local/group_by.dart';
import 'package:hse/core/service/rest_services.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/pageviews/message/forms/message_form_edit.dart';
import 'package:hse/pageviews/message/forms/message_form_view.dart';
import 'package:hse/pageviews/message/widgets/message_result_status.dart';
import 'package:provider/provider.dart';
import '../user_info.dart';
import 'abstracn_bpm_model.dart';

class MessageModel extends AbstractBpmModel<Message> {
  List<ConditionCategory> conditionCategoryList;
  List<AbstractDictionary> dangerousActionList;
  List<AbstractDictionary> takenActionList;
  List<AbstractDictionary> categoryList;

  Map<DateTime, List<Message>> messageEvents = {};
  bool loaded = false;

  @override
  Future getEntities() async {
    entities = await RestServices.getMessages();
    // Sort the list by datetime property
    entities.sort((a, b) => b.initDateTime.microsecondsSinceEpoch
        .compareTo(a.initDateTime.microsecondsSinceEpoch));
    //Группировка по дата инитиализация
    messageEvents = groupBy(entities, (msg) => getTime(msg.initDateTime));
    return entities;
  }

  Future<Map<DateTime, List<Message>>> get events async {
    if (entities == null) {
      await getEntities();
    }
    return messageEvents;
  }

  @override
  Future createEntity() async {
    entity = Message();
    entity.dangerousActions = [];
    entity.files = [];
    entity.dangerousConditionCategories = [];
    entity.violatedEmployees = [];
    entity.initDateTime = DateTime.now();
    entity.initiatorPrivacy = false;
    entity.status = AbstractDictionary(code: ' ');
    entity.requestNumber = ' ';
    await Get.to(ChangeNotifierProvider.value(
      value: this,
      child: MessageFormEdit(),
    ));
  }

  Future getDictionaries({bool withLocal = false, bool isBusy = true}) async {
    // if (isBusy) {
    //   setBusy(true, true);
    // }
    await conditionCategory(withLocal: withLocal);
    await dangerousActions(withLocal: withLocal);
    // await statuses;
    await takenActions(withLocal: withLocal);
    await categories(withLocal: withLocal);
    // if (isBusy) {
    //   setBusy(false, true);
    // }
  }

  Future<List<ConditionCategory>> conditionCategory({bool withLocal}) async {
    conditionCategoryList = await RestServices.getConditionCategory(withLocal);
    return conditionCategoryList;
  }

  Future<List<AbstractDictionary>> dangerousActions({bool withLocal}) async {
    dangerousActionList = await RestServices.getDangerousActions(withLocal);
    return dangerousActionList;
  }

  Future<List<AbstractDictionary>> takenActions({bool withLocal}) async {
    takenActionList = await RestServices.getTakenActions(withLocal);
    return takenActionList;
  }

  Future<List<AbstractDictionary>> categories({bool withLocal}) async {
    categoryList = await RestServices.getDicMessageCategories(withLocal);
    return categoryList;
  }

  @override
  Future saveEntity({bool update}) async {
    var check = await validateRequiredFields();
    if (!check) {
      //ошибка
      return;
    }

    setBusy(true, true);

    var result = await RestServices.createMessage(entity, update);
    setBusy(false, true);
    if (result == null) {
      await Get.to(MessageResultStatus(this, false));
    } else if (result) {
      await Get.to(MessageResultStatus(this, result));
    } else {
      Get.snackbar('Серверные ошибки', 'обратитесь к администратору');
    }
  }

  @override
  Future<void> openEntity(Message message) async {
    entity = message;
    if (entity.id != null) {
      await Get.to(ChangeNotifierProvider.value(
        value: this,
        child: MessageFormView(),
      ));
    } else {
      await Get.to(ChangeNotifierProvider.value(
        value: this,
        child: MessageFormEdit(
          update: true,
        ),
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
    if (entity.objectName == null) {
      Get.snackbar(S.current.attention, 'Выберите обьект');
      return false;
    }
    if (entity.category == null) {
      Get.snackbar(S.current.attention, 'Выберите категорию');
      return false;
    }

    if (entity.category.code == 'DC') {
      if (entity.dangerousConditionCategories.isEmpty) {
        Get.snackbar(S.current.attention, 'Выберите пасные условия');
        return false;
      }
    } else if (entity.category.code == 'DA') {
      if (entity.violatedEmployees.isEmpty) {
        Get.snackbar(S.current.attention, 'Добавьте ФИО нарушителя(ей)');
        return false;
      }
      if (entity.dangerousActions.isEmpty) {
        Get.snackbar(S.current.attention, 'Выберите пасные действия');
        return false;
      }
    } else {
      if (entity.otherViolationComment == null &&
          entity.otherViolationComment.isEmpty) {
        Get.snackbar(S.current.attention, 'Напишите, что было выявлено');
        return false;
      }
    }

    if (entity.takenAction == null) {
      Get.snackbar(S.current.attention, 'Выберите предпринятые действия');
      return false;
    }

    if (entity.files == null || entity.files.isEmpty) {
      Get.snackbar(S.current.attention, 'Фотофиксация обязвательно');
      return false;
    }
    return true;
  }

  Future synchronize(UserInfoModel userModel) async {
    setBusy(true, true);
    await RestServices.synchronizeMessages().then((value) async {
      print('value: $value');
      if (value == null) {
        setBusy(false, true);
        Get.snackbar(S.current.attention, 'Нет интернета');
        return;
      } else if (value is String) {
        setBusy(false, true);
        Get.snackbar(S.current.attention, value);
      } else if (value) {
        await getEntities();
        await getDictionaries(isBusy: false);
        setBusy(false, true);
        Get.snackbar(S.current.attention, 'Сообщения успешно синхронизированы');
        //choose getOrg or cancel
        // await RestServices.getOrganization(true).then((value) {
        //   print('getOrg');
        //   userModel.organization = value.first;
        // });
        // await usermodel.organizations;
      } else if (!value) {
        setBusy(false, true);
        Get.snackbar(S.current.error, 'Сообщения несинхронизированы');
      }
    });
    // setBusy(false, true);
  }

  Future cancelMessage(String id, [bool toBack = false]) async {
    setBusy(true, true);
    var result = await RestServices.cancelMessage(id);
    if (result == null) {
      setBusy(false, true);
      Get.snackbar(S.current.attention, 'Нет интернет');
    }
    if (result) {
      await getEntities();
    }
    setBusy(false, true);
    if (toBack) {
      Get.back();
    }
    Get.snackbar(S.current.attention, 'Сообщение успешно отменено');
  }

  Future delete() async {
    await entity.delete();
    await getEntities();
    Get.back();
    Get.snackbar(S.current.attention, 'Сообщения успешно удалено');
  }
}
