import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../../../main.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  Future initialise() async {
    if (kIsWeb) {
      return;
    }
    if (Platform.isIOS) {
      // request permissions if we're on android
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }

    _fcm.configure(
      // Called when the app is in the foreground and we receive a push notification
      onMessage: (Map<String, dynamic> message) async {
        // showNotification( message['notification']['title'], message['notification']['body']);
        await Get.snackbar(
            message['notification']['title'], message['notification']['body']);
      },
      // Called when the app has been closed comlpetely and it's opened
      // from the push notification.
      onLaunch: (Map<String, dynamic> message) async {
        print('onMessage: $message');
      },
      // Called when the app is in the background and it's opened
      // from the push notification.
      onResume: (Map<String, dynamic> message) async {
        print('onResume: $message');
      },
    );
  }

  // void showNotification(String title, String body) async {
  //   await _demoNotification(title, body);
  // }
  //
  // Future<void> _demoNotification(String title, String body) async {
  //   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //       'channel_ID', 'channel name', 'channel description',
  //       importance: Importance.max,
  //       playSound: true,
  //       // sound: 'sound',
  //       showProgress: true,
  //       priority: Priority.high,
  //       ticker: 'test ticker');
  //
  //   var iOSChannelSpecifics = IOSNotificationDetails();
  //   var platformChannelSpecifics = NotificationDetails(
  //       android: androidPlatformChannelSpecifics, iOS: iOSChannelSpecifics);
  //   await flutterLocalNotificationsPlugin
  //       .show(0, title, body, platformChannelSpecifics, payload: 'test');
  // }
}
