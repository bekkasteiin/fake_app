import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hse/core/model/notification/Notification.dart';
import 'package:hse/core/service/rest_services.dart';
import 'package:hse/generated/l10n.dart';
import 'package:hse/pageviews/loading_page.dart';
import 'package:hse/viewmodels/base_model.dart';

class NotificationsModel extends BaseModel {
  List<Notifications> notificationList;

  Future<List<Notifications>> get notification async {
    notificationList ??= await RestServices.getNotifications();
    return notificationList;
  }

  void submitCarOrder(Notifications notifications, bool isAgree) async {
    Get.dialog(LoadingPage());
    var result =
        await RestServices.submitCarOrderRequest(notifications, isAgree);
    if (!result.success) {
      Get.back();
      Get.snackbar(S().attention, result.errorDescription);
      return;
    }
    if (result.success) {
      notifications.status = isAgree ? 'APPROVED' : 'UNAPPROVED';
      notifications.isCloseable = false;
      // await notifications.save();
      Get.back();
      Get.snackbar(S().attention, S().successfully);
      setBusy(false);
      return;
    }
  }

  bool checkIsButtonRequired(Notifications notifications) {
    if ((notifications.status == null || notifications.status == 'IS_NEW') &&
        (notifications.notificationTypeCode == 'CAR_ORDER')) {
      return true;
    }

    return false;
  }

  setIsReaded(Notifications e, bool val) async {
    if (val || kIsWeb) {
      return;
    }
    if (!val && e.isCloseable && e.notificationTypeCode != 'CAR_ORDER') {
      e.isCloseable = false;
      await e.save();
      setBusy(false);
    }
  }
}
