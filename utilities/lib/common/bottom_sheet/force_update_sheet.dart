import 'dart:io';

import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:lottie/lottie.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:utilities/packages/smooth_rectangular_border.dart';
import 'package:utilities/theme/app_colors.dart';

appUpdateFunction({
  required num? forceUpdate,
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
        () => showForceUpdateBottomSheet(context),
      );
    }

    if (Platform.isAndroid) {
      debugPrint('Platform.isAndroid');

      try {
        final updateInfo = await InAppUpdate.checkForUpdate();

        if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
          if (forceUpdate == 1) {
            debugPrint('FORCE UPDATE STARTED');
            InAppUpdate.performImmediateUpdate().then((appUpdateResult) {
              if (appUpdateResult == AppUpdateResult.success) {}
            });
          }
        }
      } catch (e) {
        debugPrint("InAppUpdate Error $e");
      }
    }
  }
}

void showForceUpdateBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isDismissible: false,
    enableDrag: false,
    shape: const SmoothRectangleBorder(
      borderRadius: SmoothBorderRadius.vertical(
        top: SmoothRadius(cornerRadius: 16, cornerSmoothing: 1.0),
      ),
    ),
    builder: (BuildContext context) {
      return PopScope(
        canPop: false,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Force Update",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                "You need to update the app to continue using it.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              Lottie.asset(
                "packages/utilities/assets/force_update.json",
                width: 150,
                height: 150,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => _launchStore(),
                child: Text(
                  "Update Now",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void _launchStore() async {
  if (Platform.isAndroid || Platform.isIOS) {
    final appId = Platform.isAndroid ? 'com.mysiponline' : '1246082058';
    final uri = Platform.isAndroid
        ? 'market://details?id=$appId'
        : 'https://apps.apple.com/gb/app/id$appId';

    final url = Uri.parse(uri);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch Store URL';
    }
  }
}
