import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:utilities/packages/smooth_rectangular_border.dart';
import 'package:utilities/theme/app_box_decoration.dart';
import 'package:utilities/theme/app_colors.dart';

void counsellorSheet(BuildContext context, {required String phoneNumber, required String name}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const SmoothRectangleBorder(
      borderRadius: SmoothBorderRadius.vertical(
        top: SmoothRadius(cornerRadius: 16, cornerSmoothing: 1.0),
      ),
    ),
    builder: (BuildContext context) {
      return CounsellorSheet(
        phoneNumber: phoneNumber,
        name: name,
      );
    },
  );
}

class CounsellorSheet extends StatefulWidget {
  final String phoneNumber;
  final String name;

  const CounsellorSheet({Key? key, required this.phoneNumber, required this.name})
      : super(key: key);

  @override
  CounsellorSheetState createState() => CounsellorSheetState();
}

class CounsellorSheetState extends State<CounsellorSheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Ask your queries to the counsellor",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            decoration: AppBoxDecoration.getBoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: 12,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset("packages/utilities/assets/counsellor.svg"),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      // "No Counsellor assigned yet",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "COUNSELLOR",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    context.pop();
                    launchCall(phone: widget.phoneNumber);
                  },
                  child: SvgPicture.asset("packages/utilities/assets/call.svg"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

launchCall({String? phone}) {
  launchUrlString("tel:$phone");
}
