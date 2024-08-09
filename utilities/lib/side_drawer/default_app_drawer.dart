import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:utilities/common/bottom_sheet/book_session_sheet.dart';
import 'package:utilities/common/bottom_sheet/study_material_sheet.dart';
import 'package:utilities/common/controller/profile_controller.dart';
import 'package:utilities/components/enums.dart';
import 'package:utilities/side_drawer/animated_support_container.dart';
import 'package:utilities/side_drawer/default_app_drawer_controller.dart';
import 'package:utilities/side_drawer/default_custom_drawer_model.dart';
import 'package:utilities/side_drawer/drawer_controller.dart';
import 'package:utilities/components/cached_image_network_container.dart';
import 'package:utilities/theme/app_box_decoration.dart';
import 'package:utilities/theme/app_colors.dart';

final prefs = GetStorage();
final _hiddenDrawerController = Get.put(HiddenDrawerController());
final _defaultCustomDrawerController = Get.put(GetMenuItemsController());
final _profileController = Get.put(ProfileController());

typedef VoidCallback = void Function();
typedef ChangeExamCallBack = void Function();

class DefaultCustomDrawer extends StatefulWidget {
  final VoidCallback profile;
  final ChangeExamCallBack changeExamCallBack;

  const DefaultCustomDrawer({
    Key? key,
    required this.profile,
    required this.changeExamCallBack,
  }) : super(key: key);

  @override
  State<DefaultCustomDrawer> createState() => _DefaultCustomDrawerState();
}

class _DefaultCustomDrawerState extends State<DefaultCustomDrawer> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    if (_defaultCustomDrawerController.state == null) {
      _defaultCustomDrawerController.getMenuItems(path: "home");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      child: TapRegion(
        onTapOutside: (event) {
          _hiddenDrawerController.scaffoldKey.currentState?.closeDrawer();
          debugPrint('tapped -| outside');
        },
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 8,
            sigmaY: 8,
          ),
          child: _defaultCustomDrawerController.obx(
            (state) {
              return Container(
                margin: EdgeInsets.only(
                  left: 12,
                  right: MediaQuery.of(context).size.width * 0.24,
                  top: 24,
                  bottom: 10,
                ),
                decoration: AppBoxDecoration.getBoxDecoration(
                  showShadow: false,
                  borderRadius: 16,
                ),
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 20),
                    SvgPicture.asset("packages/utilities/assets/logo.svg"),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state?.result?.menuItems?.length ?? 0,
                              itemBuilder: (context, index) {
                                final item = state?.result?.menuItems?[index];
                                return GestureDetector(
                                  onTap: () async {
                                    if (item?.path == "/bottomSheet") {
                                      context.pop();
                                      bookSessionSheet(context, service: item?.title ?? "");
                                      return;
                                    } else if (item?.path == "/changeExam") {
                                      context.pop();
                                      debugPrint("/changeExam");
                                      widget.changeExamCallBack();
                                    } else {
                                      Navigator.pop(context);
                                      context.pushNamed(item?.path ?? "-", extra: {
                                        "url": item?.url ?? "",
                                        "conditionKey": item?.key ?? "",
                                      });
                                    }
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                                    decoration: AppBoxDecoration.getBoxDecoration(
                                      showShadow: false,
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        dynamicImage(image: item?.icon ?? ""),
                                        const SizedBox(width: 14),
                                        Text(
                                          item?.title ?? "",
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                color: AppColors.black,
                                                fontWeight: FontWeight.w400,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        SupportAnimatedContainer(
                          item: state?.result?.contact ?? Contact(),
                        ),
                        const SizedBox(height: 12),
                        const Divider(
                          height: 1.5,
                          endIndent: 20,
                          indent: 20,
                          color: AppColors.iron,
                          thickness: 0,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 26),
                          decoration: AppBoxDecoration.getBoxDecoration(
                            showShadow: false,
                            color: Colors.transparent,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () => studyMaterialSheet(
                                  context,
                                  extensions: Extensions.image,
                                  imageUrl: _profileController.state?.profile?.imageUrl,
                                ),
                                child: Hero(
                                  tag: "profile-image",
                                  child: CachedImageNetworkContainer(
                                    height: 44,
                                    width: 44,
                                    fit: BoxFit.contain,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    url: _profileController.state?.profile?.imageUrl,
                                    placeHolder: buildPlaceholder(
                                      name: "name",
                                      context: context,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Flexible(
                                child: GestureDetector(
                                  onTap: widget.profile,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _profileController.state?.profile?.name ?? "",
                                        style: Theme.of(context).textTheme.bodyLarge,
                                      ),
                                      Text(
                                        _profileController.state?.profile?.email ?? "",
                                        style: Theme.of(context).textTheme.bodySmall,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 26),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                foregroundColor: AppColors.whiteSmoke,
                                backgroundColor: AppColors.desertStorm,
                                elevation: 0),
                            onPressed: () async {
                              prefs.erase();
                              context.go("/login");
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset("packages/utilities/assets/logout.svg"),
                                const SizedBox(width: 8),
                                Text(
                                  "Logout",
                                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                        letterSpacing: 0.15,
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 6)
                      ],
                    )
                  ],
                ),
              );
            },
            onError: (error) => GestureDetector(
              onTap: () => _defaultCustomDrawerController.getMenuItems(path: "home"),
              child: Center(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Something Went Wrong!",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Try Again!",
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          Icon(
                            Icons.replay,
                            size: 22,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget dynamicImage({
  String? image,
  double? height,
  double? width,
}) {
  final isNetworkImage = image?.startsWith("https") == true;

  if (isNetworkImage == true) {
    if (image!.endsWith(".svg")) {
      return SvgPicture.network(
        image,
        height: height ?? 24,
        width: width ?? 24,
        semanticsLabel: 'Custom Image',
        fit: BoxFit.fill,
      );
    }
    if (image.endsWith(".png")) {
      return Image.network(
        image,
        height: height ?? 24,
        width: width ?? 24,
        fit: BoxFit.fill,
      );
    }
  }

  if (image!.contains(".png")) {
    return Image.asset(
      image,
      height: height ?? 24,
      width: width ?? 24,
      fit: BoxFit.fill,
    );
  }

  if (image.contains(".svg")) {
    return SvgPicture.asset(
      image,
      height: height ?? 24,
      width: width ?? 24,
      semanticsLabel: 'Custom Image',
      fit: BoxFit.fill,
    );
  }

  return const SizedBox();
}
