import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hse/core/model/event/events.dart';
import 'package:hse/core/model/risks/risks.dart';
import 'package:hse/core/model/ticket/ticket.dart';
import 'package:hse/core/model/ticket/ticket_history.dart';
import 'package:hse/core/model/event/event.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hse/core/model/anthropometry/Anthropometry.dart';
import 'package:hse/core/model/appeals/appeals.dart';
import 'package:hse/core/model/assignment/Assignment.dart';
import 'package:hse/core/model/assignment/Department.dart';
import 'package:hse/core/model/assignment/FoodLimits.dart';
import 'package:hse/core/model/assignment/Job.dart';
import 'package:hse/core/model/assignment/Organization.dart';
import 'package:hse/core/model/assignment/Person.dart';
import 'package:hse/core/model/assignment/Rating.dart';
import 'package:hse/core/model/assignment/rating_new.dart';
import 'package:hse/core/model/bsa/bsa.dart';
import 'package:hse/core/model/bsa/observation.dart';
import 'package:hse/core/model/calendarevents/CalendarEvents.dart';
import 'package:hse/core/model/calendarevents/Event.dart';
import 'package:hse/core/model/car_order/CarAddress.dart';
import 'package:hse/core/model/car_order/CarOrder.dart';
import 'package:hse/core/model/car_order/CarOrderGroupped.dart';
import 'package:hse/core/model/car_order/Driver.dart';
import 'package:hse/core/model/car_order/Order.dart';
import 'package:hse/core/model/car_order/Vehicle.dart';
import 'package:hse/core/model/check_points/CheckPoint.dart';
import 'package:hse/core/model/config/config.dart';
import 'package:hse/core/model/config/file.dart';
import 'package:hse/core/model/course_eating/CourseEatingHistory.dart';
import 'package:hse/core/model/course_eating/Dish.dart';
import 'package:hse/core/model/eating_menu/Complex.dart';
import 'package:hse/core/model/eating_menu/EatingMenus.dart';
import 'package:hse/core/model/eating_menu/Mealtime.dart';
import 'package:hse/core/model/eating_menu/Menu.dart';
import 'package:hse/core/model/eating_menu/Product.dart';
import 'package:hse/core/model/employee_indicators/EmployeeIndicatorsValue.dart';
import 'package:hse/core/model/employee_indicators/Indicator.dart';
import 'package:hse/core/model/employee_indicators/IndicatorValueList.dart';
import 'package:hse/core/model/employee_indicators/IndicatorValueOnDateList.dart';
import 'package:hse/core/model/employee_indicators/IndicatorValueOndateListShift.dart';
import 'package:hse/core/model/employee_indicators/Uom.dart';
import 'package:hse/core/model/file_descriptor.dart';
import 'package:hse/core/model/graphics/OverCategoryGraphic.dart';
import 'package:hse/core/model/graphics/RightAnswersGraphic.dart';
import 'package:hse/core/model/graphics/SubmittedGraphic.dart';
import 'package:hse/core/model/graphics/TestingGraphic.dart';
import 'package:hse/core/model/group_access/GroupAccess.dart';
import 'package:hse/core/model/history_eating_order/HistoryEatingOrder.dart';
import 'package:hse/core/model/material_obligations/Item.dart';
import 'package:hse/core/model/material_obligations/MaterialObligations.dart';
import 'package:hse/core/model/medicine/MedicineAndSafetyPojo.dart';
import 'package:hse/core/model/message/condition_category.dart';
import 'package:hse/core/model/message/message.dart';
import 'package:hse/core/model/message/message_dictionary.dart';
import 'package:hse/core/model/message/object_name.dart';
import 'package:hse/core/model/news/News.dart';
import 'package:hse/core/model/notification/Notification.dart';
import 'package:hse/core/model/notification/Person.dart' as nt;
import 'package:hse/core/model/place/Place.dart';
import 'package:hse/core/model/placement/Placement.dart';
import 'package:hse/core/model/ppe/PersonalProtectionEquipment.dart';
import 'package:hse/core/model/ppe/Ppe.dart';
import 'package:hse/core/model/sheet/SettlenetSheet.dart';
import 'package:hse/core/model/test/Answer.dart';
import 'package:hse/core/model/test/AnswerOption.dart';
import 'package:hse/core/model/test/Question.dart';
import 'package:hse/core/model/test/Test.dart';
import 'package:hse/core/model/work_orders/AllOrderPojo.dart';
import 'package:hse/core/model/work_orders/Defect.dart';
import 'package:hse/core/model/work_orders/ListOfEquipmentUsed.dart';
import 'package:hse/core/model/work_orders/Material.dart';
import 'package:hse/core/model/work_orders/Person.dart' as wp;
import 'package:hse/core/model/work_orders/RepairOrderPojo.dart';
import 'package:hse/core/model/work_orders/RepairOrderPojoLaborSpending.dart';
import 'package:hse/core/model/work_orders/RepairOrderPojoWork.dart';
import 'package:hse/core/model/work_orders/Transport.dart';
import 'package:hse/core/model/work_orders/TransportOrderPojo.dart';
import 'package:hse/core/model/work_orders/TransportOrderPojoWork.dart';
import 'package:hse/core/model/work_orders/WorkLaborSpending.dart';
import 'package:hse/core/model/work_orders/WorkOrderPojo.dart';
import 'package:hse/core/model/work_orders/WorkOrderPojoLaborSpending.dart';
import 'package:hse/core/model/work_orders/WorkOrderShift.dart';
import 'package:hse/core/model/work_orders/WorkOrderShiftWork.dart';
import 'package:hse/core/service/rest_services.dart';

class HiveService {
  static Future<Box<dynamic>> getBox(String name) async {
    Box box;
    if (!Hive.isBoxOpen(name)) {
      box = await Hive.openBox(name);
    } else {
      box = Hive.box(name);
    }
    return box;
  }

  //Получение список по имени Box
  static Future<List> getOfflineListBox(String name) async {
    var box = await getBox(name);
    var list = box.values.toList();
    return list;
  }

  //Очистка Box по имени
  static getClearBox(String name) async {
    var box = await getBox(name);
    await box.clear().catchError((val) => print(val));
    return box;
  }

  //Синхронизация Msg и сохранение файлы на локально, и его путь
  static Future syncMessageData(String name, List list) async {
    print('start sync');
    var size = 1;
    var box = await getBox(name);
    for (Message remoteMsg in list) {
      var localNotExist = false;
      // var check = true;
      for (var localMsg in box.values.toList().cast<Message>()) {
        var deletedMsgInRemote = false;
        if (localMsg.id != null) {
          //если в сервере удалено но с id-щником локально осталься,
          // тогда удаляю и сделаю deletedMsgInRemote = true;
          var existingItem = list.firstWhere(
              (element) => localMsg.id == element.id,
              orElse: () => null);
          if (existingItem == null) {
            deletedMsgInRemote = true;
            print('deleted Msg in remote ${localMsg.requestNumber}');
            await localMsg.delete();
          }
        }
        if (!localNotExist && !deletedMsgInRemote) {
          if (localMsg.id != null && remoteMsg.id == localMsg.id) {
            //setStatus;
            localMsg.status = remoteMsg.status;
            localMsg.requestNumber = remoteMsg.requestNumber;
            localMsg.regDateTime = remoteMsg.regDateTime;
            localNotExist = true;
            // check = false;
            print('oldMessage: $size');
            size++;
            //Если есть файлы, проверю этот Msg локально, есть ли у него file
            if (localMsg.files != null && localMsg.files.isNotEmpty) {
              //проверка каждый file и его путь, что в path реально существують ли нет
              for (var fileIndex = 0;
                  fileIndex < localMsg.files.length;
                  fileIndex++) {
                //если в file path нет тогда по ID скачиваеть и сохранить
                if (localMsg.files[fileIndex].localPath == null) {
                  // localMsg.files[fileIndex] =
                  //     await RestServices.saveImageToStorage(
                  //         localMsg.files[fileIndex]);
                  print('old: ${localMsg.files[fileIndex].localPath}');
                } else {
                  //если в file path есть, тогда проверка path,
                  // что по имя файла реально существують
                  //если path есть но  файла не существують тогда занова скачиваю

                  // var appDocDir = await getApplicationDocumentsDirectory();
                  // var dir = appDocDir.path;
                  // var filePath = '$dir/${localMsg.files[fileIndex].fileName}';
                  // var fileExist = await File(filePath).exists();
                  // if (!fileExist) {
                  //   print('fileNotExist path: $filePath');
                  //   localMsg.files[fileIndex] =
                  //   await RestServices.saveImageToStorage(
                  //       localMsg.files[fileIndex]);
                  // }

                  // print('fileNotExist path: $filePath');
                  // localMsg.files[fileIndex] =
                  // await RestServices.saveImageToStorage(
                  //     localMsg.files[fileIndex]);
                }
              }
            }
            await localMsg.save();
          }
        }
      }
      //Если его есть id, и она локально не сохранено, тогда синхроницазия Msg c файлом
      //и говорю что это Msg сохранено локально (localNotExist = false;)
      if (!localNotExist && remoteMsg.id != null) {
        if (remoteMsg.files != null) {
          for (var fileIndex = 0;
              fileIndex < remoteMsg.files.length;
              fileIndex++) {
            print(
                'new message ${remoteMsg.requestNumber}, fileIndex $fileIndex');
            // remoteMsg.files[fileIndex] = await RestServices.saveImageToStorage(
            //     remoteMsg.files[fileIndex]);
            print('new : ${remoteMsg.files[fileIndex].localPath}');
          }
        }
        await box.add(remoteMsg);
        localNotExist = false;
      }
    }
    print('success sync');
    return box.values.toList();
  }

  static Future syncBehaviorAuditData(String name, List list) async {
    print('start sync');
    var size = 1;
    var box = await getBox(name);
    for (BehaviorAudit remoteBsa in list) {
      var localNotExist = false;
      // var check = true;
      for (var localBsa in box.values.toList().cast<BehaviorAudit>()) {
        var deletedBsaInRemote = false;
        if (localBsa.id != null) {
          //если в сервере удалено но с id-щником локально осталься,
          // тогда удаляю и сделаю deletedMsgInRemote = true;
          var existingItem = list.firstWhere(
                  (element) => localBsa.id == element.id,
              orElse: () => null);
          if (existingItem == null) {
            deletedBsaInRemote = true;
            print('deleted Bsa in remote ${localBsa.regNumber}');
            await localBsa.delete();
          }
        }
        if (!localNotExist && !deletedBsaInRemote) {
          if (localBsa.id != null && remoteBsa.id == localBsa.id) {
            //setStatus;
            if(localBsa.isDone) {
              localBsa.status = remoteBsa.status;
              localBsa.regNumber = remoteBsa.regNumber;
              localBsa.isDone = remoteBsa.isDone;
              localBsa.filled = remoteBsa.filled;
              localBsa.regDateTime = remoteBsa.regDateTime;
              await localBsa.save();
            }
            // localBsa = remoteBsa;
            localNotExist = true;
            // check = false;
            print('oldBsa: $size');
            size++;
            //Если есть файлы, проверю этот Msg локально, есть ли у него file
            if (localBsa.files != null && localBsa.files.isNotEmpty) {
              //проверка каждый file и его путь, что в path реально существують ли нет
              // for (var fileIndex = 0;
              // fileIndex < localBsa.files.length;
              // fileIndex++) {
              //   //если в file path нет тогда по ID скачиваеть и сохранить
              //   if (localBsa.files[fileIndex].localPath == null) {
              //     // localBsa.files[fileIndex] =
              //     // await RestServices.saveImageToStorage(
              //     //     localBsa.files[fileIndex]);
              //     print('old: ${localBsa.files[fileIndex].localPath}');
              //   } else {
              //     //если в file path есть, тогда проверка path,
              //     // что по имя файла реально существують
              //     //если path есть но  файла не существують тогда занова скачиваю
              //     var appDocDir = await getApplicationDocumentsDirectory();
              //     var dir = appDocDir.path;
              //     var filePath = '$dir/${localBsa.files[fileIndex].fileName}';
              //     var fileExist = await File(filePath).exists();
              //     if (!fileExist) {
              //       print('fileNotExist path: $filePath');
              //       localBsa.files[fileIndex] =
              //       await RestServices.saveImageToStorage(
              //           localBsa.files[fileIndex]);
              //     }
              //   }
              // }
            }
          }
        }
      }
      //Если его есть id, и она локально не сохранено, тогда синхроницазия Msg c файлом
      //и говорю что это Msg сохранено локально (localNotExist = false;)
      if (!localNotExist && remoteBsa.id != null) {
        if (remoteBsa.files != null) {
          // for (var fileIndex = 0;
          // fileIndex < remoteBsa.files.length;
          // fileIndex++) {
          //   print(
          //       'new bsa ${remoteBsa.regNumber}, fileIndex $fileIndex');
          //   remoteBsa.files[fileIndex] = await RestServices.saveImageToStorage(
          //       remoteBsa.files[fileIndex]);
          //   print('new : ${remoteBsa.files[fileIndex].localPath}');
          // }
        }
        await box.add(remoteBsa);
        localNotExist = false;
      }
    }
    print('success sync');
    return box.values.toList();
  }

  //Синхронизация Msg и сохранение файлы на локально, и его путь
  static Future syncRisksData(String name, List list) async {
    print('start sync');
    var size = 1;
    var box = await getBox(name);
    for (RisksManagement remoteRisks in list) {
      var localNotExist = false;
      // var check = true;
      for (var localRisks in box.values.toList().cast<RisksManagement>()) {
        var deletedRiskInRemote = false;
        if (localRisks.id != null) {
          //если в сервере удалено но с id-щником локально осталься,
          // тогда удаляю и сделаю deletedMsgInRemote = true;
          var existingItem = list.firstWhere(
                  (element) => localRisks.id == element.id,
              orElse: () => null);
          if (existingItem == null) {
            deletedRiskInRemote = true;
            print('deleted Msg in remote ${localRisks.regNumber}');
            await localRisks.delete();
          }
        }
        if (!localNotExist && !deletedRiskInRemote) {
          if (localRisks.id != null && remoteRisks.id == localRisks.id) {
            //setStatus;
            localRisks.status = remoteRisks.status;
            localRisks.regNumber = remoteRisks.regNumber;
            localRisks.regDate = remoteRisks.regDate;
            localNotExist = true;
            // check = false;
            print('oldMessage: $size');
            size++;
            //Если есть файлы, проверю этот Msg локально, есть ли у него file
            if (localRisks.files != null && localRisks.files.isNotEmpty) {
              //проверка каждый file и его путь, что в path реально существують ли нет
              for (var fileIndex = 0;
              fileIndex < localRisks.files.length;
              fileIndex++) {
                // //если в file path нет тогда по ID скачиваеть и сохранить
                // if (localRisks.files[fileIndex].localPath == null) {
                //   // localRisks.files[fileIndex] =
                //   // await RestServices.saveImageToStorage(
                //   //     localRisks.files[fileIndex]);
                //   // print('old: ${localRisks.files[fileIndex].localPath}');
                // } else {
                //   //если в file path есть, тогда проверка path,
                //   // что по имя файла реально существують
                //   //если path есть но  файла не существують тогда занова скачиваю
                //
                //   // var appDocDir = await getApplicationDocumentsDirectory();
                //   // var dir = appDocDir.path;
                //   // var filePath = '$dir/${localMsg.files[fileIndex].fileName}';
                //   // var fileExist = await File(filePath).exists();
                //   // if (!fileExist) {
                //   //   print('fileNotExist path: $filePath');
                //   //   localMsg.files[fileIndex] =
                //   //   await RestServices.saveImageToStorage(
                //   //       localMsg.files[fileIndex]);
                //   // }
                //
                //   // print('fileNotExist path: $filePath');
                //   localRisks.files[fileIndex] =
                //   await RestServices.saveImageToStorage(
                //       localRisks.files[fileIndex]);
                // }
              }
            }
            await localRisks.save();
          }
        }
      }
      //Если его есть id, и она локально не сохранено, тогда синхроницазия Msg c файлом
      //и говорю что это Msg сохранено локально (localNotExist = false;)
      if (!localNotExist && remoteRisks.id != null) {
        if (remoteRisks.files != null) {
          // for (var fileIndex = 0;
          // fileIndex < remoteRisks.files.length;
          // fileIndex++) {
          //   print(
          //       'new message ${remoteRisks.regNumber}, fileIndex $fileIndex');
          //   remoteRisks.files[fileIndex] = await RestServices.saveImageToStorage(
          //       remoteRisks.files[fileIndex]);
          //   print('new : ${remoteRisks.files[fileIndex].localPath}');
          // }
        }
        await box.add(remoteRisks);
        localNotExist = false;
      }
    }
    print('success sync');
    return box.values.toList();
  }

  //Синхронизация Msg и сохранение файлы на локально, и его путь
  static Future syncEventData(String name, List list) async {
    print('start sync');
    var size = 1;
    var box = await getBox(name);
    for (EventManagement remoteEvent in list) {
      var localNotExist = false;
      // var check = true;
      for (var localEvent in box.values.toList().cast<EventManagement>()) {
        var deletedEventInRemote = false;
        if (localEvent.id != null) {
          //если в сервере удалено но с id-щником локально осталься,
          // тогда удаляю и сделаю deletedMsgInRemote = true;
          var existingItem = list.firstWhere(
                  (element) => localEvent.id == element.id,
              orElse: () => null);
          if (existingItem == null) {
            deletedEventInRemote = true;
            print('deleted Msg in remote ${localEvent.regNumber}');
            await localEvent.delete();
          }
        }
        if (!localNotExist && !deletedEventInRemote) {
          if (localEvent.id != null && remoteEvent.id == localEvent.id) {
            //setStatus;
            localEvent.status = remoteEvent.status;
            localEvent.regNumber = remoteEvent.regNumber;
            localNotExist = true;
            // check = false;
            print('oldMessage: $size');
            size++;
            //Если есть файлы, проверю этот Msg локально, есть ли у него file
            if (localEvent.files != null && localEvent.files.isNotEmpty) {
              //проверка каждый file и его путь, что в path реально существують ли нет
              for (var fileIndex = 0;
              fileIndex < localEvent.files.length;
              fileIndex++) {
                //если в file path нет тогда по ID скачиваеть и сохранить
                if (localEvent.files[fileIndex].localPath == null) {
                  localEvent.files[fileIndex] =
                  await RestServices.saveImageToStorage(
                      localEvent.files[fileIndex]);
                  print('old: ${localEvent.files[fileIndex].localPath}');
                } else {
                  localEvent.files[fileIndex] =
                  await RestServices.saveImageToStorage(
                      localEvent.files[fileIndex]);
                }
              }
            }
            await localEvent.save();
          }
        }
      }
      //Если его есть id, и она локально не сохранено, тогда синхроницазия Msg c файлом
      //и говорю что это Msg сохранено локально (localNotExist = false;)
      if (!localNotExist && remoteEvent.id != null) {
        if (remoteEvent.files != null) {
          for (var fileIndex = 0;
          fileIndex < remoteEvent.files.length;
          fileIndex++) {
            print(
                'new message ${remoteEvent.regNumber}, fileIndex $fileIndex');
            remoteEvent.files[fileIndex] = await RestServices.saveImageToStorage(
                remoteEvent.files[fileIndex]);
            print('new : ${remoteEvent.files[fileIndex].localPath}');
          }
        }
        await box.add(remoteEvent);
        localNotExist = false;
      }
    }
    print('success sync');
    return box.values.toList();
  }


  static register() {
    Hive.registerAdapter(FoodLimitsAdapter());
    Hive.registerAdapter(PercentilePojoAdapter());
    Hive.registerAdapter(KrjConfigAdapter());
    Hive.registerAdapter(ConfigFileAdapter());

    Hive.registerAdapter(AppealsAdapter());
    Hive.registerAdapter(GroupAccessAdapter());
    Hive.registerAdapter(EmployeeIndicatorsValueAdapter());
    Hive.registerAdapter(IndicatorValueOnDateListAdapter());
    Hive.registerAdapter(IndicatorValueOnDateListShiftAdapter());

    Hive.registerAdapter(IndicatorValueListAdapter());
    Hive.registerAdapter(IndicatorAdapter());
    Hive.registerAdapter(UomAdapter());

    // PPE
    Hive.registerAdapter(PersonalProtectionEquipmentAdapter());
    Hive.registerAdapter(CalendarEventsAdapter());
    Hive.registerAdapter(PpeAdapter());

    //Assignment
    Hive.registerAdapter(AssignmentAdapter());
    Hive.registerAdapter(PersonAdapter());
    Hive.registerAdapter(OrganizationAdapter());
    Hive.registerAdapter(DepartmentAdapter());
    Hive.registerAdapter(JobAdapter());
    Hive.registerAdapter(AnthropometryAdapter());
    Hive.registerAdapter(PlacementAdapter());
    Hive.registerAdapter(RatingAdapter());

    // Testing
    Hive.registerAdapter(TestAdapter());
    Hive.registerAdapter(QuestionAdapter());
    Hive.registerAdapter(AnswerAdapter());
    Hive.registerAdapter(AnswerOptionAdapter());
    Hive.registerAdapter(OverCategoryGraphicAdapter());
    Hive.registerAdapter(RightAnswersGraphicAdapter());
    Hive.registerAdapter(SubmittedGraphicAdapter());
    Hive.registerAdapter(TestingGraphicAdapter());

    // Car Order
    Hive.registerAdapter(CarOrderGrouppedAdapter());
    Hive.registerAdapter(CarOrderAdapter());
    Hive.registerAdapter(OrderAdapter());
    Hive.registerAdapter(DriverAdapter());
    Hive.registerAdapter(VehicleAdapter());
    Hive.registerAdapter(CarAddressAdapter());

    Hive.registerAdapter(SettlenetSheetAdapter());
    Hive.registerAdapter(CheckPointAdapter());
    Hive.registerAdapter(NewsAdapter());
    Hive.registerAdapter(EventAdapter());
    //Hive.registerAdapter(CalendarEventsAdapter());

    Hive.registerAdapter(EatingMenusAdapter());
    Hive.registerAdapter(ComplexAdapter());
    Hive.registerAdapter(ProductAdapter());
    Hive.registerAdapter(MenuAdapter());
    Hive.registerAdapter(MealtimeAdapter());
    Hive.registerAdapter(PlaceAdapter());
    Hive.registerAdapter(CourseEatingHistoryAdapter());
    Hive.registerAdapter(DishAdapter());
    Hive.registerAdapter(HistoryEatingOrderAdapter());

    Hive.registerAdapter(AllOrderPojoAdapter());
    Hive.registerAdapter(wp.PersonAdapter());
    Hive.registerAdapter(RepairOrderPojoAdapter());
    Hive.registerAdapter(RepairOrderPojoLaborSpendingAdapter());
    Hive.registerAdapter(RepairOrderPojoWorkAdapter());
    Hive.registerAdapter(DefectAdapter());
    Hive.registerAdapter(MaterialAdapter());
    Hive.registerAdapter(ItemAdapter());
    Hive.registerAdapter(NotificationsAdapter());
    Hive.registerAdapter(nt.PersonAdapter());
    Hive.registerAdapter(MaterialObligationsAdapter());
    Hive.registerAdapter(TransportAdapter());
    Hive.registerAdapter(WorkLaborSpendingAdapter());
    Hive.registerAdapter(WorkOrderPojoAdapter());
    Hive.registerAdapter(WorkOrderPojoLaborSpendingAdapter());
    Hive.registerAdapter(WorkOrderShiftAdapter());
    Hive.registerAdapter(WorkOrderShiftWorkAdapter());
    Hive.registerAdapter(TransportOrderPojoAdapter());
    Hive.registerAdapter(TransportOrderPojoWorkAdapter());
    Hive.registerAdapter(ListOfEquipmentUsedAdapter());
    Hive.registerAdapter(MedicineAndSafetyPojoAdapter());

    //Messages
    Hive.registerAdapter(ConditionCategoryAdapter());
    Hive.registerAdapter(MessageAdapter());
    Hive.registerAdapter(ObjectNameAdapter());
    Hive.registerAdapter(AbstractDictionaryAdapter());

    //File
    Hive.registerAdapter(FileDescriptorAdapter());

    //bsa
    Hive.registerAdapter(BehaviorAuditAdapter());
    Hive.registerAdapter(ObservationAdapter());

    //risks
    Hive.registerAdapter(RisksManagementAdapter());

    //Ticket
    Hive.registerAdapter(TicketResponseAdapter());
    Hive.registerAdapter(TicketAdapter());
    Hive.registerAdapter(TicketHistoryAdapter());
    Hive.registerAdapter(EventEntityAdapter());
    Hive.registerAdapter(EventTypeAdapter());

    //Event
    Hive.registerAdapter(EventManagementAdapter());
    Hive.registerAdapter(SupportDocAdapter());


  }
}
