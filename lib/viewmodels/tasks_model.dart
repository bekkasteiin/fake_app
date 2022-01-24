import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hse/core/model/employee_indicators/EmployeeIndicatorsValue.dart';
import 'package:hse/core/model/medicine/MedicineAndSafetyPojo.dart';
import 'package:hse/core/model/task/LaborSpending.dart';
import 'package:hse/core/model/work_orders/AllOrderPojo.dart';
import 'package:hse/core/model/work_orders/RepairOrderPojoLaborSpending.dart';
import 'package:hse/core/model/work_orders/WorkLaborSpending.dart';
import 'package:hse/core/service/rest_services.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/pageviews/loading_page.dart';
import 'package:hse/viewmodels/base_model.dart';

class TasksModel extends BaseModel {
  List<AllOrderPojo> tasksList;
  List<MedicineAndSafetyPojo> _medicineAndSafetyList;
  AllOrderPojo selectedTask;
  EmployeeIndicatorsValue employeeIndicators;
  var repairLaborSpending = RepairOrderPojoLaborSpending();
  var workLaborSpending = WorkLaborSpending();
  var laborSpending = LaborSpending();
  var personController = TextEditingController();
  String personGroupId;
  int indicatorPage = 0;
  final indicatorController = PageController();

  Future<List<AllOrderPojo>> get tasks async {
    tasksList ??= await RestServices.getTasks();
    selectedTask = tasksList.first;
    return tasksList;
  }

  Future<List<MedicineAndSafetyPojo>> get medSafe async {
    _medicineAndSafetyList ??= await RestServices.getMedicineAndSafe();
    return _medicineAndSafetyList;
  }

  Future<EmployeeIndicatorsValue> get getIndicators async {
    employeeIndicators ??= await RestServices.getEmployeeIndicators();
    employeeIndicators.indicatorValueOnDateList.add(null);
    employeeIndicators.indicatorValueOnDateList.add(null);
    return employeeIndicators;
  }

  double getResult(AllOrderPojo task) {
    switch (task.type) {
      case 'TRANSPORT_ORDER':
        return transportCompletion(task);
      case 'REPAIR_ORDER':
        if (task?.repairOrderPojo?.laborSpending.isEmpty) {
          return 0.0;
        }
        return task?.repairOrderPojo?.laborSpending?.first?.percent ?? 0.0;
      case 'WORK_ORDER':
        return task?.workOrderPojo?.totalPercent ?? 0.0;
      case 'WORK_ORDER_SHIFT':
        return 0.0;
    }
  }

  double transportCompletion(AllOrderPojo task) {
    var lastQuantity =
        task?.transportOrderPojo?.work?.laborSpending?.isNotEmpty ?? false
            ? task?.transportOrderPojo?.work?.laborSpending?.first?.tripQuantity
            : 0.0;
    var targetQuantity = task?.transportOrderPojo?.work?.trip;
    return ((lastQuantity ?? 0.0) / (targetQuantity ?? 1.0)) * 100;
  }

  void selectTask(AllOrderPojo e) {
    selectedTask = e;
    setBusy(false);
  }

  void sendRepairLabor(String percentKey) async {
    Get.dialog(LoadingPage());
    repairLaborSpending.dateAndTime = DateTime.now();
    repairLaborSpending.percent = double.tryParse(percentKey);
    repairLaborSpending.status =
        int.parse(percentKey) >= 100 ? 'Завершено' : 'В процессе';
    var res = await RestServices.submitRepairTask(
        repairLaborSpending, selectedTask.repairOrderPojo);
    await completeAndRefreshTasks(res);
  }

  Future completeAndRefreshTasks(bool res) async {
    Get.back();
    if (!res) {
      Get.snackbar(S().attention, S().errorTryAgainLater);
    } else {
      tasksList = await RestServices.getTasks();
      setBusy(false);
      Get.back();
      Get.snackbar(S().attention, S().successfully);
    }
  }

  void sendTransportData() async {
    workLaborSpending.dateAndTime = DateTime.now();
    workLaborSpending.status = selectedTask.transportOrderPojo.work.trip ==
            workLaborSpending.tripQuantity
        ? 'Завершено'
        : 'В процессе';
    var res = await RestServices.submitTransportTask(
        workLaborSpending, selectedTask.transportOrderPojo);
    await completeAndRefreshTasks(res);
  }

  // void pickPerson(personController) async {
  //   var fromValue = await Get.to(
  //       PersonSelectScreen(selectedTask.workOrderShift.work.person));
  //   personController.text =
  //       '${fromValue.lastName} ${fromValue.firstName} ${fromValue.middleName}';
  //   personGroupId = fromValue.groupId;
  //   setBusy(false);
  // }

  void sendShiftData() async {
    workLaborSpending.dateAndTime = DateTime.now();
    workLaborSpending.status = selectedTask.workOrderShift.work.work
        ? ''
        : selectedTask.workOrderShift.work.transport.trip ==
                workLaborSpending.tripQuantity
            ? 'Завершено'
            : 'В процессе';
    var res = await RestServices.submitShiftTask(
        workLaborSpending, selectedTask.workOrderShift,
        personGroupId: personGroupId);
    await completeAndRefreshTasks(res);
  }

  void sendShiftDataManager() async {
    workLaborSpending.dateAndTime = DateTime.now();
    workLaborSpending.status = '';
    workLaborSpending.uom = selectedTask.workOrderShift.work.uom;
    var res = await RestServices.submitShiftManagerTask(
        workLaborSpending, selectedTask.workOrderShift);
    await completeAndRefreshTasks(res);
  }

  void sendOrdinaryLabor(String percentKey) async {
    laborSpending.factEndDate = DateTime.now();
    laborSpending.percentCompletion = (((laborSpending.factObject /
                    selectedTask.workOrderPojo.plannedVolume) *
                100)
            .toDouble() +
        (selectedTask.workOrderPojo.totalPercent ?? 0));
    laborSpending.status =
        laborSpending.percentCompletion > 100 ? "Выполнено" : "В Процессе";
    var res = await RestServices.submitTask(
        laborSpending, selectedTask.workOrderPojo);
    laborSpending = LaborSpending();
    await completeAndRefreshTasks(res);
  }

  void indicatorNext() {
    if (indicatorPage != indicatorController.initialPage) {
      return;
    }
    indicatorPage++;
    indicatorController.jumpToPage(1);
  }

  void indicatorBack() {
    if (indicatorPage == indicatorController.initialPage) {
      Get.back();
      return;
    }
    indicatorPage = 0;
    indicatorController.jumpToPage(0);
  }
}
