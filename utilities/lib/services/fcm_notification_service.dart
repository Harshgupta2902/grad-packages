import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:utilities/common/controller/update_fcm_controller.dart';

final _updateFcmController = Get.put(UpdateFcmController());

class FCMNotificationService {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final prefs = GetStorage();
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> updateFCMToken() async {
    _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    if (fcmToken == null) {
      debugPrint("----------  updateFCMTokenAPI Stopped FCM Token in null ----------");
    }

    if (prefs.read('fcm') == null) {
      prefs.write('fcm', fcmToken);
      _updateFcmController.updateFcm(token: fcmToken);
      return;
    } else {
      if (prefs.read('fcm') == fcmToken) {
        debugPrint("----------  updateFCMTokenAPI Stopped Same FCM Token  $fcmToken----------");
        _updateFcmController.updateFcm(token: fcmToken);
        return;
      }
    }

    debugPrint("FCM TOKEN $fcmToken ");

    if (fcmToken != null) {
      _updateFcmController.updateFcm(token: fcmToken);
    }
  }

  Future<void> clearFCMToken() async {
    _firebaseMessaging.deleteToken();
    _updateFcmController.updateFcm(token: null);
  }

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('mipmap/ic_launcher');
    // AndroidInitializationSettings('mipmap/ic_notification');
    final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    // ------- Android notification click handler
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse details) {
      try {
        debugPrint("Notification clicked ${details.payload}");

        final Map payload = json.decode(details.payload ?? "");
        onNotificationClicked(payload: payload);
      } catch (e) {
        debugPrint("onDidReceiveNotificationResponse error $e");
      }
    });
  }

  onNotificationClicked({required Map payload}) {
    debugPrint(payload.toString());
    if (payload.containsKey('route') && payload.containsKey('arguments')) {
      final arguments = json.decode(payload['arguments']);
      debugPrint(arguments.runtimeType.toString());
      debugPrint(payload['route']);
      debugPrint(arguments);

      if (arguments == null) {
        return;
      }

      Navigator.pushNamed(Get.context!, payload['route'], arguments: arguments);
    } else if (payload.containsKey('route') == true) {
      Navigator.pushNamed(Get.context!, payload['route']);
    }
  }

  fcmListener() {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        debugPrint("notification reciec");
        createNotification(message);
      },
    );
  }

  void onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) async {
    try {
      final Map payLoadMap = json.decode(payload ?? "");

      onNotificationClicked(payload: payLoadMap);
    } catch (e) {
      debugPrint("onDidReceiveNotificationResponse error $e");
    }
  }

  //----------------------------------------------------------

  static void createNotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const androidNotificationDetails = AndroidNotificationDetails(
        'pushnotification',
        'pushnotification',
        importance: Importance.max,
        priority: Priority.high,
        // styleInformation: BigPictureStyleInformation(DrawableResourceAndroidBitmap('ic_notification'), largeIcon:  DrawableResourceAndroidBitmap('ic_notification')),
        largeIcon: DrawableResourceAndroidBitmap('mipmap/ic_launcher'),
      );

      const iosNotificationDetail = DarwinNotificationDetails();

      const notificationDetails = NotificationDetails(
        iOS: iosNotificationDetail,
        android: androidNotificationDetails,
      );

      await flutterLocalNotificationsPlugin.show(
        id,
        message.notification?.title,
        message.notification?.body,
        notificationDetails,
        payload: json.encode(message.data),
      );
    } catch (error) {
      debugPrint("Notification Create Error $error");
    }
  }
}
