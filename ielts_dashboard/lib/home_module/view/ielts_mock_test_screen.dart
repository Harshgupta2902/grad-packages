import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ielts_dashboard/constants/ielts_assets_path.dart';
import 'package:ielts_dashboard/home_module/components/ielts_mock_test_card.dart';
import 'package:ielts_dashboard/home_module/controller/assigned_mock_test_controller.dart';
import 'package:ielts_dashboard/home_module/model/ielts_mock_test_model.dart';
import 'package:utilities/common/controller/default_controller.dart';
import 'package:utilities/components/custom_header_delegate.dart';
import 'package:utilities/components/custom_tab_bar.dart';
import 'package:utilities/components/gradding_app_bar.dart';
import 'package:utilities/components/try_again.dart';
import 'package:utilities/theme/app_box_decoration.dart';
import 'package:utilities/theme/app_colors.dart';

final _ieltsMockTestController = Get.put(AssignedMockTestController());
final defaultController = Get.put(DefaultController());

class IeltsMockTestScreen extends StatefulWidget {
  const IeltsMockTestScreen({super.key});

  @override
  State<IeltsMockTestScreen> createState() => _IeltsMockTestScreenState();
}

class _IeltsMockTestScreenState extends State<IeltsMockTestScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _ieltsMockTestController.getIeltsMockTests();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GraddingAppBar(
        backButton: true,
        showActions: false,
      ),
      body: _ieltsMockTestController.obx(
        (state) {
          return DefaultTabController(
            length: 5,
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
                              "Know How Mock Tests are made",
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
                  IeltsMockTestCard(
                    state: fullFreeTests(state?.tests),
                    free: state?.free,
                    buyMockTests: fullBuyTests(state?.buyMockTests),
                    paymentType: defaultController.state?.result?.paymentType ?? 4,
                    testName: state?.testname ?? "IELTS",
                  ),
                  IeltsMockTestCard(
                    state: listeningFreeTests(state?.tests),
                    free: state?.free,
                    buyMockTests: listeningBuyTests(state?.buyMockTests),
                    paymentType: defaultController.state?.result?.paymentType ?? 4,
                    testName: state?.testname ?? "IELTS",
                  ),
                  IeltsMockTestCard(
                    state: readingFreeTests(state?.tests),
                    free: state?.free,
                    buyMockTests: readingBuyTests(state?.buyMockTests),
                    paymentType: defaultController.state?.result?.paymentType ?? 4,
                    testName: state?.testname ?? "IELTS",
                  ),
                  IeltsMockTestCard(
                    state: writingFreeTests(state?.tests),
                    free: state?.free,
                    buyMockTests: writingBuyTests(state?.buyMockTests),
                    paymentType: defaultController.state?.result?.paymentType ?? 4,
                    testName: state?.testname ?? "IELTS",
                  ),
                  IeltsMockTestCard(
                    state: speakingFreeTests(state?.tests),
                    free: state?.free,
                    buyMockTests: speakingBuyTests(state?.buyMockTests),
                    paymentType: defaultController.state?.result?.paymentType ?? 4,
                    testName: state?.testname ?? "IELTS",
                  ),
                ],
              ),
            ),
          );
        },
        onError: (error) => TryAgain(
          onTap: () => _ieltsMockTestController.getIeltsMockTests(),
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

List<BuyMockTests>? fullBuyTests(List<BuyMockTests>? tests) {
  return tests?.where((tests) => tests.testTitle == "Full Mock Test").toList();
}

List<BuyMockTests>? listeningBuyTests(List<BuyMockTests>? tests) {
  return tests?.where((tests) => tests.testTitle == "Listening Mock Test").toList();
}

List<BuyMockTests>? speakingBuyTests(List<BuyMockTests>? tests) {
  return tests?.where((tests) => tests.testTitle == "Speaking Mock Test").toList();
}

List<BuyMockTests>? writingBuyTests(List<BuyMockTests>? tests) {
  return tests?.where((tests) => tests.testTitle == "Writing Mock Test").toList();
}

List<BuyMockTests>? readingBuyTests(List<BuyMockTests>? tests) {
  return tests?.where((tests) => tests.testTitle == "Reading Mock Test").toList();
}
