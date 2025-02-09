import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:guest_dashboard/navigation/guest_go_paths.dart';
import 'package:ielts_dashboard/constants/ielts_assets_path.dart';
import 'package:ielts_dashboard/home_module/components/ielts_mock_test_card.dart';
import 'package:ielts_dashboard/home_module/controller/mock_test_details_controller.dart';
import 'package:utilities/components/gradding_app_bar.dart';
import 'package:utilities/theme/app_box_decoration.dart';
import 'package:utilities/theme/app_colors.dart';

final _mockTestDetailsController = Get.put(MockTestDetailsController());

class IeltsTestDetailsView extends StatelessWidget {
  const IeltsTestDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GraddingAppBar(
        backButton: true,
        showActions: false,
        centerTitle: false,
      ),
      body: _mockTestDetailsController.obx(
        (state) {
          return SingleChildScrollView(
              child: Column(
            children: List.generate(
              state?.result?.tests?.length ?? 0,
              (index) {
                final item = state?.result?.tests?[index];
                return Container(
                  decoration: AppBoxDecoration.getBoxDecoration(borderRadius: 16),
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Container(
                            decoration: AppBoxDecoration.getBorderBoxDecoration(
                              showShadow: false,
                              borderRadius: 50,
                              borderColor: AppColors.primaryColor.withOpacity(0.4),
                              color: AppColors.backgroundColor,
                            ),
                            padding: const EdgeInsets.all(12),
                            child: Image.asset(
                              getTestNamesForLWRS(fileName: item?.title ?? ""),
                              height: 70,
                              width: 70,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            item?.title ?? "-",
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.brightGrey,
                                ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                IeltsAssetPath.testDuration,
                                height: 30,
                                width: 30,
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Duration",
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.brightGrey,
                                        ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    item?.duration ?? "-",
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.brightGrey,
                                        ),
                                  )
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              SvgPicture.asset(
                                IeltsAssetPath.testSections,
                                height: 30,
                                width: 30,
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Section",
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.brightGrey,
                                        ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    item?.section ?? "-",
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.brightGrey,
                                        ),
                                  )
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              SvgPicture.asset(
                                IeltsAssetPath.testQuestions,
                                height: 30,
                                width: 30,
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Questions",
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.brightGrey,
                                        ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    item?.questions ?? "-",
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.brightGrey,
                                        ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      item?.testStatus == "completed"
                          ? Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    IeltsAssetPath.testComplete,
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              height: 50,
                              width: 50,
                              child: Center(
                                child: Text(
                                  "${item?.result}",
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      color: Colors.white),
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                Future.delayed(
                                  Duration.zero,
                                  () => context.pushReplacementNamed(
                                    GuestGoPaths.guestTestWebView,
                                    extra: {
                                      'url': item?.src,
                                      'successUrl': item?.successUrl,
                                    },
                                  ),
                                );
                              },
                              child: SvgPicture.asset(
                                item?.testStatus == "pending"
                                    ? IeltsAssetPath.startMockTest
                                    : IeltsAssetPath.testPending,
                                height: 50,
                                fit: BoxFit.fill,
                              ),
                            ),
                    ],
                  ),
                );
              },
            ),
          ));
        },
      ),
    );
  }
}

String getTestNamesForLWRS({required String fileName}) {
  switch (fileName.toLowerCase()) {
    case 'listening':
      return IeltsAssetPath.listening;
    case 'reading':
      return IeltsAssetPath.reading;
    case 'writing':
      return IeltsAssetPath.writing;
    case 'speaking':
      return IeltsAssetPath.speaking;
    default:
      return IeltsAssetPath.listening; // Default icon for unknown extensions
  }
}
