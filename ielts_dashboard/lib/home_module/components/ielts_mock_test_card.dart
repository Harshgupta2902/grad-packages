import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:guest_dashboard/navigation/guest_go_paths.dart';
import 'package:guest_dashboard/test_module/controller/get_order_id_controller.dart';
import 'package:ielts_dashboard/constants/ielts_assets_path.dart';
import 'package:ielts_dashboard/home_module/controller/mock_test_details_controller.dart';
import 'package:ielts_dashboard/home_module/model/ielts_mock_test_model.dart';
import 'package:ielts_dashboard/navigation/ielts_go_paths.dart';
import 'package:utilities/app_change.dart';
import 'package:utilities/common/model/common_model.dart';
import 'package:utilities/components/enums.dart';
import 'package:utilities/components/message_scaffold.dart';
import 'package:utilities/packages/dialogs.dart';
import 'package:utilities/packages/razorpay.dart';
import 'package:utilities/theme/app_box_decoration.dart';
import 'package:utilities/theme/app_colors.dart';

final _getOrderIdController = Get.put(GetOrderIdController());
final _mockTestDetailsController = Get.put(MockTestDetailsController());

class IeltsMockTestCard extends StatelessWidget {
  const IeltsMockTestCard({
    super.key,
    this.state,
    this.free,
    this.buyMockTests,
    required this.paymentType,
    required this.testName,
  });

  final List<Tests>? state;
  final List<num>? free;
  final List<BuyMockTests>? buyMockTests;
  final num paymentType;
  final String testName;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.separated(
            itemCount: state?.length ?? 0,
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final testData = state?[index];
              final isFree = free?.contains(testData?.testId) ?? false;
              return Stack(
                clipBehavior: Clip.hardEdge,
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(16),
                    decoration: AppBoxDecoration.getBoxDecoration(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            testData?.status != "complete"
                                ? (isFree
                                    ? const SizedBox(width: 28)
                                    : checkLocked(testData?.status ?? "locked"))
                                : checkLocked(testData?.status ?? "locked"),
                            const SizedBox(width: 10),
                            Text(
                              testData?.testTitle ?? "",
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: AppColors.brightGrey, fontWeight: FontWeight.w600),
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
                                        color: getBandsTextColor(bands[index].value),
                                        fontWeight: FontWeight.w500),
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
                                            color: AppColors.brightGrey,
                                            fontWeight: FontWeight.w500),
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
                                            color: AppColors.brightGrey,
                                            fontWeight: FontWeight.w500),
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
                          isFree
                              ? GestureDetector(
                                  onTap: () async {
                                    if (AppConstants.appName == AppConstants.gradding) {
                                      Dialogs.webViewErrorDialog(
                                        context,
                                        title: "Use the desktop version to access the mock test",
                                      );
                                    } else if (AppConstants.appName == AppConstants.ieltsPrep) {
                                      if (testData?.testTitle == "Full Mock Test") {
                                        await _mockTestDetailsController
                                            .mockTestDetails(
                                          testId: testData?.encodeTestId,
                                        )
                                            .then(
                                          (value) {
                                            if (value?['status'] == 1 ||
                                                value?['result']['tests'] != []) {
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
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.9,
                                    height: 40,
                                    decoration: const BoxDecoration(
                                      gradient: GradientAppColors.goldenGradient,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Start Free Test",
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                              color: AppColors.brightGrey,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ),
                                  ),
                                )
                              : ElevatedButton(
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
                                    }
                                    else if (AppConstants.appName == AppConstants.ieltsPrep) {
                                      if (testData?.testTitle == "Full Mock Test") {
                                        await _mockTestDetailsController
                                            .mockTestDetails(
                                          testId: testData?.encodeTestId,
                                        )
                                            .then(
                                          (value) {
                                            if (value?['status'] == 1 ||
                                                value?['result']['tests'] != []) {
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
                  ),
                  if (testData?.status != "complete") ...[
                    if (isFree)
                      Positioned(
                        top: 10,
                        left: -20,
                        child: Transform.rotate(
                          angle: -45 * (3.1415926535897932 / 180),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.25,
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
                  ]
                ],
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 16);
            },
          ),
          const SizedBox(height: 20),
          if (buyMockTests?.isNotEmpty == true) ...[
            Row(
              children: [
                Flexible(
                  child: Container(
                    height: 1,
                    color: AppColors.smokeGrey50,
                    width: MediaQuery.of(context).size.width * 0.4,
                    margin: const EdgeInsets.only(right: 12),
                  ),
                ),
                Text(
                  "Buy More Mock Tests",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.nobel,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                Flexible(
                  child: Container(
                    height: 1,
                    color: AppColors.smokeGrey50,
                    width: MediaQuery.of(context).size.width * 0.4,
                    margin: const EdgeInsets.only(left: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ListView.separated(
              itemCount: buyMockTests?.length ?? 0,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final testData = buyMockTests?[index];
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
                          checkLocked("locked"),
                          const SizedBox(width: 10),
                          Text(
                            testData?.testTitle ?? "",
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: AppColors.brightGrey, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
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
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(MediaQuery.of(context).size.width, 40),
                        ),
                        onPressed: () async {
                          await _getOrderIdController.getOrderId(
                            testId: testData?.testId.toString() ?? "",
                            testTitle: testData?.testTitle,
                          );
                          final data = _getOrderIdController.state?.result;
                          if (data?.orderId != null) {
                            if (paymentType == 4) {
                              Future.delayed(
                                Duration.zero,
                                () => openRazorpay(
                                  onTap: () {
                                    debugPrint("Payment Success from mockTest cards on Tap:");
                                    context.goNamed(IeltsGoPaths.ieltsDashboard);
                                  },
                                  testName: testName,
                                  testId: testData?.testId?.toString(),
                                  testTitle: testData?.testTitle,
                                  amount: num.tryParse("${testData?.testPrice}") ?? 0,
                                  orderId: data?.orderId?.toString() ?? "",
                                  context: context,
                                  // currency: "USD",
                                  prefill: {
                                    'contact': '${data?.phone}',
                                    'email': '${data?.email}',
                                  },
                                  description: "${testData?.testTitle}",
                                ),
                              );
                            } else if (paymentType == 8) {
                              Future.delayed(
                                Duration.zero,
                                () => messageScaffold(
                                  context: context,
                                  content: "PayU Integration Coming Soon",
                                  messageScaffoldType: MessageScaffoldType.information,
                                ),
                              );
                            }
                          }
                        },
                        child: Text("Buy Now At ${testData?.testPrice}/-"),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 16);
              },
            ),
            const SizedBox(height: 20),
          ]
        ],
      ),
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

Color getBandsTextColor(num? status) {
  if (status == null) return AppColors.brightGrey;

  if (status >= 0 && status < 4) {
    return AppColors.cadmiumRed;
  } else if (status >= 4 && status < 6) {
    return AppColors.yellow;
  } else if (status >= 6 && status <= 9) {
    return AppColors.fernGreen;
  } else {
    return AppColors.brightGrey;
  }
}
