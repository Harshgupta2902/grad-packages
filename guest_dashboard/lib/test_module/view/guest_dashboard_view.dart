import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:guest_dashboard/constants/guest_asset_paths.dart';
import 'package:guest_dashboard/navigation/guest_go_paths.dart';
import 'package:guest_dashboard/test_module/components/book_seat_card.dart';
import 'package:guest_dashboard/test_module/components/pre_ielts_test_card.dart';
import 'package:guest_dashboard/test_module/controller/guest_dashboard_controller.dart';
import 'package:ielts_dashboard/constants/ielts_assets_path.dart';
import 'package:utilities/components/change_exam.dart';
import 'package:utilities/side_drawer/default_app_drawer_controller.dart';
import 'package:utilities/components/blurry_container.dart';
import 'package:utilities/common/bottom_sheet/book_session_sheet.dart';
import 'package:utilities/packages/smooth_rectangular_border.dart';
import 'package:utilities/services/fcm_notification_service.dart';
import 'package:utilities/theme/app_box_decoration.dart';
import 'package:utilities/theme/app_colors.dart';

final _defaultCustomDrawerController = Get.put(GetMenuItemsController());
final _guestDashboardController = Get.put(GuestDashboardController());

class GuestDashboardView extends StatefulWidget {
  const GuestDashboardView({super.key});

  @override
  State<GuestDashboardView> createState() => _GuestDashboardViewState();
}

class _GuestDashboardViewState extends State<GuestDashboardView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      FCMNotificationService().updateFCMToken();
      _defaultCustomDrawerController.getMenuItems(path: "guest");
      await _guestDashboardController.getGuestDashboardData();
      if (_guestDashboardController.state?.result?.testTypeAvailable == false) {
        Future.delayed(Duration.zero, () => ChangeExam.changeExams(context: context));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _guestDashboardController.obx(
      (state) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.22,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(GuestAssetPath.guestBanner), fit: BoxFit.fill),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: Text(
                        state?.result?.banner?.title ?? "",
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600, color: Colors.white, fontSize: 20),
                      ),
                    ),
                    Container(
                      decoration: AppBoxDecoration.getBoxDecoration(
                        showShadow: false,
                        color: AppColors.saffronMango,
                        borderRadius: 14,
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      child: Text(
                        state?.result?.banner?.desc ?? "",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.pushNamed(
                          GuestGoPaths.youtubeVideoView,
                          extra: {'url': state?.result?.banner?.video},
                        );
                      },
                      child: BlurryContainer(
                        color: Colors.white.withOpacity(0.3),
                        blur: 1,
                        borderRadius: SmoothBorderRadius(cornerRadius: 12),
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Watch Now",
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            const Icon(
                              Icons.play_circle_fill_outlined,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(state?.result?.cards?.length ?? 0, (index) {
                  final data = state?.result?.cards?[index];
                  final pngImages = [
                    IeltsAssetPath.mockTest,
                    IeltsAssetPath.practiceTest,
                    IeltsAssetPath.studyMaterial,
                  ];
                  return Flexible(
                    child: GestureDetector(
                      onTap: () {
                        context.pushNamed(data?.path ?? "", extra: {
                          "url": data?.url,
                          "conditionKey": data?.key,
                        });
                      },
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration(),
                        child: Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 3,
                              decoration: AppBoxDecoration.getBorderBoxDecoration(
                                showShadow: true,
                                shadowColor: AppColors.primaryColor.withOpacity(0.06),
                                color: AppColors.white,
                                borderRadius: 16,
                                borderColor: index == 0 ? AppColors.golden : Colors.transparent,
                              ),
                              margin: EdgeInsets.only(
                                bottom: 16,
                                right: index == 2 ? 0 : 4,
                                left: index == 0 ? 0 : 4,
                              ),
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    pngImages[index],
                                    height: 50,
                                    width: 50,
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    data?.title ?? "",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.brightGrey,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            if (index == 0)
                              Positioned(
                                top: 10,
                                left: -20,
                                child: Transform.rotate(
                                  angle: -45 * (3.1415926535897932 / 180),
                                  child: Container(
                                    width: 80,
                                    decoration: const BoxDecoration(
                                      gradient: GradientAppColors.goldenGradient,
                                    ),
                                    child: Text(
                                      "FREE",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const PreIeltsTestCard(),
              const SizedBox(height: 20),
              BookSeatCard(batch: state?.result?.batch),
              const SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: AppBoxDecoration.getBoxDecoration(color: Colors.white),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                margin: const EdgeInsets.only(bottom: 26),
                child: Column(
                  children: [
                    Text(
                      "One Stop Solution for all your needs",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.marineBlue,
                          ),
                    ),
                    const SizedBox(height: 16),
                    GridView.builder(
                      shrinkWrap: true,
                      itemCount: state?.result?.services?.length ?? 0,
                      padding: const EdgeInsets.only(bottom: 6),
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 14,
                        crossAxisSpacing: 8,
                        mainAxisExtent: 90,
                      ),
                      itemBuilder: (context, index) {
                        final data = state?.result?.services?[index];
                        return GestureDetector(
                          onTap: () => bookSessionSheet(context, service: data?.name ?? ""),
                          child: Container(
                            decoration:
                                AppBoxDecoration.getBoxDecoration(color: AppColors.backgroundColor),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.network(
                                  data?.image ?? "",
                                  height: 40,
                                  width: 40,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  data?.name ?? "",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppColors.marineBlue,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 11),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
      onError: (error) => GestureDetector(
        onTap: () => _guestDashboardController.getGuestDashboardData(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Something Went Wrong!",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Try Again!",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const Icon(
                    Icons.replay,
                    size: 22,
                    color: AppColors.primaryColor,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
