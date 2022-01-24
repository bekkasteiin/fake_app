import 'package:hse/core/model/notification/Notification.dart';
import 'package:hse/core/model/utils/ToDoList.dart';
import 'package:hse/core/service/rest_services.dart';
import 'package:hse/viewmodels/base_model.dart';

class Home extends BaseModel {
  ToDoList toDoListCurrent;
  List<Notifications> notificationList;

  Future<ToDoList> get toDoList async {
   // var list = await RestServices.getAccessCategories();
    toDoListCurrent = await RestServices.getToDoList();
    return toDoListCurrent;
  }

  Future<bool> get notification async {
    //  notificationList ??= await RestServices.getDisciplineNotifications();
    /*notificationList.forEach((element) {
      Get.defaultDialog(
          title: element.title ?? '',
          middleText: element.notification ?? '',
          confirmTextColor: Colors.white,
          textConfirm: 'OK',
          buttonColor: Colors.red,
          radius: 5,
          onConfirm: () {
            setReaded(element);
            Get.back();
          });
    });*/
    return true;
  }

  void setReaded(Notifications notifications) {
    RestServices.setInactiveNotifications([notifications.id]);
  }
}
