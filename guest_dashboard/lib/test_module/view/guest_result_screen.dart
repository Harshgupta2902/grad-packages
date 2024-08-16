import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:guest_dashboard/constants/guest_asset_paths.dart';
import 'package:guest_dashboard/navigation/guest_go_paths.dart';
import 'package:guest_dashboard/test_module/controller/get_report_card_controller.dart';
import 'package:guest_dashboard/test_module/model/report_card_model.dart';
import 'package:ielts_dashboard/constants/ielts_assets_path.dart';
import 'package:utilities/common/model/common_model.dart';
import 'package:utilities/components/custom_error_or_empty.dart';
import 'package:utilities/components/custom_header_delegate.dart';
import 'package:utilities/components/custom_tab_bar.dart';
import 'package:utilities/components/gradding_app_bar.dart';
import 'package:utilities/components/try_again.dart';
import 'package:utilities/packages/smooth_rectangular_border.dart';
import 'package:utilities/theme/app_box_decoration.dart';
import 'package:utilities/theme/app_colors.dart';
import 'package:utilities/validators/extensions.dart';

final _getReportCardController = Get.put(GetReportCardController());

class GuestResultScreen extends StatefulWidget {
  const GuestResultScreen({super.key});

  @override
  State<GuestResultScreen> createState() => _GuestResultScreenState();
}

class _GuestResultScreenState extends State<GuestResultScreen> {
  final _scrollController = DraggableScrollableController();
  var _isScrolledToTop = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _getReportCardController.getReportCard();
      _scrollController.addListener(_onScroll);
    });
  }

  void _onScroll() {
    if (_scrollController.size >= 0.85) {
      setState(() {
        _isScrolledToTop = true;
      });
    } else {
      setState(() {
        _isScrolledToTop = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GraddingAppBar(
        isBlur: !_isScrolledToTop,
        bgColor: _isScrolledToTop == true ? Colors.white : null,
      ),
      body: _getReportCardController.obx((state) {
        if (state?.status?.toString() == "0" || state?.result == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomErrorOrEmpty(
                  title: state?.message,
                ),
                const SizedBox(height: kToolbarHeight),
                ElevatedButton(
                  onPressed: () => context.pushNamed(GuestGoPaths.guestPreTestScreen),
                  child: const Text(
                    "Start Pre-IELTS Test",
                  ),
                ),
              ],
            ),
          );
        }
        // setState(() {});
        return Stack(
          children: [
            _body(state),
            DraggableScrollableSheet(
              snap: true,
              controller: _scrollController,
              initialChildSize: 0.34,
              snapSizes: const [0.6],
              minChildSize: 0.34,
              maxChildSize: 0.9,
              builder: (context, scrollController) {
                return _sheet(state, scrollController);
              },
            ),
          ],
        );
      },
        onError: (error) => TryAgain(
          onTap: () => _getReportCardController.getReportCard(),
        ),

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _getReportCardController.state?.result == null
          ? null
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(MediaQuery.of(context).size.width, 42)),
                onPressed: () {
                  context.pushNamed(GuestGoPaths.guestBuyPlans);
                },
                child: const Text("Help me Achieve 7+ Bands"),
              ),
            ),
    );
  }

  _body(ReportCardModel? state) {
    return Container(
      decoration: BoxDecoration(
        gradient: GradientAppColors.resultGradient,
        boxShadow: [
          BoxShadow(
            color: AppColors.periwinkle.withOpacity(0.6),
            offset: const Offset(0, -6),
            blurRadius: 13,
            spreadRadius: 0,
          )
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
      child: Column(
        children: [
          const SizedBox(height: kToolbarHeight + 20),
          Stack(
            children: [
              SizedBox(
                height: 120,
                width: 120,
                child: CircularProgressIndicator(
                  value: (double.parse(state?.result?.averageBandScore ?? "0") / 8.0),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    (double.parse(state?.result?.averageBandScore ?? "0") / 8.0)
                        .getColorFromRange(),
                  ),
                  backgroundColor: AppColors.carolinaBlue,
                  strokeWidth: 12,
                ),
              ),
              Positioned(
                left: 35,
                right: 35,
                top: 25,
                bottom: 25,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "${state?.result?.averageBandScore}\n",
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: AppColors.white, fontWeight: FontWeight.w700, fontSize: 40),
                    children: [
                      TextSpan(
                        text: "/10",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: AppColors.carolinaBlue, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            "Hi Harsh,",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
            textAlign: TextAlign.center,
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: "Thank you for taking IELTS Pre-test. Your score is ",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
              children: [
                TextSpan(
                  text:
                      "${state?.result?.averageBandScore} ${num.parse(state?.result?.averageBandScore ?? "0").getEmojiFromRange()} ",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.brightSun,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                TextSpan(
                  text: "However based on your evaluation by Experts, you are more likely to ",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                ),
                TextSpan(
                  text: "score 8+ Bands ",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.brightSun,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                TextSpan(
                  text: "in such test",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Your Test Report",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                stops: const [0, 0.4, 1],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.paleAqua,
                  Colors.white.withOpacity(0.6),
                  Colors.white,
                ],
              ),
              borderRadius: SmoothBorderRadius(cornerRadius: 10),
            ),
            padding: const EdgeInsets.only(top: 4, right: 4, left: 4),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: SmoothBorderRadius(cornerRadius: 9),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: SizedBox(
                height: 74,
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: 4,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 30,
                  ),
                  itemBuilder: (context, index) {
                    final data = [
                      KeyValuePair(
                        key: "Listening",
                        value: state?.result?.bands?.listeningBand,
                      ),
                      KeyValuePair(
                        key: "Reading",
                        value: state?.result?.bands?.readingBand,
                      ),
                      KeyValuePair(
                        key: "Writing",
                        value: state?.result?.bands?.writingBand,
                      ),
                      KeyValuePair(
                        key: "Speaking",
                        value: state?.result?.bands?.speakingBand,
                      ),
                    ];
                    return SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            data[index].key,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppColors.darkGrey,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          const Icon(
                            Icons.play_arrow_rounded,
                            size: 12,
                          ),
                          const SizedBox(width: 8),
                          Container(
                            height: 30,
                            width: 34,
                            decoration: AppBoxDecoration.getBoxDecoration(
                              color: data[index].value!.getColorFromRange(),
                              showShadow: false,
                              borderRadius: 6,
                            ),
                            padding: const EdgeInsets.all(6),
                            child: Center(
                              child: Text(
                                data[index].value.toString(),
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  _sheet(ReportCardModel? state, ScrollController scrollController) {
    return AnimatedContainer(
      clipBehavior: Clip.hardEdge,
      duration: const Duration(seconds: 1),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: _isScrolledToTop
            ? null
            : const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
      ),
      child: DefaultTabController(
        length: 4,
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: CustomHeaderDelegate(
                minExtent: 20,
                maxExtent: 20,
                child: Align(
                  alignment: Alignment.center,
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    height: _isScrolledToTop == false ? 6 : 0,
                    width: _isScrolledToTop == false ? 42 : 0,
                    decoration: const BoxDecoration(
                      color: AppColors.stormDust,
                      borderRadius: BorderRadius.all(
                        Radius.circular(2),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverPersistentHeader(
              delegate: CustomHeaderDelegate(
                minExtent: 200,
                maxExtent: 200,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: AppBoxDecoration.getBoxDecoration(
                              color: AppColors.coralBlue,
                              borderRadius: 4,
                            ),
                            margin: const EdgeInsets.only(right: 12),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                            child: Text(
                              "Test taken at ${state?.result?.testTaken}",
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.primaryColor,
                                  ),
                            ),
                          ),
                          // SvgPicture.asset(
                          //   GuestAssetPath.download,
                          //   height: 26,
                          //   width: 26,
                          // ),
                          // const SizedBox(width: 14),
                          // SvgPicture.asset(
                          //   GuestAssetPath.share,
                          //   height: 26,
                          //   width: 26,
                          // ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 12),
                                Text(
                                  "Your IELTS Pre-Test Report Ananlysis",
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  "You can now download and share this report with your family and friends.  You can now get a personalized feedback from our experts for FREE!",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            child: SvgPicture.asset(
                              GuestAssetPath.reportAnalysis,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: CustomHeaderDelegate(
                minExtent: 45,
                maxExtent: 45,
                child: Container(
                  color: Colors.white,
                  child: CustomTabBar(
                    horizontalPadding: 16,
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    tabList: state?.result?.tabs ?? [],
                  ),
                ),
              ),
            ),
            SliverFillRemaining(
              fillOverscroll: true,
              hasScrollBody: true,
              child: TabBarView(
                children: List.generate(
                  state?.result?.tabs?.length ?? 0,
                  (index) {
                    final headings = [
                      KeyValuePair(
                        key: "Reading Section Analysis & Feedback",
                        value: IeltsAssetPath.reading,
                        path: state?.result?.bands?.readingBand.toString() ?? "",
                      ),
                      KeyValuePair(
                        key: "Reading Section Analysis & Feedback",
                        value: IeltsAssetPath.writing,
                        path: state?.result?.bands?.writingBand.toString() ?? "",
                      ),
                      KeyValuePair(
                        key: "Reading Section Analysis & Feedback",
                        value: IeltsAssetPath.listening,
                        path: state?.result?.bands?.listeningBand.toString() ?? "",
                      ),
                      KeyValuePair(
                        key: "Reading Section Analysis & Feedback",
                        value: IeltsAssetPath.speaking,
                        path: state?.result?.bands?.speakingBand.toString() ?? "",
                      ),
                    ];
                    return ReadingResult(
                      report: state?.result?.content?[index].report,
                      heading: headings[index],
                      currentBands: headings[index].path ?? "0",
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ReadingResult extends StatefulWidget {
  const ReadingResult({
    super.key,
    required this.currentBands,
    required this.heading,
    this.report,
  });

  final List<Report>? report;
  final String currentBands;
  final KeyValuePair heading;

  @override
  State<ReadingResult> createState() => _ReadingResultState();
}

class _ReadingResultState extends State<ReadingResult> {
  int isExpandedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: AppBoxDecoration.getBoxDecoration(
              borderRadius: 16,
            ),
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      widget.heading.value ?? "",
                      height: 22,
                    ),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        widget.heading.key ?? "",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColors.darkGrey,
                            ),
                      ),
                    )
                  ],
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    margin: const EdgeInsets.symmetric(vertical: 14),
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: AppBoxDecoration.getBoxDecoration(
                        borderRadius: 12, color: AppColors.golden),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.currentBands,
                          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        Text(
                          "Current Bands",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: AppColors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: AppBoxDecoration.getBoxDecoration(
                      borderRadius: 12,
                      color: AppColors.fernGreen,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "8+",
                          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        Text(
                          "Desired Bands for top Universities",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.white,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(top: 10),
                    itemCount: widget.report?.length ?? 0,
                    itemBuilder: (context, index) {
                      final report = widget.report?[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isExpandedIndex == index) {
                              isExpandedIndex = -1;
                            } else {
                              isExpandedIndex = index;
                            }
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      report?.category ?? "",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(color: AppColors.primaryColor),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  AnimatedRotation(
                                    turns: isExpandedIndex != index ? 0 : .125,
                                    duration: const Duration(milliseconds: 400),
                                    child: const Icon(
                                      Icons.add_circle_outlined,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              AnimatedCrossFade(
                                firstChild: Container(
                                  margin: const EdgeInsets.symmetric(vertical: 6),
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                                  decoration: AppBoxDecoration.getBorderBoxDecoration(
                                      color: AppColors.primaryColor.withOpacity(0.2),
                                      borderColor: AppColors.primaryColor.withOpacity(0.5),
                                      borderRadius: 6),
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: "Mistakes: ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(color: AppColors.cadmiumRed),
                                          children: [
                                            TextSpan(
                                              text: report?.mistake,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(color: AppColors.onyx),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      RichText(
                                        text: TextSpan(
                                          text: "Improvements: ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(color: AppColors.fernGreen),
                                          children: [
                                            TextSpan(
                                              text: report?.improvement,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(color: AppColors.onyx),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                secondChild: Container(),
                                crossFadeState: isExpandedIndex == index
                                    ? CrossFadeState.showFirst
                                    : CrossFadeState.showSecond,
                                duration: const Duration(milliseconds: 400),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Container(
                        height: 1,
                        width: MediaQuery.of(context).size.width,
                        color: AppColors.primaryColor.withOpacity(0.1),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
