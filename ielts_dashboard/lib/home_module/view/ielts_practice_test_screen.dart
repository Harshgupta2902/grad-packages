import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ielts_dashboard/constants/ielts_assets_path.dart';
import 'package:ielts_dashboard/home_module/components/ielts_practice_test_card.dart';
import 'package:ielts_dashboard/home_module/controller/assigned_practice_test_controller.dart';
import 'package:ielts_dashboard/home_module/model/ielts_practice_test_model.dart';
import 'package:utilities/common/controller/default_controller.dart';
import 'package:utilities/components/custom_header_delegate.dart';
import 'package:utilities/components/custom_tab_bar.dart';
import 'package:utilities/components/gradding_app_bar.dart';
import 'package:utilities/components/try_again.dart';
import 'package:utilities/theme/app_box_decoration.dart';
import 'package:utilities/theme/app_colors.dart';

final defaultController = Get.put(DefaultController());
final _ieltsPracticeTestController = Get.put(AssignedPractiseTestController());

class IeltsPracticeTestScreen extends StatefulWidget {
  const IeltsPracticeTestScreen({super.key});

  @override
  State<IeltsPracticeTestScreen> createState() => _IeltsPracticeTestScreenState();
}

class _IeltsPracticeTestScreenState extends State<IeltsPracticeTestScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _ieltsPracticeTestController.getPracticeTests();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GraddingAppBar(
        backButton: true,
        showActions: false,
      ),
      body: _ieltsPracticeTestController.obx(
        (state) {
          return DefaultTabController(
            length: 5,
            initialIndex: getInitialTabIndex(state?.tests),
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverOverlapAbsorber(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverAppBar(
                    backgroundColor: Colors.transparent,
                    automaticallyImplyLeading: false,
                    expandedHeight: 170,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        decoration: AppBoxDecoration.getBorderBoxDecoration(
                          borderColor: AppColors.primaryColor,
                          showShadow: false,
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Know How Practice Tests are made",
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w600, color: AppColors.brightGrey),
                            ),
                            const SizedBox(height: 6),
                            ...List.generate(3, (index) {
                              final data = [
                                "Authentic content that closely resemble to actual IELTS exam",
                                "Continuous update and refinement to ensure relevancy and effectiveness",
                                "Detailed feedback on each test to point out mistake and scope of improvement"
                              ];
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(IeltsAssetPath.testCheck),
                                  const SizedBox(width: 6),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 2),
                                      child: Text(
                                        data[index].replaceAll("IELTS", state?.testname ?? "IELTS"),
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.brightGrey),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            })
                          ],
                        ),
                      ),
                      collapseMode: CollapseMode.parallax,
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 20)),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: CustomHeaderDelegate(
                    minExtent: 45,
                    maxExtent: 45,
                    child: Container(
                      color: AppColors.backgroundColor,
                      child: const CustomTabBar(
                        horizontalPadding: 16,
                        tabList: [
                          "Full",
                          "Listening",
                          "Reading",
                          "Writing",
                          "Speaking",
                        ],
                        isScrollable: true,
                        tabAlignment: TabAlignment.start,
                      ),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 20)),
              ],
              body: TabBarView(
                children: [
                  IeltsPracticeTestCard(
                    state: fullFreeTests(state?.tests),
                    paymentType: defaultController.state?.result?.paymentType ?? 4,
                    testName: state?.testname ?? "IELTS",
                  ),
                  IeltsPracticeTestCard(
                    state: listeningFreeTests(state?.tests),
                    paymentType: defaultController.state?.result?.paymentType ?? 4,
                    testName: state?.testname ?? "IELTS",
                  ),
                  IeltsPracticeTestCard(
                    state: readingFreeTests(state?.tests),
                    paymentType: defaultController.state?.result?.paymentType ?? 4,
                    testName: state?.testname ?? "IELTS",
                  ),
                  IeltsPracticeTestCard(
                    state: writingFreeTests(state?.tests),
                    paymentType: defaultController.state?.result?.paymentType ?? 4,
                    testName: state?.testname ?? "IELTS",
                  ),
                  IeltsPracticeTestCard(
                    state: speakingFreeTests(state?.tests),
                    paymentType: defaultController.state?.result?.paymentType ?? 4,
                    testName: state?.testname ?? "IELTS",
                  ),
                ],
              ),
            ),
          );
        },
        onError: (error) => TryAgain(
          onTap: () => _ieltsPracticeTestController.getPracticeTests(),
        ),
      ),
    );
  }
}

List<Tests>? fullFreeTests(List<Tests>? tests) {
  return tests?.where((tests) => tests.testTitle == "Full Mock Test").toList();
}

List<Tests>? listeningFreeTests(List<Tests>? tests) {
  return tests?.where((tests) => tests.testTitle == "Listening Mock Test").toList();
}

List<Tests>? speakingFreeTests(List<Tests>? tests) {
  return tests?.where((tests) => tests.testTitle == "Speaking Mock Test").toList();
}

List<Tests>? writingFreeTests(List<Tests>? tests) {
  return tests?.where((tests) => tests.testTitle == "Writing Mock Test").toList();
}

List<Tests>? readingFreeTests(List<Tests>? tests) {
  return tests?.where((tests) => tests.testTitle == "Reading Mock Test").toList();
}

int getInitialTabIndex(List<Tests>? tests) {
  List<List<Tests>?> testCategories = [
    fullFreeTests(tests),
    listeningFreeTests(tests),
    readingFreeTests(tests),
    writingFreeTests(tests),
    speakingFreeTests(tests),
  ];

  for (int i = 0; i < testCategories.length; i++) {
    if (testCategories[i]?.isNotEmpty ?? false) {
      return i;
    }
  }

  // If all test categories are empty, return index 0
  return 0;
}
