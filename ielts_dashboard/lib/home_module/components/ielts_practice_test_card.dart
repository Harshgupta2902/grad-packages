import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:guest_dashboard/navigation/guest_go_paths.dart';
import 'package:ielts_dashboard/constants/ielts_assets_path.dart';
import 'package:ielts_dashboard/home_module/controller/mock_test_details_controller.dart';
import 'package:ielts_dashboard/home_module/model/ielts_practice_test_model.dart';
import 'package:ielts_dashboard/navigation/ielts_go_paths.dart';
import 'package:utilities/app_change.dart';
import 'package:utilities/common/model/common_model.dart';
import 'package:utilities/components/custom_error_or_empty.dart';
import 'package:utilities/packages/dialogs.dart';
import 'package:utilities/theme/app_box_decoration.dart';
import 'package:utilities/theme/app_colors.dart';

final _mockTestDetailsController = Get.put(MockTestDetailsController());

class IeltsPracticeTestCard extends StatelessWidget {
  const IeltsPracticeTestCard({
    super.key,
    this.state,
    required this.paymentType,
    required this.testName,
  });

  final List<Tests>? state;
  final num paymentType;
  final String testName;

  @override
  Widget build(BuildContext context) {
    return state?.isEmpty == true
        ? const CustomErrorOrEmpty(
            title: "No Practice Test Assigned Yet",
          )
        : ListView.separated(
            itemCount: state?.length ?? 0,
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final testData = state?[index];
              return Container(
                clipBehavior: Clip.hardEdge,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(16),
                decoration: AppBoxDecoration.getBoxDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        checkLocked(testData?.status ?? "locked"),
                        const SizedBox(width: 10),
                        Text(
                          testData?.testTitle ?? "",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: AppColors.brightGrey, fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
                        if (testData?.status == "complete")
                          Container(
                            decoration: AppBoxDecoration.getBoxDecoration(
                              color: AppColors.asparagus.withOpacity(0.1),
                              borderRadius: 6,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                            child: Text(
                              "${testData?.band ?? 0} Band",
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.fernGreen,
                                  ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    if (testData?.status == "complete" || testData?.band != null) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(4, (index) {
                          final bands = [
                            KeyValuePair(key: "L", value: testData?.listeningTestScore),
                            KeyValuePair(key: "W", value: testData?.writingTestScore),
                            KeyValuePair(key: "R", value: testData?.readingTestScore),
                            KeyValuePair(key: "S", value: testData?.speakingTestScore),
                          ];
                          return Row(
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                decoration: AppBoxDecoration.getBorderBoxDecoration(
                                  showShadow: false,
                                  color: AppColors.nobel.withOpacity(0.2),
                                  borderColor: AppColors.nobel,
                                  borderRadius: 40,
                                ),
                                child: Center(
                                  child: Text(bands[index].key),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                bands[index].value.toString(),
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: AppColors.brightGrey, fontWeight: FontWeight.w500),
                              )
                            ],
                          );
                        }),
                      ),
                    ] else ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(IeltsAssetPath.duration),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Duration",
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: AppColors.brightGrey, fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "${testData?.testDuration}",
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: Colors.black.withOpacity(0.5),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(IeltsAssetPath.section),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    testData?.testTitle == "Full Mock Test"
                                        ? "Sections"
                                        : "Questions",
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: AppColors.brightGrey, fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    testData?.testTitle == "Full Mock Test"
                                        ? "4"
                                        : "${testData?.testQuestion}",
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: Colors.black.withOpacity(0.5),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                    if (testData?.status != "complete") ...[
                      const SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(MediaQuery.of(context).size.width, 40),
                        ),
                        onPressed: () async {
                          if (AppConstants.appName == AppConstants.gradding) {
                            Dialogs.webViewErrorDialog(
                              context,
                              title: "Use the desktop version to access the mock test",
                            );
                            return;
                          } else if (AppConstants.appName == AppConstants.ieltsPrep) {
                            if (testData?.testTitle == "Full Mock Test") {
                              await _mockTestDetailsController
                                  .mockTestDetails(
                                testId: testData?.encodeTestId,
                              )
                                  .then(
                                (value) {
                                  if (value?['status'] == 1 || value?['result']['tests'] != []) {
                                    context.pushNamed(IeltsGoPaths.ieltsExercise);
                                  }
                                },
                              );
                            } else {
                              context.pushReplacementNamed(
                                GuestGoPaths.guestTestWebView,
                                extra: {
                                  'url': testData?.src,
                                  'successUrl': testData?.successUrl,
                                },
                              );
                            }
                          }
                        },
                        child: const Text("Start Now"),
                      ),
                    ]
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 16);
            },
          );
  }
}

Widget checkLocked(String status) {
  switch (status) {
    case 'complete':
      return SvgPicture.asset(IeltsAssetPath.completed);
    case 'pending':
      return SvgPicture.asset(IeltsAssetPath.open);
    case 'locked':
      return SvgPicture.asset(IeltsAssetPath.close);
    default:
      return SvgPicture.asset(IeltsAssetPath.close);
  }
}
