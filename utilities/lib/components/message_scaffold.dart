import 'package:flutter/material.dart';
import 'package:utilities/theme/app_colors.dart';

import 'enums.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

messageScaffold({
  required BuildContext context,
  required String content,
  int duration = 4,
  Enum messageScaffoldType = MessageScaffoldType.information,
  bool isTop = false,
}) {
  Color backgroundColor = AppColors.whiteFrost;
  Color mainColor = AppColors.primaryColor;
  IconData stateIcon = Icons.info_outline;

  switch (messageScaffoldType) {
    case MessageScaffoldType.success:
      backgroundColor = AppColors.hintOfGreen;
      mainColor = AppColors.shareGreen;
      stateIcon = Icons.check;
      break;

    case MessageScaffoldType.error:
      mainColor = AppColors.red;
      backgroundColor = AppColors.bgRed;
      stateIcon = Icons.cancel_outlined;
      break;

    case MessageScaffoldType.warning:
      backgroundColor = AppColors.bgYellow;
      mainColor = AppColors.yellow;
      stateIcon = Icons.warning_amber;
      break;

    case MessageScaffoldType.information:
      backgroundColor = AppColors.whiteFrost;
      mainColor = AppColors.primaryColor;
      stateIcon = Icons.info_outline;
      break;
  }

  scaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: backgroundColor,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(color: mainColor, width: 0.4),
      ),
      margin: isTop != false
          ? EdgeInsets.only(bottom: MediaQuery.of(context).size.height - 150, right: 20, left: 20)
          : null,
      content: Row(
        children: [
          Icon(stateIcon, color: mainColor),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              content,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: mainColor),
            ),
          ),
        ],
      ),
      duration: Duration(seconds: duration),
    ),
  );
}
