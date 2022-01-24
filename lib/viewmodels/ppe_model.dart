// import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hse/core/model/calendarevents/Event.dart';
import 'package:hse/core/model/ppe/PersonalProtectionEquipment.dart';
import 'package:hse/core/model/ppe/Ppe.dart';
import 'package:hse/core/service/hive_service.dart';
import 'package:hse/core/service/rest_services.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/pageviews/ppe/ppe_inspect_view.dart';
import 'package:hse/viewmodels/base_model.dart';
import 'package:provider/provider.dart';

class PpeViewModel extends BaseModel {
  PersonalProtectionEquipment _protectionEquipment;
  Ppe selectedPpe;
  num totalCost = 0;
  num count = 0;
  String calIndex = '/calendar';
  DateTime calDate;
  List<Event> events;

  Future<PersonalProtectionEquipment> get ppes async {
    _protectionEquipment ??= await RestServices.getPPEs();
    _protectionEquipment.ppes.forEach((element) {
      totalCost += element.actualCost;
      count++;
    });
    return _protectionEquipment;
  }

  num get cost {
    return totalCost;
  }

  Future scan() async {
    // Box settings = await HiveService.getBox("settings");
    // settings.get('CameraAvailable');
    // try {
    //   var barcode = await BarcodeScanner.scan();
    //
    //   await Get.to(ChangeNotifierProvider.value(
    //     value: this,
    //     builder: (context, child) => PPEScreenInspect(
    //       barcode: barcode,
    //     ),
    //   ));
    // } on PlatformException catch (e) {
    //   if (e.code == BarcodeScanner.CameraAccessDenied) {
    //     await Get.defaultDialog(
    //         title: S().attention, middleText: S().cameraPermission);
    //   } else {
    //     await Get.defaultDialog(title: S().error, middleText: e.message);
    //   }
    // } on FormatException {
    //   // ignored case User returned using the "back"-button before scanning anything
    // } catch (e) {
    //   await Get.defaultDialog(title: S().error, middleText: e.message);
    // }
  }
}
