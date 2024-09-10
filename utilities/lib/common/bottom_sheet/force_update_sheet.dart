import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:utilities/app_change.dart';

appUpdateFunction({
  required num? forceUpdate,
  required num? softUpdate,
  required num? buildNo,
  required BuildContext context,
}) async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  debugPrint('packageInfo ${packageInfo.buildNumber} inside function');

  String buildNumber = packageInfo.buildNumber;
  debugPrint("buildNumberbuildNumber$buildNumber");
  bool updateAvailable = (buildNo ?? 0) > int.parse(buildNumber);
  debugPrint('updateAvailable $updateAvailable inside function');

  if (forceUpdate == 1) {
    if (updateAvailable) {
      debugPrint('updateAvailable $updateAvailable inside forceUpdate updateAvailable');

      Future.delayed(
        Duration.zero,
        () => updateDrawer(appUpdate: forceUpdate ?? 0, context: context),
      );
    }

    if (Platform.isAndroid) {
      try {
        final updateInfo = await InAppUpdate.checkForUpdate();
        if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
          if (forceUpdate == 1) {
            debugPrint('FORCE UPDATE STARTED');
            InAppUpdate.performImmediateUpdate().then((appUpdateResult) {
              if (appUpdateResult == AppUpdateResult.success) {}
            });
          } else if (softUpdate == 1) {
            debugPrint('SOFT UPDATE STARTED');

            InAppUpdate.startFlexibleUpdate().then(
              (appUpdateResult) {
                if (appUpdateResult == AppUpdateResult.success) {
                  InAppUpdate.completeFlexibleUpdate();
                }
              },
            );
          }

          // if (forceUpdate == 1) {
          //   debugPrint('FORCE UPDATE STARTED');
          //   InAppUpdate.performImmediateUpdate().then((appUpdateResult) {
          //     if (appUpdateResult == AppUpdateResult.success) {}
          //   });
          // }
        }
      } catch (e) {
        debugPrint("InAppUpdate Error $e");
      }
    }
  }
}

updateDrawer({required num appUpdate, required BuildContext context}) {
  if (Platform.isAndroid && appUpdate == 1) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: CupertinoAlertDialog(
            title: const Text('Update Available'),
            content: const Text('A new version of the app is available.'),
            actions: [
              CupertinoDialogAction(
                child: const Text('Update'),
                onPressed: () async {
                  _launchStore();
                },
              ),
            ],
          ),
        );
      },
    );
  } else if (Platform.isIOS) {
    showCupertinoDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: CupertinoAlertDialog(
            title: const Text('Update Available'),
            content: const Text('A new version of the app is available.'),
            actions: [
              CupertinoDialogAction(
                child: const Text('Update'),
                onPressed: () async {
                  _launchStore();
                },
              ),
              if (appUpdate == 0)
                CupertinoDialogAction(
                  child: const Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}

void _launchStore() async {
  if (Platform.isAndroid || Platform.isIOS) {
    final appId = Platform.isAndroid
        ? getAndroidPackageName(AppConstants.appName)
        : getIosPackageName(AppConstants.appName);
    // final uri = Platform.isAndroid
    //     ? 'market://details?id=$appId'
    //     : 'https://apps.apple.com/gb/app/id$appId';

    final url = Uri.parse("market://details?id=$appId");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch Store URL';
    }
  }
}

String getAndroidPackageName(String appName) {
  switch (appName) {
    case 'Gradding':
      return "com.gradding";
    case 'Course-Finder':
      return "com.gradding.finder";
    case 'College-Predictor':
      return "com.gradding.predictor";
    default:
      return "com.gradding";
  }
}

String getIosPackageName(String appName) {
  switch (appName) {
    case 'Gradding':
      return "";
    case 'Course-Finder':
      return "";
    case 'College-Predictor':
      return "";
    default:
      return "";
  }
}
