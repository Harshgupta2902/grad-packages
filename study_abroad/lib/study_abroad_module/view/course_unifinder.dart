import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:study_abroad/constants/study_abroad_asset_paths.dart';
import 'package:study_abroad/study_abroad_module/components/filter/filter_button.dart';
import 'package:study_abroad/study_abroad_module/components/filter/filter_logic.dart';
import 'package:study_abroad/study_abroad_module/components/unifinder/course_view.dart';
import 'package:study_abroad/study_abroad_module/components/unifinder/safe_courses.dart';
import 'package:study_abroad/study_abroad_module/controller/course_finder_controller.dart';
import 'package:study_abroad/study_abroad_module/controller/unifinder_filter_controller.dart';
import 'package:utilities/common/bottom_sheet/book_session_sheet.dart';
import 'package:utilities/components/custom_error_or_empty.dart';
import 'package:utilities/components/custom_header_delegate.dart';
import 'package:utilities/components/gradding_app_bar.dart';
import 'package:utilities/components/try_again.dart';
import 'package:utilities/packages/smooth_rectangular_border.dart';
import 'package:utilities/theme/app_colors.dart';

final _coursesController = Get.put(CoursesUnifinderController());
final _universityFilterController = Get.put(UniFinderFilterController());

class CourseUnifinder extends StatefulWidget {
  const CourseUnifinder({super.key});

  @override
  State<CourseUnifinder> createState() => _CourseUnifinderState();
}

class _CourseUnifinderState extends State<CourseUnifinder> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _coursesController.getCoursesApi(
      offset: '1',
    );
    _coursesController.loadMoreCount = 1;
    _universityFilterController.getCoursesFilterApi();
    scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      debugPrint(scrollController.position.pixels.toString());
      debugPrint(scrollController.position.maxScrollExtent.toString());
      _loadMoreData();
    }
  }

  void _loadMoreData() async {
    debugPrint("load more satrrt");
    var limit = 1;
    limit += _coursesController.loadMoreCount;
    _coursesController.loadMoreCount += 1;
    await _coursesController.getCoursesApi(
      offset: limit.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GraddingAppBar(
        backButton: true,
      ),
      body: _coursesController.obx(
        (state) {
          return state?.result == null
              ? const Center(
                  child: CustomErrorOrEmpty(
                    title: "No Data Found \n Api Error",
                  ),
                )
              : DefaultTabController(
                  length: 4,
                  child: NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) => [
                      SliverOverlapAbsorber(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                        sliver: SliverAppBar(
                          backgroundColor: Colors.transparent,
                          automaticallyImplyLeading: false,
                          expandedHeight: 160,
                          flexibleSpace: FlexibleSpaceBar(
                            background: Container(
                              margin: const EdgeInsets.only(bottom: 10, left: 16, right: 16),
                              decoration: BoxDecoration(
                                gradient: GradientAppColors.courseFinderCardGradient,
                                borderRadius: SmoothBorderRadius(cornerRadius: 10),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Tuition fee may vary so, get in touch with India’s finest experts to budget your study abroad journey",
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        color: AppColors.white, fontWeight: FontWeight.w500),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: AppColors.jewel,
                                      minimumSize: const Size(double.infinity, 40),
                                    ),
                                    onPressed: () => bookSessionSheet(context, service: ""),
                                    child: const Text("Assign Me an Expert"),
                                  )
                                ],
                              ),
                            ),
                            collapseMode: CollapseMode.parallax,
                          ),
                        ),
                      ),
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: CustomHeaderDelegate(
                          minExtent: 120,
                          maxExtent: 120,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            color: AppColors.backgroundColor,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: "${state?.result?.totalCourses}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(fontWeight: FontWeight.w500),
                                        children: [
                                          TextSpan(
                                            text: " Courses Found",
                                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.blueGrey),
                                          ),
                                        ],
                                      ),
                                    ),
                                    FilterButton(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => FilterLogic(
                                              pageFilter: _universityFilterController
                                                  .state?.result?.selected,
                                              tempFilter: _universityFilterController.tempFilter,
                                              onApply: () async {
                                                final postData = convertMapToDesiredFormat(
                                                  _universityFilterController.tempFilter,
                                                  '10',
                                                  '1',
                                                );
                                                debugPrint(postData.toString());
                                                await _coursesController.getCoursesApi(
                                                    filterPostData: postData, offset: "1");
                                              },
                                              filterList: _universityFilterController
                                                      .state?.result?.filters ??
                                                  [],
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  margin: const EdgeInsets.symmetric(vertical: 10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.35),
                                            spreadRadius: 0.0,
                                            blurRadius: 0.0,
                                            offset: const Offset(0, 0),
                                          ),
                                          const BoxShadow(
                                            color: Colors.white,
                                            spreadRadius: -2.0,
                                            blurRadius: 10.0,
                                          ),
                                        ],
                                      ),
                                      child: TabBar(
                                        tabAlignment: TabAlignment.start,
                                        dividerColor: Colors.transparent,
                                        isScrollable: true,
                                        unselectedLabelColor: null,
                                        labelColor: Colors.white,
                                        indicatorSize: TabBarIndicatorSize.tab,
                                        padding: const EdgeInsets.all(6),
                                        indicator: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10 - 4),
                                          color: AppColors.primaryColor,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.4),
                                              spreadRadius: 0.0,
                                              blurRadius: 4.0,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        tabs: [
                                          const Tab(
                                            child: Text(
                                              "All",
                                            ),
                                          ),
                                          Tab(
                                            child: Row(
                                              children: [
                                                SvgPicture.asset(
                                                  StudyAbroadAssetPath.safe,
                                                  height: 16,
                                                ),
                                                const SizedBox(width: 6),
                                                Text(
                                                  "Safe (${state?.result?.safeCount ?? 0})",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                          color: AppColors.seaGreen,
                                                          fontWeight: FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Tab(
                                            child: Row(
                                              children: [
                                                SvgPicture.asset(
                                                  StudyAbroadAssetPath.moderate,
                                                  height: 16,
                                                ),
                                                const SizedBox(width: 6),
                                                Text(
                                                  "Moderate (${state?.result?.moderateCount ?? 0})",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                          color: AppColors.mangoOrange,
                                                          fontWeight: FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Tab(
                                            child: Row(
                                              children: [
                                                SvgPicture.asset(
                                                  StudyAbroadAssetPath.low,
                                                  height: 16,
                                                ),
                                                const SizedBox(width: 6),
                                                Text(
                                                  "Low (${state?.result?.lowCount ?? 0})",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                          color: AppColors.jasper,
                                                          fontWeight: FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                    body: Builder(
                      builder: (context) {
                        final controller = PrimaryScrollController.of(context);
                        controller.addListener(() {
                          if (controller.position.maxScrollExtent == controller.position.pixels) {
                            if (_coursesController.isLoading.value == false) {
                              _loadMoreData();
                            }
                          }
                        });
                        return Column(
                          children: [
                            Flexible(
                              child: TabBarView(
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  CourseView(
                                    courses: state?.result?.courses,
                                    isLoading: _coursesController.isLoading,
                                  ),
                                  SafeCoursesView(
                                    courses: state?.result?.safeCourses,
                                    isLoading: _coursesController.isLoading,
                                  ),
                                  SafeCoursesView(
                                    courses: state?.result?.moderateCourses,
                                    isLoading: _coursesController.isLoading,
                                  ),
                                  SafeCoursesView(
                                    courses: state?.result?.lowCourses,
                                    isLoading: _coursesController.isLoading,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                );
        },
        onError: (error) => TryAgain(
          onTap: () => _coursesController.getCoursesApi(offset: '1'),
        ),
      ),
    );
  }
}
