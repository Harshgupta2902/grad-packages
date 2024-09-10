library utilities;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:utilities/common/controller/default_controller.dart';

final _defaultController = Get.put(DefaultController());
late final GlobalKey<ScaffoldMessengerState> globalScaffoldMessengerKey;

initGlobalKeys(GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey) async {
  globalScaffoldMessengerKey = scaffoldMessengerKey;
  final getStatus = await GetStorage.init();
  _defaultController.getDefaultData();

  debugPrint("-------- initGetStorage ------ => $getStatus");
}
