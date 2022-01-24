import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hse/core/model/BaseResult.dart';
import 'package:hse/core/model/anthropometry/Anthropometry.dart';
import 'package:hse/core/model/appeals/appeals.dart';
import 'package:hse/core/model/appeals/appel_topic.dart';
import 'package:hse/core/model/assignment/Assignment.dart';
import 'package:hse/core/model/assignment/FoodLimits.dart';
import 'package:hse/core/model/assignment/Organization.dart';
import 'package:hse/core/model/assignment/rating_new.dart';
import 'package:hse/core/model/auth/register_request.dart';
import 'package:hse/core/model/auth/register_response.dart';
import 'package:hse/core/model/bsa/bsa.dart';
import 'package:hse/core/model/calendarevents/CalendarEvents.dart';
import 'package:hse/core/model/car_order/CarOrder.dart';
import 'package:hse/core/model/car_order/CarOrderGroupped.dart';
import 'package:hse/core/model/check_points/CheckPoint.dart';
import 'package:hse/core/model/config/config.dart';
import 'package:hse/core/model/course_eating/CourseEatingHistory.dart';
import 'package:hse/core/model/course_eating/Dish.dart';
import 'package:hse/core/model/eating_menu/Complex.dart';
import 'package:hse/core/model/eating_menu/EatingMenus.dart';
import 'package:hse/core/model/eating_menu/Mealtime.dart';
import 'package:hse/core/model/eating_menu/Product.dart';
import 'package:hse/core/model/employee_indicators/EmployeeIndicatorsValue.dart';
import 'package:hse/core/model/employee_indicators/Indicator.dart';
import 'package:hse/core/model/employee_indicators/IndicatorValueList.dart';
import 'package:hse/core/model/employee_indicators/IndicatorValueOnDateList.dart';
import 'package:hse/core/model/employee_indicators/Uom.dart';
import 'package:hse/core/model/event/event.dart';
import 'package:hse/core/model/event/events.dart';
import 'package:hse/core/model/file_descriptor.dart';
import 'package:hse/core/model/graphics/OverCategoryGraphic.dart';
import 'package:hse/core/model/graphics/RightAnswersGraphic.dart';
import 'package:hse/core/model/graphics/SubmittedGraphic.dart';
import 'package:hse/core/model/group_access/GroupAccess.dart';
import 'package:hse/core/model/history_eating_order/HistoryEatingOrder.dart';
import 'package:hse/core/model/material_obligations/Item.dart';
import 'package:hse/core/model/material_obligations/MaterialObligations.dart';
import 'package:hse/core/model/medicine/MedicineAndSafetyPojo.dart';
import 'package:hse/core/model/message/condition_category.dart';
import 'package:hse/core/model/message/message.dart';
import 'package:hse/core/model/message/message_dictionary.dart';
import 'package:hse/core/model/news/News.dart';
import 'package:hse/core/model/notification/Notification.dart';
import 'package:hse/core/model/place/Place.dart';
import 'package:hse/core/model/placement/Placement.dart';
import 'package:hse/core/model/ppe/PersonalProtectionEquipment.dart';
import 'package:hse/core/model/production_assignment/ProductionAssignment.dart';
import 'package:hse/core/model/risks/risks.dart';
import 'package:hse/core/model/sheet/SettlenetSheet.dart';
import 'package:hse/core/model/task/LaborSpending.dart';
import 'package:hse/core/model/test/Test.dart';
import 'package:hse/core/model/ticket/check_person_response.dart';
import 'package:hse/core/model/ticket/ticket.dart';
import 'package:hse/core/model/ticket/ticket_history.dart';
import 'package:hse/core/model/util_models.dart';
import 'package:hse/core/model/utils/ToDoList.dart';
import 'package:hse/core/model/utils/UserInfo.dart';
import 'package:hse/core/model/work_orders/AllOrderPojo.dart';
import 'package:hse/core/model/work_orders/Defect.dart';
import 'package:hse/core/model/work_orders/Material.dart';
import 'package:hse/core/model/work_orders/Person.dart';
import 'package:hse/core/model/work_orders/RepairOrderPojo.dart';
import 'package:hse/core/model/work_orders/RepairOrderPojoLaborSpending.dart';
import 'package:hse/core/model/work_orders/RepairOrderPojoWork.dart';
import 'package:hse/core/model/work_orders/TransportOrderPojo.dart';
import 'package:hse/core/model/work_orders/TransportOrderPojoWork.dart';
import 'package:hse/core/model/work_orders/WorkLaborSpending.dart';
import 'package:hse/core/model/work_orders/WorkOrderPojo.dart';
import 'package:hse/core/model/work_orders/WorkOrderShift.dart';
import 'package:hse/core/service/hive_service.dart';
import 'package:hse/core/utils/box_name_store.dart';
import 'package:hse/core/utils/method_name_store.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/viewmodels/user_info.dart' as vm;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart' show DateFormat;
import 'package:kinfolk/global_variables.dart';
import 'package:kinfolk/kinfolk.dart';
import 'package:kinfolk/model/url_types.dart';
import 'package:kinfolk/service/rest_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:version/version.dart';
import 'package:oauth2/oauth2.dart' as oauth2;

import 'firebase/AuthenticationService.dart';
import '../utils/globals.dart';
import 'local/AccessCategoryService.dart';

class RestServices {
  static String mobileService() => 'krj_MobileService';

  static getAccessCategories() async {
    Box box;
    var list = <String>[];
    var conn = await checkConnection();

    if (!conn) {
      var offBox =
      await HiveService.getOfflineListBox(BoxNameStore.getGroupAccess);
      AccessCategoryService.truncateAllowance();
      offBox.forEach((element) => list.add(element.code));
      AccessCategoryService.accessList = list;
      return list;
    } else {
      //box = await HiveService.getClearBox(BoxNameStore.getGroupAccess);
    }

    // List accessList = await Kinfolk.getListModelRest(
    //     serviceOrEntityName: mobileService(),
    //     methodName: MethodNames.getGroupAccessList,
    //     type: Types.services,
    //     fromMap: (val) => GroupAccess.fromMap(val));

    var jsonList = [
      {
        "_entityName": "krj_GroupAccessPojo",
        "_instanceName": "Модуль Питание",
        "id": "4abbfe38-dc4f-a976-d5c6-bb10704716ba",
        "code": "EATING",
        "name": "Модуль Питание"
      },
      {
        "_entityName": "krj_GroupAccessPojo",
        "_instanceName": "Модуль Наряд Задания",
        "id": "757cceec-65c5-10a3-8313-e3aab2218ecc",
        "code": "TASK_ORDERS",
        "name": "Модуль Наряд Задания"
      },
      {
        "_entityName": "krj_GroupAccessPojo",
        "_instanceName": "Модуль Допуски",
        "id": "7d851b87-cd65-a83e-2b51-592844b2115e",
        "code": "ADMISSIONS",
        "name": "Модуль Допуски"
      },
      {
        "_entityName": "krj_GroupAccessPojo",
        "_instanceName": "Модуль Тестирование",
        "id": "1760ceea-740f-a1a9-491d-7a5fcc16d95d",
        "code": "TESTING",
        "name": "Модуль Тестирование"
      },
      {
        "_entityName": "krj_GroupAccessPojo",
        "_instanceName": "Модуль Оплата Труда",
        "id": "fa76d6e5-7aca-de25-8fdd-cea3aa2c9d33",
        "code": "NAVBAR_SALARY",
        "name": "Модуль Оплата Труда"
      },
      {
        "_entityName": "krj_GroupAccessPojo",
        "_instanceName": "Модуль Заказ Транспорта",
        "id": "71c379fc-082c-08c6-1818-26a32587f3f1",
        "code": "TRANSPORT_ORDER",
        "name": "Модуль Заказ Транспорта"
      },
      {
        "_entityName": "krj_GroupAccessPojo",
        "_instanceName": "Модуль Обязательства",
        "id": "057a980f-e7df-1a76-1f39-b7958df5a84b",
        "code": "OBLIGATIONS",
        "name": "Модуль Обязательства"
      },
      {
        "_entityName": "krj_GroupAccessPojo",
        "_instanceName": "Вкладка Уведомления",
        "id": "9c6790eb-cf76-e6c9-cbf1-25dceb3557b3",
        "code": "NAVBAR_NOTIFICATION",
        "name": "Вкладка Уведомления"
      },
      {
        "_entityName": "krj_GroupAccessPojo",
        "_instanceName": "Сообщения",
        "id": "a01553ba-c528-954b-a76c-c5f4ba77f24d",
        "code": "MESSAGE",
        "name": "Сообщения"
      },
      {
        "_entityName": "krj_GroupAccessPojo",
        "_instanceName": "ПАБ",
        "id": "c2ac35b7-738b-8fef-8d77-7cbea58c738a",
        "code": "BEHAVIORAL_AUDIT",
        "name": "ПАБ"
      },
      {
        "_entityName": "krj_GroupAccessPojo",
        "_instanceName": "Риски",
        "id": "19e7ffbd-c53e-8f13-a829-53f0ef042c57",
        "code": "RISKS_MANAGEMENT",
        "name": "Риски"
      },
      {
        "_entityName": "krj_GroupAccessPojo",
        "_instanceName": "Аудит",
        "id": "08ae9434-bb66-5963-4d0c-b7117d51ecff",
        "code": "AUDIT_MANAGEMENT",
        "name": "Аудит"
      },
      {
        "_entityName": "krj_GroupAccessPojo",
        "_instanceName": "Талоны",
        "id": "a89e7c12-ae4d-d97b-7451-3ffff53cef19",
        "code": "TICKETS",
        "name": "Талоны"
      }
    ];

    var accessList =
        List<GroupAccess>.from(jsonList.map((x) => GroupAccess.fromMap(x)));

    AccessCategoryService.truncateAllowance();

    accessList.forEach((access) {
      box.add(access);
      list.add(access.code);
    });

    AccessCategoryService.accessList = list;

    return list;
  }

  static getAnthropometry() async {
    Box box;

    var connection = await checkConnection();
    if (!connection) {
      var list =
      await HiveService.getOfflineListBox(BoxNameStore.getAnthropometry);
      return list.first;
    } else {
      box = await HiveService.getClearBox(BoxNameStore.getAnthropometry);
    }

    var result = Anthropometry(
        entityName: "krj_AnthropologicalEvidencePojo",
        id: "bf0890f1-f09f-9b56-9296-c4e6f0944475",
        clothingSize: "44-46",
        shoeSize: "41",
        handSize: "9",
        personGroupId: "f63d3e47-caff-8840-cbf7-3fcbb284f66b");

    await box.add(result);
    await box.close();
    return result;
  }

  static getPlacement() async {
    Box box;
    var connection = await checkConnection();
    if (!connection) {
      var list = await HiveService.getOfflineListBox(BoxNameStore.getPlacement);
      return list.first;
    } else {
      box = await HiveService.getClearBox(BoxNameStore.getPlacement);
    }

    // Placement placement = await Kinfolk.getSingleModelRest(
    //     serviceName: mobileService(),
    //     methodName: MethodNames.getPersonLocation,
    //     type: Types.services,
    //     fromMap: (val) => Placement.fromMap(val));
    var placement = Placement(
        endDate: DateTime.now(),
        hotel: 'hotel',
        location: 'location',
        startDate: DateTime(2021, 08, 01),
        room: '123');
    await box.add(placement);
    await box.close();

    return placement;
  }

  static getAppeals() async {
    var conn = await checkConnection();
    var list = await HiveService.getOfflineListBox(BoxNameStore.getAppeals);
    if (!conn) {
      return list.cast<Appeals>();
    } else if (list.isNotEmpty) {
      return list.cast<Appeals>();
    }
    try {
      // List sources = await Kinfolk.getListModelRest(
      //     serviceOrEntityName: mobileService(),
      //     methodName: MethodNames.getUserAppeals,
      //     type: Types.services,
      //     fromMap: (val) => Appeals.fromMap(val));
      var response = [
        Appeals(
            entityName: "krj_AppealPojo",
            instanceName: "DDD\n\n\n",
            id: "62f1c3fb-13a7-4680-95a4-1d014187c2d2",
            code: "TRT-2021-00010",
            description: "DDD\n\n\n",
            topic: "EATING",
            type: "complaint",
            appealLocalDateTime: DateTime.now(),
            status: "DRAFT")
      ];
      Box box = await HiveService.getClearBox(BoxNameStore.getAppeals);
      response.forEach((e) {
        box.add(e);
      });
      return response.cast<Appeals>();
    } catch (e) {
      print(e);
    }
  }

  static Future<BaseResult> setAppeals(Appeals appeals) async {
    var box = await HiveService.getBox(BoxNameStore.getAppeals);
    await box.add(appeals);
    return BaseResult(success: true, errorDescription: 'success');
    // await appeals.save();
    // var body = '''
    //          {
    //           "appeal": ${appeals.toShortJson()}
    //          }
    //     ''';
    //
    // BaseResult result = await Kinfolk.getSingleModelRest(
    //     serviceName: mobileService(),
    //     methodName: MethodNames.setUserAppeals,
    //     type: Types.services,
    //     body: body,
    //     fromMap: (val) => BaseResult.fromMap(val));
    //
    // return result;
  }

  static resetPassword({String login, String upi}) async {
    var url = Kinfolk.createRestUrl(mobileService(),
        'restorePassword?login=$login&iin=$upi', Types.services);

    var response = await http.get(url, headers: Kinfolk.appJsonHeader);

    var scores = jsonDecode(response.body);

    var result = BaseResult.fromMap(scores);

    return result;
  }

  static getPPEs() async {
    Box box;
    var connection = await checkConnection();
    if (!connection) {
      var list = await HiveService.getOfflineListBox(
          BoxNameStore.getPeronalProtection);
      return list.first;
    } else {
      box = await HiveService.getClearBox(BoxNameStore.getPeronalProtection);
    }

    // PersonalProtectionEquipment protection = await Kinfolk.getSingleModelRest(
    //     serviceName: mobileService(),
    //     methodName: MethodNames.getUserPPEs,
    //     type: Types.services,
    //     fromMap: (val) => PersonalProtectionEquipment.fromMap(val));

    var josnL = {
      "_entityName": "krj_UserPPEPojo",
      "_instanceName":
          "kz.uco.krj.entity.ppe.restpojo.UserPPEPojo-6d75ea6a-3d61-bfdd-36ed-7f77f4f3046b [new]",
      "id": "6d75ea6a-3d61-bfdd-36ed-7f77f4f3046b",
      "perscent": "2498.630",
      "ppes": [
        {
          "_entityName": "krj_PPEPojo",
          "_instanceName": "Костюм рабочий из смесовых тканей ",
          "id": "779eae56-92e6-651f-8fee-73f7d200b1e5",
          "image": "assets/fake/3_1.jpeg",
          "endDate": "2017-12-21 00:00:00.000",
          "langValue": "Костюм рабочий из смесовых тканей",
          "perscentWear": 65,
          "size": "44-46",
          "seasonSign": "Летняя одежда",
          "issueDate": "2017-08-03 00:00:00.000",
          "sizeGrowth": "158-164",
          "actualCost": 603
        },
        {
          "_entityName": "krj_PPEPojo",
          "_instanceName":
              "Костюм рабочий утепленный из хлопчатобумажных тканей ",
          "id": "c29f2dea-26fc-2d08-924a-ca43ed402f53",
          "image": 'assets/fake/25102-14048867.jpeg',
          "endDate": "2021-11-02 00:00:00.000",
          "langValue": "Костюм рабочий утепленный из хлопчатобумажных тканей",
          "perscentWear": 92.19,
          "size": "44-46",
          "seasonSign": "Зимняя одежда",
          "issueDate": "2019-11-03 00:00:00.000",
          "sizeGrowth": "158-164",
          "actualCost": 2498.631
        },
        {
          "_entityName": "krj_PPEPojo",
          "_instanceName": "Перчатки трикотажные с полимерным покрытием ",
          "id": "8678b942-6837-4b2c-3002-f664c22d2e2c",
          "image": "assets/fake/images.jpeg",
          "watchDate": "2020-10-06 00:01:00.000",
          "endDate": "2019-08-10 00:00:00.000",
          "langValue": "Перчатки трикотажные с полимерным покрытием",
          "perscentWear": 98,
          "size": "9",
          "seasonSign": "Вне сезонный",
          "issueDate": "2019-01-03 00:00:00.000",
          "actualCost": 603
        },
        {
          "_entityName": "krj_PPEPojo",
          "_instanceName": "Подшлемник под каску ",
          "id": "0ab560fe-4aae-afa4-518a-a6fa5ab98d7b",
          "image": "assets/fake/12333.png",
          "watchDate": "2020-10-06 00:01:00.000",
          "endDate": "2020-01-03 00:00:00.000",
          "langValue": "Подшлемник под каску",
          "perscentWear": 100,
          "seasonSign": "Зимняя одежда",
          "issueDate": "2019-01-03 00:00:00.000",
          "actualCost": 0
        }
      ]
    };

    var protection = PersonalProtectionEquipment.fromMap(josnL);
    await box.add(protection);
    await box.close();

    return protection;
  }

  static getAssignment() async {
    Box box;
    if (!(await checkConnection())) {
      box = await HiveService.getBox(BoxNameStore.getAssignmentDB);
      var first = box.values.first;
      await box.close();
      return first;
    } else {
      box = await HiveService.getClearBox(BoxNameStore.getAssignmentDB);
    }

    // List sources = await Kinfolk.getListModelRest(
    //     serviceOrEntityName: mobileService(),
    //     methodName: MethodNames.getAssignments,
    //     type: Types.services,
    //     fromMap: (val) => Assignment.fromMap(val));
    var response = [
      {
        "_entityName": "krj_AssignmentPojo",
        "id": "ea87ddc1-1f5f-842a-b3f3-48321b75d4454",
        "orderNumber":
            "Кадровое перемещение организаций 00000000209 от 04.09.2020 10:45:44",
        "person": {
          "_entityName": "krj_PersonPojo",
          "id": "75b1de21-315e-38fa-77e5-d9f74e552981",
          "birthday": "1973-12-05 00:00:00.000",
          "lastName": "Ерлан",
          "image": "5f60b797-ff34-d23a-c9f0-c09e8b00070e",
          "sex": "Мужской",
          "groupId": "f63d3e47-caff-8840-cbf7",
          "employeeNumber": "2662",
          "firstName": "Сабыров",
          "phone": "87071234567",
          "middleName": "Таланұлы",
          "nationalIdentifier": "901212301123"
        },
        "groupId": "ec6e1edd-95d6-c9a8-acf4-29068cfb6a83",
        "organization": {
          "_entityName": "krj_OrganizationPojo",
          "id": "b10cd8e0-c0dc-ef66-af9a-fbdb942f62c4",
          "organizationName": "ТОО 'UCO'",
          "groupId": "6fb225ef-2d01-9941-0b19-e12654b8089a"
        },
        "rating": {
          "_entityName": "krj_RatingPojo",
          "id": "30dad67e-bc53-439c-b991-6a3f598fb665",
          "disciplineRating": -0.0,
          "safetyRating": 3.0,
          "testRating": 0.0,
          "rating": 90.0,
          "productivityRating": 3.0,
          "wasteRating": 3.0
        },
        "job": {
          "_entityName": "krj_JobPojo",
          "id": "6c9cb3ab-7a22-0e92-ce87-57f3cecd9ca2",
          "jobName": "Главный специалист",
          "groupId": "bab16a87-0389-3bf7-1bf1-e21e525a022d",
          "aup": "false"
        },
        "department": {
          "_entityName": "krj_DepartmentPojo",
          "id": "4ea14d87-1a43-7506-f504-b9ab8208dece",
          "departmentName": "Digital департамент",
          "groupId": "26e7b108-f9a7-bad9-6b2f-2b927a"
        },
        "limits": {
          "monthLimit": 12,
          "dayLimit": 4,
          "spent": 17,
          "left": 1,
        }
      }
    ];
    var sources =
        List<Assignment>.from(response.map((x) => Assignment.fromMap(x)));
    var assignment = sources.first;
    assignment.limits = FoodLimits(
      monthLimit: 14300,
      dayLimit: 1720,
      spent: 6330,
      left: 7970,
    );
    assignment.percentilePojo = await getPercentile();

    await box.add(assignment);
    await box.close();

    return assignment;
  }

  // static getEvents() async {
  //   var connection = await checkConnection();
  //   if (!connection) {
  //     var list = await HiveService.getOfflineListBox(BoxNameStore.getEvents);
  //     return list.cast<CalendarEvents>();
  //   }
  //
  //   List<CalendarEvents> events = List();
  //
  //   var accessList = await Kinfolk.getListModelRest(
  //       serviceOrEntityName: mobileService(),
  //       methodName: MethodNames.getCalendarEvents,
  //       type: Types.services,
  //       fromMap: (val) => CalendarEvents.fromMap(val));
  //
  //   Box box = await HiveService.getClearBox(BoxNameStore.getEvents);
  //
  //   accessList.forEach((event) {
  //     box.add(event);
  //     events.add(event);
  //   });
  //
  //   return events;
  // }

  static getToDoList() async {
    var connection = await checkConnection();
    if (!connection) {
      return ToDoList(
          appeal: 0,
          eating: 0,
          salary: 0,
          transportation: 0,
          testing: 0,
          work: 0);
    }

    // ToDoList toDoList = await Kinfolk.getSingleModelRest(
    //     serviceName: mobileService(),
    //     methodName: MethodNames.getToDoList,
    //     type: Types.services,
    //     fromMap: (val) => ToDoList.fromMap(val));
    var toDoList = ToDoList(
        appeal: 0,
        eating: 0,
        salary: 0,
        transportation: 0,
        testing: 0,
        work: 0);
    return toDoList;
  }

  static getCheckPoints() async {
    var conn = await checkConnection();
    if (!conn) {
      var list =
      await HiveService.getOfflineListBox(BoxNameStore.getAdmissions);
      return list.cast<CheckPoint>();
    }

    // List checkPointsList = await Kinfolk.getListModelRest(
    //     serviceOrEntityName: mobileService(),
    //     methodName: MethodNames.getCheckPointDetail,
    //     type: Types.services,
    //     fromMap: (val) => CheckPoint.fromMap(val));
    var checkPointsList = [
      CheckPoint(
        dateAndTime: DateTime.now(),
        controlPoint: 'главный',
        direction: 'ENTRANCE',
      ),
      CheckPoint(
        dateAndTime: DateTime.now(),
        controlPoint: 'боковой',
        direction: 'ENTRANCEwq',
      ),
      CheckPoint(
        dateAndTime: DateTime.now(),
        controlPoint: 'controlPoint',
        direction: 'ENTRANCE',
      ),
    ];
    // checkPointsList ??= [];

    Box box = await HiveService.getClearBox(BoxNameStore.getAdmissions);

    checkPointsList.forEach((e) => box.add(e));

    return checkPointsList.cast<CheckPoint>();
  }

  static getIssuedEquipment() async {
    var conn = await checkConnection();
    if (!conn) {
      var list =
      await HiveService.getOfflineListBox(BoxNameStore.getObligations);
      return list.first;
    }

    // MaterialObligations obligations = await Kinfolk.getSingleModelRest(
    //     serviceName: mobileService(),
    //     methodName: MethodNames.getIssuedEquipment,
    //     type: Types.services,
    //     fromMap: (val) => MaterialObligations.fromMap(val));
    var obligations = MaterialObligations();
    var resJson = {
      "_entityName": "krj_IssuedEquipmentPojo",
      "id": "ea989cba-7d2a-00e1-1f95-e19188fded0a",
      "totalAmount": 15.0,
      "total": 8450.531,
      "ppes": [
        {
          "_entityName": "krj_PPEPojo",
          "id": "54cef2fc-ae51-f279-40b1-656774e675ce",
          "image": "46080b3b-45c4-cbbf-4ef1-f4a7954a8246",
          "watchDate": "2020-10-06 00:01:00.000",
          "endDate": "2022-02-21 00:00:00.000",
          "langValue": "Рукавицы меховые ГОСТ 12,4,010-75",
          "perscentWear": 76.99,
          "size": "9",
          "seasonSign": "Зимняя одежда",
          "issueDate": "2020-02-22 00:00:00.000",
          "actualCost": 80.548
        },
        {
          "_entityName": "krj_PPEPojo",
          "id": "39fb5088-32b7-1078-b573-12f6dd9cc322",
          "image": "c5bf8d96-0eeb-5b40-f22d-0afc2c7ab6fb",
          "watchDate": "2020-10-16 15:39:35.953",
          "endDate": "2020-12-15 00:00:00.000",
          "langValue": "Перчатки трикотажные с полимерным покрытием",
          "perscentWear": 100,
          "size": "9",
          "seasonSign": "Вне сезонный",
          "issueDate": "2020-10-16 00:00:00.000",
          "actualCost": 0
        },
        {
          "_entityName": "krj_PPEPojo",
          "id": "7e57ccc3-b286-c89f-a869-f7b687209ac5",
          "image": "ad4c981c-4c59-32e3-6459-15f2afa38c01",
          "endDate": "2020-07-21 00:00:00.000",
          "langValue":
              "Костюм сварщика из хлопчатобумажных тканей с огнестойкой отделкой",
          "perscentWear": 100,
          "size": "44-46",
          "seasonSign": "Летняя одежда",
          "issueDate": "2019-07-22 00:00:00.000",
          "sizeGrowth": "158-164",
          "actualCost": 0
        },
        {
          "_entityName": "krj_PPEPojo",
          "id": "048c9e8e-a91e-3034-d72c-b33db143642f",
          "image": "c5bf8d96-0eeb-5b40-f22d-0afc2c7ab6fb",
          "watchDate": "2020-10-06 00:01:00.000",
          "endDate": "2018-04-25 00:00:00.000",
          "langValue":
              "Перчатки защитные с полимерным покрытием, морозостойкие с утепляющими вкладышами",
          "perscentWear": 100,
          "size": "9",
          "seasonSign": "Зимняя одежда",
          "issueDate": "2017-10-25 00:00:00.000",
          "actualCost": 0
        },
        {
          "_entityName": "krj_PPEPojo",
          "id": "5500c192-c463-f261-439c-6f04e36f7ddc",
          "image": "c5bf8d96-0eeb-5b40-f22d-0afc2c7ab6fb",
          "watchDate": "2020-10-06 00:01:00.000",
          "endDate": "2019-07-22 00:00:00.000",
          "langValue": "Перчатки трикотажные с полимерным покрытием",
          "perscentWear": 100,
          "size": "9",
          "seasonSign": "Вне сезонный",
          "issueDate": "2019-01-21 00:00:00.000",
          "actualCost": 0
        },
        {
          "_entityName": "krj_PPEPojo",
          "id": "8967536b-9a3d-1579-4795-11b74f9f03fc",
          "image": "fbf29941-784a-3bc1-21c1-6d8050f5373e",
          "watchDate": "2020-10-06 00:01:00.000",
          "endDate": "2019-03-22 00:00:00.000",
          "langValue":
              "Перчатки теплостойкие для защиты от искр и брызг расплавленного металла",
          "perscentWear": 100,
          "size": "9",
          "seasonSign": "Вне сезонный",
          "issueDate": "2018-06-03 00:00:00.000",
          "actualCost": 0
        },
        {
          "_entityName": "krj_PPEPojo",
          "id": "121d57ef-7bd6-887a-e4d6-c2398e7160ee",
          "image": "eb3bf13b-369f-47f8-bc5b-eb9a8b22c764",
          "watchDate": "2020-10-06 00:01:00.000",
          "endDate": "2020-12-24 00:00:00.000",
          "langValue": "Очки защитные",
          "perscentWear": 100,
          "seasonSign": "Вне сезонный",
          "issueDate": "2017-12-25 00:00:00.000",
          "actualCost": 0
        }
      ],
      "items": [
        {
          '_entityName': 'entityName',
          "id": 'id',
          "date": '2020-12-24 00:00:00.000',
          // "image": null,
          "quantity": 24.5,
          "cost": 6345.54,
          'name': 'Перчатки теплостойкие для защиты',
          'cause': 'cause',
          "comment": 'comment',
          "uom": 'uom',
          "isPersonal": true,
          "image": 'assets/fake/13hq.jpeg',
        },
        {
          '_entityName': 'entityName',
          "id": 'id',
          "date": '2020-12-24 00:00:00.000',
          // "image": null,
          "quantity": 24.5,
          "cost": 1345.54,
          "image": 'assets/fake/ochki.jpeg',
          'name': 'Очки защитные',
          'cause': 'cause',
          "comment": 'comment',
          "uom": 'uom',
          "isPersonal": true,
        },
        {
          '_entityName': 'entityName',
          "id": 'id',
          "date": '2020-12-24 00:00:00.000',
          // "image": null,
          "quantity": 24.5,
          "cost": 345.54,
          'name': 'Очки защитные',
          "image": 'assets/fake/ochki.jpeg',
          'cause': 'cause',
          "comment": 'comment',
          "uom": 'uom',
          "isPersonal": false,
        },
        {
          '_entityName': 'entityName',
          "id": 'id',
          "date": '2020-12-24 00:00:00.000',
          // "image": null,
          "quantity": 24.5,
          "cost": 9145.54,
          'name': 'Перчатки теплостойкие для защиты',
          'cause': 'cause',
          "comment": 'comment',
          "uom": 'uom',
          "isPersonal": false,
          "image": 'assets/fake/13hq.jpeg',
        }
      ],
      "tools": [
        {
          '_entityName': 'entityName',
          "id": 'id',
          "date": '2020-12-24 00:00:00.000',
          "image": 'assets/fake/13hq.jpeg',
          "quantity": 24.5,
          "cost": 6345.54,
          'name': 'Перчатки теплостойкие для защиты',
          'cause': 'cause',
          "comment": 'comment',
          "uom": 'uom',
          "isPersonal": true,
        },
        {
          '_entityName': 'entityName',
          "id": 'id',
          "date": '2020-12-24 00:00:00.000',
          "image": 'assets/fake/ochki.jpeg',
          "quantity": 24.5,
          "cost": 1345.54,
          'name': 'Очки защитные',
          'cause': 'cause',
          "comment": 'comment',
          "uom": 'uom',
          "isPersonal": true,
        },
        {
          '_entityName': 'entityName',
          "id": 'id',
          "date": '2020-12-24 00:00:00.000',
          // "image": null,
          "image": 'assets/fake/ochki.jpeg',
          "quantity": 24.5,
          "cost": 345.54,
          'name': 'Очки защитные',
          'cause': 'cause',
          "comment": 'comment',
          "uom": 'uom',
          "isPersonal": false,
        },
        {
          '_entityName': 'entityName',
          "id": 'id',
          "date": '2020-12-24 00:00:00.000',
          "image": 'assets/fake/13hq.jpeg',
          "quantity": 24.5,
          "cost": 9145.54,
          'name': 'Перчатки теплостойкие для защиты',
          'cause': 'cause',
          "comment": 'comment',
          "uom": 'uom',
          "isPersonal": false,
        }
      ]
    };

    obligations = MaterialObligations.fromMap(resJson);

    Box box = await HiveService.getClearBox(BoxNameStore.getObligations);
    await box.add(obligations);

    return obligations;
  }

  static getItems() async {
    var conn = await checkConnection();
    if (!conn) {
      var list = await HiveService.getOfflineListBox(BoxNameStore.getItems);
      return list.first;
    }

    Item items = await Kinfolk.getSingleModelRest(
        serviceName: mobileService(),
        methodName: MethodNames.getIssuedEquipment,
        type: Types.services,
        fromMap: (val) => Item.fromMap(val));

    Box box = await HiveService.getClearBox(BoxNameStore.getItems);
    await box.add(items);

    return items;
  }

  static getCarOrders() async {
    var conn = await checkConnection();
    if (!conn) {
      var list =
      await HiveService.getOfflineListBox(BoxNameStore.getCarOrderGroupped);
      return list;
    }

    // List carOrders = await Kinfolk.getListModelRest(
    //     serviceOrEntityName: mobileService(),
    //     methodName: MethodNames.getMyAllRequestsAndOrder,
    //     type: Types.services,
    //     fromMap: (val) => CarOrderGroupped.fromMap(val));
    var carOrders = [
      CarOrderGroupped(month: 'Январь', list: [
        CarOrder(
            status: 'APPROVED',
            requestedDate: DateTime.now(),
            cost: 1200,
            fromAddress: 'Алматы',
            toAddress: 'Москва'),
      ]),
    ];
    Box box = await HiveService.getClearBox(BoxNameStore.getCarOrderGroupped);
    carOrders.forEach((element) {
      box.add(element);
    });

    return carOrders;
  }

  static getHistoryCourseEating() async {
    var conn = await checkConnection();
    if (!conn) {
      var box =
      await HiveService.getOfflineListBox(BoxNameStore.getCourseEating);
      var cast = box.cast<CourseEatingHistory>();
      cast.sort((a, b) => b.courseEatingDate.compareTo(a.courseEatingDate));
      return cast;
    }

    // List historyList = await Kinfolk.getListModelRest(
    //     serviceOrEntityName: mobileService(),
    //     methodName: MethodNames.getHistoryCourseEating,
    //     type: Types.services,
    //     fromMap: (val) => CourseEatingHistory.fromMap(val));

    var historyList = [
      CourseEatingHistory(
          courseEatingDate: DateTime.now(),
          assessment: 12.5,
          location: 'location',
          dishes: [
            Dish(quantity: 2, amount: 14.9, name: 'Name1'),
            Dish(quantity: 6, amount: 64, name: 'Name1'),
          ],
          dayLimitOverrun: 2),
    ];
    Box box = await HiveService.getClearBox(BoxNameStore.getCourseEating);

    historyList.forEach((e) {
      box.add(e);
    });
    historyList
        .sort((a, b) => b.courseEatingDate.compareTo(a.courseEatingDate));
    return historyList.cast<CourseEatingHistory>();
  }

  static getMenu({mealtimeId, locationId}) async {
    var connection = await checkConnection();
    if (!connection) {
      var list = await HiveService.getOfflineListBox(BoxNameStore.getEmenu);
      return list.cast<EatingMenus>();
    }
    var body = '''
    {
      "mealtimeId": ${mealtimeId != null ? '$mealtimeId' : null},
      "locationId": ${locationId != null ? '$locationId' : null}
    }
    ''';

    // List menuList = await Kinfolk.getListModelRest(
    //     serviceOrEntityName: mobileService(),
    //     methodName: MethodNames.getEatingMenus,
    //     type: Types.services,
    //     body: body,
    //     fromMap: (val) => EatingMenus.fromMap(val));

    var menuList = [
      EatingMenus(
          id: 'sdsd',
          name: 'name1',
          complexes: [
            Complex(
                name: 'complexName',
                amount: 32.4,
                dayOfWeek: 2,
                products: [
                  Product(
                      name: 'Беш1',
                      amount: 245,
                      calories: 23.4,
                      uom: '1',
                      quantity: 4),
                  Product(
                      name: 'Беш2',
                      amount: 245,
                      calories: 23.4,
                      uom: '1',
                      quantity: 4),
                  Product(
                      name: 'Беш3',
                      amount: 245,
                      calories: 23.4,
                      uom: '1',
                      quantity: 4),
                ],
                mealtime: '12:00 13:30'),
            Complex(
              dayOfWeek: 2,
              name: 'complexName',
              amount: 32.4,
              mealtime: '12:00 13:30',
              products: [
                Product(
                    name: 'productName',
                    amount: 245,
                    calories: 23.4,
                    uom: '1',
                    quantity: 4),
                Product(
                    name: 'productName1',
                    amount: 245,
                    calories: 23.4,
                    uom: '1',
                    quantity: 4),
                Product(
                    name: 'productName4',
                    amount: 245,
                    calories: 23.4,
                    uom: '1',
                    quantity: 4),
              ],
            ),
            Complex(
                name: 'complexName',
                amount: 32.4,
                dayOfWeek: 0,
                products: [
                  Product(
                      name: 'Беш1',
                      amount: 245,
                      calories: 23.4,
                      uom: '1',
                      quantity: 4),
                  Product(
                      name: 'Беш2',
                      amount: 245,
                      calories: 23.4,
                      uom: '1',
                      quantity: 4),
                  Product(
                      name: 'Беш3',
                      amount: 245,
                      calories: 23.4,
                      uom: '1',
                      quantity: 4),
                ],
                mealtime: '12:00 13:30'),
            Complex(
              dayOfWeek: 0,
              name: 'complexName',
              amount: 32.4,
              mealtime: '12:00 13:30',
              products: [
                Product(
                    name: 'productName',
                    amount: 245,
                    calories: 23.4,
                    uom: '1',
                    quantity: 4),
                Product(
                    name: 'productName1',
                    amount: 245,
                    calories: 23.4,
                    uom: '1',
                    quantity: 4),
                Product(
                    name: 'productName4',
                    amount: 245,
                    calories: 23.4,
                    uom: '1',
                    quantity: 4),
              ],
            ),
            Complex(
                name: 'complexName',
                amount: 32.4,
                dayOfWeek: 4,
                products: [
                  Product(
                      name: 'Беш1',
                      amount: 245,
                      calories: 23.4,
                      uom: '1',
                      quantity: 4),
                  Product(
                      name: 'Беш2',
                      amount: 245,
                      calories: 23.4,
                      uom: '1',
                      quantity: 4),
                  Product(
                      name: 'Беш3',
                      amount: 245,
                      calories: 23.4,
                      uom: '1',
                      quantity: 4),
                ],
                mealtime: '12:00 13:30'),
            Complex(
              dayOfWeek: 4,
              name: 'complexName',
              amount: 32.4,
              mealtime: '12:00 13:30',
              products: [
                Product(
                    name: 'productName',
                    amount: 245,
                    calories: 23.4,
                    uom: '1',
                    quantity: 4),
                Product(
                    name: 'productName1',
                    amount: 245,
                    calories: 23.4,
                    uom: '1',
                    quantity: 4),
                Product(
                    name: 'productName4',
                    amount: 245,
                    calories: 23.4,
                    uom: '1',
                    quantity: 4),
              ],
            ),
          ],
          products: [
            Product(
              dayOfWeek: 2,
              name: 'Беш1',
              amount: 245,
              calories: 23.4,
              uom: '1',
              quantity: 4,
              mealtime: '12:00 13:30',
            ),
            Product(
              dayOfWeek: 2,
              name: 'Салат',
              amount: 245,
              calories: 23.4,
              uom: '1',
              quantity: 4,
              mealtime: '12:00 13:30',
            ),
            Product(
              dayOfWeek: 2,
              name: 'Суп',
              amount: 245,
              calories: 23.4,
              uom: '1',
              quantity: 4,
              mealtime: '12:00 13:30',
            ),
            Product(
              dayOfWeek: 0,
              name: 'Беш1',
              amount: 245,
              calories: 23.4,
              uom: '1',
              quantity: 4,
              mealtime: '12:00 13:30',
            ),
            Product(
              dayOfWeek: 0,
              name: 'Салат',
              amount: 245,
              calories: 23.4,
              uom: '1',
              quantity: 4,
              mealtime: '12:00 13:30',
            ),
            Product(
              dayOfWeek: 1,
              name: 'Суп',
              amount: 245,
              calories: 23.4,
              uom: '1',
              quantity: 4,
              mealtime: '12:00 13:30',
            ),
            Product(
              dayOfWeek: 1,
              name: 'Беш1',
              amount: 245,
              calories: 23.4,
              uom: '1',
              quantity: 4,
              mealtime: '12:00 13:30',
            ),
            Product(
              dayOfWeek: 1,
              name: 'Салат',
              amount: 245,
              calories: 23.4,
              uom: '1',
              quantity: 4,
              mealtime: '12:00 13:30',
            ),
            Product(
              dayOfWeek: 1,
              name: 'Суп',
              amount: 245,
              calories: 23.4,
              uom: '1',
              quantity: 4,
              mealtime: '12:00 13:30',
            ),
            Product(
              dayOfWeek: 3,
              name: 'Беш1',
              amount: 245,
              calories: 23.4,
              uom: '1',
              quantity: 4,
              mealtime: '12:00 13:30',
            ),
            Product(
              dayOfWeek: 3,
              name: 'Салат',
              amount: 245,
              calories: 23.4,
              uom: '1',
              quantity: 4,
              mealtime: '12:00 13:30',
            ),
            Product(
              dayOfWeek: 3,
              name: 'Суп',
              amount: 245,
              calories: 23.4,
              uom: '1',
              quantity: 4,
              mealtime: '12:00 13:30',
            ),
            Product(
              dayOfWeek: 4,
              name: 'Беш1',
              amount: 245,
              calories: 23.4,
              uom: '1',
              quantity: 4,
              mealtime: '12:00 13:30',
            ),
            Product(
              dayOfWeek: 4,
              name: 'Салат',
              amount: 245,
              calories: 23.4,
              uom: '1',
              quantity: 4,
              mealtime: '12:00 13:30',
            ),
            Product(
              dayOfWeek: 4,
              name: 'Суп',
              amount: 245,
              calories: 23.4,
              uom: '1',
              quantity: 4,
              mealtime: '12:00 13:30',
            ),
          ],
          location: 'location'),
    ];
    Box box = await HiveService.getClearBox(BoxNameStore.getEmenu);
    menuList.forEach((e) => box.add(e));

    return menuList.cast<EatingMenus>();
  }

  static Future getMealtimes({locationId}) async {
    var connection = await checkConnection();
    if (!connection) {
      var list = await HiveService.getOfflineListBox(BoxNameStore.getMealtimes);
      return list.cast<Mealtime>();
    }
    var body = '''
    {
      "locationId": ${locationId != null ? '$locationId' : null}
    }
    ''';
    //
    // List menuList = await Kinfolk.getListModelRest(
    //     serviceOrEntityName: mobileService(),
    //     methodName: MethodNames.getMealtimeList,
    //     type: Types.services,
    //     body: body,
    //     fromMap: (val) => Mealtime.fromMap(val));
    var jsonList;
    if (locationId == null) {
      jsonList = [];
    } else if (locationId == 'fa2dff89-a0b9-e78e2') {
      jsonList = [
        {
          "_entityName": "krj_MealtimePojoMobile",
          "_instanceName":
              "kz.uco.krj.entity.ppe.restpojo.MealtimePojoMobile-3c383bc6-0a09-10b5-d072-685b352f9274 [new]",
          "id": "3c383bc6-0a09-10b5-d072-685b352f9274",
          "langValue1": "Комплексный ужин",
          "startTime": "19:00",
          "endTime": "23:00"
        },
        {
          "_entityName": "krj_MealtimePojoMobile",
          "_instanceName":
              "kz.uco.krj.entity.ppe.restpojo.MealtimePojoMobile-4ec3d87d-8728-16f3-3b86-33e908f5ce4f [new]",
          "id": "4ec3d87d-8728-16f3-3b86-33e908f5ce4f",
          "langValue1": "Комплексный завтрак",
          "startTime": "09:00",
          "endTime": "10:30"
        },
        {
          "_entityName": "krj_MealtimePojoMobile",
          "_instanceName":
              "kz.uco.krj.entity.ppe.restpojo.MealtimePojoMobile-d5b8ab6c-0179-8501-8539-8bcea967a10f [new]",
          "id": "d5b8ab6c-0179-8501-8539-8bcea967a10f",
          "langValue1": "Завтрак",
          "startTime": "09:00",
          "endTime": "10:30"
        },
        {
          "_entityName": "krj_MealtimePojoMobile",
          "_instanceName":
              "kz.uco.krj.entity.ppe.restpojo.MealtimePojoMobile-ecb94d1a-9b74-d4ac-a212-ed66206d8a83 [new]",
          "id": "ecb94d1a-9b74-d4ac-a212-ed66206d8a83",
          "langValue1": "Комплексный обед",
          "startTime": "10:00",
          "endTime": "17:59"
        },
        {
          "_entityName": "krj_MealtimePojoMobile",
          "_instanceName":
              "kz.uco.krj.entity.ppe.restpojo.MealtimePojoMobile-0a6dd637-b4b2-9543-4782-88e0cdbec2a2 [new]",
          "id": "0a6dd637-b4b2-9543-4782-88e0cdbec2a2",
          "langValue1": "Обед",
          "startTime": "12:00",
          "endTime": "14:00"
        },
        {
          "_entityName": "krj_MealtimePojoMobile",
          "_instanceName":
              "kz.uco.krj.entity.ppe.restpojo.MealtimePojoMobile-136a98f5-3637-d1d5-2f7a-a0f4a7d9a962 [new]",
          "id": "136a98f5-3637-d1d5-2f7a-a0f4a7d9a962",
          "langValue1": "Ужин",
          "startTime": "16:00",
          "endTime": "23:00"
        },
      ];
    } else if (locationId == 'd70a989c-5668-1e71') {
      jsonList = [
        {
          "_entityName": "krj_MealtimePojoMobile",
          "_instanceName":
              "kz.uco.krj.entity.ppe.restpojo.MealtimePojoMobile-22c6e882-7ad1-b872-7270-a6b8fbf0f6ed [new]",
          "id": "22c6e882-7ad1-b872-7270-a6b8fbf0f6ed",
          "langValue1": "Ужин",
          "startTime": "18:00",
          "endTime": "23:00"
        },
        {
          "_entityName": "krj_MealtimePojoMobile",
          "_instanceName":
              "kz.uco.krj.entity.ppe.restpojo.MealtimePojoMobile-c75a4558-6a77-14d1-6cd1-9f67f1ea502d [new]",
          "id": "c75a4558-6a77-14d1-6cd1-9f67f1ea502d",
          "langValue1": "Комплексный обед",
          "startTime": "10:00",
          "endTime": "17:05"
        },
        {
          "_entityName": "krj_MealtimePojoMobile",
          "_instanceName":
              "kz.uco.krj.entity.ppe.restpojo.MealtimePojoMobile-a3c3c369-8e71-c8a5-3168-fd82dcbf6004 [new]",
          "id": "a3c3c369-8e71-c8a5-3168-fd82dcbf6004",
          "langValue1": "Комплексный завтрак",
          "startTime": "09:00",
          "endTime": "10:30"
        },
        {
          "_entityName": "krj_MealtimePojoMobile",
          "_instanceName":
              "kz.uco.krj.entity.ppe.restpojo.MealtimePojoMobile-175e300a-734d-b097-1fe3-4d67b9b66403 [new]",
          "id": "175e300a-734d-b097-1fe3-4d67b9b66403",
          "langValue1": "Комплексный ужин",
          "startTime": "17:00",
          "endTime": "23:00"
        },
        {
          "_entityName": "krj_MealtimePojoMobile",
          "_instanceName":
              "kz.uco.krj.entity.ppe.restpojo.MealtimePojoMobile-07d6d82b-9eea-07d3-693f-277fe3268c66 [new]",
          "id": "07d6d82b-9eea-07d3-693f-277fe3268c66",
          "langValue1": "Завтрак",
          "startTime": "06:00",
          "endTime": "09:59"
        },
        {
          "_entityName": "krj_MealtimePojoMobile",
          "_instanceName":
              "kz.uco.krj.entity.ppe.restpojo.MealtimePojoMobile-2fda75db-a2e7-4b22-434f-26bba61e32bd [new]",
          "id": "2fda75db-a2e7-4b22-434f-26bba61e32bd",
          "langValue1": "Обед",
          "startTime": "10:00",
          "endTime": "17:59"
        }
      ];
    } else if (locationId == '1563bc94-5920-caa3') {
      jsonList = [
        {
          "_entityName": "krj_MealtimePojoMobile",
          "_instanceName":
              "kz.uco.krj.entity.ppe.restpojo.MealtimePojoMobile-47353ce9-a18b-84ed-ab1c-b7b6f99e90c6 [new]",
          "id": "47353ce9-a18b-84ed-ab1c-b7b6f99e90c6",
          "langValue1": "Комплексный ужин",
          "startTime": "00:00",
          "endTime": "02:01"
        },
        {
          "_entityName": "krj_MealtimePojoMobile",
          "_instanceName":
              "kz.uco.krj.entity.ppe.restpojo.MealtimePojoMobile-8590a93b-3553-f587-5cd0-a491687f01e9 [new]",
          "id": "8590a93b-3553-f587-5cd0-a491687f01e9",
          "langValue1": "Комплексный обед",
          "startTime": "11:00",
          "endTime": "15:00"
        }
      ];
    }
    var menuList =
        List<Mealtime>.from(jsonList.map((x) => Mealtime.fromMap(x)));

    Box box = await HiveService.getClearBox(BoxNameStore.getMealtimes);
    menuList.forEach((e) => box.add(e));

    return menuList.cast<Mealtime>();
  }

  static getPlaces() async {
    var connection = await checkConnection();
    if (!connection) {
      var list =
      await HiveService.getOfflineListBox(BoxNameStore.getEatingPlace);
      return list.cast<Place>();
    }

    // List placesList = await Kinfolk.getListModelRest(
    //     serviceOrEntityName: mobileService(),
    //     methodName: MethodNames.getPlaces,
    //     type: Types.services,
    //     fromMap: (val) => Place.fromMap(val));
    var placesList = [
      Place(
          entityName: 'PlacePojo',
          instanceName: 'Столовая карьер',
          id: 'fa2dff89-a0b9-e78e2',
          groupName: 'Пункты приема пищи',
          name: 'Столовая карьер'),
      Place(
          entityName: 'PlacePojo',
          instanceName: 'Столовая карьер',
          id: 'd70a989c-5668-1e71',
          groupName: 'Пункты приема пищи',
          name: 'Столовая в поселке'),
      Place(
          entityName: 'PlacePojo',
          instanceName: 'Столовая карьер',
          id: '1563bc94-5920-caa3',
          groupName: 'Пункты приема пищи',
          name: 'Доставка'),
    ];
    Box box = await HiveService.getClearBox(BoxNameStore.getEatingPlace);
    placesList.forEach((e) => box.add(e));

    return placesList.cast<Place>();
  }

  static Future getOrderHistory() async {
    var connection = await checkConnection();
    if (!connection) {
      var list =
      await HiveService.getOfflineListBox(BoxNameStore.getOrderHistory);
      return list.cast<HistoryEatingOrder>();
    }

    var list =
        await HiveService.getOfflineListBox(BoxNameStore.getOrderHistory);
    if (list.isNotEmpty) {
      return list.cast<HistoryEatingOrder>();
    }

    // List historyList = await Kinfolk.getListModelRest(
    //     serviceOrEntityName: mobileService(),
    //     methodName: MethodNames.getHistoryEatingOrder,
    //     type: Types.services,
    //     fromMap: (val) => HistoryEatingOrder.fromMap(val));
    var historyList = [
      HistoryEatingOrder(
        orderDateTime: DateTime.now(),
        locationName: 'locationName',
        location: 'location',
        locationGroupName: 'locationGroupName',
        status: 'COMPLETED',
        code: 'F12-D13',
        eatingMenus: [
          EatingMenus(
            products: [
              Product(
                  name: 'productName',
                  amount: 356,
                  calories: 23.4,
                  uom: '5',
                  quantity: 2),
              Product(
                  name: 'productName',
                  amount: 245,
                  calories: 27.4,
                  uom: '5',
                  quantity: 1),
              Product(
                  name: 'productName',
                  amount: 565,
                  calories: 13.4,
                  uom: '5',
                  quantity: 7),
            ],
            complexes: [
              Complex(
                name: 'complexName',
                amount: 32.4,
                products: [
                  Product(
                      name: 'productName',
                      amount: 245,
                      calories: 23.4,
                      uom: '1',
                      quantity: 4),
                  Product(
                      name: 'productName1',
                      amount: 245,
                      calories: 23.4,
                      uom: '1',
                      quantity: 4),
                  Product(
                      name: 'productName4',
                      amount: 245,
                      calories: 23.4,
                      uom: '1',
                      quantity: 4),
                ],
              ),
              Complex(
                name: 'complexName',
                amount: 32.4,
                products: [
                  Product(
                      name: 'productName',
                      amount: 245,
                      calories: 23.4,
                      uom: '1',
                      quantity: 4),
                  Product(
                      name: 'productName1',
                      amount: 245,
                      calories: 23.4,
                      uom: '1',
                      quantity: 4),
                  Product(
                      name: 'productName4',
                      amount: 245,
                      calories: 23.4,
                      uom: '1',
                      quantity: 4),
                ],
              ),
            ],
          ),
          EatingMenus(
            products: [
              Product(
                  name: 'productName',
                  amount: 356,
                  calories: 23.4,
                  uom: '5',
                  quantity: 2),
              Product(
                  name: 'productName',
                  amount: 245,
                  calories: 27.4,
                  uom: '5',
                  quantity: 1),
              Product(
                  name: 'productName',
                  amount: 565,
                  calories: 13.4,
                  uom: '5',
                  quantity: 7),
            ],
            complexes: [
              Complex(
                name: 'complexName',
                amount: 32.4,
                products: [
                  Product(
                      name: 'productName',
                      amount: 245,
                      calories: 23.4,
                      uom: '1',
                      quantity: 4),
                  Product(
                      name: 'productName1',
                      amount: 245,
                      calories: 23.4,
                      uom: '1',
                      quantity: 4),
                  Product(
                      name: 'productName4',
                      amount: 245,
                      calories: 23.4,
                      uom: '1',
                      quantity: 4),
                ],
              ),
              Complex(
                name: 'complexName',
                amount: 32.4,
                products: [
                  Product(
                      name: 'productName',
                      amount: 245,
                      calories: 23.4,
                      uom: '1',
                      quantity: 4),
                  Product(
                      name: 'productName1',
                      amount: 245,
                      calories: 23.4,
                      uom: '1',
                      quantity: 4),
                  Product(
                      name: 'productName4',
                      amount: 245,
                      calories: 23.4,
                      uom: '1',
                      quantity: 4),
                ],
              ),
            ],
          ),
        ],
      ),
      HistoryEatingOrder(
        status: 'UNAPPROVED',
        orderDateTime: DateTime.now(),
        code: 'F12-D15',
        locationName: 'locationName1',
        location: 'location',
        locationGroupName: 'locationGroupName',
        eatingMenus: [
          EatingMenus(
            products: [
              Product(
                  name: 'productName',
                  amount: 356,
                  calories: 23.4,
                  uom: '5',
                  quantity: 2),
              Product(
                  name: 'productName',
                  amount: 245,
                  calories: 27.4,
                  uom: '5',
                  quantity: 1),
              Product(
                  name: 'productName',
                  amount: 1065,
                  calories: 13.4,
                  uom: '5',
                  quantity: 7),
            ],
            complexes: [
              Complex(
                name: 'complexName',
                amount: 32.4,
                products: [
                  Product(
                      name: 'productName',
                      amount: 245,
                      calories: 23.4,
                      uom: '1',
                      quantity: 4),
                  Product(
                      name: 'productName1',
                      amount: 245,
                      calories: 23.4,
                      uom: '1',
                      quantity: 4),
                  Product(
                      name: 'productName4',
                      amount: 245,
                      calories: 23.4,
                      uom: '1',
                      quantity: 4),
                ],
              ),
              Complex(
                name: 'complexName',
                amount: 32.4,
                products: [
                  Product(
                      name: 'productName',
                      amount: 245,
                      calories: 23.4,
                      uom: '1',
                      quantity: 4),
                  Product(
                      name: 'productName1',
                      amount: 245,
                      calories: 23.4,
                      uom: '1',
                      quantity: 4),
                  Product(
                      name: 'productName4',
                      amount: 245,
                      calories: 23.4,
                      uom: '1',
                      quantity: 4),
                ],
              ),
            ],
          ),
          EatingMenus(
            products: [
              Product(
                  name: 'productName',
                  amount: 156,
                  calories: 23.4,
                  uom: '5',
                  quantity: 2),
              Product(
                  name: 'productName',
                  amount: 245,
                  calories: 27.4,
                  uom: '5',
                  quantity: 1),
              Product(
                  name: 'productName',
                  amount: 365,
                  calories: 13.4,
                  uom: '5',
                  quantity: 7),
            ],
            complexes: [
              Complex(
                name: 'complexName',
                amount: 32.4,
                products: [
                  Product(
                      name: 'productName',
                      amount: 245,
                      calories: 23.4,
                      uom: '1',
                      quantity: 4),
                  Product(
                      name: 'productName1',
                      amount: 645,
                      calories: 23.4,
                      uom: '1',
                      quantity: 4),
                  Product(
                      name: 'productName4',
                      amount: 945,
                      calories: 23.4,
                      uom: '1',
                      quantity: 4),
                ],
              ),
              Complex(
                name: 'complexName',
                amount: 32.4,
                products: [
                  Product(
                      name: 'productName',
                      amount: 945,
                      calories: 23.4,
                      uom: '1',
                      quantity: 4),
                  Product(
                      name: 'productName1',
                      amount: 145,
                      calories: 23.4,
                      uom: '1',
                      quantity: 4),
                  Product(
                      name: 'productName4',
                      amount: 545,
                      calories: 23.4,
                      uom: '1',
                      quantity: 4),
                ],
              ),
            ],
          ),
        ],
      )
    ];

    Box box = await HiveService.getClearBox(BoxNameStore.getOrderHistory);
    historyList.forEach((e) => box.add(e));

    historyList.sort((a, b) => b.orderDateTime.compareTo(a.orderDateTime));

    return historyList.cast<HistoryEatingOrder>();
  }

  static Future<BaseResult> cancelOrder(HistoryEatingOrder order) async {
    var body = '''
          {
          "orderPojo":${json.encode(order.toFullMap())}
          }
    ''';

    var result = await Kinfolk.getSingleModelRest(
        serviceName: mobileService(),
        methodName: MethodNames.cancelEatingOrder,
        type: Types.services,
        body: body,
        fromMap: (val) => BaseResult.fromMap(val));

    return result;
  }

  static Future<BaseResult> sendEatingOrder(HistoryEatingOrder order) async {
    var body = '''
    {
    "eatingOrderPojo":${order.toJson()}
    }
    ''';

    // var result = await Kinfolk.getSingleModelRest(
    //     serviceName: mobileService(),
    //     methodName: MethodNames.setEatingOrder,
    //     type: Types.services,
    //     body: body,
    //     fromMap: (val) => BaseResult.fromMap(val));

    return BaseResult(success: true, errorDescription: '');
  }

  static setCourseEatingAssessment(
      String courseEatingId, double assessment) async {
    var body = '''
             {
              "courseEatingId": "$courseEatingId",
              "assessment": $assessment
            }
        ''';

    var result = await Kinfolk.getSingleModelRest(
        serviceName: mobileService(),
        methodName: MethodNames.setCourseEatingAssessment,
        type: Types.services,
        body: body,
        fromMap: (val) => BaseResult.fromMap(val));

    return result;
  }

  static Future<BaseResult> cancelCarOrder(CarOrder order, {bool check}) async {
    var body = ''' {
              "requestId" : "${order.id}",
              "check" : "${check ?? false}"
            }
        ''';
    // var result = await Kinfolk.getSingleModelRest(
    //     serviceName: mobileService(),
    //     methodName: MethodNames.canceledRequestOrOrder,
    //     type: Types.services,
    //     body: body,
    //     fromMap: (val) => BaseResult.fromMap(val));

    return BaseResult(success: true, errorDescription: 'sds');
  }

  static changePassword(
      {String passwordConfirmation,
        String newPassword,
        String currentPassword}) async {
    var result = await Kinfolk.getSingleModelRest(
        serviceName: mobileService(),
        methodName:
        'changePassword?currentPassword=$currentPassword&newPassword=$newPassword&passwordConfirmation=$passwordConfirmation',
        type: Types.services,
        fromMap: (val) => BaseResult.fromMap(val));

    return result;
  }

  static tryToRegister() async {
    Box settings = await HiveService.getBox('settings');

    UserInfo info = userInfoFromJson(settings.get('info'));

    var body = '''
            {
              "pass" : "${info.password}"
            }
    ''';

    BaseResult result = await Kinfolk.getSingleModelRest(
        serviceName: mobileService(),
        methodName: MethodNames.tryToRegister,
        type: Types.services,
        body: body,
        fromMap: (val) => BaseResult.fromMap(val));

    if (result.success) {
      var assignment = await vm.UserInfoModel().assignment();
      return (await auth(assignment.person.email, info.password));
    } else {
      var source = jsonDecode(result.errorDescription);
      print(source['login']);
      print(source['pass']);
      return (await auth(source['login'], source['pass']));
    }
  }

  static auth(String email, String password) async {
    var res = await AuthenticationService()
        .loginWithEmail(email: email.trim(), password: password.trim());
    if (res is bool) {
      if (res) {
        print('SUCCESS');
        return true;
      } else {
        print('NOT SUCCESS');
        return false;
      }
    } else {
      print(res);
      return false;
    }
  }

  static Future<bool> checkConnection() async {
    if (kIsWeb) {
      return true;
    }

    try {
      final result = await InternetAddress.lookup('google.com').timeout(
        Duration(milliseconds: 200),
        onTimeout: () => [],
      );
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  static Future<PersonalProtectionEquipment> getPpesByPpeCode(
      String code) async {
    var body = '''{ 
             "ppeCode":"$code"
                }''';

    var result = await Kinfolk.getSingleModelRest(
        serviceName: mobileService(),
        methodName: MethodNames.getPersonsPPEsByPPECode,
        type: Types.services,
        body: body,
        fromMap: (val) => PersonalProtectionEquipment.fromMap(val));

    return result;
  }

  static getProductionAssignmentByPpeCode(String code) async {
    var body = '''{ 
             "ppeCode":"$code",
             "isItsMe":false
                }''';

    var result = await Kinfolk.getListModelRest(
        serviceOrEntityName: mobileService(),
        methodName: MethodNames.getPersonProductionAssignmentByPPECode,
        type: Types.services,
        body: body,
        fromMap: (val) => ProductionAssignment.fromMap(val));

    return result;
  }

  static getEventsByPpeCode(String code) async {
    var body = '''{ 
             "ppeCode":"$code"
                }''';

    var result = await Kinfolk.getListModelRest(
        serviceOrEntityName: mobileService(),
        methodName: MethodNames.getCalendarEventsByPPECode,
        type: Types.services,
        body: body,
        fromMap: (val) => CalendarEvents.fromMap(val));

    return result.cast<CalendarEvents>();
  }

  static sendToken(String token) async {
    var body = '''
    {
      "token":"$token"
    }
    ''';

    BaseResult result = await Kinfolk.getSingleModelRest(
        serviceName: mobileService(),
        methodName: MethodNames.setUserPhoneToken,
        type: Types.services,
        body: body,
        fromMap: (val) => BaseResult.fromMap(val));

    return result;
  }

  static Future<BaseResult> sendNewRequest(CarOrder order) async {
    order.status = 'IS_NEW';

    var body = '''
        {
          "userId": "${Uuid().v4()}",
          "transportationRequestPojo": {
            "requestId": "${Uuid().v4()}",
            "date": "${DateFormat("yyyy-MM-dd HH:mm:ss.SSS").format(order.requestedDate)}",
            "from": "${order.fromAddress}",
            "to": "${order.toAddress}",
            "status": "${order.status}",
            "createDate": "${DateFormat("yyyy-MM-dd HH:mm:ss.SSS").format(order.createDate)}",
            "count":"${order.count}",
            "comment":"${order.comment}",
            "typeOfCar":"${order.typeOfCar}",
            "isEmergency":${order.isEmergency}
          }
        }
        ''';

    // BaseResult result = await Kinfolk.getSingleModelRest(
    //     serviceName: mobileService(),
    //     methodName: MethodNames.setTransportRequest,
    //     type: Types.services,
    //     body: body,
    //     fromMap: (val) => BaseResult.fromMap(val));

    return BaseResult(success: true, errorDescription: '');
  }

  static Future<BaseResult> setTransportationOrderAssessment(
      CarOrder order, double val) async {
    var body = ''' {
                    "requestId" : "${order.id}",
                    "val" : $val
            }
        ''';

    BaseResult result = await Kinfolk.getSingleModelRest(
        serviceName: mobileService(),
        methodName: MethodNames.setTransportationOrderAssessment,
        type: Types.services,
        body: body,
        fromMap: (val) => BaseResult.fromMap(val));

    return result;
  }

  static getSettlenetSheet() async {
    var connection = await checkConnection();
    if (!connection) {
      var list =
      await HiveService.getOfflineListBox(BoxNameStore.getSettlenetSheet);
      return list.cast<SettlenetSheet>();
    }

    // List result = await Kinfolk.getListModelRest(
    //     serviceOrEntityName: mobileService(),
    //     methodName: MethodNames.getSettlenetSheet,
    //     type: Types.services,
    //     fromMap: (val) => SettlenetSheet.fromMap(val));
    var result = <SettlenetSheet>[
      SettlenetSheet(
          entityName: "krj_SettlenetSheetPojo",
          // "_instanceName": "kz.uco.krj.entity.SettlenetSheetPojo-b8b077c9-beee-db52-c51c-c0ace1c581d1 [new]",
          id: "b8b077c9-beee-db52-c51c-c0ace1c581d1",
          date: DateTime(2021, 08, 01),
          period: "AUGUST",
          seen: true,
          fileId: "9ca668ef-64de-e32a-0799"),
      SettlenetSheet(
          entityName: "krj_SettlenetSheetPojo",
          // "_instanceName": "kz.uco.krj.entity.SettlenetSheetPojo-b8b077c9-beee-db52-c51c-c0ace1c581d1 [new]",
          id: "b8b077c9-beee-db52-c51c-c0ace1c581d1",
          date: DateTime(2021, 07, 01),
          period: "JULY",
          seen: true,
          fileId: "9ca668ef-64de-e32a-0799-")
    ];
    Box box = await HiveService.getClearBox(BoxNameStore.getSettlenetSheet);
    result.forEach((element) {
      box.add(element);
    });

    return result.cast<SettlenetSheet>();
  }

  static void setSeen(String code) async {
    var body = '''
             {
	            "code": "$code"
             }
        ''';

    BaseResult result = await Kinfolk.getSingleModelRest(
        serviceName: mobileService(),
        methodName: MethodNames.setSeenSettlenet,
        type: Types.services,
        body: body,
        fromMap: (val) => BaseResult.fromMap(val));
  }

  static Future<List<Test>> getTests() async {
    var connection = await checkConnection();
    if (!connection) {
      var list = await HiveService.getOfflineListBox(BoxNameStore.getTests);
      return list.cast<Test>();
    }

    // List test = await Kinfolk.getListModelRest(
    //     serviceOrEntityName: mobileService(),
    //     methodName: MethodNames.getAttempts2,
    //     type: Types.services,
    //     fromMap: (val) => Test.fromMap(val));
    // test ??= [];

    var jsonList = [
      {
        "_entityName": "krj_TestPojo",
        "_instanceName":
            "kz.uco.krj.entity.testing.restpojo.TestPojo-dcff168b-d3ab-f341-2535-1aacbd422fc3 [new]",
        "id": "dcff168b-d3ab-f341-2535-1aacbd422fc3",
        "duration": 5,
        "timeForQuestion": 20,
        "answers": [
          {
            "_entityName": "krj_AnswerPojo",
            "_instanceName":
                "kz.uco.krj.entity.testing.restpojo.AnswerPojo-994666ef-6da2-28f2-9b05-7b9d735cfcdc [new]",
            "id": "994666ef-6da2-28f2-9b05-7b9d735cfcdc",
            "answer": "",
            "question": {
              "_entityName": "krj_QuestionPojo",
              "_instanceName":
                  "kz.uco.krj.entity.testing.restpojo.QuestionPojo-511de322-d266-d589-b188-b51fa26f54be [new]",
              "id": "511de322-d266-d589-b188-b51fa26f54be",
              "questionText":
                  "Кто контролирует своевременность обучения в области   безопасности труда работников предприятия?",
              "answerOptions": [
                {
                  "_entityName": "krj_AnswerOptionPojo",
                  "_instanceName":
                      "kz.uco.krj.entity.testing.restpojo.AnswerOptionPojo-4699a935-8a40-3a78-f163-3071344a224e [new]",
                  "id": "4699a935-8a40-3a78-f163-3071344a224e",
                  "answerText": "инженер по охране труда;"
                },
                {
                  "_entityName": "krj_AnswerOptionPojo",
                  "_instanceName":
                      "kz.uco.krj.entity.testing.restpojo.AnswerOptionPojo-b96197e2-7e5b-95a7-38ae-8d3caedaabc6 [new]",
                  "id": "b96197e2-7e5b-95a7-38ae-8d3caedaabc6",
                  "answerText": "отдел  охраны труда  и инспектор надзора;"
                },
                {
                  "_entityName": "krj_AnswerOptionPojo",
                  "_instanceName":
                      "kz.uco.krj.entity.testing.restpojo.AnswerOptionPojo-6c14974b-d847-6490-2570-ca26e37f56aa [new]",
                  "id": "6c14974b-d847-6490-2570-ca26e37f56aa",
                  "answerText": "отдел (бюро, инженер) охраны труда;"
                },
                {
                  "_entityName": "krj_AnswerOptionPojo",
                  "_instanceName":
                      "kz.uco.krj.entity.testing.restpojo.AnswerOptionPojo-1b3afb21-b160-cd8b-479d-b98a35733438 [new]",
                  "id": "1b3afb21-b160-cd8b-479d-b98a35733438",
                  "answerText":
                      "инженерно-технический работник по приказу работодателя;"
                },
                {
                  "_entityName": "krj_AnswerOptionPojo",
                  "_instanceName":
                      "kz.uco.krj.entity.testing.restpojo.AnswerOptionPojo-c3a95277-b795-c440-5feb-e2f16503b11f [new]",
                  "id": "c3a95277-b795-c440-5feb-e2f16503b11f",
                  "answerText":
                      "отдел (бюро, инженер) охраны труда или инженерно-технический работник по приказу работодателя"
                }
              ]
            }
          },
          {
            "_entityName": "krj_AnswerPojo",
            "_instanceName":
                "kz.uco.krj.entity.testing.restpojo.AnswerPojo-ec86db70-a2d7-eccb-d40a-5c1602178e03 [new]",
            "id": "ec86db70-a2d7-eccb-d40a-5c1602178e03",
            "answer": "",
            "question": {
              "_entityName": "krj_QuestionPojo",
              "_instanceName":
                  "kz.uco.krj.entity.testing.restpojo.QuestionPojo-5d82d26a-5b7a-bb01-885f-c22359f71d1d [new]",
              "id": "5d82d26a-5b7a-bb01-885f-c22359f71d1d",
              "questionText":
                  "В течение, какого времени расследуется несчастный случай  хронического профессионального заболевания с момента  получения сообщения?",
              "answerOptions": [
                {
                  "_entityName": "krj_AnswerOptionPojo",
                  "_instanceName":
                      "kz.uco.krj.entity.testing.restpojo.AnswerOptionPojo-c3cc1005-8677-c971-4a34-fdadf013274d [new]",
                  "id": "c3cc1005-8677-c971-4a34-fdadf013274d",
                  "answerText": "в течение 24 часов;"
                },
                {
                  "_entityName": "krj_AnswerOptionPojo",
                  "_instanceName":
                      "kz.uco.krj.entity.testing.restpojo.AnswerOptionPojo-5fe3eb12-a492-e127-1120-4cd8c969d967 [new]",
                  "id": "5fe3eb12-a492-e127-1120-4cd8c969d967",
                  "answerText": "в течение 7 дней;"
                },
                {
                  "_entityName": "krj_AnswerOptionPojo",
                  "_instanceName":
                      "kz.uco.krj.entity.testing.restpojo.AnswerOptionPojo-102e865f-8c37-d711-2a74-7a4eb2725b5c [new]",
                  "id": "102e865f-8c37-d711-2a74-7a4eb2725b5c",
                  "answerText": "в течение 5 дней."
                },
                {
                  "_entityName": "krj_AnswerOptionPojo",
                  "_instanceName":
                      "kz.uco.krj.entity.testing.restpojo.AnswerOptionPojo-4c4b9138-c6eb-5a9e-f911-5431d6b7cbfd [new]",
                  "id": "4c4b9138-c6eb-5a9e-f911-5431d6b7cbfd",
                  "answerText": "в течение 10 дней;"
                },
                {
                  "_entityName": "krj_AnswerOptionPojo",
                  "_instanceName":
                      "kz.uco.krj.entity.testing.restpojo.AnswerOptionPojo-65f69c64-55d5-355c-a561-8e0655292a7c [new]",
                  "id": "65f69c64-55d5-355c-a561-8e0655292a7c",
                  "answerText": "в течение 48 часов;"
                }
              ]
            }
          },
          {
            "_entityName": "krj_AnswerPojo",
            "_instanceName":
                "kz.uco.krj.entity.testing.restpojo.AnswerPojo-79ac468a-acf4-954a-8f19-9960c35bf546 [new]",
            "id": "79ac468a-acf4-954a-8f19-9960c35bf546",
            "answer": "",
            "question": {
              "_entityName": "krj_QuestionPojo",
              "_instanceName":
                  "kz.uco.krj.entity.testing.restpojo.QuestionPojo-68ffacc0-a5a3-5e87-be1e-0f4f9c701251 [new]",
              "id": "68ffacc0-a5a3-5e87-be1e-0f4f9c701251",
              "questionText":
                  "Каким пределом огнестойкости обладают постройки и сооружения I степени огнестойкости?",
              "answerOptions": [
                {
                  "_entityName": "krj_AnswerOptionPojo",
                  "_instanceName":
                      "kz.uco.krj.entity.testing.restpojo.AnswerOptionPojo-b3e7102b-d528-e234-0a23-c9c8222ff894 [new]",
                  "id": "b3e7102b-d528-e234-0a23-c9c8222ff894",
                  "answerText": "0,5 – 2,5 часа;"
                },
                {
                  "_entityName": "krj_AnswerOptionPojo",
                  "_instanceName":
                      "kz.uco.krj.entity.testing.restpojo.AnswerOptionPojo-3197ce69-6b4f-b04e-5ba9-f73851bd29f6 [new]",
                  "id": "3197ce69-6b4f-b04e-5ba9-f73851bd29f6",
                  "answerText": "0, 5 – 2 часа;"
                },
                {
                  "_entityName": "krj_AnswerOptionPojo",
                  "_instanceName":
                      "kz.uco.krj.entity.testing.restpojo.AnswerOptionPojo-a08d8603-e5c5-b3b9-c72d-9de03be56d84 [new]",
                  "id": "a08d8603-e5c5-b3b9-c72d-9de03be56d84",
                  "answerText": "0,25 – 2 часа;"
                },
                {
                  "_entityName": "krj_AnswerOptionPojo",
                  "_instanceName":
                      "kz.uco.krj.entity.testing.restpojo.AnswerOptionPojo-4d8d3e0a-8505-01fd-e5ef-ce0811fc763c [new]",
                  "id": "4d8d3e0a-8505-01fd-e5ef-ce0811fc763c",
                  "answerText": "0,25 – 0,5 часа;"
                },
                {
                  "_entityName": "krj_AnswerOptionPojo",
                  "_instanceName":
                      "kz.uco.krj.entity.testing.restpojo.AnswerOptionPojo-877144ff-2dc0-1ea2-4779-449ca1e88dfa [new]",
                  "id": "877144ff-2dc0-1ea2-4779-449ca1e88dfa",
                  "answerText": "0,25 – 3 часа."
                }
              ]
            }
          },
          {
            "_entityName": "krj_AnswerPojo",
            "_instanceName":
                "kz.uco.krj.entity.testing.restpojo.AnswerPojo-49ac914a-318c-f066-922c-56c6c54631a0 [new]",
            "id": "49ac914a-318c-f066-922c-56c6c54631a0",
            "answer": "",
            "question": {
              "_entityName": "krj_QuestionPojo",
              "_instanceName":
                  "kz.uco.krj.entity.testing.restpojo.QuestionPojo-30dcf5e8-0a86-1251-f350-543acbf13984 [new]",
              "id": "30dcf5e8-0a86-1251-f350-543acbf13984",
              "questionText": "Параметры, характеризующие пенные огнетушители?",
              "answerOptions": [
                {
                  "_entityName": "krj_AnswerOptionPojo",
                  "_instanceName":
                      "kz.uco.krj.entity.testing.restpojo.AnswerOptionPojo-36b58724-1b91-3d6d-8a5c-8606ce025a61 [new]",
                  "id": "36b58724-1b91-3d6d-8a5c-8606ce025a61",
                  "answerText":
                      "длина струи 8 м, тушит поверхность 0,75 м2, действует 15 мин."
                },
                {
                  "_entityName": "krj_AnswerOptionPojo",
                  "_instanceName":
                      "kz.uco.krj.entity.testing.restpojo.AnswerOptionPojo-ccc8b75a-99cc-aea6-d147-a604948153aa [new]",
                  "id": "ccc8b75a-99cc-aea6-d147-a604948153aa",
                  "answerText":
                      "длина струи 2 м, действует 30 с, тушит поверхность 0,75 м2;"
                },
                {
                  "_entityName": "krj_AnswerOptionPojo",
                  "_instanceName":
                      "kz.uco.krj.entity.testing.restpojo.AnswerOptionPojo-047404fe-d6b2-b25c-57dd-ee885da9257f [new]",
                  "id": "047404fe-d6b2-b25c-57dd-ee885da9257f",
                  "answerText":
                      "длина струи 8 м, действует в течение 60 с, тушит поверхность 0,75 м2;"
                },
                {
                  "_entityName": "krj_AnswerOptionPojo",
                  "_instanceName":
                      "kz.uco.krj.entity.testing.restpojo.AnswerOptionPojo-c9a51a5b-7c06-464b-3fde-20f06afa60a9 [new]",
                  "id": "c9a51a5b-7c06-464b-3fde-20f06afa60a9",
                  "answerText":
                      "длина струи 12 м, тушит поверхность 0,2 м2, действует 10 мин;"
                },
                {
                  "_entityName": "krj_AnswerOptionPojo",
                  "_instanceName":
                      "kz.uco.krj.entity.testing.restpojo.AnswerOptionPojo-2e8c735b-732e-2296-7ed2-fc88619c016c [new]",
                  "id": "2e8c735b-732e-2296-7ed2-fc88619c016c",
                  "answerText":
                      "тушит поверхность 2 м2, длина струи 10 м, время действия 2 мин;"
                }
              ]
            }
          },
          {
            "_entityName": "krj_AnswerPojo",
            "_instanceName":
                "kz.uco.krj.entity.testing.restpojo.AnswerPojo-0a30772d-b2dd-f5bf-67e9-d95e12c5dddd [new]",
            "id": "0a30772d-b2dd-f5bf-67e9-d95e12c5dddd",
            "answer": "",
            "question": {
              "_entityName": "krj_QuestionPojo",
              "_instanceName":
                  "kz.uco.krj.entity.testing.restpojo.QuestionPojo-c0b64765-c0d5-02f4-a441-314b1ff6f330 [new]",
              "id": "c0b64765-c0d5-02f4-a441-314b1ff6f330",
              "questionText":
                  "Что понимается под коэффициентом пульсации освещенности?",
              "answerOptions": [
                {
                  "_entityName": "krj_AnswerOptionPojo",
                  "_instanceName":
                      "kz.uco.krj.entity.testing.restpojo.AnswerOptionPojo-5794dfab-7b38-638a-eb62-ed66f8fc9f90 [new]",
                  "id": "5794dfab-7b38-638a-eb62-ed66f8fc9f90",
                  "answerText":
                      "изменение светового  потока через световые проемы;"
                },
                {
                  "_entityName": "krj_AnswerOptionPojo",
                  "_instanceName":
                      "kz.uco.krj.entity.testing.restpojo.AnswerOptionPojo-7b089c65-5d56-b770-a5dd-d1d1967e336c [new]",
                  "id": "7b089c65-5d56-b770-a5dd-d1d1967e336c",
                  "answerText":
                      "изменение светового потока при превышении срока эксплуатации светильников."
                },
                {
                  "_entityName": "krj_AnswerOptionPojo",
                  "_instanceName":
                      "kz.uco.krj.entity.testing.restpojo.AnswerOptionPojo-bb6acb5a-9d9d-00b2-33d3-4c5325229c19 [new]",
                  "id": "bb6acb5a-9d9d-00b2-33d3-4c5325229c19",
                  "answerText":
                      "колебания светового потока при изменении напряжения питающей сети;"
                },
                {
                  "_entityName": "krj_AnswerOptionPojo",
                  "_instanceName":
                      "kz.uco.krj.entity.testing.restpojo.AnswerOptionPojo-35ad8bb1-231f-e5fd-6f93-e1a303e1719a [new]",
                  "id": "35ad8bb1-231f-e5fd-6f93-e1a303e1719a",
                  "answerText":
                      "колебания светового потока при питании переменным током;"
                },
                {
                  "_entityName": "krj_AnswerOptionPojo",
                  "_instanceName":
                      "kz.uco.krj.entity.testing.restpojo.AnswerOptionPojo-446b2665-1a5c-069b-a49e-008f4ff50675 [new]",
                  "id": "446b2665-1a5c-069b-a49e-008f4ff50675",
                  "answerText": "совместно А, В;"
                }
              ]
            }
          }
        ],
        "testDate": "2021-09-06 00:00:00.000"
      },
      {
        "_entityName": "krj_TestPojo",
        "_instanceName":
            "kz.uco.krj.entity.testing.restpojo.TestPojo-e8fae055-7cb4-56da-b504-bb62cfe8ab46 [new]",
        "id": "e8fae055-7cb4-56da-b504-bb62cfe8ab46",
        "duration": 5,
        "result": "0",
        "timeForQuestion": 20,
        "testDate": "2021-09-05 00:00:00.000"
      },
      {
        "_entityName": "krj_TestPojo",
        "_instanceName":
            "kz.uco.krj.entity.testing.restpojo.TestPojo-a34e6935-f1fe-7596-1ea0-a6ccb364708a [new]",
        "id": "a34e6935-f1fe-7596-1ea0-a6ccb364708a",
        "duration": 5,
        "result": "0",
        "timeForQuestion": 20,
        "testDate": "2021-09-04 00:00:00.000"
      },
      {
        "_entityName": "krj_TestPojo",
        "_instanceName":
            "kz.uco.krj.entity.testing.restpojo.TestPojo-7c043b29-b65b-7130-d8aa-6c147fd74a24 [new]",
        "id": "7c043b29-b65b-7130-d8aa-6c147fd74a24",
        "duration": 5,
        "result": "0",
        "timeForQuestion": 20,
        "testDate": "2021-09-03 00:00:00.000"
      },
      {
        "_entityName": "krj_TestPojo",
        "_instanceName":
            "kz.uco.krj.entity.testing.restpojo.TestPojo-e49ffc3e-dfbc-5655-3832-6f323f69ea25 [new]",
        "id": "e49ffc3e-dfbc-5655-3832-6f323f69ea25",
        "duration": 5,
        "result": "0",
        "timeForQuestion": 20,
        "testDate": "2021-09-02 00:00:00.000"
      },
      {
        "_entityName": "krj_TestPojo",
        "_instanceName":
            "kz.uco.krj.entity.testing.restpojo.TestPojo-05c8963c-2310-09ea-0e97-b626a70c8a82 [new]",
        "id": "05c8963c-2310-09ea-0e97-b626a70c8a82",
        "duration": 5,
        "result": "0",
        "timeForQuestion": 20,
        "testDate": "2021-09-01 00:00:00.000"
      }
    ];
    var test = List<Test>.from(jsonList.map((x) => Test.fromMap(x)));

    Box box = await HiveService.getClearBox(BoxNameStore.getTests);
    test.forEach((f) {
      box.add(f);
    });

    return test.cast<Test>();
  }

  static setDailyTest(Test test) async {
    // var body = '{"testPojo":${testToJson(test)}}';
    // var client = await Kinfolk.getClient();
    // var url = Kinfolk.createRestUrl(
    //     mobileService(), MethodNames.setAttempt, TypgetTestingGraphicRightAnswerses.services);
    // var response = await RestHelper()
    //     .getPostResponse(url: url, body: body, client: client);
    return 'Ok';
  }

  static getTestingSubmittedGraphic() async {
    var conn = await checkConnection();
    if (!conn) {
      var list =
      await HiveService.getOfflineListBox(BoxNameStore.getSubmittedGraphic);
      return list[0];
    }

    // SubmittedGraphic result = await Kinfolk.getSingleModelRest(
    //     serviceName: mobileService(),
    //     methodName: MethodNames.getTestingGraphicPassedTests,
    //     type: Types.services,
    //     fromMap: (val) => SubmittedGraphic.fromMap(val));
    var jsonList = {
      "_entityName": "krj_TestingGraphic2Pojo",
      "_instanceName":
          "kz.uco.krj.entity.testing.restpojo.TestingGraphicPassedTestsPojo-5cc03e59-a272-4dff-01f7-1fb38eab7baa [new]",
      "id": "5cc03e59-a272-4dff-01f7-1fb38eab7baa",
      "passedTest": 1,
      "allTests": 6,
      "percent": 16.67
    };

    var result = SubmittedGraphic.fromMap(jsonList);

    var box = await HiveService.getBox(BoxNameStore.getSubmittedGraphic);
    await box.add(result);

    return result;
  }

  static getTestingGraphicRightAnswers() async {
    var conn = await checkConnection();
    if (!conn) {
      var list = await HiveService.getOfflineListBox(
          BoxNameStore.getTestingGraphicRightAnswers);
      return list[0];
    }

    // var graphic = await Kinfolk.getSingleModelRest(
    //     serviceName: mobileService(),
    //     methodName: MethodNames.getTestingGraphicRightAnswers,
    //     type: Types.services,
    //     fromMap: (val) => RightAnswersGraphic.fromMap(val));
    var graphic = RightAnswersGraphic(
        entityName: "krj_TestingGraphicRightAnswersPojo",
        id: "bde7dbf2-e6a0-0083-2aa2-844d4373695d",
        allAnswers: 5,
        rightAnswers: 1,
        percent: 20);

    var box =
    await HiveService.getBox(BoxNameStore.getTestingGraphicRightAnswers);
    await box.add(graphic);

    return graphic;
  }

  static Future<List<OverCategoryGraphic>>
  getTestingGraphicOverCategoryList() async {
    var conn = await checkConnection();
    if (!conn) {
      var list = await HiveService.getOfflineListBox(
          BoxNameStore.getGraphicOverCategory);
      return list.cast<OverCategoryGraphic>();
    }

    var list = <OverCategoryGraphic>[];

    // List test = await Kinfolk.getListModelRest(
    //     serviceOrEntityName: mobileService(),
    //     methodName: MethodNames.getTestingGraphicOverCategoryList,
    //     type: Types.services,
    //     fromMap: (val) => OverCategoryGraphic.fromMap(val));
    var as = [
      {
        "_entityName": "krj_TestingGraphicOverCategoryPojo",
        "_instanceName":
            "kz.uco.krj.entity.testing.restpojo.TestingGraphicOverCategoryPojo-a938939f-0cda-56ad-5c41-8e9b951d1809 [new]",
        "id": "a938939f-0cda-56ad-5c41-8e9b951d1809",
        "allAnswers": 1,
        "rightAnswers": 0,
        "category": "Должностные обязанности",
        "percent": 0
      },
      {
        "_entityName": "krj_TestingGraphicOverCategoryPojo",
        "_instanceName":
            "kz.uco.krj.entity.testing.restpojo.TestingGraphicOverCategoryPojo-90c18b82-2981-e0d6-2112-9b1a5e820ed6 [new]",
        "id": "90c18b82-2981-e0d6-2112-9b1a5e820ed6",
        "allAnswers": 1,
        "rightAnswers": 0,
        "category": "По специальности",
        "percent": 0
      },
      {
        "_entityName": "krj_TestingGraphicOverCategoryPojo",
        "_instanceName":
            "kz.uco.krj.entity.testing.restpojo.TestingGraphicOverCategoryPojo-64f14950-69c4-2236-43e5-a4fdf60cfcfe [new]",
        "id": "64f14950-69c4-2236-43e5-a4fdf60cfcfe",
        "allAnswers": 3,
        "rightAnswers": 1,
        "category": "Техника безопасности",
        "percent": 33.33
      }
    ];
    Box box =
        await HiveService.getClearBox(BoxNameStore.getGraphicOverCategory);
    var test = List<OverCategoryGraphic>.from(
        as.map((e) => OverCategoryGraphic.fromMap(e)));
    test.forEach((e) {
      box.add(e);
      list.add(e);
    });

    return list;
  }

  static Future<Assignment> getAssignmentByPpeCode(String code) async {
    var body = '''{
            "ppeCode":"$code"
             }''';

    Assignment assignmentOne = await Kinfolk.getSingleModelRest(
        serviceName: mobileService(),
        methodName: MethodNames.getPersonAssignmentByPPECode,
        type: Types.services,
        body: body,
        fromMap: (val) => Assignment.fromMap(val));

    return assignmentOne;
  }

  static Future<BaseResult> changeEmail(String email) async {
    BaseResult result = await Kinfolk.getSingleModelRest(
        serviceName: mobileService(),
        methodName: 'changeEmail?email=$email',
        type: Types.services,
        fromMap: (val) => BaseResult.fromMap(val));
    return result;
  }

  static getNews() async {
    var conn = await checkConnection();
    if (!conn) {
      var list = await HiveService.getOfflineListBox(BoxNameStore.getNews);
      return list.cast<News>();
    }
    var newsList = [
      {
        "_entityName": "krj_NewsPogo",
        "_instanceName": "С днем шахтера!",
        "id": "81e5cbe2-ea40-f2c9-ab9b-e2685af5dddf",
        "image": "576e3c64-61d2-67d1-e1d1-a0a88e4c76ae",
        "text":
            "Дорогие работники угольной промышленности! Искренне поздравляю вас с Днем шахтера! Ваша работа трудна и опасна, а польза от шахтерского труда громадна. Пока есть вы, в доме каждого из нас тепло и светло. Так пускай частички тепла из каждого дома греют вам душу, а лучики света — освещают темные забои! С праздником, горняки!",
        "title": "Fake news",
        "newsDate": "2020-09-08 00:00:00.000"
      }
    ];

    Box box = await HiveService.getClearBox(BoxNameStore.getNews);
    var getNewsList = List<News>.from(newsList.map((x) => News.fromMap(x)));
    getNewsList.forEach((e) => box.add(e));

    return getNewsList.cast<News>();
  }

  static getArchiveNews() async {
    var conn = await checkConnection();
    if (!conn) {
      var list =
      await HiveService.getOfflineListBox(BoxNameStore.getArchiveNews);
      return list.cast<News>();
    }

    // List getArchivesList = await Kinfolk.getListModelRest(
    //     serviceOrEntityName: mobileService(),
    //     methodName: MethodNames.getArchiveNews,
    //     type: Types.services,
    //     fromMap: (val) => News.fromMap(val));
    var response = [
      {
        "_entityName": "krj_NewsPogo",
        "_instanceName": "тест",
        "id": "8dcfe5fc-64cd-7776-cd1d-3c5aca1539df",
        "image": "576e3c64-61d2-67d1-e1d1-a0a88e4c76ae",
        "text": "тест",
        "title": "тест",
        "newsDate": "2020-10-02 00:00:00.000"
      },
      {
        "_entityName": "krj_NewsPogo",
        "_instanceName": "С днем шахтера!",
        "id": "81e5cbe2-ea40-f2c9-ab9b-e2685af5dddf",
        "image": "576e3c64-61d2-67d1-e1d1-a0a88e4c76ae",
        "text":
            "Дорогие работники угольной промышленности! Искренне поздравляю вас с Днем шахтера! Ваша работа трудна и опасна, а польза от шахтерского труда громадна. Пока есть вы, в доме каждого из нас тепло и светло. Так пускай частички тепла из каждого дома греют вам душу, а лучики света — освещают темные забои! С праздником, горняки!",
        "title": "С днем шахтера!",
        "newsDate": "2020-09-08 00:00:00.000"
      }
    ];
    Box box = await HiveService.getClearBox(BoxNameStore.getArchiveNews);
    var getArchivesList = List<News>.from(response.map((x) => News.fromMap(x)));
    getArchivesList.forEach((e) => box.add(e));

    return getArchivesList.cast<News>();
  }

  static Future getMedicineAndSafe() async {
    var conn = await checkConnection();
    if (!conn) {
      var list =
      await HiveService.getOfflineListBox(BoxNameStore.getMedSafeBox);
      return list.cast<MedicineAndSafetyPojo>();
    }
    //
    // List tasks = await Kinfolk.getListModelRest(
    //     serviceOrEntityName: mobileService(),
    //     methodName: MethodNames.getMedicineAndSafetyCheck,
    //     type: Types.services,
    //     fromMap: (val) => MedicineAndSafetyPojo.fromMap(val));
    //

    var tasks = [
      MedicineAndSafetyPojo(
        id: '233',
        code: '',
        medicine: true,
        safety: false,
      ),
      MedicineAndSafetyPojo(
        id: '233',
        code: '',
        medicine: false,
        safety: true,
      ),
      MedicineAndSafetyPojo(
        id: '233',
        code: '',
        medicine: false,
        safety: false,
      ),
      MedicineAndSafetyPojo(
        id: '233',
        code: 'sdsd',
        medicine: true,
        safety: true,
      ),
    ];
    Box box = await HiveService.getClearBox(BoxNameStore.getMedSafeBox);
    tasks.forEach((e) => box.add(e));

    return tasks.cast<MedicineAndSafetyPojo>();
  }

  static getTasks() async {
    var conn = await checkConnection();
    if (!conn) {
      var list = await HiveService.getOfflineListBox(BoxNameStore.getTasksBox);
      return list.cast<AllOrderPojo>();
    }

    // List tasks = await Kinfolk.getListModelRest(
    //     serviceOrEntityName: mobileService(),
    //     methodName: MethodNames.getAllOrders,
    //     type: Types.services,
    //     fromMap: (val) => AllOrderPojo.fromMap(val));

    var tasks = [
      AllOrderPojo(
          id: '1',
          workOrderPojo: WorkOrderPojo(
              totalFact: 12.0, totalPercent: 12.7, number: 'Demo'),
          responsible: false,
          type: 'WORK_ORDER',
          repairOrderPojo: RepairOrderPojo(
              number: 'numve',
              laborSpending: [
                RepairOrderPojoLaborSpending(
                    dateAndTime: DateTime.now(),
                    status: 'status',
                    percent: 57.8),
              ],
              work: RepairOrderPojoWork(material: [
                Material(uom: 'uom', item: 'item', quantity: '23'),
              ], defect: [
                Defect(defect: 'defect', comment: 'comment')
              ], person: [
                Person(
                    lastName: 'lastName',
                    firstName: 'firstName',
                    middleName: 'middleName',
                    equipmentName: 'equipmentName'),
              ]),
              asset: 'Обьект1',
              repairType: 'Вид ремонта',
              planEndDate: DateTime.now(),
              comment: 'comment'),
          transportOrderPojo: TransportOrderPojo(
              id: 'ad',
              work: TransportOrderPojoWork(id: '123', laborSpending: [
                WorkLaborSpending(dateAndTime: DateTime.now())
              ])),
          workOrderShift: WorkOrderShift(
            code: 'sdsd',
          )
          // @HiveField(7)
          // WorkOrderShift workOrderShift;
          ),
      AllOrderPojo(
          id: '1',
          workOrderPojo: WorkOrderPojo(
              totalFact: 12.0, totalPercent: 52.5, number: 'Demo'),
          responsible: false,
          type: 'WORK_ORDER',
          repairOrderPojo: RepairOrderPojo(
              number: 'numve',
              laborSpending: [
                RepairOrderPojoLaborSpending(
                    dateAndTime: DateTime.now(),
                    status: 'status',
                    percent: 57.8),
              ],
              work: RepairOrderPojoWork(material: [
                Material(uom: 'uom', item: 'item', quantity: '23'),
              ], defect: [
                Defect(defect: 'defect', comment: 'comment')
              ], person: [
                Person(
                    lastName: 'lastName',
                    firstName: 'firstName',
                    middleName: 'middleName',
                    equipmentName: 'equipmentName'),
              ]),
              asset: 'Обьект1',
              repairType: 'Вид ремонта',
              planEndDate: DateTime.now(),
              comment: 'comment'),
          transportOrderPojo: TransportOrderPojo(
              id: 'ad',
              work: TransportOrderPojoWork(id: '123', laborSpending: [
                WorkLaborSpending(dateAndTime: DateTime.now())
              ])),
          workOrderShift: WorkOrderShift(
            code: 'sdsd',
          )
          // @HiveField(7)
          // WorkOrderShift workOrderShift;
          ),
      AllOrderPojo(
          id: '1',
          workOrderPojo: WorkOrderPojo(
              totalFact: 32.0, totalPercent: 91.8, number: 'Demo'),
          responsible: false,
          type: 'WORK_ORDER',
          repairOrderPojo: RepairOrderPojo(
              number: 'numve',
              laborSpending: [
                RepairOrderPojoLaborSpending(
                    dateAndTime: DateTime.now(),
                    status: 'status',
                    percent: 57.8),
              ],
              work: RepairOrderPojoWork(material: [
                Material(uom: 'uom', item: 'item', quantity: '23'),
              ], defect: [
                Defect(defect: 'defect', comment: 'comment')
              ], person: [
                Person(
                    lastName: 'lastName',
                    firstName: 'firstName',
                    middleName: 'middleName',
                    equipmentName: 'equipmentName'),
              ]),
              asset: 'Обьект1',
              repairType: 'Вид ремонта',
              planEndDate: DateTime.now(),
              comment: 'comment'),
          transportOrderPojo: TransportOrderPojo(
              id: 'ad',
              work: TransportOrderPojoWork(id: '123', laborSpending: [
                WorkLaborSpending(dateAndTime: DateTime.now())
              ])),
          workOrderShift: WorkOrderShift(
            code: 'sdsd',
          )
          // @HiveField(7)
          // WorkOrderShift workOrderShift;
          ),
    ];

    await Future.delayed(Duration(milliseconds: 300));
    Box box = await HiveService.getClearBox(BoxNameStore.getTasksBox);
    tasks = tasks.cast<AllOrderPojo>();
    tasks.forEach((element) {
      if ((element).repairOrderPojo != null) {
        (element)
            .repairOrderPojo
            .laborSpending
            .sort((a, b) => b.dateAndTime.compareTo(a.dateAndTime));
      }
      if ((element).transportOrderPojo != null) {
        (element)
            .transportOrderPojo
            .work
            .laborSpending
            .sort((a, b) => b.dateAndTime.compareTo(a.dateAndTime));
      }

      box.add(element);
    });

    return tasks;
  }

  static Future<bool> submitTask(
      LaborSpending results, WorkOrderPojo task) async {
    final client = await Kinfolk.getClient();
    var url = Kinfolk.createRestUrl(
        mobileService(), MethodNames.setResult, Types.services);

    var body = '''
            {
            "userId": null,
            "workOrder": "${task.workOrderId}",
            "laborSpendingPojo": {
              "factEndDate":"${results.factEndDate}",
              "factObject":"${results.factObject}",
              "percentCompletion":"${results.percentCompletion}",
              "status":"${results.percentCompletion <= 100 ? "IN_PROCESS" : "COMPLETED"}"
             }
            }
        ''';

    var response = await client
        .post(url, body: body, headers: {'Content-Type': 'application/json'});
    if (response.body.contains('OK')) {
      return true;
    }
    return false;
  }

  static Future<bool> submitRepairTask(
      RepairOrderPojoLaborSpending laborSpending, RepairOrderPojo task) async {
    return true;
    // final client = await Kinfolk.getClient();
    // var url = Kinfolk.createRestUrl(
    //     mobileService(), MethodNames.setResultRLS, Types.services);
    // var body = '''
    //         {
    //           "repairOrder":"${task.id}",
    //           "repairLaborSpendingPojo":{
    //             "dateAndTime" : "${DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(laborSpending.dateAndTime)}",
    //             "percent":"${laborSpending.percent}",
    //             "status":"${laborSpending.status}"
    //           }
    //         }
    //     ''';
    //
    // var response = await client
    //     .post(url, body: body, headers: {'Content-Type': 'application/json'});
    // if (response.body.contains('OK')) {
    //   return true;
    // }
    // return false;
  }

  static Future<bool> submitTransportTask(
      WorkLaborSpending laborSpending, TransportOrderPojo task) async {
    final client = await Kinfolk.getClient();
    var url = Kinfolk.createRestUrl(
        mobileService(), MethodNames.setResultTLS, Types.services);

    var body = '''
            {
              "transportOrder" : "${task.id}",
              "transportWork":"${task.work.id}",
              "toLaborSpendingPojo":{
                "dateAndTime" : "${DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(laborSpending.dateAndTime)}",
                "tripQuantity":"${laborSpending.tripQuantity}",
                "milage":"${laborSpending.milage}",
                "turnover":"${laborSpending.turnover}",
                "status":"${laborSpending.status}"
              }
            }
        ''';

    var response = await client
        .post(url, body: body, headers: {'Content-Type': 'application/json'});
    if (response.body.contains('OK')) {
      return true;
    }
    return false;
  }

  static Future<bool> submitShiftTask(
      WorkLaborSpending laborSpending, WorkOrderShift task,
      {personGroupId}) async {
    final client = await Kinfolk.getClient();
    var url = Kinfolk.createRestUrl(
        mobileService(), MethodNames.setResultSLS, Types.services);
    var body = '''
            {
              "shiftOrder" : "${task.id}",
              "shiftWork":"${task.work.id}",
              "personGroupId":${personGroupId ?? '${personGroupId}'},
              "wosLaborSpendingPojo":{
                "dateAndTime" : "${DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(laborSpending.dateAndTime)}",
                "tripQuantity":"${laborSpending.tripQuantity}",
                "milage":"${laborSpending.milage}",
                "turnover":"${laborSpending.turnover}",
                "status":"${laborSpending.status}",
                "fact":${laborSpending.fact},
                "uom":"${laborSpending.uom}"
              }
            }
        ''';

    var response = await client
        .post(url, body: body, headers: {'Content-Type': 'application/json'});
    if (response.body.contains('OK')) {
      return true;
    }
    return false;
  }

  static Future<bool> submitShiftManagerTask(
      WorkLaborSpending laborSpending, WorkOrderShift task) async {
    final client = await Kinfolk.getClient();
    var url = Kinfolk.createRestUrl(
        mobileService(), MethodNames.setResultSLSE, Types.services);

    var body = '''
            {
              "shiftOrder" : "${task.id}",
              "shiftWork":"${task.work.id}",
              "wosLaborSpendingPojo":{
                "dateAndTime" : "${DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(laborSpending.dateAndTime)}",
                "fact":${laborSpending.fact},
                "uom":"${laborSpending.uom}"
              }
            }
        ''';

    var response = await client
        .post(url, body: body, headers: {'Content-Type': 'application/json'});
    if (response.body.contains('OK')) {
      return true;
    }
    return false;
  }

  static getCalendarEvents() async {
    var conn = await checkConnection();
    if (!conn) {
      var list =
      await HiveService.getOfflineListBox(BoxNameStore.getCalendarEvents);
      return list.cast<CalendarEvents>();
    }

    List EventsList = await Kinfolk.getListModelRest(
        serviceOrEntityName: mobileService(),
        methodName: MethodNames.getCalendarEvents,
        type: Types.services,
        fromMap: (val) => CalendarEvents.fromMap(val));

    Box box = await HiveService.getClearBox(BoxNameStore.getCalendarEvents);

    EventsList.forEach((e) => box.add(e));

    return EventsList.cast<CalendarEvents>();
  }

  static getNotifications() async {
    var conn = await checkConnection();
    if (!conn) {
      var list =
      await HiveService.getOfflineListBox(BoxNameStore.getNotifications);
      return list.cast<Notifications>();
    }
    // var notificationsList = [];
    // var readedNotifications = <String>[];
    // List getNotificationsList = await Kinfolk.getListModelRest(
    //     serviceOrEntityName: mobileService(),
    //     methodName: MethodNames.getNotifications,
    //     type: Types.services,
    //     fromMap: (val) => Notifications.fromMap(val));
    var response = [
      {
        "_entityName": "name",
        "id": "${Uuid().v4()}",
        "message": "TEST FAKE DATA",
        "fromPersonPojo": {
          "_entityName": "edsf",
          "id": "${Uuid().v4()}",
          "firstName": "firstName",
          "lastName": "lastName",
          "middleName": "middleName"
        },
        "isCloseable": false,
        "notificationTypeCode": "sdf",
        "createTs":
            "${DateFormat("yyyy-MM-dd HH:mm:ss.SSS").format(DateTime.now())}",
        "status": "APPROVED",
        "title": "Notification test",
      },
      {
        "_entityName": "name",
        "id": "${Uuid().v4()}",
        "message": "TEST FAKE DATA2",
        "fromPersonPojo": {
          "_entityName": "edsf",
          "id": "${Uuid().v4()}",
          "firstName": "firstName",
          "lastName": "lastName",
          "middleName": "middleName"
        },
        "isCloseable": false,
        "notificationTypeCode": "CAR_ORDER",
        "createTs":
        "${DateFormat("yyyy-MM-dd HH:mm:ss.SSS").format(DateTime.now())}",
        "status": "IS_NEW",
        "title": "Notification test2",
      }
    ];
    var getNotificationsList =
        List<Notifications>.from(response.map((x) => Notifications.fromMap(x)));

    // Box box;
    // if (kIsWeb) {
    //   box = await HiveService.getClearBox(BoxNameStore.getNotifications);
    // } else {
    //   box = await HiveService.getBox(BoxNameStore.getNotifications);
    // }
    //
    // notificationsList.addAll(box.values);
    // notificationsList.addAll(getNotificationsList);
    //
    // getNotificationsList.forEach((e) {
    //   readedNotifications.add(e.id);
    //   box.add(e);
    // });
    // if (readedNotifications.isNotEmpty) {
    //   setInactiveNotifications(readedNotifications);
    // }
    // notificationsList.sort((a, b) => b.createTs.compareTo(a.createTs));

    return getNotificationsList.cast<Notifications>();
  }

  static getDisciplineNotifications() async {
    var conn = await checkConnection();
    if (!conn) {
      return [];
    }
    List getNotificationsList = await Kinfolk.getListModelRest(
        serviceOrEntityName: mobileService(),
        methodName: MethodNames.getNotifications,
        type: Types.services,
        fromMap: (val) => Notifications.fromMap(val));

    getNotificationsList = getNotificationsList
        .cast<Notifications>()
        .where((element) => element.notificationTypeCode == 'DISCIPLINE')
        .toList();
    Box box;
    if (!kIsWeb) {
      box = await HiveService.getBox(BoxNameStore.getNotifications);
    }

    getNotificationsList.forEach((e) {
      box.add(e);
    });

    return getNotificationsList.cast<Notifications>();
  }

  static setInactiveNotifications(List<String> readedNotifications) async {
    if (readedNotifications.isEmpty) {
      return true;
    }
    var uuidS = '';
    readedNotifications.forEach((e) {
      uuidS = '$uuidS"$e",';
    });
    uuidS = uuidS.replaceRange(uuidS.length - 1, uuidS.length, '');
    var body = '''
    {
      "notificationIds":[$uuidS]
    }
    ''';

    var result = await Kinfolk.getSingleModelRest(
        serviceName: mobileService(),
        methodName: MethodNames.setInactiveNotifications,
        type: Types.services,
        body: body,
        fromMap: (val) => BaseResult.fromMap(val));

    return result.success ? result.success : result.errorDescription;
  }

  static Future<BaseResult> submitCarOrderRequest(Notifications notification, bool isAgree) async {
    // var body = '''
    //          {
    //           "requestId": "${notification.id}",
    //           "status": "${isAgree ? "APPROVED" : "UNAPPROVED"}"
    //         }
    //     ''';
    // var result = await Kinfolk.getSingleModelRest(
    //     serviceName: mobileService(),
    //     methodName: MethodNames.setNotificationAnswer,
    //     type: Types.services,
    //     body: body,
    //     fromMap: (val) => BaseResult.fromMap(val));
    var result = {
      "success": true,
      "errorDescription": "test",
    };
    return BaseResult(success: true, errorDescription: 'success');
    //
    // var response = CheckPersonResponse.fromMap(result);
    // return response;
  }

  static getAppealsTopic() async {
    var connection = await checkConnection();
    if (!connection) {
      return [].cast<AppealTopic>();
    }

    // List historyList = await Kinfolk.getListModelRest(
    //     serviceOrEntityName: mobileService(),
    //     methodName: MethodNames.getDicAppealsTopics,
    //     type: Types.services,
    //     fromMap: (val) => AppealTopic.fromMap(val));
    var response = [
      {
        "code": "MOBILE",
        "nameRu": "Мобильное приложение",
        "nameKz": "",
        "nameEn": "Mobile App"
      },
      {"code": "EATING", "nameRu": "Питание", "nameKz": "", "nameEn": "Eating"},
      {
        "code": "ALLOWANCE",
        "nameRu": "СКУД",
        "nameKz": "",
        "nameEn": "Security"
      },
      {
        "code": "TESTING",
        "nameRu": "Тестирование",
        "nameKz": "",
        "nameEn": "Testing"
      },
    ];
    var historyList =
        List<AppealTopic>.from(response.map((x) => AppealTopic.fromMap(x)));
    return historyList.cast<AppealTopic>();
  }

  static getEmployeeIndicators() async {
    var conn = await checkConnection();
    if (!conn) {
      var list =
      await HiveService.getOfflineListBox(BoxNameStore.getEmpindcBox);
      return list.cast<EmployeeIndicatorsValue>().first;
    }
    try {
      // EmployeeIndicatorsValue indicator = await Kinfolk.getSingleModelRest(
      //     serviceName: mobileService(),
      //     methodName: MethodNames.getEmployeeIndicatorsValue,
      //     type: Types.services,
      //     fromMap: (val) =>
      //         val == null ? null : EmployeeIndicatorsValue.fromMap(val));
      var indicator = EmployeeIndicatorsValue(
        indicatorValueOnDateList: [
          IndicatorValueOnDateList(
            date: DateTime.now(),
            equipment: Indicator(langValue: 'Indicator'),
            indicatorValueList: [
              IndicatorValueList(
                id: 'sd',
                entityName: '',
                indicatorValue: 1,
                indicator: Indicator(
                  code: 'dod',
                  isSystemRecord: false,
                  langValue: 'sdf',
                  version: 2,
                ),
              ),
              IndicatorValueList(
                id: 'sd',
                entityName: '',
                indicatorValue: 1,
                indicator: Indicator(
                  code: 'dod',
                  isSystemRecord: false,
                  langValue: 'sdf',
                  version: 2,
                ),
              ),
              IndicatorValueList(
                id: 'sd',
                entityName: '',
                indicatorValue: 1,
                indicator: Indicator(
                  code: 'dod',
                  isSystemRecord: true,
                  langValue: 'sdf',
                  version: 2,
                ),
                uom: Uom(description1: 'sds', code: 'sdfs'),
              ),
            ],
          ),
          IndicatorValueOnDateList(
            date: DateTime.now(),
            equipment: Indicator(langValue: 'Indicator2'),
            indicatorValueList: [
              IndicatorValueList(
                id: 'sd',
                entityName: '',
                indicatorValue: 1,
                indicator: Indicator(
                  code: 'dod',
                  isSystemRecord: false,
                  langValue: 'sdf',
                  version: 2,
                ),
              ),
              IndicatorValueList(
                id: 'sd',
                entityName: '',
                indicatorValue: 1,
                indicator: Indicator(
                  code: 'dod',
                  isSystemRecord: false,
                  langValue: 'sdf',
                  version: 2,
                ),
              ),
              IndicatorValueList(
                id: 'sd',
                entityName: '',
                indicatorValue: 1,
                indicator: Indicator(
                  code: 'dod',
                  isSystemRecord: true,
                  langValue: 'sdf',
                  version: 2,
                ),
                uom: Uom(description1: 'sds', code: 'sdfs'),
              ),
            ],
          ),
          IndicatorValueOnDateList(
            date: DateTime.now(),
            equipment: Indicator(langValue: 'Indicator3'),
            indicatorValueList: [
              IndicatorValueList(
                id: 'sd',
                entityName: '',
                indicatorValue: 1,
                indicator: Indicator(
                  code: 'dod',
                  isSystemRecord: false,
                  langValue: 'sdf',
                  version: 2,
                ),
              ),
              IndicatorValueList(
                id: 'sd',
                entityName: '',
                indicatorValue: 1,
                indicator: Indicator(
                  code: 'dod',
                  isSystemRecord: false,
                  langValue: 'sdf',
                  version: 2,
                ),
              ),
              IndicatorValueList(
                id: 'sd',
                entityName: '',
                indicatorValue: 1,
                indicator: Indicator(
                  code: 'dod',
                  isSystemRecord: true,
                  langValue: 'sdf',
                  version: 2,
                ),
                uom: Uom(description1: 'sds', code: 'sdfs'),
              ),
            ],
          ),
        ],
        indicatorTotalValueList: [
          IndicatorValueList(
              indicator: Indicator(
                code: 'sd',
                langValue: '',
              ),
              uom: Uom())
        ],
      );
      Box box = await HiveService.getClearBox(BoxNameStore.getEmpindcBox);
      await box.add(indicator);
      print(indicator);
      return indicator;
    } catch (e) {
      print(e);
    }
  }

  // static void setNewsRead(String newsId) async {
  //   var connection = await checkConnection();
  //   if (!connection) {
  //     return;
  //   }
  //
  //   await Kinfolk.getSingleModelRest(
  //     serviceName: mobileService(),
  //     methodName: MethodNames.setNewsRead,
  //     body: '''{
  //           "newsId":"$newsId"
  //           } ''',
  //     type: Types.services,
  //     fromMap: (val) => (val),
  //   );
  // }

  static getUserGuides() async {
    var conn = await checkConnection();
    if (!conn) {
      var list =
      await HiveService.getOfflineListBox(BoxNameStore.getUserGuides);
      return list.cast<KrjConfig>();
    }

    // List indicator = await Kinfolk.getListModelRest(
    //   serviceOrEntityName: 'krj_Config',
    //   methodName: MethodNames.search,
    //   type: Types.entities,
    //   filter: CubaEntityFilter(
    //     filter: Filter(
    //       conditions: [
    //         FilterCondition(
    //           property: 'code',
    //           conditionOperator: Operators.contains,
    //           value: 'USER_GUIDE',
    //         ),
    //       ],
    //     ),
    //     view: 'config-edit',
    //     sort: 'order',
    //     sortType: SortTypes.asc,
    //   ),
    //   fromMap: (val) => val == null ? null : KrjConfig.fromMap(val),
    // );
    var response = [
      {
        'entityName': 'test',
        'instanceName': 'USER_GUIDE',
        'id': '${Uuid().v4()}',
        'code': 'DRAFT',
        'description1': 'test fake',
        // 'configFile': {
        //   '_entityName': 'entityName',
        //   '_instanceName': 'instanceName',
        //   'id': '${Uuid().v4()}',
        //   'extension': 'extension',
        //   'name': 'name',
        //   'createDate': "${DateFormat("yyyy-MM-dd HH:mm:ss.SSS").format(DateTime.now())}",
        // },
        'isSystemRecord': true,
        'active': true,
        'isDefault': false,
        'langValue1': 'test',
        'order': 2,
      }
    ];
    var indicator =
        List<KrjConfig>.from(response.map((x) => KrjConfig.fromMap(x)));
    indicator = indicator.cast<KrjConfig>();
    Box box = await HiveService.getClearBox(BoxNameStore.getUserGuides);
    await box.addAll(indicator);

    return indicator;
  }

  static Future<File> downloadFile(String url, String fileName,
      {String folder = '',
        bool downloads = false,
        bool hasLocalFile = false}) async {
    var httpClient = HttpClient();
    File file;
    var filePath = '';
    var myUrl = '';
    var dir = '';
    var appDocDir = await getApplicationDocumentsDirectory();
    dir = appDocDir.path;
    filePath = '$dir/$fileName';

    if (hasLocalFile) {
      var savedImage = await File(url).copy(filePath);
      return savedImage;
    }
    var downloadsDirectory = await DownloadsPathProvider.downloadsDirectory;
    if (downloads) {
      filePath = '${downloadsDirectory.path}/$fileName';
    }
    if (await File(filePath).exists()) {
      print('fileExist');
      return File(filePath);
    }
    try {
      myUrl = url;
      var request = await httpClient.getUrl(Uri.parse(myUrl));
      var response = await request.close();
      if (response.statusCode == 200) {
        var bytes = await consolidateHttpClientResponseBytes(response);
        file = File(filePath);
        await file.writeAsBytes(bytes);
      } else {
        throw Exception('Error code: ' + response.statusCode.toString());
      }
    } catch (ex) {
      Get.snackbar(S.current.attention, ex.message);
      throw Exception(ex.message);
    }
    return file;
  }

  static Future<PercentilePojo> getPercentile() async {
    var conn = await checkConnection();
    if (!conn) {
      var list = await HiveService.getOfflineListBox(BoxNameStore.getPerRating);
      return list.cast<PercentilePojo>().first;
    }

    // var date = DateFormat('dd.MM.yyyy').format(DateTime.now());

    // PercentilePojo indicator = await Kinfolk.getSingleModelRest(
    //     serviceName: mobileService(),
    //     methodName: 'getPercentile?date=$date',
    //     type: Types.services,
    //     fromMap: (val) => val == null ? null : PercentilePojo.fromMap(val));

    var indicator = PercentilePojo(
        lowLimit: 0,
        highLimit: 1450,
        lowestScore: 290,
        highestScore: 1160,
        totalNumberOfScores: 1450,
        currentEmpRank: 942,
        currentEmpRating: 9.0);

    Box box = await HiveService.getClearBox(BoxNameStore.getPerRating);
    await box.add(indicator);
    print(indicator);
    return indicator;
  }

  static void getAppVersion() async {
    if (!(await checkConnection())) {
      return null;
    }
    var url = Kinfolk.createRestUrl(
        mobileService(), MethodNames.getAppVersion, Types.services);
    var response = await http.get(url, headers: Kinfolk.appJsonHeader);

    var versionsMap = jsonDecode(response.body) as Map;
    var latestVersion = Version.parse(versionsMap['latestVersion']);
    var minimalVersion = Version.parse(versionsMap['minimalVersion']);

    if (currentVersion < minimalVersion) {
      await Get.offAndToNamed('/update');
    }

    if (currentVersion < latestVersion) {
      // ignore: unawaited_futures
      Get.dialog(CupertinoAlertDialog(
        title: Text(S.current.attention),
        content: Text(S.current.updateIsAvailable),
      ));
    }
  }

  static Future<Uint8List> downloadFileData(String url) async {
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        throw Exception('Error code: ' + response.statusCode.toString());
      }
    } catch (ex) {
      Get.snackbar(S.current.attention, ex.message);
      throw Exception(ex.message);
    }
  }

  static Future<RegisterResponseData> register(
      {@required RegisterRequest request}) async {
    var url = Kinfolk.createRestUrl(
      mobileService(),
      MethodNames.getLoginAndPassword,
      Types.services,
    );

    var body = '''{
              "phoneDataJson": ${request.toJson()}
            }''';

    var response =
    await http.post(url, body: body, headers: Kinfolk.appJsonHeader);

    return RegisterResponseData.fromJson(response.body);
  }

  ////Messages
  static Future getMessages() async {
    var conn = await checkConnection();
    var list =
        await HiveService.getOfflineListBox(BoxNameStore.getUserMessages);
    if (!conn) {
      return list.cast<Message>();
    } else if (list.isNotEmpty) {
      return list.cast<Message>();
    }
    try {
      var messageList = [
        {
          "_entityName": "krj_MessagePojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.MessagePojo-507435d4-ae2f-3148-8c6d-85a9f27a6294 [new]",
          "id": "507435d4-ae2f-3148-8c6d-64c5d18q75",
          "requestNumber": "AIT-12-23",
          "initiator": {
            "_entityName": "krj_PersonPojo",
            "_instanceName": "Жакеев",
            "id": "3fb7c8ff-ba5b-0d8a-754e-qf24j13456q6",
            "lastName": "Нұржан",
            "image": "5f60b797-ff34-d23a-c9f0-c09e8b00070e",
            "firstName": "Жакеев",
            "middleName": "Құралбекұлы"
          },
          "violatedEmployees": [
            {
              "_entityName": "krj_PersonPojo",
              "_instanceName": "Денис",
              "id": "c86b14f9-6450-3ef8-1108-102gv8014f8q",
              "lastName": "Хайбулин",
              "groupId": "5f2e6edf-9e87-c740-46d3-1915e89340f3",
              "photo": {
                "_entityName": "sys$FileDescriptor",
                "_instanceName": "хайбулин д (25.08.2020 19:07)",
                "id": "e2289aa4-83a3-5ef1-3617-3b98b00fa2e4",
                "extension": "JPEG",
                "name": "хайбулин д",
                "version": 1,
                "createDate": "2020-08-25 19:07:36.051"
              },
              "firstName": "Денис",
              "organization": "АО \"Каражыра\"",
              "middleName": "Гахпляхатович",
              "nationalIdentifier": "820620300448"
            }
          ],
          "initiatorPrivacy": false,
          "initDateTime": "2021-09-04 12:53:34.000",
          "sevirity": {
            "_entityName": "krj_DicSevirityPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicSevirityPojo-a62561cf-dba0-a8c2-998f-e78a3a2282ff [new]",
            "id": "a62561cf-dba0-a8c2-998f-e29r4p2193gr",
            "code": "LOW",
            "langValue": "Низкий"
          },
          "organization": {
            "_entityName": "krj_OrganizationPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.OrganizationPojo-eaad86be-54a3-8dfa-a00e-f3b435d2cb61 [new]",
            "id": "eaad86be-54a3-8dfa-a00e-f4o652l6or52",
            "organizationName": "АО \"Каражыра\"",
            "groupId": "6fb225ef-2d01-9941-0b19-e12654b8089a"
          },
          "objectName": {
            "_entityName": "krj_DicObjectName",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicObjectNamePojo-7fe0404f-b96b-d328-af05-67f2592abf2e [new]",
            "id": "7fe0404f-b96b-d328-af05-67f2592abf2e",
            "code": "KITCHEN_WORK",
            "langValue": "Кухня Рабочая",
            "department": {
              "_entityName": "krj_DepartmentPojo",
              "_instanceName":
                  "kz.uco.krj.hse.restpojo.DepartmentPojo-c11426d4-82df-696f-76e2-8dd972f51ecd [new]",
              "id": "c11426d4-82df-696f-76e2-8dd972h32iop",
              "departmentName": "(АРОхр) Рабочие службы безопасности",
              "groupId": "71b089b9-016b-4341-32d4-60054bdae439"
            }
          },
          "files": [
            {
              "_entityName": "sys$FileDescriptor",
              "_instanceName": "_image_.png (14.07.2021 18:34)",
              "id": "6169fa18-f4ad-c7d4-6e56-1339fa62c8b6",
              "extension": "png",
              "name": "_image_.png",
              "version": 1,
              "createDate": "2021-07-14 18:34:13.436"
            }
          ],
          "takenAction": {
            "_entityName": "krj_DicTakenAction",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicTakenActionPojo-6d9d52af-69fd-880f-9a1a-3c5264f5bce7 [new]",
            "id": "6d9d52af-69fd-880f-9a1a-3c5264f5bce7",
            "code": "WORK_SUSPENDED",
            "langValue": "Работы приостановлены"
          },
          "category": {
            "_entityName": "krj_DicMessageCategoryPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicMessageCategoryPojo-3695707e-23e2-4f92-8d36-86b371bb56e9 [new]",
            "id": "3695707e-23e2-4f92-8d36-86b371bb56e9",
            "code": "DA",
            "langValue": "ОД"
          },
          "department": {
            "_entityName": "krj_DepartmentPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DepartmentPojo-c11426d4-82df-696f-76e2-8dd972f51ecd [new]",
            "id": "c11426d4-82df-696f-76e2-8dd972f52qwe",
            "departmentName": "(АРОхр) Рабочие службы безопасности",
            "groupId": "c11426d4-82df-696f-76e2-8dd972f51ecd"
          },
          "dangerousActions": [
            {
              "_entityName": "krj_DicDangerousActionPojo",
              "_instanceName":
                  "kz.uco.krj.hse.restpojo.DicDangerousActionPojo-2c034741-dd2b-cdde-955e-e080c722f96c [new]",
              "id": "2c034741-dd2b-cdde-955e-e080c722f96c",
              "code": "NO_PERMIT",
              "langValue": "Без наряд задания/допуска"
            },
            {
              "_entityName": "krj_DicDangerousActionPojo",
              "_instanceName":
                  "kz.uco.krj.hse.restpojo.DicDangerousActionPojo-acb2c359-4530-6c8d-e2c6-5f1eb6d2d04d [new]",
              "id": "acb2c359-4530-6c8d-e2c6-5f1eb6d2d04d",
              "code": "NO_BELTS",
              "langValue": "Без предохранительных поясов"
            }
          ],
          "status": {
            "_entityName": "krj_DicMessageStatusPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicMessageStatusPojo-304aca95-ddf3-8f95-9441-87fac553073d [new]",
            "id": "304aca95-ddf3-8f95-9441-87fac553052s",
            "code": "APPROVED",
            "langValue": "Зарегистрирован"
          }
        },
        {
          "_entityName": "krj_MessagePojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.MessagePojo-5e59cc42-d606-7eed-2923-032e94243009 [new]",
          "id": "5e59cc42-d606-7eed-2923-032e96244503",
          "initiator": {
            "_entityName": "krj_PersonPojo",
            "_instanceName": "Жакеев",
            "id": "3fb7c8ff-ba5b-0d8a-754e-db18e023789r5",
            "lastName": "Нұржан",
            "image": "5f60b797-ff34-d23a-c9f0-c09e8b00070e",
            "firstName": "Жакеев",
            "middleName": "Құралбекұлы"
          },
          "violatedEmployees": [
            {
              "_entityName": "krj_PersonPojo",
              "_instanceName": "Денис",
              "id": "c86b14f9-6450-3ef8-1108-302fd8045r51r",
              "lastName": "Хайбулин",
              "groupId": "5f2e6edf-9e87-c740-46d3-1915e89340f3",
              "photo": {
                "_entityName": "sys$FileDescriptor",
                "_instanceName": "хайбулин д (25.08.2020 19:07)",
                "id": "e2289aa4-83a3-5ef1-3617-3b98b00as5f4h",
                "extension": "JPEG",
                "name": "хайбулин д",
                "version": 1,
                "createDate": "2020-08-25 19:07:36.051"
              },
              "firstName": "Денис",
              "organization": "АО \"Каражыра\"",
              "middleName": "Гахпляхатович",
              "nationalIdentifier": "820620300448"
            }
          ],
          "initiatorPrivacy": false,
          "requestNumber": "AIT-18-23",
          "initDateTime": "2021-09-06 12:53:34.000",
          "sevirity": {
            "_entityName": "krj_DicSevirityPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicSevirityPojo-a62561cf-dba0-a8c2-998f-e78a3a2282ff [new]",
            "id": "a62561cf-dba0-a8c2-998f-e78a3a2285we",
            "code": "LOW",
            "langValue": "Низкий"
          },
          "organization": {
            "_entityName": "krj_OrganizationPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.OrganizationPojo-eaad86be-54a3-8dfa-a00e-f3b435d2cb61 [new]",
            "id": "eaad86be-54a3-8dfa-a00e-f3b435d2c5d5",
            "organizationName": "АО \"Каражыра\"",
            "groupId": "6fb225ef-2d01-9941-0b19-e12654b8089a"
          },
          "objectName": {
            "_entityName": "krj_DicObjectName",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicObjectNamePojo-7fe0404f-b96b-d328-af05-67f2592abf2e [new]",
            "id": "7fe0404f-b96b-d328-af05-67f25fabf2e",
            "code": "KITCHEN_WORK",
            "langValue": "Кухня Рабочая",
            "department": {
              "_entityName": "krj_DepartmentPojo",
              "_instanceName":
                  "kz.uco.krj.hse.restpojo.DepartmentPojo-c11426d4-82df-696f-76e2-8dd972f51ecd [new]",
              "id": "c11426d4-82df-696f-76e2-6ad972f51scd",
              "departmentName": "(АРОхр) Рабочие службы безопасности",
              "groupId": "71b089b9-016b-4341-32d4-60054bdae439"
            }
          },
          "files": [
            {
              "_entityName": "sys$FileDescriptor",
              "_instanceName": "_image_.png (14.07.2021 18:34)",
              "id": "6169fa18-f4ad-c7d4-6e56-1339fa62c8b6",
              "extension": "png",
              "name": "_image_.png",
              "version": 1,
              "createDate": "2021-07-14 18:34:13.436"
            }
          ],
          "takenAction": {
            "_entityName": "krj_DicTakenAction",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicTakenActionPojo-6d9d52af-69fd-880f-9a1a-3c5264f5bce7 [new]",
            "id": "6d9d52af-69fd-880f-9a1a-3c5264f5bce7",
            "code": "WORK_SUSPENDED",
            "langValue": "Работы приостановлены"
          },
          "category": {
            "_entityName": "krj_DicMessageCategoryPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicMessageCategoryPojo-3695707e-23e2-4f92-8d36-86b371bb56e9 [new]",
            "id": "3695707e-23e2-4f92-8d36-86b371wq46e9",
            "code": "DA",
            "langValue": "ОД"
          },
          "department": {
            "_entityName": "krj_DepartmentPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DepartmentPojo-c11426d4-82df-696f-76e2-8dd972f51ecd [new]",
            "id": "c11426d4-82df-696f-76e2-8dd972f65qcd",
            "departmentName": "(АРОхр) Рабочие службы безопасности",
            "groupId": "c11426d4-82df-696f-76e2-8dd972f51ecd"
          },
          "dangerousActions": [
            {
              "_entityName": "krj_DicDangerousActionPojo",
              "_instanceName":
                  "kz.uco.krj.hse.restpojo.DicDangerousActionPojo-2c034741-dd2b-cdde-955e-e080c722f96c [new]",
              "id": "2c034741-dd2b-cdde-955e-e080c722f96c",
              "code": "NO_PERMIT",
              "langValue": "Без наряд задания/допуска"
            },
            {
              "_entityName": "krj_DicDangerousActionPojo",
              "_instanceName":
                  "kz.uco.krj.hse.restpojo.DicDangerousActionPojo-acb2c359-4530-6c8d-e2c6-5f1eb6d2d04d [new]",
              "id": "acb2c359-4530-6c8d-e2c6-5f1eb6d2d04d",
              "code": "NO_BELTS",
              "langValue": "Без предохранительных поясов"
            }
          ],
          "status": {
            "_entityName": "krj_DicMessageStatusPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicMessageStatusPojo-304aca95-ddf3-8f95-9441-87fac553073d [new]",
            "id": "a565104e-fb4c-4338-92a4-a66c097569d1",
            "code": "CLOSED",
            "langValue": "Закрыт"
          }
        },
        {
          "_entityName": "krj_MessagePojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.MessagePojo-507435d4-ae2f-3148-8c6d-85a9f27a6294 [new]",
          "id": "507435d4-ae2f-3148-8c6d-64c5d18dg44d",
          "initiator": {
            "_entityName": "krj_PersonPojo",
            "_instanceName": "Жакеев",
            "id": "3fb7c8ff-ba5b-0d8a-754e-qf24j13456q6",
            "lastName": "Нұржан",
            "image": "5f60b797-ff34-d23a-c9f0-c09e8b00070e",
            "firstName": "Жакеев",
            "middleName": "Құралбекұлы"
          },
          "violatedEmployees": [
            {
              "_entityName": "krj_PersonPojo",
              "_instanceName": "Денис",
              "id": "c86b14f9-6450-3ef8-1108-102gv8014f8q",
              "lastName": "Хайбулин",
              "groupId": "5f2e6edf-9e87-c740-46d3-1915e89340f3",
              "photo": {
                "_entityName": "sys$FileDescriptor",
                "_instanceName": "хайбулин д (25.08.2020 19:07)",
                "id": "e2289aa4-83a3-5ef1-3617-3b98b00fa2e4",
                "extension": "JPEG",
                "name": "хайбулин д",
                "version": 1,
                "createDate": "2020-08-25 19:07:36.051"
              },
              "firstName": "Денис",
              "organization": "АО \"Каражыра\"",
              "middleName": "Гахпляхатович",
              "nationalIdentifier": "820620300448"
            }
          ],
          "initiatorPrivacy": false,
          "requestNumber": "AIT-12-53",
          "initDateTime": "2021-09-04 12:53:34.000",
          "sevirity": {
            "_entityName": "krj_DicSevirityPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicSevirityPojo-a62561cf-dba0-a8c2-998f-e78a3a2282ff [new]",
            "id": "a62561cf-dba0-a8c2-998f-e29r4p2193gr",
            "code": "LOW",
            "langValue": "Низкий"
          },
          "organization": {
            "_entityName": "krj_OrganizationPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.OrganizationPojo-eaad86be-54a3-8dfa-a00e-f3b435d2cb61 [new]",
            "id": "eaad86be-54a3-8dfa-a00e-f4o652l6or52",
            "organizationName": "АО \"Каражыра\"",
            "groupId": "6fb225ef-2d01-9941-0b19-e12654b8089a"
          },
          "objectName": {
            "_entityName": "krj_DicObjectName",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicObjectNamePojo-7fe0404f-b96b-d328-af05-67f2592abf2e [new]",
            "id": "7fe0404f-b96b-d328-af05-67f2592abf2e",
            "code": "KITCHEN_WORK",
            "langValue": "Кухня Рабочая",
            "department": {
              "_entityName": "krj_DepartmentPojo",
              "_instanceName":
                  "kz.uco.krj.hse.restpojo.DepartmentPojo-c11426d4-82df-696f-76e2-8dd972f51ecd [new]",
              "id": "c11426d4-82df-696f-76e2-8dd972h32iop",
              "departmentName": "(АРОхр) Рабочие службы безопасности",
              "groupId": "71b089b9-016b-4341-32d4-60054bdae439"
            }
          },
          "files": [
            {
              "_entityName": "sys$FileDescriptor",
              "_instanceName": "_image_.png (14.07.2021 18:34)",
              "id": "6169fa18-f4ad-c7d4-6e56-1339fa62c8b6",
              "extension": "png",
              "name": "_image_.png",
              "version": 1,
              "createDate": "2021-07-14 18:34:13.436"
            }
          ],
          "takenAction": {
            "_entityName": "krj_DicTakenAction",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicTakenActionPojo-6d9d52af-69fd-880f-9a1a-3c5264f5bce7 [new]",
            "id": "6d9d52af-69fd-880f-9a1a-3c5264f5bce7",
            "code": "WORK_SUSPENDED",
            "langValue": "Работы приостановлены"
          },
          "category": {
            "_entityName": "krj_DicMessageCategoryPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicMessageCategoryPojo-3695707e-23e2-4f92-8d36-86b371bb56e9 [new]",
            "id": "3695707e-23e2-4f92-8d36-86b371bb56e9",
            "code": "DA",
            "langValue": "ОД"
          },
          "department": {
            "_entityName": "krj_DepartmentPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DepartmentPojo-c11426d4-82df-696f-76e2-8dd972f51ecd [new]",
            "id": "c11426d4-82df-696f-76e2-8dd972f52qwe",
            "departmentName": "(АРОхр) Рабочие службы безопасности",
            "groupId": "c11426d4-82df-696f-76e2-8dd972f51ecd"
          },
          "dangerousActions": [
            {
              "_entityName": "krj_DicDangerousActionPojo",
              "_instanceName":
                  "kz.uco.krj.hse.restpojo.DicDangerousActionPojo-2c034741-dd2b-cdde-955e-e080c722f96c [new]",
              "id": "2c034741-dd2b-cdde-955e-e080c722f96c",
              "code": "NO_PERMIT",
              "langValue": "Без наряд задания/допуска"
            },
            {
              "_entityName": "krj_DicDangerousActionPojo",
              "_instanceName":
                  "kz.uco.krj.hse.restpojo.DicDangerousActionPojo-acb2c359-4530-6c8d-e2c6-5f1eb6d2d04d [new]",
              "id": "acb2c359-4530-6c8d-e2c6-5f1eb6d2d04d",
              "code": "NO_BELTS",
              "langValue": "Без предохранительных поясов"
            }
          ],
          "status": {
            "_entityName": "krj_DicMessageStatusPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicMessageStatusPojo-304aca95-ddf3-8f95-9441-87fac553073d [new]",
            "id": "fac465ae-b489-6ceb-5c9a-1b32827d8ce9",
            "code": "CANCELED",
            "langValue": "Отменен"
          }
        },
        {
          "_entityName": "krj_MessagePojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.MessagePojo-5e59cc42-d606-7eed-2923-032e94243009 [new]",
          "id": "5e59cc42-d606-7eed-2923-032e962df554",
          "initiator": {
            "_entityName": "krj_PersonPojo",
            "_instanceName": "Жакеев",
            "id": "3fb7c8ff-ba5b-0d8a-754e-db18e023789r5",
            "lastName": "Нұржан",
            "image": "5f60b797-ff34-d23a-c9f0-c09e8b00070e",
            "firstName": "Жакеев",
            "middleName": "Құралбекұлы"
          },
          "violatedEmployees": [
            {
              "_entityName": "krj_PersonPojo",
              "_instanceName": "Денис",
              "id": "c86b14f9-6450-3ef8-1108-302fd8045r51r",
              "lastName": "Хайбулин",
              "groupId": "5f2e6edf-9e87-c740-46d3-1915e89340f3",
              "photo": {
                "_entityName": "sys$FileDescriptor",
                "_instanceName": "хайбулин д (25.08.2020 19:07)",
                "id": "e2289aa4-83a3-5ef1-3617-3b98b00as5f4h",
                "extension": "JPEG",
                "name": "хайбулин д",
                "version": 1,
                "createDate": "2020-08-25 19:07:36.051"
              },
              "firstName": "Денис",
              "organization": "АО \"Каражыра\"",
              "middleName": "Гахпляхатович",
              "nationalIdentifier": "820620300448"
            }
          ],
          "initiatorPrivacy": false,
          "requestNumber": "AIT-72-93",
          "initDateTime": "2021-09-06 12:53:34.000",
          "sevirity": {
            "_entityName": "krj_DicSevirityPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicSevirityPojo-a62561cf-dba0-a8c2-998f-e78a3a2282ff [new]",
            "id": "a62561cf-dba0-a8c2-998f-e78a3a2285we",
            "code": "LOW",
            "langValue": "Низкий"
          },
          "organization": {
            "_entityName": "krj_OrganizationPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.OrganizationPojo-eaad86be-54a3-8dfa-a00e-f3b435d2cb61 [new]",
            "id": "eaad86be-54a3-8dfa-a00e-f3b435d2c5d5",
            "organizationName": "АО \"Каражыра\"",
            "groupId": "6fb225ef-2d01-9941-0b19-e12654b8089a"
          },
          "objectName": {
            "_entityName": "krj_DicObjectName",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicObjectNamePojo-7fe0404f-b96b-d328-af05-67f2592abf2e [new]",
            "id": "7fe0404f-b96b-d328-af05-67f25fabf2e",
            "code": "KITCHEN_WORK",
            "langValue": "Кухня Рабочая",
            "department": {
              "_entityName": "krj_DepartmentPojo",
              "_instanceName":
                  "kz.uco.krj.hse.restpojo.DepartmentPojo-c11426d4-82df-696f-76e2-8dd972f51ecd [new]",
              "id": "c11426d4-82df-696f-76e2-6ad972f51scd",
              "departmentName": "(АРОхр) Рабочие службы безопасности",
              "groupId": "71b089b9-016b-4341-32d4-60054bdae439"
            }
          },
          "files": [
            {
              "_entityName": "sys$FileDescriptor",
              "_instanceName": "_image_.png (14.07.2021 18:34)",
              "id": "6169fa18-f4ad-c7d4-6e56-1339fa62c8b6",
              "extension": "png",
              "name": "_image_.png",
              "version": 1,
              "createDate": "2021-07-14 18:34:13.436"
            }
          ],
          "takenAction": {
            "_entityName": "krj_DicTakenAction",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicTakenActionPojo-6d9d52af-69fd-880f-9a1a-3c5264f5bce7 [new]",
            "id": "6d9d52af-69fd-880f-9a1a-3c5264f5bce7",
            "code": "WORK_SUSPENDED",
            "langValue": "Работы приостановлены"
          },
          "category": {
            "_entityName": "krj_DicMessageCategoryPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicMessageCategoryPojo-3695707e-23e2-4f92-8d36-86b371bb56e9 [new]",
            "id": "3695707e-23e2-4f92-8d36-86b371wq46e9",
            "code": "DA",
            "langValue": "ОД"
          },
          "department": {
            "_entityName": "krj_DepartmentPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DepartmentPojo-c11426d4-82df-696f-76e2-8dd972f51ecd [new]",
            "id": "c11426d4-82df-696f-76e2-8dd972f65qcd",
            "departmentName": "(АРОхр) Рабочие службы безопасности",
            "groupId": "c11426d4-82df-696f-76e2-8dd972f51ecd"
          },
          "dangerousActions": [
            {
              "_entityName": "krj_DicDangerousActionPojo",
              "_instanceName":
                  "kz.uco.krj.hse.restpojo.DicDangerousActionPojo-2c034741-dd2b-cdde-955e-e080c722f96c [new]",
              "id": "2c034741-dd2b-cdde-955e-e080c722f96c",
              "code": "NO_PERMIT",
              "langValue": "Без наряд задания/допуска"
            },
            {
              "_entityName": "krj_DicDangerousActionPojo",
              "_instanceName":
                  "kz.uco.krj.hse.restpojo.DicDangerousActionPojo-acb2c359-4530-6c8d-e2c6-5f1eb6d2d04d [new]",
              "id": "acb2c359-4530-6c8d-e2c6-5f1eb6d2d04d",
              "code": "NO_BELTS",
              "langValue": "Без предохранительных поясов"
            }
          ],
          "status": {
            "_entityName": "krj_DicMessageStatusPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicMessageStatusPojo-304aca95-ddf3-8f95-9441-87fac553073d [new]",
            "id": "10218553-fa51-bc9d-f274-d89a1447a1c5",
            "code": "DISTRIBUTED",
            "langValue": "Распределен"
          }
        }
      ];
      // List messageList = await Kinfolk.getListModelRest(
      //     serviceOrEntityName: mobileService(),
      //     methodName: MethodNames.getUserMessages,
      //     type: Types.services,
      //     fromMap: (val) => Message.fromMap(val));

      var menuList =
          List<Message>.from(messageList.map((x) => Message.fromMap(x)));

      var list = await HiveService.syncMessageData(
          BoxNameStore.getUserMessages, menuList);
      return list.cast<Message>();
    } catch (e) {
      print(e);
    }
  }

  static Future getDicMessageCategories(bool isList) async {
    var conn = await checkConnection();
    if (!conn) {
      var list = await HiveService.getOfflineListBox(
          BoxNameStore.getDicMessageCategories);
      return list.cast<AbstractDictionary>();
    }

    if (isList) {
      var list = await HiveService.getOfflineListBox(
          BoxNameStore.getDicMessageCategories);
      if (list.isNotEmpty) {
        return list.cast<AbstractDictionary>();
      }
    }

    try {
      // List response = await Kinfolk.getListModelRest(
      //     serviceOrEntityName: mobileService(),
      //     methodName: MethodNames.getDicMessageCategories,
      //     type: Types.services,
      //     fromMap: (val) => AbstractDictionary.fromMap(val));
      var response = [
        {
          "_entityName": "krj_DicMessageCategoryPojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.DicMessageCategoryPojo-6f4164c6-4c0a-9504-bd58-89abf9e33184 [new]",
          "id": "6f4164c6-4c0a-9504-bd58-89abf9e33132",
          "code": "DC",
          "langValue": "ОУ"
        },
        {
          "_entityName": "krj_DicMessageCategoryPojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.DicMessageCategoryPojo-3695707e-23e2-4f92-8d36-86b371bb56e9 [new]",
          "id": "3695707e-23e2-4f92-8d36-86b371bb646d5",
          "code": "DA",
          "langValue": "ОД"
        },
        {
          "_entityName": "krj_DicMessageCategoryPojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.DicMessageCategoryPojo-25a2e626-79ea-98de-c730-4bc9ac993089 [new]",
          "id": "25a2e626-79ea-98de-c730-4bc9ac125468",
          "code": "OTHER",
          "langValue": "Другое"
        }
      ];
      var categoryList = List<AbstractDictionary>.from(
          response.map((x) => AbstractDictionary.fromMap(x)));
      Box box =
          await HiveService.getClearBox(BoxNameStore.getDicMessageCategories);
      categoryList.forEach((e) {
        box.add(e);
      });
      return categoryList.cast<AbstractDictionary>();
    } catch (e) {
      print(e);
    }
  }

  static Future getConditionCategory(bool withLocal) async {
    var conn = await checkConnection();
    if (!conn) {
      var list = await HiveService.getOfflineListBox(
          BoxNameStore.getConditionCategory);
      return list.cast<ConditionCategory>();
    }

    if (withLocal) {
      var list = await HiveService.getOfflineListBox(
          BoxNameStore.getConditionCategory);
      if (list.isNotEmpty) {
        return list.cast<ConditionCategory>();
      }
    }
    try {
      var response = [
        {
          "_entityName": "krj_DicDangerousConditionPojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.DicConditionCategoryPojo-a4bb3e23-5a7f-a532-8e3c-884fd81c6013 [new]",
          "id": "a4bb3e23-5a7f-a532-8e3c-884fd81c6013",
          "code": "CHEMICAL_GAS",
          "langValue": "Газы и химические вещества",
          "conditions": [
            {
              "_entityName": "krj_DicDangerousConditionCategory",
              "_instanceName":
                  "kz.uco.krj.hse.restpojo.DicDangerousConditionPojo-553c5d3e-bcb2-a138-5e7d-723288ad34ab [new]",
              "id": "553c5d3e-bcb2-a138-5e7d-723288ad34ab",
              "code": "TOXIC_SUBSTANCES",
              "langValue": "Ядовитые вещества"
            },
            {
              "_entityName": "krj_DicDangerousConditionCategory",
              "_instanceName":
                  "kz.uco.krj.hse.restpojo.DicDangerousConditionPojo-e11676d2-1feb-d1bf-92f6-3b93a6ccebbb [new]",
              "id": "e11676d2-1feb-d1bf-92f6-3b93a6ccebbb",
              "code": "CORROSIVE_SUBSTANCES",
              "langValue": "Едкие вещества"
            },
            {
              "_entityName": "krj_DicDangerousConditionCategory",
              "_instanceName":
                  "kz.uco.krj.hse.restpojo.DicDangerousConditionPojo-d9596f1e-e201-34a6-c81d-44aecf16f110 [new]",
              "id": "d9596f1e-e201-34a6-c81d-44aecf16f110",
              "code": "CHEMICAL_VAPORS",
              "langValue": "Газы или пары химических веществ"
            }
          ]
        },
        {
          "_entityName": "krj_DicDangerousConditionPojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.DicConditionCategoryPojo-a076930b-fe3c-57ad-c98d-74460e769005 [new]",
          "id": "a076930b-fe3c-57ad-c98d-74460e769005",
          "code": "FALLING",
          "langValue": "Падение",
          "conditions": [
            {
              "_entityName": "krj_DicDangerousConditionCategory",
              "_instanceName":
                  "kz.uco.krj.hse.restpojo.DicDangerousConditionPojo-512a9b13-f8a8-44bd-52c9-377d2cc9c971 [new]",
              "id": "512a9b13-f8a8-44bd-52c9-377d2cc9c971",
              "code": "SUSPENDED_LOADS",
              "langValue": "Подвешенные грузы"
            },
            {
              "_entityName": "krj_DicDangerousConditionCategory",
              "_instanceName":
                  "kz.uco.krj.hse.restpojo.DicDangerousConditionPojo-bcbc6dbc-80b3-ea3e-56e6-57a05a6822cb [new]",
              "id": "bcbc6dbc-80b3-ea3e-56e6-57a05a6822cb",
              "code": "ROCK_PIECES",
              "langValue": "Заколы/куски горной массы"
            },
          ]
        },
      ];
      // List response = await Kinfolk.getListModelRest(
      //     serviceOrEntityName: mobileService(),
      //     methodName: MethodNames.getDicDangerousConditions,
      //     type: Types.services,
      //     fromMap: (val) => ConditionCategory.fromMap(val));
      var conditionList = List<ConditionCategory>.from(
          response.map((x) => ConditionCategory.fromMap(x)));
      Box box =
          await HiveService.getClearBox(BoxNameStore.getConditionCategory);
      conditionList.forEach((e) {
        box.add(e);
      });
      return conditionList.cast<ConditionCategory>();
    } catch (e) {
      print(e);
    }
  }

  static Future getTakenActions(bool isList) async {
    var conn = await checkConnection();
    if (!conn) {
      var list =
      await HiveService.getOfflineListBox(BoxNameStore.getTakenActions);
      return list.cast<AbstractDictionary>();
    }

    if (isList) {
      var list =
      await HiveService.getOfflineListBox(BoxNameStore.getTakenActions);
      if (list.isNotEmpty) {
        return list.cast<AbstractDictionary>();
      }
    }

    try {
      // List response = await Kinfolk.getListModelRest(
      //     serviceOrEntityName: mobileService(),
      //     methodName: MethodNames.getDicTakenActions,
      //     type: Types.services,
      //     fromMap: (val) => AbstractDictionary.fromMap(val));
      var response = [
        {
          "_entityName": "krj_DicTakenAction",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.DicTakenActionPojo-6d9d52af-69fd-880f-9a1a-3c5264f5bce7 [new]",
          "id": "6d9d52af-69fd-880f-9a1a-3c5264f5bce7",
          "code": "WORK_SUSPENDED",
          "langValue": "Работы приостановлены"
        },
        {
          "_entityName": "krj_DicTakenAction",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.DicTakenActionPojo-d44c520a-6d94-0034-d87b-1803255a9ed4 [new]",
          "id": "d44c520a-6d94-0034-d87b-1803255a9ed4",
          "code": "SOLVED",
          "langValue": "Нарушение устранено самостоятельно"
        },
        {
          "_entityName": "krj_DicTakenAction",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.DicTakenActionPojo-c9c10319-c2dc-3e37-5aa9-7616829f9c41 [new]",
          "id": "c9c10319-c2dc-3e37-5aa9-7616829f9c41",
          "code": "NOTHING",
          "langValue": "Ничего не предпринято"
        }
      ];
      var takenList = List<AbstractDictionary>.from(
          response.map((x) => AbstractDictionary.fromMap(x)));
      Box box = await HiveService.getClearBox(BoxNameStore.getTakenActions);
      takenList.forEach((e) {
        box.add(e);
      });

      return takenList.cast<AbstractDictionary>();
    } catch (e) {
      print(e);
    }
  }

  static Future getDangerousActions(bool isList) async {
    var conn = await checkConnection();

    if (!conn) {
      var list =
      await HiveService.getOfflineListBox(BoxNameStore.getDangerousActions);
      return list.cast<AbstractDictionary>();
    }

    if (isList) {
      var list =
      await HiveService.getOfflineListBox(BoxNameStore.getDangerousActions);
      if (list.isNotEmpty) {
        return list.cast<AbstractDictionary>();
      }
    }

    try {
      // List response = await Kinfolk.getListModelRest(
      //     serviceOrEntityName: mobileService(),
      //     methodName: MethodNames.getDicDangerousActions,
      //     type: Types.services,
      //     fromMap: (val) => AbstractDictionary.fromMap(val));
      var response = [
        {
          "_entityName": "krj_DicDangerousActionPojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.DicDangerousActionPojo-2c034741-dd2b-cdde-955e-e080c722f96c [new]",
          "id": "2c034741-dd2b-cdde-955e-e080c722f96c",
          "code": "NO_PERMIT",
          "langValue": "Без наряд задания/допуска"
        },
        {
          "_entityName": "krj_DicDangerousActionPojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.DicDangerousActionPojo-acb2c359-4530-6c8d-e2c6-5f1eb6d2d04d [new]",
          "id": "acb2c359-4530-6c8d-e2c6-5f1eb6d2d04d",
          "code": "NO_BELTS",
          "langValue": "Без предохранительных поясов"
        },
        {
          "_entityName": "krj_DicDangerousActionPojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.DicDangerousActionPojo-1e5630df-4081-e86e-6f73-d94c3f22cea3 [new]",
          "id": "1e5630df-4081-e86e-6f73-d94c3f22cea3",
          "code": "ALCOHOL_NARCO_ INTOXICATION",
          "langValue": "Алкогольное/Наркотическое опьянение"
        },
        {
          "_entityName": "krj_DicDangerousActionPojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.DicDangerousActionPojo-fe20d0f3-081d-e2db-89ce-a7dc795bc8fc [new]",
          "id": "fe20d0f3-081d-e2db-89ce-a7dc795bc8fc",
          "code": "NO_BLOCKING_DEVICES",
          "langValue": "Без блокирующих устройств для работ"
        },
      ];
      var dangerousActionList = List<AbstractDictionary>.from(
          response.map((x) => AbstractDictionary.fromMap(x)));
      Box box = await HiveService.getClearBox(BoxNameStore.getDangerousActions);
      dangerousActionList.forEach((e) {
        box.add(e);
      });
      return dangerousActionList.cast<AbstractDictionary>();
    } catch (e) {
      print(e);
    }
  }

  static Future createMessage(Message entity, bool isUpdated) async {
    var conn = await checkConnection();
    var uuid = Uuid();
    var v1 = uuid.v1();
    if (!conn) {
      if (isUpdated) {
        await entity.save();
      } else {
        var box = await HiveService.getBox(BoxNameStore.getUserMessages);
        await box.add(entity);
      }
      return null;
    } else {
      entity.id = v1;
      print(entity.id);
      if (isUpdated) {
        await entity.save();
      } else {
        var box = await HiveService.getBox(BoxNameStore.getUserMessages);
        await box.add(entity);
      }
      return true;
    }
    // oauth2.Client client = await Kinfolk.getClient();
    //
    // var url = Kinfolk.createRestUrl(
    //   mobileService(),
    //   MethodNames.createMessage,
    //   Types.services,
    // );
    //
    // var body = '''{
    //           "messagePojo": ${entity.toJsonCreate()}
    //         }''';
    // var response =
    //     await client.post(url, body: body, headers: Kinfolk.appJsonHeader);
    //
    // if (response.statusCode == 200) {
    //   if (isUpdated) {
    //     await entity.delete();
    //   }
    //   return true;
    // } else {
    //   return false;
    // }
  }

  static Future cancelMessage(String msgId) async {
    var conn = await checkConnection();
    if (!conn) {
      return null;
    }

    oauth2.Client client = await Kinfolk.getClient();

    var url = Kinfolk.createRestUrl(
      mobileService(),
      MethodNames.deleteMessage,
      Types.services,
    );

    var body = '''{
              "id": "$msgId"
            }''';
    var response =
    await client.post(url, body: body, headers: Kinfolk.appJsonHeader);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future synchronizeMessages() async {
    var conn = await checkConnection();
    var result = true;
    print('conn: $conn');
    if (!conn) {
      return null;
    }

    var box = await HiveService.getBox(BoxNameStore.getUserMessages);
    var list = box.values.toList();
    for (Message e in list) {
      if (e.id == null) {
        // for (var i = 0; i < e.files.length; i++) {
        //   if (e.files[i].id == null) {
        //     if (e.files[i].localPath == null || e.files[i].localPath.isEmpty) {
        //       return 'Не правильно фото № ${e.files.indexOf(e.files[i]) + 1}, '
        //           'в сообщение ${dateFormatFullToNumeric(e.initDateTime)}';
        //     } else {
        //       var savedImage = await saveFile(
        //           file: File(e.files[i].localPath), toServer: true);
        //       savedImage.localPath = e.files[i].localPath;
        //       savedImage.fileName = e.files[i].fileName;
        //       e.files[i] = savedImage;
        //       await e.save();
        //     }
        //   }
        // }
        await createMessage(e, true).then((value) async {
          if (value != null && value) {
            // await e.delete();
          } else {
            // continue;
            result = false;
          }
        });
      }
    }
    return result;
  }

  static Future<List<Organization>> getOrganization(
      [bool hasNew = true]) async {
    var conn = await checkConnection();
    if (!conn) {
      var list =
      await HiveService.getOfflineListBox(BoxNameStore.getOrganization);
      return list.cast<Organization>();
    }
    try {
      // List response = await Kinfolk.getListModelRest(
      //     serviceOrEntityName: mobileService(),
      //     methodName: MethodNames.getOrganization,
      //     type: Types.services,
      //     fromMap: (val) => Organization.fromMap(val));
      var response = [
        {
          "_entityName": "krj_OrganizationPojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.OrganizationPojo-eaad86be-54a3-8dfa-a00e-f3b435d2cb61 [new]",
          "id": "b10cd8e0-c0dc-ef66-af9a-fbdb942f62c4",
          "organizationName": "ТОО 'UCO'",
          "groupId": "6fb225ef-2d01-9941-0b19-e12654b8052a",
          "departments": [
            {
              "_entityName": "krj_DepartmentPojo",
              "_instanceName":
                  "kz.uco.krj.hse.restpojo.DepartmentPojo-c11426d4-82df-696f-76e2-8dd972f51ecd [new]",
              "id": "4ea14d87-1a43-7506-f504-b9ab8208dece",
              "departmentName": "Digital департамент",
              "groupId": "ec6e1edd-95d6-c9a8-acf4-29068cfb6a83",
              "objectName": [
                {
                  "_entityName": "krj_DicObjectName",
                  "_instanceName":
                      "kz.uco.krj.hse.restpojo.DicObjectNamePojo-7fe0404f-b96b-d328-af05-67f2592abf2e [new]",
                  "id": "7fe0404f-b96b-d328-af05-67f2592abf2e",
                  "code": "KITCHEN_WORK",
                  "langValue": "Кухня Рабочая"
                },
                {
                  "_entityName": "krj_DicObjectName",
                  "_instanceName":
                      "kz.uco.krj.hse.restpojo.DicObjectNamePojo-655f5288-0e50-34a8-7743-e393e744a369 [new]",
                  "id": "655f5288-0e50-34a8-7743-e393e744a369",
                  "code": "STANOK",
                  "langValue": "Персональный компьютер"
                }
              ],
              "employees": [
                {
                  "_entityName": "krj_PersonPojo",
                  "_instanceName": "Денис",
                  "id": "5f2e6edf-9e87-c740-46d3-1915e89340f3",
                  "lastName": "Хайбулин",
                  "groupId": "5f2e6edf-9e87-c740-46d3-1915e89340f3",
                  "photo": {
                    "_instanceName": "хайбулин д (25.08.2020 19:07)",
                    "id": "e2289aa4-83a3-5ef1-3617-3b98b00fa2e4",
                    "extension": "JPEG",
                    "name": "хайбулин д",
                    "version": 1,
                    "createDate": "2020-08-25 19:07:36.051"
                  },
                  "firstName": "Денис",
                  "middleName": "Гахпляхатович",
                  "nationalIdentifier": "820620300448"
                },
                {
                  "_entityName": "krj_PersonPojo",
                  "_instanceName": "Дастан",
                  "id": "6ea596ac-29cf-10c1-fad5-6c8bfd7ee9b9",
                  "lastName": "Дастан",
                  "groupId": "6ea596ac-29cf-10c1-fad5-6c8bfd7ee9b9",
                  "photo": {
                    "_instanceName": "нуранов д (25.08.2020 19:04)",
                    "id": "d5f657e1-53e1-03d8-2ac6-1633484e9837",
                    "extension": "JPEG",
                    "name": "нуранов д",
                    "version": 1,
                    "createDate": "2020-08-25 19:04:42.830"
                  },
                  "firstName": "Дастан",
                  "middleName": "Даулетович ",
                  "nationalIdentifier": "940305351266"
                },
                {
                  "_entityName": "krj_PersonPojo",
                  "_instanceName": "Асет",
                  "id": "6fad4713-0143-8045-4f18-1e6563cec0ca",
                  "lastName": "Асет",
                  "groupId": "6fad4713-0143-8045-4f18-1e6563cec0ca",
                  "photo": {
                    "_instanceName": "сматов а (25.08.2020 19:05)",
                    "id": "9096f9c5-d00e-b824-da69-a27c1ed5b1cb",
                    "extension": "JPEG",
                    "name": "сматов а",
                    "version": 1,
                    "createDate": "2020-08-25 19:05:26.794"
                  },
                  "firstName": "Асет",
                  "middleName": "Жансеитович",
                  "nationalIdentifier": "830727300510"
                }
              ]
            },
            {
              "_entityName": "krj_DepartmentPojo",
              "_instanceName":
                  "kz.uco.krj.hse.restpojo.DepartmentPojo-f7b584ef-b655-b190-c661-0db5a0e4e699 [new]",
              "id": "f7b584ef-b655-b190-c661-0db5a0e4e699",
              "departmentName": "Бухгалтерия",
              "groupId": "f7b584ef-b655-b190-c661-0db5a0e4e699",
              "objectName": [
                {
                  "_entityName": "krj_DicObjectName",
                  "_instanceName":
                      "kz.uco.krj.hse.restpojo.DicObjectNamePojo-7fe0404f-b96b-d328-af05-67f2592abf2e [new]",
                  "id": "7fe0404f-b96b-d328-af05-67f2592abf2e",
                  "code": "KITCHEN_WORK",
                  "langValue": "Кабинет"
                },
                {
                  "_entityName": "krj_DicObjectName",
                  "_instanceName":
                      "kz.uco.krj.hse.restpojo.DicObjectNamePojo-655f5288-0e50-34a8-7743-e393e744a369 [new]",
                  "id": "655f5288-0e50-34a8-7743-e393e744a369",
                  "code": "STANOK",
                  "langValue": "Персональный компьютер"
                }
              ],
              "employees": [
                {
                  "_entityName": "krj_PersonPojo",
                  "_instanceName": "Илиас",
                  "id": "3bec8bc2-c158-dc48-b80b-237b117da20c",
                  "lastName": "Илиас",
                  "groupId": "3bec8bc2-c158-dc48-b80b-237b117da20c",
                  "photo": {
                    "_instanceName": "ахметбеков (23.07.2020 22:29)",
                    "id": "8dd0d9c4-0201-f57d-b734-460061815ac9",
                    "extension": "JPEG",
                    "name": "ахметбеков",
                    "version": 1,
                    "createDate": "2020-07-23 22:29:58.933"
                  },
                  "firstName": "Илиас",
                  "middleName": "Абайдуллаевич",
                  "nationalIdentifier": "970815351551"
                },
                {
                  "_entityName": "krj_PersonPojo",
                  "_instanceName": "Азамат",
                  "id": "21ecda78-c746-7713-dd00-8fe362dcd91f",
                  "lastName": "Азамат",
                  "groupId": "21ecda78-c746-7713-dd00-8fe362dcd91f",
                  "photo": {
                    "_instanceName":
                        "Кайрбеков Азамат Бекболатович (23.07.2020 22:18)",
                    "id": "11572504-95a1-63e0-4ae6-77d80ab5d0eb",
                    "extension": "JPEG",
                    "name": "Кайрбеков Азамат Бекболатович",
                    "version": 1,
                    "createDate": "2020-07-23 22:18:14.713"
                  },
                  "firstName": "Азамат",
                  "middleName": "Бекболатович",
                  "nationalIdentifier": "971225350320"
                }
              ]
            },
          ],
        }
      ];
      var organizationList =
          List<Organization>.from(response.map((x) => Organization.fromMap(x)));
      Box box = await HiveService.getClearBox(BoxNameStore.getOrganization);
      organizationList.cast<Organization>().forEach((e) {
        box.add(e);
      });
      return organizationList.cast<Organization>();
    } catch (e) {
      print(e);
    }
  }

  ////BehaviorAudit - BSA
  static Future getBehavior() async {
    var conn = await checkConnection();
    var list =
        await HiveService.getOfflineListBox(BoxNameStore.getBehaviorAudit);
    if (!conn) {
      return list.cast<BehaviorAudit>();
    } else if (list.isNotEmpty) {
      return list.cast<BehaviorAudit>();
    }
    try {
      // List bsaList = await Kinfolk.getListModelRest(
      //     serviceOrEntityName: mobileService(),
      //     methodName: MethodNames.getAllBehaviors,
      //     type: Types.services,
      //     fromMap: (val) => BehaviorAudit.fromMap(val));
      var response = [
        {
          "_entityName": "krj_BehaviorPojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.BehaviorPojo-815d964c-7cdd-4af4-6bd7-595a023e5332 [new]",
          "id": "815d964c-7cdd-4af4-6bd7-595a0234545",
          "date": "2021-09-05 11:54:20.776",
          "regDateTime": "2021-09-05 11:54:20.776",
          "initiator": {
            "_entityName": "krj_PersonPojo",
            "_instanceName": "Жакеев",
            "id": "3fb7c8ff-ba5b-0d8a-754e-db18e02344e5",
            "lastName": "Нұржан",
            "firstName": "Жакеев",
            "middleName": "Құралбекұлы"
          },
          "planDate": "2021-08-10 13:00:00.000",
          "regNumber": "BAU-PL-2021-00176",
          "sevirity": {
            "_entityName": "krj_DicSevirityPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicSevirityPojo-a62561cf-dba0-a8c2-998f-e78a3a2282ff [new]",
            "id": "a62561cf-dba0-a8c2-998f-e78a3a2282ff",
            "code": "LOW",
            "langValue": "Низкий"
          },
          "organization": {
            "_entityName": "krj_OrganizationPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.OrganizationPojo-eaad86be-54a3-8dfa-a00e-f3b435d2cb61 [new]",
            "id": "eaad86be-54a3-8dfa-a00e-f3b435d2cb61",
            "organizationName": "АО \"Каражыра\"",
            "groupId": "6fb225ef-2d01-9941-0b19-e12654b8089a"
          },
          "workType": "Заменить пол",
          "objectName": {
            "_entityName": "krj_DicObjectName",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicObjectNamePojo-f719001e-9521-468b-61b0-f43a1027d916 [new]",
            "id": "f719001e-9521-468b-61b0-f43a1027d916",
            "code": "KITCHEN",
            "langValue": "Станок №101"
          },
          "files": [],
          "responsibles": [
            {
              "_entityName": "krj_PersonPojo",
              "_instanceName": "Жакеев",
              "id": "3fb7c8ff-ba5b-0d8a-754e-db18e02344e5",
              "lastName": "Нұржан",
              "groupId": "f63d3e47-caff-8840-cbf7-3fcbb284f66b",
              "photo": {
                "_entityName": "sys$FileDescriptor",
                "_instanceName":
                    "альмуханов-33915aea-4631-40b6-8084-e2e76ae656ce.jpeg (05.08.2021 17:36)",
                "id": "5f60b797-ff34-d23a-c9f0-c09e8b00070e",
                "extension": "jpeg",
                "name": "альмуханов-33915aea-4631-40b6-8084-e2e76ae656ce.jpeg",
                "version": 1,
                "createDate": "2021-08-05 17:36:36.435"
              },
              "firstName": "Жакеев",
              "organization": "АО \"Каражыра\"",
              "middleName": "Құралбекұлы",
              "nationalIdentifier": "901205300210"
            }
          ],
          "department": {
            "_entityName": "krj_DepartmentPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DepartmentPojo-26e7b108-f9a7-bad9-6b2f-21610f2b927a [new]",
            "id": "26e7b108-f9a7-bad9-6b2f-21610f2b927a",
            "departmentName": "(ПерПерс) Рабочие автоколонны (угольный разрез)",
            "groupId": "26e7b108-f9a7-bad9-6b2f-21610f2b927a"
          },
          "category": {
            "_entityName": "krj_DicBehaviorCategoryPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicBehaviorCategoryPojo-11e5b72c-6c6c-ae6f-ae9f-541f40f5d614 [new]",
            "id": "11e5b72c-6c6c-ae6f-ae9f-541f40f5d614",
            "code": "PLANNED",
            "langValue": "Плановый"
          },
          "status": {
            "_entityName": "krj_DicMessageStatusPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicMessageStatusPojo-304aca95-ddf3-8f95-9441-87fac553073d [new]",
            "id": "304aca95-ddf3-8f95-9441-87fac553073d",
            "code": "NEW",
            "langValue": "Новый"
          }
        },
        {
          "_entityName": "krj_BehaviorPojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.BehaviorPojo-838cd9af-aa84-ad04-4995-9d2d062577d2 [new]",
          "id": "838cd9af-aa84-ad04-4995-9d2d062577d2",
          "date": "2021-08-06 13:25:41.490",
          "regDateTime": "2021-08-06 13:30:16.128",
          "watchedQuantity": 1,
          "initiator": {
            "_entityName": "krj_PersonPojo",
            "_instanceName": "Жакеев",
            "id": "3fb7c8ff-ba5b-0d8a-754e-db18e02344e5",
            "lastName": "Нұржан",
            "firstName": "Жакеев",
            "middleName": "Құралбекұлы"
          },
          "actionDescription": "ddd",
          "planDate": "2021-08-06 00:00:00.000",
          "duration": 12,
          "regNumber": "BAU-PL-2021-00223",
          "sevirity": {
            "_entityName": "krj_DicSevirityPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicSevirityPojo-a62561cf-dba0-a8c2-998f-e78a3a2282ff [new]",
            "id": "a62561cf-dba0-a8c2-998f-e78a3a2282ff",
            "code": "LOW",
            "langValue": "Низкий"
          },
          "organization": {
            "_entityName": "krj_OrganizationPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.OrganizationPojo-eaad86be-54a3-8dfa-a00e-f3b435d2cb61 [new]",
            "id": "eaad86be-54a3-8dfa-a00e-f3b435d2cb61",
            "organizationName": "АО \"Каражыра\"",
            "groupId": "6fb225ef-2d01-9941-0b19-e12654b8089a"
          },
          "observations": [
            {
              "_entityName": "krj_ObservationPojo",
              "_instanceName":
                  "kz.uco.krj.hse.restpojo.ObservationPojo-a9fbb569-d636-ba40-f0b7-8f0fb666046f [new]",
              "id": "a9fbb569-d636-ba40-f0b7-8f0fb666046f",
              "observationKindSitutation": {
                "_entityName": "krj_DicObservationKindSitutationPojo",
                "_instanceName":
                    "kz.uco.krj.hse.restpojo.DicObservationKindSitutationPojo-af034707-679c-1b2a-8cf4-523facc086e8 [new]",
                "id": "af034707-679c-1b2a-8cf4-523facc086e8",
                "code": "SAFE_ENV",
                "langValue": "Безопасные условия"
              },
              "observationKindDanger": {
                "_entityName": "krj_DicObservationKindDangerPojo",
                "_instanceName":
                    "kz.uco.krj.hse.restpojo.DicObservationKindDangerPojo-3d938b44-f01d-4c79-3b28-ca294f69bc9e [new]",
                "id": "3d938b44-f01d-4c79-3b28-ca294f69bc9e",
                "code": "DAMAGE_PROTRUD",
                "langValue": "Удар о выступающий предмет"
              },
              "observationSevirityConsequences": {
                "_entityName": "krj_DicObservationSevirityConsequencesPojo",
                "_instanceName":
                    "kz.uco.krj.hse.restpojo.DicObservationSevirityConsequencesPojo-397a8d96-47e5-f776-7abb-cef4009f4cee [new]",
                "id": "397a8d96-47e5-f776-7abb-cef4009f4cee",
                "code": "SEVERE",
                "langValue": "Несчастный случай с тяжелым исходом"
              },
              "observationCategory": {
                "_entityName": "krj_DicObservationCategoryPojo",
                "_instanceName":
                    "kz.uco.krj.hse.restpojo.DicObservationCategoryPojo-357007e7-ab68-0555-e55e-da5340ea4045 [new]",
                "id": "357007e7-ab68-0555-e55e-da5340ea4045",
                "code": "EMP_POSITION",
                "langValue": "Положение/Поза работника"
              },
              "comment": "mg",
              "isChecked": true
            }
          ],
          "workType": "gg",
          "objectName": {
            "_entityName": "krj_DicObjectName",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicObjectNamePojo-f719001e-9521-468b-61b0-f43a1027d916 [new]",
            "id": "f719001e-9521-468b-61b0-f43a1027d916",
            "code": "KITCHEN",
            "langValue": "Станок №101"
          },
          "files": [
            {
              "_entityName": "sys$FileDescriptor",
              "_instanceName":
                  "scaled_4e4c5c16-c47e-4c21-979c-66ca381b6ede3993237087606561844.jpg (06.08.2021 13:29)",
              "id": "b27261b3-5482-bc2d-414b-36b8827e2621",
              "extension": "jpg",
              "name":
                  "scaled_4e4c5c16-c47e-4c21-979c-66ca381b6ede3993237087606561844.jpg",
              "version": 1,
              "createDate": "2021-08-06 13:29:32.708"
            }
          ],
          "responsibles": [
            {
              "_entityName": "krj_PersonPojo",
              "_instanceName": "Жакеев",
              "id": "3fb7c8ff-ba5b-0d8a-754e-db18e02344e5",
              "lastName": "Нұржан",
              "groupId": "f63d3e47-caff-8840-cbf7-3fcbb284f66b",
              "photo": {
                "_entityName": "sys$FileDescriptor",
                "_instanceName":
                    "альмуханов-33915aea-4631-40b6-8084-e2e76ae656ce.jpeg (05.08.2021 17:36)",
                "id": "5f60b797-ff34-d23a-c9f0-c09e8b00070e",
                "extension": "jpeg",
                "name": "альмуханов-33915aea-4631-40b6-8084-e2e76ae656ce.jpeg",
                "version": 1,
                "createDate": "2021-08-05 17:36:36.435"
              },
              "firstName": "Жакеев",
              "organization": "АО \"Каражыра\"",
              "middleName": "Құралбекұлы",
              "nationalIdentifier": "901205300210"
            }
          ],
          "department": {
            "_entityName": "krj_DepartmentPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DepartmentPojo-26e7b108-f9a7-bad9-6b2f-21610f2b927a [new]",
            "id": "26e7b108-f9a7-bad9-6b2f-21610f2b927a",
            "departmentName": "(ПерПерс) Рабочие автоколонны (угольный разрез)",
            "groupId": "26e7b108-f9a7-bad9-6b2f-21610f2b927a"
          },
          "category": {
            "_entityName": "krj_DicBehaviorCategoryPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicBehaviorCategoryPojo-11e5b72c-6c6c-ae6f-ae9f-541f40f5d614 [new]",
            "id": "11e5b72c-6c6c-ae6f-ae9f-541f40f5d614",
            "code": "PLANNED",
            "langValue": "Плановый"
          },
          "status": {
            "_entityName": "krj_DicMessageStatusPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicMessageStatusPojo-304aca95-ddf3-8f95-9441-87fac553073d [new]",
            "id": "304aca95-ddf3-8f95-9441-87fac553073d",
            "code": "CLOSED",
            "langValue": "Закрыт"
          }
        },
        {
          "_entityName": "krj_BehaviorPojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.BehaviorPojo-ce14fe22-a3a1-e0cd-8a3a-dce391229865 [new]",
          "id": "ce14fe22-a3a1-e0cd-8a3a-dce391229865",
          "date": "2021-08-07 14:10:00.000",
          "regDateTime": "2021-08-06 12:22:53.425",
          "watchedQuantity": 1,
          "initiator": {
            "_entityName": "krj_PersonPojo",
            "_instanceName": "Жакеев",
            "id": "3fb7c8ff-ba5b-0d8a-754e-db18e02344e5",
            "lastName": "Нұржан",
            "firstName": "Жакеев",
            "middleName": "Құралбекұлы"
          },
          "empComment": "Karajyra 7 AUG",
          "actionDescription": "Acted",
          "planDate": "2021-08-06 12:22:00.000",
          "duration": 10,
          "regNumber": "BAU-PL-2021-00218",
          "sevirity": {
            "_entityName": "krj_DicSevirityPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicSevirityPojo-7c72fa2e-956f-efc3-831a-ad6b35723642 [new]",
            "id": "7c72fa2e-956f-efc3-831a-ad6b35723642",
            "code": "HIGH",
            "langValue": "Высокий"
          },
          "organization": {
            "_entityName": "krj_OrganizationPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.OrganizationPojo-de154c4e-52bb-d4de-73e6-e7e60b764104 [new]",
            "id": "de154c4e-52bb-d4de-73e6-e7e60b764104",
            "organizationName": "ТОО \"ВостокУгольПром\"",
            "groupId": "b56bb85c-5532-b70c-8cba-1498e631ab7d"
          },
          "observations": [
            {
              "_entityName": "krj_ObservationPojo",
              "_instanceName":
                  "kz.uco.krj.hse.restpojo.ObservationPojo-f87b5512-a36c-0169-1f69-f3af7bc8d4a7 [new]",
              "id": "f87b5512-a36c-0169-1f69-f3af7bc8d4a7",
              "observationKindSitutation": {
                "_entityName": "krj_DicObservationKindSitutationPojo",
                "_instanceName":
                    "kz.uco.krj.hse.restpojo.DicObservationKindSitutationPojo-af034707-679c-1b2a-8cf4-523facc086e8 [new]",
                "id": "af034707-679c-1b2a-8cf4-523facc086e8",
                "code": "SAFE_ENV",
                "langValue": "Безопасные условия"
              },
              "observationKindDanger": {
                "_entityName": "krj_DicObservationKindDangerPojo",
                "_instanceName":
                    "kz.uco.krj.hse.restpojo.DicObservationKindDangerPojo-83374665-d00f-ec7a-b448-a558837079f8 [new]",
                "id": "83374665-d00f-ec7a-b448-a558837079f8",
                "code": "HIGHT_FALL",
                "langValue": "Падения с высоты"
              },
              "observationSevirityConsequences": {
                "_entityName": "krj_DicObservationSevirityConsequencesPojo",
                "_instanceName":
                    "kz.uco.krj.hse.restpojo.DicObservationSevirityConsequencesPojo-397a8d96-47e5-f776-7abb-cef4009f4cee [new]",
                "id": "397a8d96-47e5-f776-7abb-cef4009f4cee",
                "code": "SEVERE",
                "langValue": "Несчастный случай с тяжелым исходом"
              },
              "observationCategory": {
                "_entityName": "krj_DicObservationCategoryPojo",
                "_instanceName":
                    "kz.uco.krj.hse.restpojo.DicObservationCategoryPojo-357007e7-ab68-0555-e55e-da5340ea4045 [new]",
                "id": "357007e7-ab68-0555-e55e-da5340ea4045",
                "code": "EMP_POSITION",
                "langValue": "Положение/Поза работника"
              },
              "comment": "Comment наблюдения",
              "isChecked": true
            },
            {
              "_entityName": "krj_ObservationPojo",
              "_instanceName":
                  "kz.uco.krj.hse.restpojo.ObservationPojo-5e74987b-38bd-5268-a38c-f061d7c67b43 [new]",
              "id": "5e74987b-38bd-5268-a38c-f061d7c67b43",
              "observationKindSitutation": {
                "_entityName": "krj_DicObservationKindSitutationPojo",
                "_instanceName":
                    "kz.uco.krj.hse.restpojo.DicObservationKindSitutationPojo-af034707-679c-1b2a-8cf4-523facc086e8 [new]",
                "id": "af034707-679c-1b2a-8cf4-523facc086e8",
                "code": "SAFE_ENV",
                "langValue": "Безопасные условия"
              },
              "observationKindDanger": {
                "_entityName": "krj_DicObservationKindDangerPojo",
                "_instanceName":
                    "kz.uco.krj.hse.restpojo.DicObservationKindDangerPojo-83374665-d00f-ec7a-b448-a558837079f8 [new]",
                "id": "83374665-d00f-ec7a-b448-a558837079f8",
                "code": "HIGHT_FALL",
                "langValue": "Падения с высоты"
              },
              "observationSevirityConsequences": {
                "_entityName": "krj_DicObservationSevirityConsequencesPojo",
                "_instanceName":
                    "kz.uco.krj.hse.restpojo.DicObservationSevirityConsequencesPojo-397a8d96-47e5-f776-7abb-cef4009f4cee [new]",
                "id": "397a8d96-47e5-f776-7abb-cef4009f4cee",
                "code": "SEVERE",
                "langValue": "Несчастный случай с тяжелым исходом"
              },
              "observationCategory": {
                "_entityName": "krj_DicObservationCategoryPojo",
                "_instanceName":
                    "kz.uco.krj.hse.restpojo.DicObservationCategoryPojo-cf608015-a043-8cfc-72d8-0fc0d63ec543 [new]",
                "id": "cf608015-a043-8cfc-72d8-0fc0d63ec543",
                "code": "TOOLS",
                "langValue": "Инструменты и оборудование"
              },
              "comment": "Коммент 2 ка",
              "isChecked": true
            }
          ],
          "objectName": {
            "_entityName": "krj_DicObjectName",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicObjectNamePojo-655f5288-0e50-34a8-7743-e393e744a369 [new]",
            "id": "655f5288-0e50-34a8-7743-e393e744a369",
            "code": "STANOK",
            "langValue": "Станок №102"
          },
          "files": [
            {
              "_entityName": "sys$FileDescriptor",
              "_instanceName":
                  "d0e46543-0f4c-4240-a1bc-f14a1eefc014653871596991147811.jpg (19.07.2021 17:17)",
              "id": "3ceb6fb1-e896-5617-0ee8-b054e1e94701",
              "extension": "jpg",
              "name":
                  "d0e46543-0f4c-4240-a1bc-f14a1eefc014653871596991147811.jpg",
              "version": 1,
              "createDate": "2021-07-19 17:17:11.806"
            },
            {
              "_entityName": "sys$FileDescriptor",
              "_instanceName":
                  "9c7c4716-6eb0-447b-bd6c-8178c4e60a83732612431572545753.jpg (19.07.2021 17:18)",
              "id": "6f2e5946-63f7-3cf6-36f0-74e367c38e2a",
              "extension": "jpg",
              "name":
                  "9c7c4716-6eb0-447b-bd6c-8178c4e60a83732612431572545753.jpg",
              "version": 1,
              "createDate": "2021-07-19 17:18:56.587"
            }
          ],
          "comment": "No Comment",
          "responsibles": [
            {
              "_entityName": "krj_PersonPojo",
              "_instanceName": "Жакеев",
              "id": "3fb7c8ff-ba5b-0d8a-754e-db18e02344e5",
              "lastName": "Нұржан",
              "groupId": "f63d3e47-caff-8840-cbf7-3fcbb284f66b",
              "photo": {
                "_entityName": "sys$FileDescriptor",
                "_instanceName":
                    "альмуханов-33915aea-4631-40b6-8084-e2e76ae656ce.jpeg (05.08.2021 17:36)",
                "id": "5f60b797-ff34-d23a-c9f0-c09e8b00070e",
                "extension": "jpeg",
                "name": "альмуханов-33915aea-4631-40b6-8084-e2e76ae656ce.jpeg",
                "version": 1,
                "createDate": "2021-08-05 17:36:36.435"
              },
              "firstName": "Жакеев",
              "organization": "АО \"Каражыра\"",
              "middleName": "Құралбекұлы",
              "nationalIdentifier": "901205300210"
            }
          ],
          "department": {
            "_entityName": "krj_DepartmentPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DepartmentPojo-f7b584ef-b655-b190-c661-0db5a0e4e699 [new]",
            "id": "f7b584ef-b655-b190-c661-0db5a0e4e699",
            "departmentName":
                "(ГМК) Рабочие отдела главного маркшейдера и геолога",
            "groupId": "f7b584ef-b655-b190-c661-0db5a0e4e699"
          },
          "category": {
            "_entityName": "krj_DicBehaviorCategoryPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicBehaviorCategoryPojo-0a46c7b4-9095-84ec-4c6d-3bb4633c0583 [new]",
            "id": "0a46c7b4-9095-84ec-4c6d-3bb4633c0583",
            "code": "UN_SCHEDULED",
            "langValue": "Внеплановый"
          },
          "status": {
            "_entityName": "krj_DicMessageStatusPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicMessageStatusPojo-10218553-fa51-bc9d-f274-d89a1447a1c5 [new]",
            "id": "10218553-fa51-bc9d-f274-d89a1447a1c5",
            "code": "DISTRIBUTED",
            "langValue": "Распределен"
          }
        },
        {
          "_entityName": "krj_BehaviorPojo",
          "watchedQuantity": 1,
          "_instanceName":
              "kz.uco.krj.hse.restpojo.BehaviorPojo-854923aa-67bc-a616-8899-2771234e874c [new]",
          "id": "854923aa-67bc-a616-8899-2771234e874c",
          "date": "2021-08-07 14:10:00.000",
          "regDateTime": "2021-08-06 12:16:49.145",
          "initiator": {
            "_entityName": "krj_PersonPojo",
            "_instanceName": "Жакеев",
            "id": "3fb7c8ff-ba5b-0d8a-754e-db18e02344e5",
            "lastName": "Нұржан",
            "firstName": "Жакеев",
            "middleName": "Құралбекұлы"
          },
          "empComment": "Karajyra 7 AUG",
          "actionDescription": "Acted",
          "planDate": "2021-08-06 22:00:00.000",
          "duration": 10,
          "regNumber": "BAU-UN-2021-00215",
          "sevirity": {
            "_entityName": "krj_DicSevirityPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicSevirityPojo-7c72fa2e-956f-efc3-831a-ad6b35723642 [new]",
            "id": "7c72fa2e-956f-efc3-831a-ad6b35723642",
            "code": "HIGH",
            "langValue": "Высокий"
          },
          "organization": {
            "_entityName": "krj_OrganizationPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.OrganizationPojo-de154c4e-52bb-d4de-73e6-e7e60b764104 [new]",
            "id": "de154c4e-52bb-d4de-73e6-e7e60b764104",
            "organizationName": "ТОО \"ВостокУгольПром\"",
            "groupId": "b56bb85c-5532-b70c-8cba-1498e631ab7d"
          },
          "observations": [
            {
              "_entityName": "krj_ObservationPojo",
              "_instanceName":
                  "kz.uco.krj.hse.restpojo.ObservationPojo-a0af9be8-5b3d-1812-bc18-04e4bea86135 [new]",
              "id": "a0af9be8-5b3d-1812-bc18-04e4bea86135",
              "observationKindSitutation": {
                "_entityName": "krj_DicObservationKindSitutationPojo",
                "_instanceName":
                    "kz.uco.krj.hse.restpojo.DicObservationKindSitutationPojo-af034707-679c-1b2a-8cf4-523facc086e8 [new]",
                "id": "af034707-679c-1b2a-8cf4-523facc086e8",
                "code": "SAFE_ENV",
                "langValue": "Безопасные условия"
              },
              "observationKindDanger": {
                "_entityName": "krj_DicObservationKindDangerPojo",
                "_instanceName":
                    "kz.uco.krj.hse.restpojo.DicObservationKindDangerPojo-83374665-d00f-ec7a-b448-a558837079f8 [new]",
                "id": "83374665-d00f-ec7a-b448-a558837079f8",
                "code": "HIGHT_FALL",
                "langValue": "Падения с высоты"
              },
              "observationSevirityConsequences": {
                "_entityName": "krj_DicObservationSevirityConsequencesPojo",
                "_instanceName":
                    "kz.uco.krj.hse.restpojo.DicObservationSevirityConsequencesPojo-397a8d96-47e5-f776-7abb-cef4009f4cee [new]",
                "id": "397a8d96-47e5-f776-7abb-cef4009f4cee",
                "code": "SEVERE",
                "langValue": "Несчастный случай с тяжелым исходом"
              },
              "observationCategory": {
                "_entityName": "krj_DicObservationCategoryPojo",
                "_instanceName":
                    "kz.uco.krj.hse.restpojo.DicObservationCategoryPojo-cf608015-a043-8cfc-72d8-0fc0d63ec543 [new]",
                "id": "cf608015-a043-8cfc-72d8-0fc0d63ec543",
                "code": "TOOLS",
                "langValue": "Инструменты и оборудование"
              },
              "comment": "Коммент 2 ка",
              "isChecked": true
            },
            {
              "_entityName": "krj_ObservationPojo",
              "_instanceName":
                  "kz.uco.krj.hse.restpojo.ObservationPojo-6a4c9cae-7e7e-6167-9bab-301167b2ad49 [new]",
              "id": "6a4c9cae-7e7e-6167-9bab-301167b2ad49",
              "observationKindSitutation": {
                "_entityName": "krj_DicObservationKindSitutationPojo",
                "_instanceName":
                    "kz.uco.krj.hse.restpojo.DicObservationKindSitutationPojo-af034707-679c-1b2a-8cf4-523facc086e8 [new]",
                "id": "af034707-679c-1b2a-8cf4-523facc086e8",
                "code": "SAFE_ENV",
                "langValue": "Безопасные условия"
              },
              "observationKindDanger": {
                "_entityName": "krj_DicObservationKindDangerPojo",
                "_instanceName":
                    "kz.uco.krj.hse.restpojo.DicObservationKindDangerPojo-83374665-d00f-ec7a-b448-a558837079f8 [new]",
                "id": "83374665-d00f-ec7a-b448-a558837079f8",
                "code": "HIGHT_FALL",
                "langValue": "Падения с высоты"
              },
              "observationSevirityConsequences": {
                "_entityName": "krj_DicObservationSevirityConsequencesPojo",
                "_instanceName":
                    "kz.uco.krj.hse.restpojo.DicObservationSevirityConsequencesPojo-397a8d96-47e5-f776-7abb-cef4009f4cee [new]",
                "id": "397a8d96-47e5-f776-7abb-cef4009f4cee",
                "code": "SEVERE",
                "langValue": "Несчастный случай с тяжелым исходом"
              },
              "observationCategory": {
                "_entityName": "krj_DicObservationCategoryPojo",
                "_instanceName":
                    "kz.uco.krj.hse.restpojo.DicObservationCategoryPojo-357007e7-ab68-0555-e55e-da5340ea4045 [new]",
                "id": "357007e7-ab68-0555-e55e-da5340ea4045",
                "code": "EMP_POSITION",
                "langValue": "Положение/Поза работника"
              },
              "comment": "Comment наблюдения",
              "isChecked": true
            }
          ],
          "objectName": {
            "_entityName": "krj_DicObjectName",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicObjectNamePojo-655f5288-0e50-34a8-7743-e393e744a369 [new]",
            "id": "655f5288-0e50-34a8-7743-e393e744a369",
            "code": "STANOK",
            "langValue": "Станок №102"
          },
          "files": [
            {
              "_entityName": "sys$FileDescriptor",
              "_instanceName":
                  "d0e46543-0f4c-4240-a1bc-f14a1eefc014653871596991147811.jpg (19.07.2021 17:17)",
              "id": "3ceb6fb1-e896-5617-0ee8-b054e1e94701",
              "extension": "jpg",
              "name":
                  "d0e46543-0f4c-4240-a1bc-f14a1eefc014653871596991147811.jpg",
              "version": 1,
              "createDate": "2021-07-19 17:17:11.806"
            },
            {
              "_entityName": "sys$FileDescriptor",
              "_instanceName":
                  "9c7c4716-6eb0-447b-bd6c-8178c4e60a83732612431572545753.jpg (19.07.2021 17:18)",
              "id": "6f2e5946-63f7-3cf6-36f0-74e367c38e2a",
              "extension": "jpg",
              "name":
                  "9c7c4716-6eb0-447b-bd6c-8178c4e60a83732612431572545753.jpg",
              "version": 1,
              "createDate": "2021-07-19 17:18:56.587"
            }
          ],
          "comment": "No Comment",
          "responsibles": [
            {
              "_entityName": "krj_PersonPojo",
              "_instanceName": "Жакеев",
              "id": "3fb7c8ff-ba5b-0d8a-754e-db18e02344e5",
              "lastName": "Нұржан",
              "groupId": "f63d3e47-caff-8840-cbf7-3fcbb284f66b",
              "photo": {
                "_entityName": "sys$FileDescriptor",
                "_instanceName":
                    "альмуханов-33915aea-4631-40b6-8084-e2e76ae656ce.jpeg (05.08.2021 17:36)",
                "id": "5f60b797-ff34-d23a-c9f0-c09e8b00070e",
                "extension": "jpeg",
                "name": "альмуханов-33915aea-4631-40b6-8084-e2e76ae656ce.jpeg",
                "version": 1,
                "createDate": "2021-08-05 17:36:36.435"
              },
              "firstName": "Жакеев",
              "organization": "АО \"Каражыра\"",
              "middleName": "Құралбекұлы",
              "nationalIdentifier": "901205300210"
            }
          ],
          "department": {
            "_entityName": "krj_DepartmentPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DepartmentPojo-f7b584ef-b655-b190-c661-0db5a0e4e699 [new]",
            "id": "f7b584ef-b655-b190-c661-0db5a0e4e699",
            "departmentName":
                "(ГМК) Рабочие отдела главного маркшейдера и геолога",
            "groupId": "f7b584ef-b655-b190-c661-0db5a0e4e699"
          },
          "category": {
            "_entityName": "krj_DicBehaviorCategoryPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicBehaviorCategoryPojo-0a46c7b4-9095-84ec-4c6d-3bb4633c0583 [new]",
            "id": "0a46c7b4-9095-84ec-4c6d-3bb4633c0583",
            "code": "UN_SCHEDULED",
            "langValue": "Внеплановый"
          },
          "status": {
            "_entityName": "krj_DicMessageStatusPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicMessageStatusPojo-10218553-fa51-bc9d-f274-d89a1447a1c5 [new]",
            "id": "10218553-fa51-bc9d-f274-d89a1447a1c5",
            "code": "DISTRIBUTED",
            "langValue": "Распределен"
          }
        },
        {
          "_entityName": "krj_BehaviorPojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.BehaviorPojo-477e66ec-0a34-25fe-fe72-6364a4daaddd [new]",
          "id": "477e66ec-0a34-25fe-fe72-6364a4daaddd",
          "date": "2021-08-07 14:10:00.000",
          "watchedQuantity": 1,
          "regDateTime": "2021-08-06 12:18:02.913",
          "initiator": {
            "_entityName": "krj_PersonPojo",
            "_instanceName": "Жакеев",
            "id": "3fb7c8ff-ba5b-0d8a-754e-db18e02344e5",
            "lastName": "Нұржан",
            "firstName": "Жакеев",
            "middleName": "Құралбекұлы"
          },
          "empComment": "Karajyra 7 AUG",
          "actionDescription": "Acted",
          "planDate": "2021-08-07 00:00:00.000",
          "duration": 10,
          "regNumber": "BAU-UN-2021-00217",
          "sevirity": {
            "_entityName": "krj_DicSevirityPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicSevirityPojo-7c72fa2e-956f-efc3-831a-ad6b35723642 [new]",
            "id": "7c72fa2e-956f-efc3-831a-ad6b35723642",
            "code": "HIGH",
            "langValue": "Высокий"
          },
          "organization": {
            "_entityName": "krj_OrganizationPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.OrganizationPojo-de154c4e-52bb-d4de-73e6-e7e60b764104 [new]",
            "id": "de154c4e-52bb-d4de-73e6-e7e60b764104",
            "organizationName": "ТОО \"ВостокУгольПром\"",
            "groupId": "b56bb85c-5532-b70c-8cba-1498e631ab7d"
          },
          "observations": [
            {
              "_entityName": "krj_ObservationPojo",
              "_instanceName":
                  "kz.uco.krj.hse.restpojo.ObservationPojo-2429a790-b8a6-8285-87d1-22edddc3b1f5 [new]",
              "id": "2429a790-b8a6-8285-87d1-22edddc3b1f5",
              "observationKindSitutation": {
                "_entityName": "krj_DicObservationKindSitutationPojo",
                "_instanceName":
                    "kz.uco.krj.hse.restpojo.DicObservationKindSitutationPojo-af034707-679c-1b2a-8cf4-523facc086e8 [new]",
                "id": "af034707-679c-1b2a-8cf4-523facc086e8",
                "code": "SAFE_ENV",
                "langValue": "Безопасные условия"
              },
              "observationKindDanger": {
                "_entityName": "krj_DicObservationKindDangerPojo",
                "_instanceName":
                    "kz.uco.krj.hse.restpojo.DicObservationKindDangerPojo-83374665-d00f-ec7a-b448-a558837079f8 [new]",
                "id": "83374665-d00f-ec7a-b448-a558837079f8",
                "code": "HIGHT_FALL",
                "langValue": "Падения с высоты"
              },
              "observationSevirityConsequences": {
                "_entityName": "krj_DicObservationSevirityConsequencesPojo",
                "_instanceName":
                    "kz.uco.krj.hse.restpojo.DicObservationSevirityConsequencesPojo-397a8d96-47e5-f776-7abb-cef4009f4cee [new]",
                "id": "397a8d96-47e5-f776-7abb-cef4009f4cee",
                "code": "SEVERE",
                "langValue": "Несчастный случай с тяжелым исходом"
              },
              "observationCategory": {
                "_entityName": "krj_DicObservationCategoryPojo",
                "_instanceName":
                    "kz.uco.krj.hse.restpojo.DicObservationCategoryPojo-357007e7-ab68-0555-e55e-da5340ea4045 [new]",
                "id": "357007e7-ab68-0555-e55e-da5340ea4045",
                "code": "EMP_POSITION",
                "langValue": "Положение/Поза работника"
              },
              "comment": "Comment наблюдения",
              "isChecked": true
            },
            {
              "_entityName": "krj_ObservationPojo",
              "_instanceName":
                  "kz.uco.krj.hse.restpojo.ObservationPojo-04d41c0a-8cbb-534d-1b0e-3c1201012c9f [new]",
              "id": "04d41c0a-8cbb-534d-1b0e-3c1201012c9f",
              "observationKindSitutation": {
                "_entityName": "krj_DicObservationKindSitutationPojo",
                "_instanceName":
                    "kz.uco.krj.hse.restpojo.DicObservationKindSitutationPojo-af034707-679c-1b2a-8cf4-523facc086e8 [new]",
                "id": "af034707-679c-1b2a-8cf4-523facc086e8",
                "code": "SAFE_ENV",
                "langValue": "Безопасные условия"
              },
              "observationKindDanger": {
                "_entityName": "krj_DicObservationKindDangerPojo",
                "_instanceName":
                    "kz.uco.krj.hse.restpojo.DicObservationKindDangerPojo-83374665-d00f-ec7a-b448-a558837079f8 [new]",
                "id": "83374665-d00f-ec7a-b448-a558837079f8",
                "code": "HIGHT_FALL",
                "langValue": "Падения с высоты"
              },
              "observationSevirityConsequences": {
                "_entityName": "krj_DicObservationSevirityConsequencesPojo",
                "_instanceName":
                    "kz.uco.krj.hse.restpojo.DicObservationSevirityConsequencesPojo-397a8d96-47e5-f776-7abb-cef4009f4cee [new]",
                "id": "397a8d96-47e5-f776-7abb-cef4009f4cee",
                "code": "SEVERE",
                "langValue": "Несчастный случай с тяжелым исходом"
              },
              "observationCategory": {
                "_entityName": "krj_DicObservationCategoryPojo",
                "_instanceName":
                    "kz.uco.krj.hse.restpojo.DicObservationCategoryPojo-cf608015-a043-8cfc-72d8-0fc0d63ec543 [new]",
                "id": "cf608015-a043-8cfc-72d8-0fc0d63ec543",
                "code": "TOOLS",
                "langValue": "Инструменты и оборудование"
              },
              "comment": "Коммент 2 ка",
              "isChecked": true
            }
          ],
          "objectName": {
            "_entityName": "krj_DicObjectName",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicObjectNamePojo-655f5288-0e50-34a8-7743-e393e744a369 [new]",
            "id": "655f5288-0e50-34a8-7743-e393e744a369",
            "code": "STANOK",
            "langValue": "Станок №102"
          },
          "files": [
            {
              "_entityName": "sys$FileDescriptor",
              "_instanceName":
                  "9c7c4716-6eb0-447b-bd6c-8178c4e60a83732612431572545753.jpg (19.07.2021 17:18)",
              "id": "6f2e5946-63f7-3cf6-36f0-74e367c38e2a",
              "extension": "jpg",
              "name":
                  "9c7c4716-6eb0-447b-bd6c-8178c4e60a83732612431572545753.jpg",
              "version": 1,
              "createDate": "2021-07-19 17:18:56.587"
            },
            {
              "_entityName": "sys$FileDescriptor",
              "_instanceName":
                  "d0e46543-0f4c-4240-a1bc-f14a1eefc014653871596991147811.jpg (19.07.2021 17:17)",
              "id": "3ceb6fb1-e896-5617-0ee8-b054e1e94701",
              "extension": "jpg",
              "name":
                  "d0e46543-0f4c-4240-a1bc-f14a1eefc014653871596991147811.jpg",
              "version": 1,
              "createDate": "2021-07-19 17:17:11.806"
            }
          ],
          "comment": "No Comment",
          "responsibles": [
            {
              "_entityName": "krj_PersonPojo",
              "_instanceName": "Жакеев",
              "id": "3fb7c8ff-ba5b-0d8a-754e-db18e02344e5",
              "lastName": "Нұржан",
              "groupId": "f63d3e47-caff-8840-cbf7-3fcbb284f66b",
              "photo": {
                "_entityName": "sys$FileDescriptor",
                "_instanceName":
                    "альмуханов-33915aea-4631-40b6-8084-e2e76ae656ce.jpeg (05.08.2021 17:36)",
                "id": "5f60b797-ff34-d23a-c9f0-c09e8b00070e",
                "extension": "jpeg",
                "name": "альмуханов-33915aea-4631-40b6-8084-e2e76ae656ce.jpeg",
                "version": 1,
                "createDate": "2021-08-05 17:36:36.435"
              },
              "firstName": "Жакеев",
              "organization": "АО \"Каражыра\"",
              "middleName": "Құралбекұлы",
              "nationalIdentifier": "901205300210"
            }
          ],
          "department": {
            "_entityName": "krj_DepartmentPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DepartmentPojo-f7b584ef-b655-b190-c661-0db5a0e4e699 [new]",
            "id": "f7b584ef-b655-b190-c661-0db5a0e4e699",
            "departmentName":
                "(ГМК) Рабочие отдела главного маркшейдера и геолога",
            "groupId": "f7b584ef-b655-b190-c661-0db5a0e4e699"
          },
          "category": {
            "_entityName": "krj_DicBehaviorCategoryPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicBehaviorCategoryPojo-0a46c7b4-9095-84ec-4c6d-3bb4633c0583 [new]",
            "id": "0a46c7b4-9095-84ec-4c6d-3bb4633c0583",
            "code": "UN_SCHEDULED",
            "langValue": "Внеплановый"
          },
          "status": {
            "_entityName": "krj_DicMessageStatusPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicMessageStatusPojo-10218553-fa51-bc9d-f274-d89a1447a1c5 [new]",
            "id": "10218553-fa51-bc9d-f274-d89a1447a1c5",
            "code": "DISTRIBUTED",
            "langValue": "Распределен"
          }
        },
      ];
      var bsaList = List<BehaviorAudit>.from(
          response.map((x) => BehaviorAudit.fromMap(x)));
      var list = await HiveService.syncBehaviorAuditData(
          BoxNameStore.getBehaviorAudit, bsaList);
      return list.cast<BehaviorAudit>();
    } catch (e) {
      print(e);
    }
  }

  static Future getObservationsCategory(bool isList) async {
    var conn = await checkConnection();
    if (!conn) {
      var list = await HiveService.getOfflineListBox(
          BoxNameStore.getObservationsCategory);
      return list.cast<AbstractDictionary>();
    }

    if (isList) {
      var list = await HiveService.getOfflineListBox(
          BoxNameStore.getObservationsCategory);
      if (list.isNotEmpty) {
        return list.cast<AbstractDictionary>();
      }
    }
    try {
      // List response = await Kinfolk.getListModelRest(
      //     serviceOrEntityName: mobileService(),
      //     methodName: MethodNames.getDicObservationCategory,
      //     type: Types.services,
      //     fromMap: (val) => AbstractDictionary.fromMap(val));
      var response = [
        {
          "_entityName": "krj_DicObservationCategoryPojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.DicObservationCategoryPojo-357007e7-ab68-0555-e55e-da5340ea4045 [new]",
          "id": "357007e7-ab68-0555-e55e-da5340ea4045",
          "code": "EMP_POSITION",
          "langValue": "Положение/Поза работника"
        },
        {
          "_entityName": "krj_DicObservationCategoryPojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.DicObservationCategoryPojo-fdcccabf-b651-4944-8cc0-842804b25d54 [new]",
          "id": "fdcccabf-b651-4944-8cc0-842804b25d54",
          "code": "EMP_REACT",
          "langValue": "Реакция работника"
        },
        {
          "_entityName": "krj_DicObservationCategoryPojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.DicObservationCategoryPojo-7638759c-d695-748e-dfd8-2569301fd990 [new]",
          "id": "7638759c-d695-748e-dfd8-2569301fd990",
          "code": "RULES",
          "langValue": "Инструкции и правила"
        },
      ];
      var observationCategoryList = List<AbstractDictionary>.from(
          response.map((x) => AbstractDictionary.fromMap(x)));
      Box box =
          await HiveService.getClearBox(BoxNameStore.getObservationsCategory);
      observationCategoryList.forEach((e) {
        box.add(e);
      });
      var list = await HiveService.getOfflineListBox(
          BoxNameStore.getObservationsCategory);
      return list.cast<AbstractDictionary>();
    } catch (e) {
      print(e);
    }
  }

  static Future getKindSituations(bool isList) async {
    var conn = await checkConnection();
    if (!conn) {
      var list =
      await HiveService.getOfflineListBox(BoxNameStore.getKindSituation);
      return list.cast<AbstractDictionary>();
    }

    if (isList) {
      var list =
      await HiveService.getOfflineListBox(BoxNameStore.getKindSituation);
      if (list.isNotEmpty) {
        return list.cast<AbstractDictionary>();
      }
    }
    try {
      // List response = await Kinfolk.getListModelRest(
      //     serviceOrEntityName: mobileService(),
      //     methodName: MethodNames.getDicObservationKindSituation,
      //     type: Types.services,
      //     fromMap: (val) => AbstractDictionary.fromMap(val));
      var response = [
        {
          "_entityName": "krj_DicObservationKindSitutationPojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.DicObservationKindSitutationPojo-af034707-679c-1b2a-8cf4-523facc086e8 [new]",
          "id": "af034707-679c-1b2a-8cf4-523facc086e8",
          "code": "SAFE_ENV",
          "langValue": "Безопасные условия"
        },
        {
          "_entityName": "krj_DicObservationKindSitutationPojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.DicObservationKindSitutationPojo-08096318-82fc-ac57-5bc2-d325fb375973 [new]",
          "id": "08096318-82fc-ac57-5bc2-d325fb375973",
          "code": "DANGEROUS_CONDITION",
          "langValue": "Опасные Условия"
        },
        {
          "_entityName": "krj_DicObservationKindSitutationPojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.DicObservationKindSitutationPojo-c41b39b0-992d-d07b-7348-90ce164dbc4f [new]",
          "id": "c41b39b0-992d-d07b-7348-90ce164dbc4f",
          "code": "SAFE_ACTIONS",
          "langValue": "Безопасные Действия"
        },
        {
          "_entityName": "krj_DicObservationKindSitutationPojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.DicObservationKindSitutationPojo-9434a96f-bc69-1349-6a4a-2308f8798059 [new]",
          "id": "9434a96f-bc69-1349-6a4a-2308f8798059",
          "code": "DANGEROUS_ACTIONS",
          "langValue": "Опасные Действия"
        }
      ];
      var kindSituationList = List<AbstractDictionary>.from(
          response.map((x) => AbstractDictionary.fromMap(x)));
      Box box = await HiveService.getClearBox(BoxNameStore.getKindSituation);
      kindSituationList.forEach((e) {
        box.add(e);
      });
      return kindSituationList.cast<AbstractDictionary>();
    } catch (e) {
      print(e);
    }
  }

  static Future getKindConsequences(bool isList) async {
    var conn = await checkConnection();
    if (!conn) {
      var list = await HiveService.getOfflineListBox(
          BoxNameStore.getObservationConsequences);
      return list.cast<AbstractDictionary>();
    }

    if (isList) {
      var list = await HiveService.getOfflineListBox(
          BoxNameStore.getObservationConsequences);
      if (list.isNotEmpty) {
        return list.cast<AbstractDictionary>();
      }
    }
    try {
      // List response = await Kinfolk.getListModelRest(
      //     serviceOrEntityName: mobileService(),
      //     methodName: MethodNames.getDicObservationSeviritiyConsequences,
      //     type: Types.services,
      //     fromMap: (val) => AbstractDictionary.fromMap(val));
      var response = [
        {
          "_entityName": "krj_DicObservationSevirityConsequencesPojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.DicObservationSevirityConsequencesPojo-397a8d96-47e5-f776-7abb-cef4009f4cee [new]",
          "id": "397a8d96-47e5-f776-7abb-cef4009f4cee",
          "code": "SEVERE",
          "langValue": "Несчастный случай с тяжелым исходом"
        },
        {
          "_entityName": "krj_DicObservationSevirityConsequencesPojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.DicObservationSevirityConsequencesPojo-9c65a916-f86a-bf74-5c1c-75409714d48d [new]",
          "id": "9c65a916-f86a-bf74-5c1c-75409714d48d",
          "code": "FATAL",
          "langValue": "Несчастный случай со смертельным исходом"
        },
        {
          "_entityName": "krj_DicObservationSevirityConsequencesPojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.DicObservationSevirityConsequencesPojo-c01bebae-f0da-f0fd-46ff-660d8d30e087 [new]",
          "id": "c01bebae-f0da-f0fd-46ff-660d8d30e087",
          "code": "EASY",
          "langValue": "Несчастный случай с легким исходом"
        }
      ];
      var kindConsequencesList = List<AbstractDictionary>.from(
          response.map((x) => AbstractDictionary.fromMap(x)));
      Box box = await HiveService.getClearBox(
          BoxNameStore.getObservationConsequences);
      kindConsequencesList.forEach((e) {
        box.add(e);
      });
      return kindConsequencesList.cast<AbstractDictionary>();
    } catch (e) {
      print(e);
    }
  }

  static Future getKindDanger(bool isList) async {
    var conn = await checkConnection();
    if (!conn) {
      var list = await HiveService.getOfflineListBox(
          BoxNameStore.getObservationDanger);
      return list.cast<AbstractDictionary>();
    }

    if (isList) {
      var list = await HiveService.getOfflineListBox(
          BoxNameStore.getObservationDanger);
      if (list.isNotEmpty) {
        return list.cast<AbstractDictionary>();
      }
    }
    try {
      // List response = await Kinfolk.getListModelRest(
      //     serviceOrEntityName: mobileService(),
      //     methodName: MethodNames.getDicObservationKindDanger,
      //     type: Types.services,
      //     fromMap: (val) => AbstractDictionary.fromMap(val));
      var response = [
        {
          "_entityName": "krj_DicObservationKindDangerPojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.DicObservationKindDangerPojo-a095be00-73e8-32a2-1ec9-4bbe99608fc8 [new]",
          "id": "a095be00-73e8-32a2-1ec9-4bbe99608fc8",
          "code": "ACCIDENT",
          "langValue": "ДТП (раздавливание, наезд, удар внутри салона)"
        },
        {
          "_entityName": "krj_DicObservationKindDangerPojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.DicObservationKindDangerPojo-3d938b44-f01d-4c79-3b28-ca294f69bc9e [new]",
          "id": "3d938b44-f01d-4c79-3b28-ca294f69bc9e",
          "code": "DAMAGE_PROTRUD",
          "langValue": "Удар о выступающий предмет"
        },
        {
          "_entityName": "krj_DicObservationKindDangerPojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.DicObservationKindDangerPojo-d7483bb3-7876-8bb2-c48a-8c65602f0b13 [new]",
          "id": "d7483bb3-7876-8bb2-c48a-8c65602f0b13",
          "code": "DISEASE",
          "langValue": "Заболевание от пыли, шума, вибрации, излучения"
        },
      ];
      var kindDangerList = List<AbstractDictionary>.from(
          response.map((x) => AbstractDictionary.fromMap(x)));
      Box box =
          await HiveService.getClearBox(BoxNameStore.getObservationDanger);
      kindDangerList.forEach((e) {
        box.add(e);
      });
      return kindDangerList.cast<AbstractDictionary>();
    } catch (e) {
      print(e);
    }
  }

  static Future<FileDescriptor> saveImageToStorage(
      FileDescriptor fileDescriptor) async {
    var savedFile = await downloadFile(
        Kinfolk.getFileUrl(fileDescriptor.id), fileDescriptor.name);
    fileDescriptor.localPath = savedFile.path;
    fileDescriptor.fileName = fileDescriptor.name;
    return fileDescriptor;
  }

  static Future<FileDescriptor> saveFile(
      {@required File file, bool toServer = false}) async {
    var conn = await checkConnection();
    final fileName = file.path.split('/').last;
    // await GallerySaver.saveImage(file.path);
    var fileDescriptor = FileDescriptor();
    File localFile;
    if (!toServer) {
      localFile = await downloadFile(file.path, fileName, hasLocalFile: true);
      if (!conn) {
        fileDescriptor.localPath = localFile.path;
        fileDescriptor.fileName = fileName;
        return fileDescriptor;
      } else if (file != null) {
        fileDescriptor.localPath = localFile.path;
        fileDescriptor.fileName = fileName;
        return fileDescriptor;
      }
    }

    // final url = '$endpointUrl/rest/v2/files?name=' + fileName;
    // final headers = {'Authorization': 'Bearer ${GlobalVariables.token}'};
    // var request = http.MultipartRequest('POST', Uri.parse(url));
    // request.files
    //     .add(await http.MultipartFile.fromPath('file', '${file.path}'));
    // request.headers.addAll(headers);
    // final response = await request.send();
    // final respStr = await response.stream.bytesToString();
    // var responseFile = FileDescriptor.fromJson(respStr);
    // if (!toServer) {
    //   responseFile.localPath = localFile.path;
    //   responseFile.fileName = fileName;
    // }
    // return responseFile;
  }

  static Future createBsa(BehaviorAudit entity, bool isUpdated) async {
    var conn = await checkConnection();
    var uuid = Uuid();
    var v1 = uuid.v1();
    if (!conn) {
      if (isUpdated) {
        await entity.save();
      } else {
        var box = await HiveService.getBox(BoxNameStore.getBehaviorAudit);
        await box.add(entity);
      }
      return null;
    } else {
      entity.id = v1;
      entity.filled = false;
      entity.isDone = true;
      print(entity.id);
      if (isUpdated) {
        await entity.save();
      } else {
        var box = await HiveService.getBox(BoxNameStore.getBehaviorAudit);
        await box.add(entity);
      }
      return true;
    }
    // oauth2.Client client = await Kinfolk.getClient();
    // var url = Kinfolk.createRestUrl(
    //   mobileService(),
    //   MethodNames.createBehavior,
    //   Types.services,
    // );
    // var body = '''{
    //           "behaviorPojo": ${entity.toJsonCreate()}
    //         }''';
    // var response =
    //     await client.post(url, body: body, headers: Kinfolk.appJsonHeader);
    // if (response.statusCode == 200) {
    //   if (isUpdated) {
    //     await entity.delete();
    //   }
    //   return true;
    // } else {
    //   return false;
    // }
  }

  static Future cancelBsa(String bsaId) async {
    var conn = await checkConnection();
    if (!conn) {
      return null;
    }

    oauth2.Client client = await Kinfolk.getClient();

    var url = Kinfolk.createRestUrl(
      mobileService(),
      MethodNames.deleteBehavior,
      Types.services,
    );

    var body = '''{
              "id": "$bsaId"
            }''';
    var response =
    await client.post(url, body: body, headers: Kinfolk.appJsonHeader);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future synchronizeBehavior() async {
    var conn = await checkConnection();
    var result = true;
    if (!conn) {
      return null;
    }

    var box = await HiveService.getBox(BoxNameStore.getBehaviorAudit);
    var list = box.values.toList();
    for (BehaviorAudit e in list) {
      if (e.id == null) {
        // for (var i = 0; i < e.files.length; i++) {
        //   if (e.files[i].id == null) {
        //     if (e.files[i].localPath == null || e.files[i].localPath.isEmpty) {
        //       Get.snackbar(
        //           S.current.attention,
        //           'Не правильно фото № ${e.files.indexOf(e.files[i]) + 1}, '
        //           'в сообщение ${dateFormatFullToNumeric(e.date)}');
        //       return null;
        //     } else {
        //       var savedImage = await saveFile(
        //           file: File(e.files[i].localPath), toServer: true);
        //       savedImage.localPath = e.files[i].localPath;
        //       savedImage.fileName = e.files[i].fileName;
        //       e.files[i] = savedImage;
        //       await e.save();
        //     }
        //   }
        // }
        await createBsa(e, true).then((value) async {
          if (value != null && value) {
            // await e.delete();
          } else {
            // continue;
            result = false;
          }
        });
      } else if (!e.isDone && e.filled) {
        for (var i = 0; i < e.files.length; i++) {
          // if (e.files[i].id == null) {
          //   if (e.files[i].localPath == null || e.files[i].localPath.isEmpty) {
          //     return 'Не правильно фото № ${e.files.indexOf(e.files[i]) + 1}, '
          //         'в сообщение ${dateFormatFullToNumeric(e.date)}';
          //   } else {
          //     var savedImage = await saveFile(
          //         file: File(e.files[i].localPath), toServer: true);
          //     savedImage.localPath = e.files[i].localPath;
          //     savedImage.fileName = e.files[i].fileName;
          //     e.files[i] = savedImage;
          //     await e.save();
          //   }
          // }
        }
        await createBsa(e, true).then((value) async {
          if (value != null && value) {
            // await e.delete();
          } else {
            // continue;
            result = false;
          }
        });
      }
    }
    return result;
  }

  //risk request
  static Future getRisks() async {
    var conn = await checkConnection();
    var list = await HiveService.getOfflineListBox(BoxNameStore.getRisks);
    if (!conn) {
      return list.cast<RisksManagement>();
    } else if (list.isNotEmpty) {
      return list.cast<RisksManagement>();
    }
    try {
      // List risksList = await Kinfolk.getListModelRest(
      //     serviceOrEntityName: mobileService(),
      //     methodName: MethodNames.getAllRisks,
      //     type: Types.services,
      //     fromMap: (val) => RisksManagement.fromMap(val));
      var response = [
        {
          "_entityName": "krj_RiskPojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.RiskPojo-63a93676-962b-94d3-ab84-6a86ce56e313 [new]",
          "id": "63a93676-962b-94d3-ab84-6a86ce56v1254",
          "calculation": 15,
          "assessmentVersion": 6,
          "level": {
            "_entityName": "krj_DicRiskLevelPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicRiskLevelPojo-16220120-654d-583c-dc14-03f4e8a41305 [new]",
            "id": "16220120-654d-583c-dc14-03f4e8a41305",
            "code": "HIGH",
            "langValue": "Высокий"
          },
          "initDate": "2021-09-02 00:00:00.000",
          "probability": {
            "_entityName": "krj_DicRiskProbabilityPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicRiskProbabilityPojo-c07a4594-5f61-9af1-3798-6744888d239d [new]",
            "id": "c07a4594-5f61-9af1-3798-6744888d239d",
            "code": "E_1",
            "langValue": "E"
          },
          "initiator": {
            "_entityName": "krj_PersonPojo",
            "_instanceName": "Жакеев",
            "id": "3fb7c8ff-ba5b-0d8a-754e-db18e02344e5",
            "lastName": "Нұржан",
            "image": "5f60b797-ff34-d23a-c9f0-c09e8b00070e",
            "firstName": "Жакеев",
            "middleName": "Құралбекұлы"
          },
          "regDate": "2021-09-01 16:17:31.773",
          "riskManageability": [
            {
              "_entityName": "krj_DicRiskManageabilityPojo",
              "_instanceName":
                  "kz.uco.krj.hse.restpojo.DicRiskManageabilityPojo-f3eeaeb7-41a7-7a61-f1a5-9a9d2c9b42b7 [new]",
              "id": "f3eeaeb7-41a7-7a61-f1a5-9a9d2c9b42b7",
              "code": "TECHNICAL_MAINTENANCE",
              "langValue": "Поддержание технических мер"
            }
          ],
          "dangerousCategory": {
            "_entityName": "krj_DicDangerousCategoryPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicDangerousCategoryPojo-b79d4c38-8bc6-e673-054d-273e54e7d0a7 [new]",
            "id": "b79d4c38-8bc6-e673-054d-273e54e7d0a7",
            "code": "TRANSPORT",
            "langValue": "Транспорт"
          },
          "dangerousSource": {
            "_entityName": "krj_DicDangerousSourcePojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicDangerousSourcePojo-1f9beba7-35bc-3223-d073-4a70d3a347e2 [new]",
            "id": "1f9beba7-35bc-3223-d073-4a70d3a347e2",
            "code": "ROTATING_EQUIPMENT",
            "langValue": "Вращающиеся элементы оборудования"
          },
          "actionType": {
            "_entityName": "krj_DicActionTypePojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicActionTypePojo-65897f5e-ad82-9cf8-22cc-039465b45094 [new]",
            "id": "65897f5e-ad82-9cf8-22cc-039465b45094",
            "code": "TEST",
            "langValue": "TEST"
          },
          "regNumber": "00037",
          "organization": {
            "_entityName": "krj_OrganizationPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.OrganizationPojo-eaad86be-54a3-8dfa-a00e-f3b435d2cb61 [new]",
            "id": "eaad86be-54a3-8dfa-a00e-f3b435d2cb61",
            "organizationName": "АО \"Каражыра\"",
            "groupId": "6fb225ef-2d01-9941-0b19-e12654b8089a"
          },
          "objectName": {
            "_entityName": "krj_DicObjectName",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicObjectNamePojo-f719001e-9521-468b-61b0-f43a1027d916 [new]",
            "id": "f719001e-9521-468b-61b0-f43a1027d916",
            "code": "KITCHEN",
            "langValue": "Станок №101"
          },
          "consequences": {
            "_entityName": "krj_DicRiskConsequencesPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicRiskConsequencesPojo-a1c8dcde-0c91-2c03-c66a-a0f389df32e4 [new]",
            "id": "a1c8dcde-0c91-2c03-c66a-a0f389df32e4",
            "code": "SEVERITY_3",
            "langValue": "Тяжесть - 3"
          },
          "files": [
            {
              "_entityName": "sys$FileDescriptor",
              "_instanceName": "Танкаева А. (23.07.2020 22:25)",
              "id": "6ed80b70-d06d-49ff-c502-84ecee0b9730",
              "extension": "PNG",
              "name": "Танкаева А.",
              "version": 1,
              "createDate": "2020-07-23 22:25:05.297"
            }
          ],
          "comment": "TEST UPDATE",
          "department": {
            "_entityName": "krj_DepartmentPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DepartmentPojo-c11426d4-82df-696f-76e2-8dd972f51ecd [new]",
            "id": "c11426d4-82df-696f-76e2-8dd972f51ecd",
            "departmentName": "(АРОхр) Рабочие службы безопасности",
            "groupId": "c11426d4-82df-696f-76e2-8dd972f51ecd"
          },
          "status": {
            "_entityName": "krj_DicMessageStatusPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicMessageStatusPojo-a565104e-fb4c-4338-92a4-a66c097569d1 [new]",
            "id": "a565104e-fb4c-4338-92a4-a66c097569d1",
            "code": "APPROVED",
            "langValue": "Зарегистрирован"
          }
        },
        {
          "_entityName": "krj_RiskPojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.RiskPojo-63a93676-962b-94d3-ab84-6a86ce56e313 [new]",
          "id": "63a93676-962b-94d3-ab84",
          "calculation": 15,
          "assessmentVersion": 6,
          "level": {
            "_entityName": "krj_DicRiskLevelPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicRiskLevelPojo-16220120-654d-583c-dc14-03f4e8a41305 [new]",
            "id": "16220120-654d-583c-dc14-03f4e8a41305",
            "code": "HIGH",
            "langValue": "Высокий"
          },
          "initDate": "2021-09-05 00:00:00.000",
          "probability": {
            "_entityName": "krj_DicRiskProbabilityPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicRiskProbabilityPojo-c07a4594-5f61-9af1-3798-6744888d239d [new]",
            "id": "c07a4594-5f61-9af1-3798-6744888d239d",
            "code": "E_1",
            "langValue": "E"
          },
          "initiator": {
            "_entityName": "krj_PersonPojo",
            "_instanceName": "Жакеев",
            "id": "3fb7c8ff-ba5b-0d8a-754e-db18e02344e5",
            "lastName": "Нұржан",
            "image": "5f60b797-ff34-d23a-c9f0-c09e8b00070e",
            "firstName": "Жакеев",
            "middleName": "Құралбекұлы"
          },
          "regDate": "2021-09-01 16:17:31.773",
          "riskManageability": [
            {
              "_entityName": "krj_DicRiskManageabilityPojo",
              "_instanceName":
                  "kz.uco.krj.hse.restpojo.DicRiskManageabilityPojo-f3eeaeb7-41a7-7a61-f1a5-9a9d2c9b42b7 [new]",
              "id": "f3eeaeb7-41a7-7a61-f1a5-9a9d2c9b42b7",
              "code": "TECHNICAL_MAINTENANCE",
              "langValue": "Поддержание технических мер"
            }
          ],
          "dangerousCategory": {
            "_entityName": "krj_DicDangerousCategoryPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicDangerousCategoryPojo-b79d4c38-8bc6-e673-054d-273e54e7d0a7 [new]",
            "id": "b79d4c38-8bc6-e673-054d-273e54e7d0a7",
            "code": "TRANSPORT",
            "langValue": "Транспорт"
          },
          "dangerousSource": {
            "_entityName": "krj_DicDangerousSourcePojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicDangerousSourcePojo-1f9beba7-35bc-3223-d073-4a70d3a347e2 [new]",
            "id": "1f9beba7-35bc-3223-d073-4a70d3a347e2",
            "code": "ROTATING_EQUIPMENT",
            "langValue": "Вращающиеся элементы оборудования"
          },
          "actionType": {
            "_entityName": "krj_DicActionTypePojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicActionTypePojo-65897f5e-ad82-9cf8-22cc-039465b45094 [new]",
            "id": "65897f5e-ad82-9cf8-22cc-039465b45094",
            "code": "TEST",
            "langValue": "TEST"
          },
          "regNumber": "00022",
          "organization": {
            "_entityName": "krj_OrganizationPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.OrganizationPojo-eaad86be-54a3-8dfa-a00e-f3b435d2cb61 [new]",
            "id": "eaad86be-54a3-8dfa-a00e-f3b435d2cb61",
            "organizationName": "АО \"Каражыра\"",
            "groupId": "6fb225ef-2d01-9941-0b19-e12654b8089a"
          },
          "objectName": {
            "_entityName": "krj_DicObjectName",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicObjectNamePojo-f719001e-9521-468b-61b0-f43a1027d916 [new]",
            "id": "f719001e-9521-468b-61b0-f43a1027d916",
            "code": "KITCHEN",
            "langValue": "Станок №101"
          },
          "consequences": {
            "_entityName": "krj_DicRiskConsequencesPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicRiskConsequencesPojo-a1c8dcde-0c91-2c03-c66a-a0f389df32e4 [new]",
            "id": "a1c8dcde-0c91-2c03-c66a-a0f389df32e4",
            "code": "SEVERITY_3",
            "langValue": "Тяжесть - 3"
          },
          "files": [
            {
              "_entityName": "sys$FileDescriptor",
              "_instanceName": "Танкаева А. (23.07.2020 22:25)",
              "id": "6ed80b70-d06d-49ff-c502-84ecee0b9730",
              "extension": "PNG",
              "name": "Танкаева А.",
              "version": 1,
              "createDate": "2020-07-23 22:25:05.297"
            }
          ],
          "comment": "TEST UPDATE",
          "department": {
            "_entityName": "krj_DepartmentPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DepartmentPojo-c11426d4-82df-696f-76e2-8dd972f51ecd [new]",
            "id": "c11426d4-82df-696f-76e2-8dd972f51ecd",
            "departmentName": "(АРОхр) Рабочие службы безопасности",
            "groupId": "c11426d4-82df-696f-76e2-8dd972f51ecd"
          },
          "status": {
            "_entityName": "krj_DicMessageStatusPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicMessageStatusPojo-a565104e-fb4c-4338-92a4-a66c097569d1 [new]",
            "id": "a565104e-fb4c-4338-92a4-a66c097569d1",
            "code": "CLOSED",
            "langValue": "Закрыт"
          }
        },
        {
          "_entityName": "krj_RiskPojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.RiskPojo-63a93676-962b-94d3-ab84-6a86ce56e313 [new]",
          "id": "63a93676-962b-94d3-6a86ce56v1254",
          "calculation": 15,
          "assessmentVersion": 6,
          "level": {
            "_entityName": "krj_DicRiskLevelPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicRiskLevelPojo-16220120-654d-583c-dc14-03f4e8a41305 [new]",
            "id": "16220120-654d-583c-dc14-03f4e8a41305",
            "code": "HIGH",
            "langValue": "Высокий"
          },
          "initDate": "2021-09-01 00:00:00.000",
          "probability": {
            "_entityName": "krj_DicRiskProbabilityPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicRiskProbabilityPojo-c07a4594-5f61-9af1-3798-6744888d239d [new]",
            "id": "c07a4594-5f61-9af1-3798-6744888d239d",
            "code": "E_1",
            "langValue": "E"
          },
          "initiator": {
            "_entityName": "krj_PersonPojo",
            "_instanceName": "Жакеев",
            "id": "3fb7c8ff-ba5b-0d8a-754e-db18e02344e5",
            "lastName": "Нұржан",
            "image": "5f60b797-ff34-d23a-c9f0-c09e8b00070e",
            "firstName": "Жакеев",
            "middleName": "Құралбекұлы"
          },
          "regDate": "2021-09-01 16:17:31.773",
          "riskManageability": [
            {
              "_entityName": "krj_DicRiskManageabilityPojo",
              "_instanceName":
                  "kz.uco.krj.hse.restpojo.DicRiskManageabilityPojo-f3eeaeb7-41a7-7a61-f1a5-9a9d2c9b42b7 [new]",
              "id": "f3eeaeb7-41a7-7a61-f1a5-9a9d2c9b42b7",
              "code": "TECHNICAL_MAINTENANCE",
              "langValue": "Поддержание технических мер"
            }
          ],
          "dangerousCategory": {
            "_entityName": "krj_DicDangerousCategoryPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicDangerousCategoryPojo-b79d4c38-8bc6-e673-054d-273e54e7d0a7 [new]",
            "id": "b79d4c38-8bc6-e673-054d-273e54e7d0a7",
            "code": "TRANSPORT",
            "langValue": "Транспорт"
          },
          "dangerousSource": {
            "_entityName": "krj_DicDangerousSourcePojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicDangerousSourcePojo-1f9beba7-35bc-3223-d073-4a70d3a347e2 [new]",
            "id": "1f9beba7-35bc-3223-d073-4a70d3a347e2",
            "code": "ROTATING_EQUIPMENT",
            "langValue": "Вращающиеся элементы оборудования"
          },
          "actionType": {
            "_entityName": "krj_DicActionTypePojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicActionTypePojo-65897f5e-ad82-9cf8-22cc-039465b45094 [new]",
            "id": "65897f5e-ad82-9cf8-22cc-039465b45094",
            "code": "TEST",
            "langValue": "TEST"
          },
          "regNumber": "00015",
          "organization": {
            "_entityName": "krj_OrganizationPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.OrganizationPojo-eaad86be-54a3-8dfa-a00e-f3b435d2cb61 [new]",
            "id": "eaad86be-54a3-8dfa-a00e-f3b435d2cb61",
            "organizationName": "АО \"Каражыра\"",
            "groupId": "6fb225ef-2d01-9941-0b19-e12654b8089a"
          },
          "objectName": {
            "_entityName": "krj_DicObjectName",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicObjectNamePojo-f719001e-9521-468b-61b0-f43a1027d916 [new]",
            "id": "f719001e-9521-468b-61b0-f43a1027d916",
            "code": "KITCHEN",
            "langValue": "Станок №101"
          },
          "consequences": {
            "_entityName": "krj_DicRiskConsequencesPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicRiskConsequencesPojo-a1c8dcde-0c91-2c03-c66a-a0f389df32e4 [new]",
            "id": "a1c8dcde-0c91-2c03-c66a-a0f389df32e4",
            "code": "SEVERITY_3",
            "langValue": "Тяжесть - 3"
          },
          "files": [
            {
              "_entityName": "sys$FileDescriptor",
              "_instanceName": "Танкаева А. (23.07.2020 22:25)",
              "id": "6ed80b70-d06d-49ff-c502-84ecee0b9730",
              "extension": "PNG",
              "name": "Танкаева А.",
              "version": 1,
              "createDate": "2020-07-23 22:25:05.297"
            }
          ],
          "comment": "TEST UPDATE",
          "department": {
            "_entityName": "krj_DepartmentPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DepartmentPojo-c11426d4-82df-696f-76e2-8dd972f51ecd [new]",
            "id": "c11426d4-82df-696f-76e2-8dd972f51ecd",
            "departmentName": "(АРОхр) Рабочие службы безопасности",
            "groupId": "c11426d4-82df-696f-76e2-8dd972f51ecd"
          },
          "status": {
            "_entityName": "krj_DicMessageStatusPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicMessageStatusPojo-a565104e-fb4c-4338-92a4-a66c097569d1 [new]",
            "id": "a565104e-fb4c-4338-92a4-a66c097569d1",
            "code": "CANCELED",
            "langValue": "Отменен"
          }
        },
      ];
      var bsaList = List<RisksManagement>.from(
          response.map((x) => RisksManagement.fromMap(x)));
      var list =
          await HiveService.syncRisksData(BoxNameStore.getRisks, bsaList);
      return list.cast<RisksManagement>();
    } catch (e) {
      print(e);
    }
  }

  static Future getRiskManageability(bool withLocal) async {
    var conn = await checkConnection();
    if (!conn) {
      var list = await HiveService.getOfflineListBox(
          BoxNameStore.getRiskManageabilities);
      return list.cast<AbstractDictionary>();
    }

    if (withLocal) {
      var list = await HiveService.getOfflineListBox(
          BoxNameStore.getRiskManageabilities);
      if (list.isNotEmpty) {
        return list.cast<AbstractDictionary>();
      }
    }

    try {
      // List response = await Kinfolk.getListModelRest(
      //     serviceOrEntityName: mobileService(),
      //     methodName: MethodNames.getRiskManageability,
      //     type: Types.services,
      //     fromMap: (val) => AbstractDictionary.fromMap(val));
      var response = [
        {
          "_entityName": "krj_DicRiskManageabilityPojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.DicRiskManageabilityPojo-0f15627f-9a35-0eb4-fc78-8c378424f458 [new]",
          "id": "0f15627f-9a35-0eb4-fc78-8c378424f458",
          "code": "TECHNICAL",
          "langValue": "Технические Меры"
        },
        {
          "_entityName": "krj_DicRiskManageabilityPojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.DicRiskManageabilityPojo-f3eeaeb7-41a7-7a61-f1a5-9a9d2c9b42b7 [new]",
          "id": "f3eeaeb7-41a7-7a61-f1a5-9a9d2c9b42b7",
          "code": "TECHNICAL_MAINTENANCE",
          "langValue": "Поддержание технических мер"
        },
        {
          "_entityName": "krj_DicRiskManageabilityPojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.DicRiskManageabilityPojo-f41e17c1-937a-0934-c9ea-d40f96569f47 [new]",
          "id": "f41e17c1-937a-0934-c9ea-d40f96569f47",
          "code": "SEC_BYPASS",
          "langValue": "Обход мер безопасности"
        },
      ];
      var riskManageabilityList = List<AbstractDictionary>.from(
          response.map((x) => AbstractDictionary.fromMap(x)));
      Box box =
          await HiveService.getClearBox(BoxNameStore.getRiskManageabilities);
      riskManageabilityList.forEach((e) {
        box.add(e);
      });
      return riskManageabilityList.cast<AbstractDictionary>();
    } catch (e) {
      print(e);
    }
  }

  static Future getRiskProbabilities() async {
    var conn = await checkConnection();
    if (!conn) {
      var list = await HiveService.getOfflineListBox(
          BoxNameStore.getRiskProbabilities);
      return list.cast<AbstractDictionary>();
    }

    // if (withLocal) {
    //   var list = await HiveService.getOfflineListBox(
    //       BoxNameStore.getRiskProbabilities);
    //   if (list.isNotEmpty) {
    //     return list.cast<AbstractDictionary>();
    //   }
    // }

    try {
      // List response = await Kinfolk.getListModelRest(
      //     serviceOrEntityName: mobileService(),
      //     methodName: MethodNames.getRiskProbabilities,
      //     type: Types.services,
      //     fromMap: (val) => AbstractDictionary.fromMap(val));
      var response = [
        {
          "_entityName": "krj_DicRiskProbabilityPojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.DicRiskProbabilityPojo-1d0b421d-e661-f317-53e5-201567c3e1cd [new]",
          "id": "1d0b421d-e661-f317-53e5-201567c3e1cd",
          "code": "A_5",
          "langValue": "A"
        },
        {
          "_entityName": "krj_DicRiskProbabilityPojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.DicRiskProbabilityPojo-0163c58a-9e56-cfd2-296a-2a14cfa09f59 [new]",
          "id": "0163c58a-9e56-cfd2-296a-2a14cfa09f59",
          "code": "B_4",
          "langValue": "B"
        },
        {
          "_entityName": "krj_DicRiskProbabilityPojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.DicRiskProbabilityPojo-95ff8d75-d975-8aa5-9a0c-4c5322389cb6 [new]",
          "id": "95ff8d75-d975-8aa5-9a0c-4c5322389cb6",
          "code": "C_3",
          "langValue": "C"
        },
        {
          "_entityName": "krj_DicRiskProbabilityPojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.DicRiskProbabilityPojo-d175a786-6a10-de76-0483-8aeae0bc7b1d [new]",
          "id": "d175a786-6a10-de76-0483-8aeae0bc7b1d",
          "code": "D_2",
          "langValue": "D"
        },
        {
          "_entityName": "krj_DicRiskProbabilityPojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.DicRiskProbabilityPojo-c07a4594-5f61-9af1-3798-6744888d239d [new]",
          "id": "c07a4594-5f61-9af1-3798-6744888d239d",
          "code": "E_1",
          "langValue": "E"
        }
      ];
      var riskProbabilitiesList = List<AbstractDictionary>.from(
          response.map((x) => AbstractDictionary.fromMap(x)));
      Box box =
          await HiveService.getClearBox(BoxNameStore.getRiskProbabilities);
      riskProbabilitiesList.forEach((e) {
        box.add(e);
      });
      return riskProbabilitiesList.cast<AbstractDictionary>();
    } catch (e) {
      print(e);
    }
  }

  static Future getRiskActionType(bool withLocal) async {
    var conn = await checkConnection();
    if (!conn) {
      var list =
      await HiveService.getOfflineListBox(BoxNameStore.getDicActionTypes);
      return list.cast<AbstractDictionary>();
    }

    if (withLocal) {
      var list =
      await HiveService.getOfflineListBox(BoxNameStore.getDicActionTypes);
      if (list.isNotEmpty) {
        return list.cast<AbstractDictionary>();
      }
    }

    try {
      // List response = await Kinfolk.getListModelRest(
      //     serviceOrEntityName: mobileService(),
      //     methodName: MethodNames.getDicActionTypes,
      //     type: Types.services,
      //     fromMap: (val) => AbstractDictionary.fromMap(val));
      var response = [
        {
          "_entityName": "krj_DicActionTypePojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.DicActionTypePojo-65897f5e-ad82-9cf8-22cc-039465b45094 [new]",
          "id": "65897f5e-ad82-9cf8-22cc-032sdg5as45f",
          "code": "TEST",
          "langValue": "TEST"
        }
      ];
      var riskActionTypeList = List<AbstractDictionary>.from(
          response.map((x) => AbstractDictionary.fromMap(x)));
      Box box = await HiveService.getClearBox(BoxNameStore.getDicActionTypes);
      riskActionTypeList.forEach((e) {
        box.add(e);
      });
      return riskActionTypeList.cast<AbstractDictionary>();
    } catch (e) {
      print(e);
    }
  }

  static Future getRiskDangerousCategories(bool withLocal) async {
    var conn = await checkConnection();
    if (!conn) {
      var list = await HiveService.getOfflineListBox(
          BoxNameStore.getDicDangerousCategories);
      return list.cast<AbstractDictionary>();
    }

    if (withLocal) {
      var list = await HiveService.getOfflineListBox(
          BoxNameStore.getDicDangerousCategories);
      if (list.isNotEmpty) {
        return list.cast<AbstractDictionary>();
      }
    }

    try {
      // List response = await Kinfolk.getListModelRest(
      //     serviceOrEntityName: mobileService(),
      //     methodName: MethodNames.getDicDangerousCategories,
      //     type: Types.services,
      //     fromMap: (val) => AbstractDictionary.fromMap(val));
      var response = [
        {
          "_entityName": "krj_DicDangerousCategoryPojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.DicDangerousCategoryPojo-25f969e6-1930-b215-99a8-6d76aa77f6ba [new]",
          "id": "25f969e6-1930-b215-99a8-6d76aa77f6ba",
          "code": "MECHANIC",
          "langValue": "Механические"
        },
        {
          "_entityName": "krj_DicDangerousCategoryPojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.DicDangerousCategoryPojo-0ff5424c-4ebc-1ac4-664a-51e4a33f3e8c [new]",
          "id": "0ff5424c-4ebc-1ac4-664a-51e4a33f3e8c",
          "code": "THERMAL",
          "langValue": "Термические"
        },
      ];
      var riskDangerCategoryList = List<AbstractDictionary>.from(
          response.map((x) => AbstractDictionary.fromMap(x)));
      Box box =
          await HiveService.getClearBox(BoxNameStore.getDicDangerousCategories);
      riskDangerCategoryList.forEach((e) {
        box.add(e);
      });
      return riskDangerCategoryList.cast<AbstractDictionary>();
    } catch (e) {
      print(e);
    }
  }

  static Future getRiskDangerousSources(bool withLocal) async {
    var conn = await checkConnection();
    if (!conn) {
      var list = await HiveService.getOfflineListBox(
          BoxNameStore.getDicDangerousSources);
      return list.cast<AbstractDictionary>();
    }

    if (withLocal) {
      var list = await HiveService.getOfflineListBox(
          BoxNameStore.getDicDangerousSources);
      if (list.isNotEmpty) {
        return list.cast<AbstractDictionary>();
      }
    }

    try {
      // List response = await Kinfolk.getListModelRest(
      //     serviceOrEntityName: mobileService(),
      //     methodName: MethodNames.getDicDangerousSources,
      //     type: Types.services,
      //     fromMap: (val) => AbstractDictionary.fromMap(val));
      var response = [
        {
          "_entityName": "krj_DicDangerousSourcePojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.DicDangerousSourcePojo-1f9beba7-35bc-3223-d073-4a70d3a347e2 [new]",
          "id": "1f9beba7-35bc-3223-d073-1d2f6a5s89d4",
          "code": "ROTATING_EQUIPMENT",
          "langValue": "Вращающиеся элементы оборудования"
        },
        {
          "_entityName": "krj_DicDangerousSourcePojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.DicDangerousSourcePojo-54d0367b-9f67-13ec-d79f-886ee206379e [new]",
          "id": "54d0367b-9f67-13ec-d79f-122dsaw36f4a",
          "code": "MOVING_EQUIP_ITEMS",
          "langValue": "Подвижные элементы оборудования"
        },
      ];
      var riskDangerSourcesList = List<AbstractDictionary>.from(
          response.map((x) => AbstractDictionary.fromMap(x)));
      Box box =
          await HiveService.getClearBox(BoxNameStore.getDicDangerousSources);
      riskDangerSourcesList.forEach((e) {
        box.add(e);
      });
      return riskDangerSourcesList.cast<AbstractDictionary>();
    } catch (e) {
      print(e);
    }
  }

  static Future getRiskConsequences(bool withLocal) async {
    var conn = await checkConnection();
    if (!conn) {
      var list =
      await HiveService.getOfflineListBox(BoxNameStore.getRiskConsequences);
      return list.cast<AbstractDictionary>();
    }

    if (withLocal) {
      var list =
      await HiveService.getOfflineListBox(BoxNameStore.getRiskConsequences);
      if (list.isNotEmpty) {
        return list.cast<AbstractDictionary>();
      }
    }

    try {
      // List response = await Kinfolk.getListModelRest(
      //     serviceOrEntityName: mobileService(),
      //     methodName: MethodNames.getRiskConsequences,
      //     type: Types.services,
      //     fromMap: (val) => AbstractDictionary.fromMap(val));
      var response = [
        {
          "_entityName": "krj_DicRiskConsequencesPojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.DicRiskConsequencesPojo-738f2e65-6244-b326-281e-0e6e9ba993e9 [new]",
          "id": "738f2e65-6244-b326-281e-1f2a5s6fdf5e",
          "code": "SEVERITY_1",
          "langValue": "Тяжесть - 1"
        },
        {
          "_entityName": "krj_DicRiskConsequencesPojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.DicRiskConsequencesPojo-5f2e9628-610d-45b7-9e36-769cb439fbd8 [new]",
          "id": "5f2e9628-610d-45b7-9e36-1df25s68faf4",
          "code": "SEVERITY_2",
          "langValue": "Тяжесть - 2"
        },
      ];
      var riskConsequencesList = List<AbstractDictionary>.from(
          response.map((x) => AbstractDictionary.fromMap(x)));
      Box box = await HiveService.getClearBox(BoxNameStore.getRiskConsequences);
      riskConsequencesList.forEach((e) {
        box.add(e);
      });
      return riskConsequencesList.cast<AbstractDictionary>();
    } catch (e) {
      print(e);
    }
  }

  static Future createRisk(RisksManagement entity, bool isUpdated) async {
    var conn = await checkConnection();
    var uuid = Uuid();
    var v1 = uuid.v1();
    if (!conn) {
      if (isUpdated) {
        await entity.save();
      } else {
        var box = await HiveService.getBox(BoxNameStore.getRisks);
        await box.add(entity);
      }
      return null;
    } else {
      entity.id = v1;
      print(entity.id);
      if (isUpdated) {
        await entity.save();
      } else {
        var box = await HiveService.getBox(BoxNameStore.getRisks);
        await box.add(entity);
      }
      return true;
    }
    // oauth2.Client client = await Kinfolk.getClient();
    // var url = Kinfolk.createRestUrl(
    //   mobileService(),
    //   MethodNames.createRisk,
    //   Types.services,
    // );
    // var body = '''{
    //           "riskPojo": ${entity.toJsonCreate()}
    //         }''';
    // var response =
    //     await client.post(url, body: body, headers: Kinfolk.appJsonHeader);
    // if (response.statusCode == 200) {
    //   if (isUpdated) {
    //     await entity.delete();
    //   }
    //   return true;
    // } else {
    //   return false;
    // }
  }

  static Future cancelRisk(String riskId) async {
    var conn = await checkConnection();
    if (!conn) {
      return null;
    }

    oauth2.Client client = await Kinfolk.getClient();

    var url = Kinfolk.createRestUrl(
      mobileService(),
      MethodNames.deleteRisk,
      Types.services,
    );

    var body = '''{
              "id": "$riskId"
            }''';
    var response =
    await client.post(url, body: body, headers: Kinfolk.appJsonHeader);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future synchronizeRisks() async {
    var conn = await checkConnection();
    var result = true;
    print('conn: $conn');
    if (!conn) {
      return null;
    }

    var box = await HiveService.getBox(BoxNameStore.getRisks);
    var list = box.values.toList();
    for (RisksManagement e in list) {
      if (e.id == null) {
        for (var i = 0; i < e.files.length; i++) {
          if (e.files[i].id == null) {
            if (e.files[i].localPath == null || e.files[i].localPath.isEmpty) {
              return 'Не правильно фото № ${e.files.indexOf(e.files[i]) + 1}, '
                  'в сообщение ${dateFormatFullToNumeric(e.initDate)}';
            } else {
              var savedImage = await saveFile(
                  file: File(e.files[i].localPath), toServer: true);
              savedImage.localPath = e.files[i].localPath;
              savedImage.fileName = e.files[i].fileName;
              e.files[i] = savedImage;
              await e.save();
            }
          }
        }
        await createRisk(e, true).then((value) async {
          if (value != null && value) {
            // await e.delete();
          } else {
            // continue;
            result = false;
          }
        });
      }
    }
    return result;
  }

  static Future getMyTicket() async {
    var conn = await checkConnection();
    if (!conn) {
      var list = await HiveService.getOfflineListBox(BoxNameStore.getMyTicket);
      return list.isNotEmpty ? list.first : TicketResponse(status: false);
    }
    try {
      // var response = await Kinfolk.getSingleModelRest(
      //     serviceName: mobileService(),
      //     methodName: MethodNames.getValidTicketForLoggedIn,
      //     type: Types.services,
      //     fromMap: (val) => TicketResponse.fromMap(val));
      var response = {
        "ticket": {
          "_entityName": "krj_TicketPojo",
          "id": "ed984bab-d7bb-3d0b-634c-14b22beff523",
          "issuedDate": "2021-08-25 00:00:00.000",
          "qr":
              "iVBORw0KGgoAAAANSUhEUgAAASwAAAEsAQAAAABRBrPYAAAB/ElEQVR4Xu2ZO27DMBBEV3ChMkfgUXQ06mg6So7g0oWhzcyQthPCQFIGGG5hk9xHF4P9SY78i11jPHlrExtsYoNNbLCJDfb/sSNoJfcFJwUHd+5Sp1EdMS3LEfTDzgtPc3n57LCIFYLt8kKwyw1wXSifM/bUbbmvPLTHMhlBn1HPkN8Z47KQDlacpG7vMssGo7spxXh6fOk0HLHReql5Hbhh1G294mPJ2wcyi184PC/YbY5YckBpDiUYd6B7k3bEdi23nUUX9iw1kM8TS/gRMxxoaS2zSOOuI3agH7PahiJo2xVWuQfCqlUcN4zGmKGDl9qcolKDnSH21E0G3Zopzzau3DDmUnclL7XWVBVIlpjaDyVafmaWxKyGWO7Nn70LBecU6dbNDzv7CNt000Nxu2uKtQgKpRQrjrpQoP4kxfTDmFma8KUb5GuDW39nYIkB4YQP3bjvhYcJxp9wxBY6um7bY67FhD+8R/LBQhM+ldLgpjvB6Cq64IdRomB3XplLKrpHsPDg0BDrdqgfA3ukVOvVhhgl4kNO7U8+6s5KN0aXI1a5LBjc2J01vDTd+l1DTH4qpVzSC6RvYtpioQEFJZi9Ws1oCCQ7LFmC9QefVMSu0G+IcVlEc6/MgjGsQj43jGIFdWuTrByMp6GJ22C/2sQGm9hgExtsYoMZYV9aqVNOl1QfSQAAAABJRU5ErkJggg==",
          "ticketNumber": "WTI-2021-00003",
          "code": "6210",
          "issuedBy": {
            "_entityName": "krj_PersonPojo",
            "id": "f63d3e47-caff-8840-cbf7-3fcbb284f66b",
            "lastName": "Нұрсұлтан",
            "firstName": "Азаматов",
            "middleName": "Ерлан",
            "nationalIdentifier": "430706305152"
          },
          "type": "GREEN",
          "incident": "Incident test",
          "status": "Выдано"
        },
        "status": true
      };
      var getMyTicketList = TicketResponse.fromMap(response);
      Box box = await HiveService.getClearBox(BoxNameStore.getMyTicket);
      await box.add(getMyTicketList);
      return getMyTicketList;
    } catch (e) {
      print(e);
    }
  }

  static Future<CheckPersonResponse> checkPersonByNId(int iin) async {
    try {
      // var response = await Kinfolk.getSingleModelRest(
      //     serviceName: mobileService(),
      //     methodName: MethodNames.checkNationalId + '?nationalId=$iin',
      //     type: Types.services,
      //     fromMap: (val) => CheckPersonResponse.fromMap(val));
      // print('response.status: ${response.status}');
      var response = {
        "_entityName": "krj_PersonPojo",
        "_instanceName": "",
        "id": "f63d3e47-caff-8840-cbf7",
        "fullName": "Азаматов Н.Н.",
        "status": true
      };
      var checkPerson = CheckPersonResponse.fromMap(response);
      return checkPerson;
    } catch (e) {
      print(e);
    }
  }

  static Future<List<EventEntity>> getEventsById(String pgId) async {
    var conn = await checkConnection();
    if (!conn) {
      return <EventEntity>[];
    }
    try {
      // List response = await Kinfolk.getListModelRest(
      //     serviceOrEntityName: mobileService(),
      //     methodName: MethodNames.getEventsById + '?id=$pgId',
      //     type: Types.services,
      //     fromMap: (val) => EventEntity.fromMap(val));
      // var list = await HiveService.syncRisksData(
      //     BoxNameStore.getRisks, risksList);
      var response = [
        {
          "_entityName": "krj_EventPojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.EventPojo-483a226a-d188-0eff-513a-cee25fbef0a8 [new]",
          "id": "483a226a-d188-0eff-513a-cee25fbdf448",
          "initDate": "2021-08-27 13:35:00.472",
          "initiator": {
            "_entityName": "krj_PersonPojo",
            "_instanceName": "Жакеев",
            "id": "f63d3e47-caff-8840-cbf7-3fcbb284f66b",
            "lastName": "Нұржан",
            "firstName": "Жакеев",
            "middleName": "Құралбекұлы",
            "nationalIdentifier": "901205300210"
          },
          "eventType": {
            "_entityName": "krj_DicEventTypePojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicEventTypePojo-e7b29a7a-fea3-5c55-7b8b-b29d2b98553c [new]",
            "id": "e7b29a7a-fea3-5c55-7b8b-b29d2b98553c",
            "code": "TICKET_WITHDRAWAL_TW",
            "langValue": "Изъятие талона"
          },
          "regNumber": "TWE-2021-00011",
          "files": [],
          "comment": " мпап",
          "incident": "Incident test",
          "status": {
            "_entityName": "krj_DicMessageStatusPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicMessageStatusPojo-304aca95-ddf3-8f95-9441-87fac553073d [new]",
            "id": "304aca95-ddf3-8f95-9441-87fac553073d",
            "code": "NEW",
            "langValue": "Новый"
          }
        },
      ];
      var getEventById =
          List<EventEntity>.from(response.map((x) => EventEntity.fromMap(x)));
      return getEventById.cast<EventEntity>();
    } catch (e) {
      print(e);
    }
  }

  static Future<List<TicketHistory>> getTicketHistoryByPGId(String pgId) async {
    var conn = await checkConnection();
    if (!conn) {
      return <TicketHistory>[];
    }
    try {
      // List response = await Kinfolk.getListModelRest(
      //     serviceOrEntityName: mobileService(),
      //     methodName: MethodNames.getTicketHistoriesById + '?personId=$pgId',
      //     type: Types.services,
      //     fromMap: (val) => TicketHistory.fromMap(val));
      // var list = await HiveService.syncRisksData(
      //     BoxNameStore.getRisks, risksList);
      var response = [
        {
          "_entityName": "krj_TicketHistoryPojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.TicketHistoryPojo-32ba3bc4-99ef-d10b-7314-a311a836c7b6 [new]",
          "id": "32ba3bc4-99ef-d10b-7314-a311aq4w5s4d",
          "ticketNumber": "WTI-2021-00003",
          "color": "GREEN",
          "historyId": "TI-2021-00000",
          "issuedBy": {
            "_entityName": "krj_PersonPojo",
            "_instanceName": "",
            "id": "f63d3e47-caff-8840-cbf7-3fcbb284f66b",
            "fullName": "Жакеев Н.Қ.",
            "nationalIdentifier": "901205300210"
          },
          "type": "Выдача Талона",
          "actionDate": "2021-08-25 00:00:00.000",
          "incident": "No incident"
        },
        {
          "_entityName": "krj_TicketHistoryPojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.TicketHistoryPojo-e074017f-6288-db49-7c8f-6425a9ff3031 [new]",
          "id": "e074017f-6288-db49-7c8f-425aq4ww578d",
          "ticketNumber": "WTI-2021-00003",
          "color": "GREEN",
          "historyId": "TW-2021-00030",
          "issuedBy": {
            "_entityName": "krj_PersonPojo",
            "_instanceName": "",
            "id": "3fb7c8ff-ba5b-0d8a-754e-db18e02344e5",
            "fullName": "Жакеев Н.Қ.",
            "nationalIdentifier": "901205300210"
          },
          "type": "Изьятие Талона",
          "actionDate": "2021-08-29 00:00:00.000",
          "incident": "No incident"
        },
      ];
      var getTicketHistoryById = List<TicketHistory>.from(
          response.map((x) => TicketHistory.fromMap(x)));
      return getTicketHistoryById.cast<TicketHistory>();
    } catch (e) {
      print(e);
    }
  }

  static Future createEventForTicket(EventEntity entity) async {
    var conn = await checkConnection();
    if (!conn || conn) {
      var box = await HiveService.getBox(BoxNameStore.getMyTicketEvent);
      await box.add(entity);
      return null;
    }

    // oauth2.Client client = await Kinfolk.getClient();
    //
    // var url = Kinfolk.createRestUrl(
    //   mobileService(),
    //   MethodNames.createEvent,
    //   Types.services,
    // );
    //
    // var body = '''{
    //           "eventPojo": ${entity.toJsonCreate()}
    //         }''';
    // var response =
    //     await client.post(url, body: body, headers: Kinfolk.appJsonHeader);
    //
    // if (response.statusCode == 200) {
    //   return true;
    // } else {
    //   return false;
    // }
  }

  static Future getMyEventHistory() async {
    var conn = await checkConnection();
    if (!conn) {
      var list =
      await HiveService.getOfflineListBox(BoxNameStore.getUserMessages);
      return [];
    }
    try {
      // List messageList = await Kinfolk.getListModelRest(
      //     serviceOrEntityName: mobileService(),
      //     methodName: MethodNames.getMyEvents,
      //     type: Types.services,
      //     fromMap: (val) => EventEntity.fromMap(val));
      // var list = await HiveService.syncMessageData(
      //     BoxNameStore.getUserMessages, messageList);
      // return list.cast<Message>();
      var response = [
        {
          "_entityName": "krj_EventPojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.EventPojo-483a226a-d188-0eff-513a-cee25fbef0a8 [new]",
          "id": "483a226a-d188-0eff-513a-cee25fbefs78",
          "initDate": "2021-08-27 13:35:00.472",
          "initiator": {
            "_entityName": "krj_PersonPojo",
            "_instanceName": "Жакеев",
            "id": "f63d3e47-caff-8840-cbf7-3fcbb284f66b",
            "lastName": "Нұржан",
            "firstName": "Жакеев",
            "middleName": "Құралбекұлы",
            "nationalIdentifier": "901205300210"
          },
          "eventType": {
            "_entityName": "krj_DicEventTypePojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicEventTypePojo-e7b29a7a-fea3-5c55-7b8b-b29d2b98553c [new]",
            "id": "e7b29a7a-fea3-5c55-7b8b-b29d2b98553c",
            "code": "TICKET_WITHDRAWAL_TW",
            "langValue": "Изъятие талона"
          },
          "regNumber": "TWE-2021-00011",
          "files": [],
          "comment": " мпап",
          "incident": "Incident test",
          "status": {
            "_entityName": "krj_DicMessageStatusPojo",
            "_instanceName":
                "kz.uco.krj.hse.restpojo.DicMessageStatusPojo-304aca95-ddf3-8f95-9441-87fac553073d [new]",
            "id": "304aca95-ddf3-8f95-9441-87fac553073d",
            "code": "NEW",
            "langValue": "Новый"
          }
        },
      ];
      var getMyEventHistory =
          List<EventEntity>.from(response.map((x) => EventEntity.fromMap(x)));
      return getMyEventHistory.cast<EventEntity>();
    } catch (e) {
      print(e);
    }
  }

  static Future getMyTicketHistory() async {
    var conn = await checkConnection();
    if (!conn) {
      var list = await HiveService.getOfflineListBox(
          BoxNameStore.getMyTicketHistories);
      return list.cast<TicketHistory>();
    }
    try {
      // List list = await Kinfolk.getListModelRest(
      //     serviceOrEntityName: mobileService(),
      //     methodName: MethodNames.getMyTicketHistories,
      //     type: Types.services,
      //     fromMap: (val) => TicketHistory.fromMap(val));
      var response = [
        {
          "_entityName": "krj_TicketHistoryPojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.TicketHistoryPojo-32ba3bc4-99ef-d10b-7314-a311a836c7b6 [new]",
          "id": "32ba3bc4-99ef-d10b-7314-a311a836a4sf",
          "ticketNumber": "WTI-2021-00003",
          "color": "GREEN",
          "historyId": "TI-2021-00000",
          "issuedBy": {
            "_entityName": "krj_PersonPojo",
            "_instanceName": "",
            "id": "f63d3e47-caff-8840-cbf7-3fcbb284f66b",
            "fullName": "Жакеев Н.Қ.",
            "nationalIdentifier": "901205300210"
          },
          "type": "Выдача Талона",
          "actionDate": "2021-08-25 00:00:00.000",
          "incident": "No incident"
        },
        {
          "_entityName": "krj_TicketHistoryPojo",
          "_instanceName":
              "kz.uco.krj.hse.restpojo.TicketHistoryPojo-e074017f-6288-db49-7c8f-6425a9ff3031 [new]",
          "id": "e074017f-6288-db49-7c8f-6425a9ff4857",
          "ticketNumber": "WTI-2021-00003",
          "color": "GREEN",
          "historyId": "TW-2021-00030",
          "issuedBy": {
            "_entityName": "krj_PersonPojo",
            "_instanceName": "",
            "id": "3fb7c8ff-ba5b-0d8a-754e-db18e02344e5",
            "fullName": "Жакеев Н.Қ.",
            "nationalIdentifier": "901205300210"
          },
          "type": "Изьятие Талона",
          "actionDate": "2021-08-29 00:00:00.000",
          "incident": "No incident"
        },
      ];
      var getMyTicketHistory = List<TicketHistory>.from(
          response.map((x) => TicketHistory.fromMap(x)));
      Box box =
          await HiveService.getClearBox(BoxNameStore.getMyTicketHistories);
      getMyTicketHistory.forEach((e) {
        box.add(e);
      });
      return getMyTicketHistory.cast<TicketHistory>();
    } catch (e) {
      print(e);
    }
  }

  static Future synchronizeTicketEvents() async {
    var conn = await checkConnection();
    print('conn: $conn');
    if (!conn) {
      return null;
    }

    var box = await HiveService.getBox(BoxNameStore.getMyTicketEvent);
    var list = box.values.toList();
    if (box.values.toList().isNotEmpty) {
      for (EventEntity e in list) {
        if (e.id == null) {
          await createEventForTicket(e).then((value) async {
            print('deleted: $value');
            if (value != null && value) {
              await e.delete();
            }
          });
        }
      }
    }
    return true;
  }

  ////Events
  static Future getEventList() async {
    var conn = await checkConnection();
    var list =
    await HiveService.getOfflineListBox(BoxNameStore.getMyEvents);
    if (!conn) {
      return list.cast<EventManagement>();
    }
    else if(list.isNotEmpty){
      return list.cast<EventManagement>();
    }
    try {
      //   List risksList = await Kinfolk.getListModelRest(
      //       serviceOrEntityName: mobileService(),
      //       methodName: MethodNames.getMyEvent,
      //       type: Types.services,
      //       fromMap: (val) => EventManagement.fromMap(val));
      var response = [
        {
          "_entityName": "krj_EventPojo",
          "_instanceName": "kz.uco.krj.hse.restpojo.EventPojo-5529e0fa-f4af-fbd3-13b2-686b78a439bc [new]",
          "id": "5529e0fa-f4af-fbd3-13b2-b78a439bc",
          "planDateTo": "2021-09-05 00:00:00.000",
          "initDate": "2021-09-01 10:21:55.722",
          "initiator": {
            "_entityName": "krj_PersonPojo",
            "_instanceName": "Нурлан",
            "id": "a5c41c34-e636-791d-56c4-be2cadc4c299",
            "lastName": "Абеуов",
            "firstName": "Нурлан",
            "middleName": "Серикович",
            "nationalIdentifier": "861216301152"
          },
          "eventType": {
            "_entityName": "krj_DicEventTypePojo",
            "_instanceName": "kz.uco.krj.hse.restpojo.DicEventTypePojo-ab4635b7-d446-26e4-a70d-b8ec2b9fe672 [new]",
            "id": "ab4635b7-d446-26e4-a70d-b8ec2b9fe672",
            "code": "DEFAULT",
            "langValue": "По Умолчанию"
          },
          "actualDateTo": "2021-09-03 00:00:00.000",
          "observer": {
            "_entityName": "krj_PersonPojo",
            "_instanceName": "Мурат",
            "id": "172afae4-2718-19ae-7ea7-c165316a7508",
            "lastName": "Мусатаев",
            "firstName": "Мурат",
            "middleName": "Какманович",
            "nationalIdentifier": "600112300817"
          },
          "regNumber": "LT-2021-00001",
          "sevirity": {
            "_entityName": "krj_DicSevirityPojo",
            "_instanceName": "kz.uco.krj.hse.restpojo.DicSevirityPojo-f0122632-69ec-6b28-7a1a-d5eda4deb253 [new]",
            "id": "f0122632-69ec-6b28-7a1a-d5eda4deb253",
            "code": "MIDDLE",
            "langValue": "Средний"
          },
          "eventDescription": "Event s",
          "files": [],
          "comment": "Comment Beka",
          "finishPercent": 23,
          "actualDateFrom": "2021-09-02 00:00:00.000",
          "incident": "Incident test",
          "supervisor": {
            "_entityName": "krj_PersonPojo",
            "_instanceName": "Болат",
            "id": "d4a5f0e0-459c-77d1-6fc7-1b761d9491c4",
            "lastName": "Кушеев",
            "firstName": "Болат",
            "middleName": "Бопетаевич",
            "nationalIdentifier": "640112300180"
          },
          "planDateFrom": "2021-09-01 00:00:00.000",
          "status": {
            "_entityName": "krj_DicMessageStatusPojo",
            "_instanceName": "kz.uco.krj.hse.restpojo.DicMessageStatusPojo-10218553-fa51-bc9d-f274-d89a1447a1c5 [new]",
            "id": "10218553-fa51-bc9d-f274-d89a1447a1c5",
            "code": "DISTRIBUTED",
            "langValue": "Распределен"
          }
        },
        {
          "_entityName": "krj_EventPojo",
          "_instanceName": "kz.uco.krj.hse.restpojo.EventPojo-c17eb702-416c-9cb4-a436-d5004094bc50 [new]",
          "id": "c17eb702-416c-9cb4-a436-d5004094",
          "issuedTo": {
            "_entityName": "krj_PersonPojo",
            "_instanceName": "Жакеев",
            "id": "f63d3e47-caff-8840-cbf7-3fcbb284f66b",
            "lastName": "Нұржан",
            "firstName": "Жакеев",
            "middleName": "Құралбекұлы",
            "nationalIdentifier": "731205301890"
          },
          "planDateTo": "2021-09-05 00:00:00.000",
          "initDate": "2021-09-01 10:21:55.722",
          "initiator": {
            "_entityName": "krj_PersonPojo",
            "_instanceName": "Нурлан",
            "id": "a5c41c34-e636-791d-56c4-be2cadc4c299",
            "lastName": "Абеуов",
            "firstName": "Нурлан",
            "middleName": "Серикович",
            "nationalIdentifier": "861216301152"
          },
          "eventType": {
            "_entityName": "krj_DicEventTypePojo",
            "_instanceName": "kz.uco.krj.hse.restpojo.DicEventTypePojo-ab4635b7-d446-26e4-a70d-b8ec2b9fe672 [new]",
            "id": "ab4635b7-d446-26e4-a70d-b8ec2b9fe672",
            "code": "DEFAULT",
            "langValue": "По Умолчанию"
          },
          "actualDateTo": "2021-09-03 00:00:00.000",
          "observer": {
            "_entityName": "krj_PersonPojo",
            "_instanceName": "Мурат",
            "id": "172afae4-2718-19ae-7ea7-c165316a7508",
            "lastName": "Мусатаев",
            "firstName": "Мурат",
            "middleName": "Какманович",
            "nationalIdentifier": "600112300817"
          },
          "regNumber": "EV-2021-00007",
          "sevirity": {
            "_entityName": "krj_DicSevirityPojo",
            "_instanceName": "kz.uco.krj.hse.restpojo.DicSevirityPojo-f0122632-69ec-6b28-7a1a-d5eda4deb253 [new]",
            "id": "f0122632-69ec-6b28-7a1a-d5eda4deb253",
            "code": "MIDDLE",
            "langValue": "Средний"
          },
          "eventDescription": "Event s",
          "files": [],
          "comment": "Withdrawal",
          "supportDocument": {
            "_entityName": "krj_SupportDocumentPojo",
            "_instanceName": "kz.uco.krj.hse.restpojo.SupportDocumentPojo-df1ebe10-b782-ce5e-9433-db3943ad1d07 [new]",
            "id": "df1ebe10-b782-ce5e-9433-db3943ad1d07",
            "supportDocNumber": "TC-2021-000000"
          },
          "finishPercent": 23,
          "actualDateFrom": "2021-09-02 00:00:00.000",
          "incident": "Incident test",
          "supervisor": {
            "_entityName": "krj_PersonPojo",
            "_instanceName": "Болат",
            "id": "d4a5f0e0-459c-77d1-6fc7-1b761d9491c4",
            "lastName": "Кушеев",
            "firstName": "Болат",
            "middleName": "Бопетаевич",
            "nationalIdentifier": "640112300180"
          },
          "planDateFrom": "2021-09-01 00:00:00.000",
          "status": {
            "_entityName": "krj_DicMessageStatusPojo",
            "_instanceName":
            "kz.uco.krj.hse.restpojo.DicMessageStatusPojo-a565104e-fb4c-4338-92a4-a66c097569d1 [new]",
            "id": "a565104e-fb4c-4338-92a4-a66c097569d1",
            "code": "CLOSED",
            "langValue": "Закрыт"
          }
        },
      ];
      var risksList = List<EventManagement>.from(
          response.map((x) => EventManagement.fromMap(x)));
      var list =
      await HiveService.syncEventData(BoxNameStore.getMyEvents, risksList);
      return list.cast<EventManagement>();
    } catch (e) {
      print(e);
    }
  }

  static Future createEvent(EventManagement entity, bool isUpdated) async {
    var conn = await checkConnection();
    var uuid = Uuid();
    var v1 = uuid.v1();
    if (!conn) {
      if (isUpdated) {
        await entity.save();
      } else {
        var box = await HiveService.getBox(BoxNameStore.getMyEvents);
        await box.add(entity);
      }
      return null;
    } else {
      entity.id = v1;
      print(entity.id);
      if (isUpdated) {
        await entity.save();
      } else {
        var box = await HiveService.getBox(BoxNameStore.getMyEvents);
        await box.add(entity);
      }
      return true;
    }
    // var conn = await checkConnection();
    // if (!conn) {
    //   if (isUpdated) {
    //     await entity.save();
    //   } else {
    //     var box = await HiveService.getBox(BoxNameStore.getMyEvents);
    //     await box.add(entity);
    //   }
    //   return null;
    // }
    // oauth2.Client client = await Kinfolk.getClient();
    // var url = Kinfolk.createRestUrl(
    //   mobileService(),
    //   MethodNames.createEvent,
    //   Types.services,
    // );
    // var body = '''{
    //           "eventPojo": ${entity.toJsonCreate()}
    //         }''';
    // print(body);
    // var response =
    // await client.post(url, body: body, headers: Kinfolk.appJsonHeader);
    // print(response.body);
    // if (response.statusCode == 200) {
    //   if (isUpdated) {
    //     await entity.delete();
    //   }
    //   return true;
    // } else {
    //   return false;
    // }
  }

  static Future getSevirity(bool withLocal) async {
    var conn = await checkConnection();
    if (!conn) {
      var list = await HiveService.getOfflineListBox(
          BoxNameStore.getDicSevirities);
      return list.cast<AbstractDictionary>();
    }

    if (withLocal) {
      var list = await HiveService.getOfflineListBox(
          BoxNameStore.getDicSevirities);
      if (list.isNotEmpty) {
        return list.cast<AbstractDictionary>();
      }
    }
    try{
      var response = [
        {
          "_entityName": "krj_DicSevirityPojo",
          "_instanceName": "kz.uco.krj.hse.restpojo.DicSevirityPojo-7c72fa2e-956f-efc3-831a-ad6b35723642 [new]",
          "id": "7c72fa2e-956f-efc3-831a-ad6b357232",
          "code": "HIGH",
          "langValue": "Высокий"
        },
        {
          "_entityName": "krj_DicSevirityPojo",
          "_instanceName": "kz.uco.krj.hse.restpojo.DicSevirityPojo-a62561cf-dba0-a8c2-998f-e78a3a2282ff [new]",
          "id": "a62561cf-dba0-a8c2-998f-e78a3282ff",
          "code": "LOW",
          "langValue": "Низкий"
        },
        {
          "_entityName": "krj_DicSevirityPojo",
          "_instanceName": "kz.uco.krj.hse.restpojo.DicSevirityPojo-f0122632-69ec-6b28-7a1a-d5eda4deb253 [new]",
          "id": "f0122632-69ec-6b28-7a1a-d5eddeb253",
          "code": "MIDDLE",
          "langValue": "Средний"
        }
      ];
      var getSevirity = List<AbstractDictionary>.from(
          response.map((x) => AbstractDictionary.fromMap(x)));
      Box box =
      await HiveService.getClearBox(BoxNameStore.getDicSevirities);
      getSevirity.forEach((e) {
        box.add(e);
      });
      return getSevirity.cast<AbstractDictionary>();
    } catch (e) {
      print(e);
    }
    }

    // try {
    //   List response = await Kinfolk.getListModelRest(
    //       serviceOrEntityName: mobileService(),
    //       methodName: MethodNames.getDicSevirities,
    //       type: Types.services,
    //       fromMap: (val) => AbstractDictionary.fromMap(val));
    //   Box box =
    //   await HiveService.getClearBox(BoxNameStore.getDicSevirities);
    //   response.forEach((e) {
    //     box.add(e);
    //   });
    //   return response.cast<AbstractDictionary>();
    // } catch (e) {
    //   print(e);
    // }

  static Future getSupportDoc(bool withLocal) async {
    var conn = await checkConnection();
    if (!conn) {
      var list = await HiveService.getOfflineListBox(
          BoxNameStore.getAllSupportDocuments);
      return list.cast<SupportDoc>();
    }

    if (withLocal) {
      var list = await HiveService.getOfflineListBox(
          BoxNameStore.getAllSupportDocuments);
      if (list.isNotEmpty) {
        return list.cast<SupportDoc>();
      }
    }
    try {
      var response = [
        {
          "_entityName": "krj_SupportDocumentPojo",
          "_instanceName": "kz.uco.krj.hse.restpojo.SupportDocumentPojo-59ddbb7f-b5b0-4335-9adf-c27a1129d290 [new]",
          "id": "59ddbb7f-b5b0-4335-9af-c27129d290",
          "documentDate": "2021-09-06 00:00:00.000",
          "supportDocNumber": "TC-2021-000000"
        },
        {
          "_entityName": "krj_SupportDocumentPojo",
          "_instanceName": "kz.uco.krj.hse.restpojo.SupportDocumentPojo-ef4b9dd3-7f1d-de2a-20ab-dce9ea240222 [new]",
          "id": "ef4b9dd3-7f1d-de2a-20ab-dce240222",
          "documentDate": "2021-09-08 00:00:00.000",
          "supportDocNumber": "LS-2021-00000001"
        },
        {
          "_entityName": "krj_SupportDocumentPojo",
          "_instanceName": "kz.uco.krj.hse.restpojo.SupportDocumentPojo-6485cb58-bbc0-b35f-726c-63827d753299 [new]",
          "id": "6485cb58-bbc0-b35f-726c-637d753299",
          "documentDate": "2021-09-11 00:00:00.000",
          "supportDocNumber": "TC-2021-000001"
        }
      ];
      var getSupportDoc = List<SupportDoc>.from(
          response.map((x) => SupportDoc.fromMap(x)));
      Box box =
      await HiveService.getClearBox(BoxNameStore.getAllSupportDocuments);
      getSupportDoc.forEach((e) {
        box.add(e);
      });
      return getSupportDoc.cast<SupportDoc>();
    } catch (e) {
      print(e);
    }
    // try {
    //   List response = await Kinfolk.getListModelRest(
    //       serviceOrEntityName: mobileService(),
    //       methodName: MethodNames.getAllSupportDocuments,
    //       type: Types.services,
    //       fromMap: (val) => SupportDoc.fromMap(val));
    //   Box box =
    //   await HiveService.getClearBox(BoxNameStore.getAllSupportDocuments);
    //   response.forEach((e) {
    //     box.add(e);
    //   });
    //   return response.cast<SupportDoc>();
    // } catch (e) {
    //   print(e);
    // }
  }

  static Future synchronizeEvent() async {
    var conn = await checkConnection();
    var result = true;
    print('conn: $conn');
    if (!conn) {
      return null;
    }

    var box = await HiveService.getBox(BoxNameStore.getMyEvents);
    var list = box.values.toList();
    for (EventManagement e in list) {
      if (e.id == null) {
        // for (var i = 0; i < e.files.length; i++) {
        //   if (e.files[i].id == null) {
        //     if (e.files[i].localPath == null || e.files[i].localPath.isEmpty) {
        //       return 'Не правильно фото № ${e.files.indexOf(e.files[i]) + 1}, '
        //           'в сообщение ${dateFormatFullToNumeric(e.initDateTime)}';
        //     } else {
        //       var savedImage = await saveFile(
        //           file: File(e.files[i].localPath), toServer: true);
        //       savedImage.localPath = e.files[i].localPath;
        //       savedImage.fileName = e.files[i].fileName;
        //       e.files[i] = savedImage;
        //       await e.save();
        //     }
        //   }
        // }
        await createEvent(e, true).then((value) async {
          if (value != null && value) {
            // await e.delete();
          } else {
            // continue;
            result = false;
          }
        });
      }
    }
    return result;
  }
}