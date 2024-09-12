import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_abroad/study_abroad_module/components/filter/filter_button.dart';
import 'package:study_abroad/study_abroad_module/components/filter/filter_logic.dart';
import 'package:study_abroad/study_abroad_module/components/unifinder/course_view.dart';
import 'package:study_abroad/study_abroad_module/components/unifinder/safe_courses.dart';
import 'package:study_abroad/study_abroad_module/controller/course_finder_controller.dart';
import 'package:study_abroad/study_abroad_module/controller/unifinder_filter_controller.dart';
import 'package:utilities/components/custom_error_or_empty.dart';
import 'package:utilities/components/custom_header_delegate.dart';
import 'package:utilities/components/gradding_app_bar.dart';
import 'package:utilities/components/try_again.dart';
import 'package:utilities/theme/app_colors.dart';

final _universityFilterController = Get.put(UniFinderFilterController());
final _coursesController = Get.put(CoursesUnifinderController());

class UniversityCourses extends StatefulWidget {
  const UniversityCourses({super.key, required this.postData});

  final Map<String, dynamic> postData;

  @override
  State<UniversityCourses> createState() => _UniversityCoursesState();
}

class _UniversityCoursesState extends State<UniversityCourses> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final postData = convertMapToDesiredFormat(
      widget.postData,
      '10',
      '1',
    );
    _coursesController.getCoursesApi(filterPostData: postData, offset: "1");
    _universityFilterController.getCoursesFilterApi();
    _coursesController.loadMoreCount = 1;
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
    final postData = convertMapToDesiredFormat(
      widget.postData,
      '10',
      limit.toString(),
    );
    await _coursesController.getCoursesApi(
      filterPostData: postData,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GraddingAppBar(
        backButton: true,
        showActions: false,
        title: "Courses",
      ),
      body: _coursesController.obx(
        (state) {
          return state?.result == null
              ? const Center(
                  child: CustomErrorOrEmpty(
                    title: "No Data Found \n Api Error",
                  ),
                )
              : NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: CustomHeaderDelegate(
                        minExtent: 50,
                        maxExtent: 50,
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
                                            pageFilter:
                                                _universityFilterController.state?.result?.selected,
                                            tempFilter: _universityFilterController.tempFilter,
                                            onApply: () async {
                                              _universityFilterController.tempFilter['university'] =
                                                  widget.postData['university'];
                                              final postData = convertMapToDesiredFormat(
                                                _universityFilterController.tempFilter,
                                                '10',
                                                '1',
                                              );
                                              debugPrint("filter post Data  :::::::::::$postData");
                                              await _coursesController.getCoursesApi(
                                                filterPostData: postData,
                                                hadLoad: true,
                                              );
                                            },
                                            skipFilter: true,
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
                      return CourseView(
                        courses: state?.result?.courses,
                        isLoading: _coursesController.isLoading,
                      );
                    },
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
