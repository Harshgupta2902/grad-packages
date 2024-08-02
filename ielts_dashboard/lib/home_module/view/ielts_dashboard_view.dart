import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:guest_dashboard/navigation/guest_go_paths.dart';
import 'package:ielts_dashboard/constants/ielts_assets_path.dart';
import 'package:utilities/components/custom_error_or_empty.dart';
import 'package:ielts_dashboard/home_module/components/ielts_grid_test_card.dart';
import 'package:ielts_dashboard/home_module/controller/dashboard_controller.dart';
import 'package:ielts_dashboard/home_module/controller/my_task_controller.dart';
import 'package:ielts_dashboard/navigation/ielts_go_paths.dart';
import 'package:lottie/lottie.dart';
import 'package:utilities/components/blurry_container.dart';
import 'package:utilities/components/custom_tab_bar.dart';
import 'package:utilities/side_drawer/default_app_drawer_controller.dart';
import 'package:utilities/packages/smooth_rectangular_border.dart';
import 'package:utilities/services/fcm_notification_service.dart';
import 'package:utilities/theme/app_box_decoration.dart';
import 'package:utilities/theme/app_colors.dart';

final _dashboardController = Get.put(DashboardController());
final _myTasksController = Get.put(MyTasksController());
final _defaultCustomDrawerController = Get.put(GetMenuItemsController());

class IeltsDashboardView extends StatefulWidget {
  const IeltsDashboardView({super.key});

  @override
  State<IeltsDashboardView> createState() => _IeltsDashboardViewState();
}

class _IeltsDashboardViewState extends State<IeltsDashboardView> {
  final pngImages = [
    IeltsAssetPath.mockTest,
    IeltsAssetPath.practiceTest,
    IeltsAssetPath.studyMaterial,
    IeltsAssetPath.mySchedule,
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      FCMNotificationService().updateFCMToken();
      await _defaultCustomDrawerController.getMenuItems(path: "ielts");
      _myTasksController.getMyTasks();
      _dashboardController.getDashboardData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _dashboardController.obx(
      (state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: AppBoxDecoration.getBoxDecoration(
                  color: AppColors.lightSlateBlue,
                  shadowColor: AppColors.primaryColor.withOpacity(0.06),
                  borderRadius: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            state?.result?.stripData?.welcomeStripTitle ?? "-",
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            state?.result?.stripData?.welcomeStripDesc ?? "-",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        if (state?.result?.stripData?.classScheduleText != null)
                          GestureDetector(
                            onTap: () {
                              debugPrint("----------- tapped ");
                            },
                            child: BlurryContainer(
                              color: Colors.white.withOpacity(0.3),
                              blur: 1,
                              borderRadius: SmoothBorderRadius(cornerRadius: 6),
                              padding: const EdgeInsets.all(6),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.access_time_outlined,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    " ${state?.result?.stripData?.classScheduleText ?? "-"}",
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        if (state?.result?.stripData?.classStatus == true) {
                          context.pushNamed(
                            IeltsGoPaths.ieltsClassWebView,
                            extra: {
                              "leaveUrl":
                                  _dashboardController.state?.result?.stripData?.classEndLink,
                              "url": _dashboardController.state?.result?.stripData?.classButtonLink,
                              "errorLink":
                                  _dashboardController.state?.result?.stripData?.classLinkError
                            },
                          );
                          return;
                        }
                      },
                      child: Lottie.asset(
                        IeltsAssetPath.liveClass,
                        height: MediaQuery.of(context).size.height * 0.11,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              IeltsGridTestCard(
                cards: state?.result?.cards ?? [],
                images: pngImages,
              ),
              const SizedBox(height: 20),
              Container(
                decoration: AppBoxDecoration.getBoxDecoration(borderRadius: 10),
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "My Course Progress",
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.blueBayoux,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "${(state?.result?.courseProgress ?? 0 / 100).toString()}%",
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.blueBell,
                                  ),
                            ),
                          ],
                        ),
                        SvgPicture.asset(IeltsAssetPath.courseProgress)
                      ],
                    ),
                    const SizedBox(height: 12),
                    LinearProgressIndicator(
                      color: AppColors.primaryColor,
                      borderRadius: SmoothBorderRadius(
                        cornerRadius: 31,
                      ),
                      value: (state?.result?.courseProgress?.toDouble() ?? 0) / 100,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _myTasksController.obx(
                (state) {
                  return Container(
                    decoration: AppBoxDecoration.getBoxDecoration(
                      borderRadius: 16,
                    ),
                    padding: const EdgeInsets.all(16),
                    child: DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          const CustomTabBar(
                            isScrollable: false,
                            unselectedColor: AppColors.cadmiumRed,
                            tabList: [
                              "Today",
                              "Missed",
                            ],
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 150,
                            child: TabBarView(
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                state?.result?.today?.isEmpty == true
                                    ? const CustomErrorOrEmpty(
                                        title: "No Tasks Found",
                                      )
                                    : ListView.separated(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: state?.result?.today?.length ?? 0,
                                        itemBuilder: (context, index) {
                                          final item = state?.result?.today?[index];
                                          return Padding(
                                            padding: const EdgeInsets.all(14),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  item?.taskModule ?? "-",
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                        color: AppColors.gunMetal,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.access_time_outlined,
                                                      color: AppColors.gunMetal,
                                                      size: 18,
                                                    ),
                                                    const SizedBox(width: 2),
                                                    Text(
                                                      item?.taskType ?? "-",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall
                                                          ?.copyWith(
                                                            color: AppColors.gunMetal,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return Container(
                                            height: 2,
                                            width: double.infinity,
                                            color: Colors.black.withOpacity(0.1),
                                          );
                                        },
                                      ),
                                state?.result?.missed?.isEmpty == true
                                    ? const CustomErrorOrEmpty(title: "No Tasks Found")
                                    : ListView.separated(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: state?.result?.missed?.length ?? 0,
                                        itemBuilder: (context, index) {
                                          final item = state?.result?.missed?[index];
                                          return Padding(
                                            padding: const EdgeInsets.all(14),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    item?.taskModule ?? "-",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.copyWith(
                                                          color: AppColors.gunMetal,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context).size.width * 0.35,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      const Icon(
                                                        Icons.access_time_outlined,
                                                        color: AppColors.gunMetal,
                                                        size: 18,
                                                      ),
                                                      const SizedBox(width: 2),
                                                      Text(
                                                        item?.taskType ?? "-",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall
                                                            ?.copyWith(
                                                              color: AppColors.gunMetal,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return Container(
                                            height: 2,
                                            width: double.infinity,
                                            color: Colors.black.withOpacity(0.1),
                                          );
                                        },
                                      )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                onEmpty: const CustomErrorOrEmpty(),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: AppBoxDecoration.getBoxDecoration(
                  color: AppColors.chardonnay,
                  borderRadius: 12,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.card_giftcard_outlined,
                        ),
                        const SizedBox(width: 16),
                        Text(
                          "Free Gift Awaits You!",
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: AppColors.darkJungleGreen,
                              ),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () => context.pushNamed(GuestGoPaths.guestBuyPlans),
                      child: Row(
                        children: [
                          Text(
                            "Upgrade your account",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.mistBlue,
                                ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: AppColors.mistBlue,
                            size: 14,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: kBottomNavigationBarHeight),
            ],
          ),
        );
      },
      onError: (error) => GestureDetector(
        onTap: () => _dashboardController.getDashboardData(),
        child: Center(
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
                    Icon(
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
      ),
    );
  }
}
