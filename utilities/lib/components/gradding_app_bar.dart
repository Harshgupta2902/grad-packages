import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:utilities/theme/app_colors.dart';

class GraddingAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function()? openDrawer;
  final Function()? backOnTap;
  final bool? backButton;
  final bool? showActions;
  final String? title;
  final bool? showLeading;
  final bool? centerTitle;
  final Color? bgColor;
  final bool? isBlur;

  const GraddingAppBar({
    super.key,
    this.openDrawer,
    this.backButton = false,
    this.title,
    this.showActions = false,
    this.showLeading = true,
    this.centerTitle = false,
    this.bgColor,
    this.isBlur,
    this.backOnTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget child = AppBar(
      titleSpacing: 0,
      title: title == null
          ? Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: SvgPicture.asset(
                "packages/utilities/assets/logo.svg",
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                title ?? "-",
                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 20),
              ),
            ),
      centerTitle: centerTitle ?? backButton == true ? false : true,
      leadingWidth: backButton == false ? 62 : null,
      backgroundColor: bgColor ?? Colors.transparent,
      scrolledUnderElevation: 0,
      elevation: 0,
      leading: showLeading == true
          ? backButton == false
              ? GestureDetector(
                  onTap: openDrawer,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: SvgPicture.asset(
                      "packages/utilities/assets/Menu.svg",
                      fit: BoxFit.fill,
                    ),
                  ),
                )
              : GestureDetector(
                  onTap: backOnTap ??
                      () {
                        if (context.canPop()) {
                          context.pop();
                        }
                      },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 2),
                    child: SvgPicture.asset("packages/utilities/assets/back.svg"),
                  ),
                )
          : null,
      actions: showActions == true
          ? [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                child: GestureDetector(
                  onTap: () {
                    context.pushNamed("/profile");
                  },
                  child: SvgPicture.asset("packages/utilities/assets/profile.svg"),

                  // child: SvgPicture.asset("packages/utilities/assets/notification.svg"),
                ),
              ),
            ]
          : null,
    );

    if (isBlur == true) {
      return Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 26, bottom: 6),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.whiteFrost.withOpacity(0.3),
                borderRadius: BorderRadius.circular(14),
              ),
              padding: const EdgeInsets.only(top: 8),
              height: kToolbarHeight,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(
                        "packages/utilities/assets/back.svg",
                        fit: BoxFit.fill,
                      ),
                    ),
                    SvgPicture.asset(
                      "packages/utilities/assets/logo.svg",
                    ),
                    GestureDetector(
                      onTap: () {
                        context.pushNamed("/profile");
                      },
                      child: SvgPicture.asset("packages/utilities/assets/profile.svg"),

                      // child: SvgPicture.asset("packages/utilities/assets/notification.svg"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    return child;
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight + (isBlur == true ? 60 : 0));
}
