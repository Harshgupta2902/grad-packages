import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_abroad/study_abroad_module/components/filter/filter_button.dart';
import 'package:study_abroad/study_abroad_module/components/filter/filter_logic.dart';
import 'package:study_abroad/study_abroad_module/components/university/university_card.dart';
import 'package:study_abroad/study_abroad_module/components/university/university_load_more_shimmer.dart';
import 'package:study_abroad/study_abroad_module/controller/unifinder_filter_controller.dart';
import 'package:study_abroad/study_abroad_module/controller/university_finder_controller.dart';
import 'package:utilities/components/button_loader.dart';
import 'package:utilities/components/custom_error_or_empty.dart';
import 'package:utilities/components/custom_header_delegate.dart';
import 'package:utilities/components/gradding_app_bar.dart';
import 'package:utilities/components/skeleton.dart';
import 'package:utilities/components/try_again.dart';
import 'package:utilities/packages/smooth_rectangular_border.dart';
import 'package:utilities/theme/app_box_decoration.dart';
import 'package:utilities/theme/app_colors.dart';

final _universityController = Get.put(UniversityUnifinderController());
final _universityFilterController = Get.put(UniFinderFilterController());

class UniversityUnifinder extends StatefulWidget {
  const UniversityUnifinder({super.key});

  @override
  State<UniversityUnifinder> createState() => _UniversityUnifinderState();
}

class _UniversityUnifinderState extends State<UniversityUnifinder> {
  Map<String, String> exams = {};
  Map<String, String> intakes = {};
  String currency = 'INR';
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _universityController.getUniversityApi(offset: '1', currency: currency);
    _universityController.loadMoreCount = 1;
    _universityFilterController.getUniversityFilterApi();
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
    limit += _universityController.loadMoreCount;
    _universityController.loadMoreCount += 1;
    await _universityController.getUniversityApi(offset: limit.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GraddingAppBar(
        backButton: true,
      ),
      body: _universityController.obx(
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
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: CustomHeaderDelegate(
                          minExtent: 60,
                          maxExtent: 60,
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
                                        text: "${state?.result?.totalUniversity}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(fontWeight: FontWeight.w500),
                                        children: [
                                          TextSpan(
                                            text: " Universities Found",
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
                                                await _universityController.getUniversityApi(
                                                  filterPostData: postData,
                                                  offset: "1",
                                                );
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
                            if (_universityController.isLoading.value == false) {
                              _loadMoreData();
                            }
                          }
                        });
                        return state?.result?.university?.isEmpty == true
                            ? const CustomErrorOrEmpty(title: "No Universities Found")
                            : SingleChildScrollView(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  children: [
                                    ...List.generate(state?.result?.university?.length ?? 0,
                                        (index) {
                                      final university = state?.result?.university?[index];
                                      final universityId = '${university?.id}';
                                      return UniversityCard(
                                        currency: currency,
                                        state: university,
                                        selectedExam: exams[universityId],
                                        selectedIntake: intakes[universityId],
                                        onChangeExam: (value) {
                                          setState(() {
                                            exams[universityId] = value ?? "";
                                          });
                                        },
                                        onChangeIntake: (value) {
                                          setState(() {
                                            intakes[universityId] = value ?? "";
                                          });
                                        },
                                      );
                                    }),
                                    Obx(() {
                                      return _universityController.isLoading.value == true
                                          ? const UniversityLoadMoreShimmer()
                                          : const SizedBox.shrink();
                                    }),
                                  ],
                                ),
                              );
                      },
                    ),
                  ),
                );
        },
        onError: (error) => TryAgain(
          onTap: () => _universityController.getUniversityApi(offset: '1'),
        ),
      ),
    );
  }
}
