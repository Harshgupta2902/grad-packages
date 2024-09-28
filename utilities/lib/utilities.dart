library utilities;

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:utilities/common/controller/default_controller.dart';

final _defaultController = Get.put(DefaultController());
late final GlobalKey<ScaffoldMessengerState> globalScaffoldMessengerKey;

initGlobalKeys(GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey) async {
  globalScaffoldMessengerKey = scaffoldMessengerKey;

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyA-uGAs_9fLLAYTa2YRia7o3JHJ4-BDrqI",
      appId: "1:605122150369:android:24a14717fbcad2df9edca0",
      messagingSenderId: "605122150369",
      projectId: "gradding-app",
    ),
  );

  final getStatus = await GetStorage.init();
  _defaultController.getDefaultData();

  FlutterError.onError = (FlutterErrorDetails details) {
    debugPrint('Error: ${details.exception}');
    debugPrint('Stack trace:${details.stack}');
  };


  debugPrint("-------- initGetStorage ------ => $getStatus");
}
