import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:study_abroad/constants/study_abroad_asset_paths.dart';
import 'package:study_abroad/study_abroad_module/components/unifinder/courses_card.dart';
import 'package:study_abroad/study_abroad_module/components/unifinder/courses_load_more_shimmer.dart';
import 'package:study_abroad/study_abroad_module/controller/course_finder_controller.dart';
import 'package:study_abroad/study_abroad_module/controller/shortlist_course_controller.dart';
import 'package:study_abroad/study_abroad_module/models/courses_unifinder_model.dart';
import 'package:utilities/common/bottom_sheet/councellor_sheet.dart';
import 'package:utilities/components/enums.dart';
import 'package:utilities/components/message_scaffold.dart';

final _shortListCourseController = Get.put(ShortlistCourseController());
final _coursesController = Get.put(CoursesUnifinderController());

class CourseView extends StatefulWidget {
  const CourseView({
    super.key,
    this.courses,
    required this.isLoading,
  });

  final List<Courses>? courses;
  final RxBool isLoading;

  @override
  State<CourseView> createState() => _CourseViewState();
}

class _CourseViewState extends State<CourseView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          if (widget.courses?.isEmpty == true) ...[
            const SizedBox(height: kToolbarHeight + kToolbarHeight),
            Lottie.asset(StudyAbroadAssetPath.noCourseFoundLottie, height: 120),
            const SizedBox(height: 20),
            Text(
              "No Courses Found",
              style: Theme.of(context).textTheme.titleMedium,
            )
          ] else ...[
            ...List.generate(widget.courses?.length ?? 0, (index) {
              final course = widget.courses?[index];
              return CoursesCard(
                courseName: course?.name,
                universityName: course?.university?.name,
                country: course?.university?.countries?.name,
                intakes: course?.intakes,
                duration: "${course?.durationValue} ${course?.durationUnit}",
                fees: "${course?.university?.countries?.symbol} ${course?.amount}",
                shortlist: course?.shortlisted,
                applied: course?.applied,
                applyNowOnTap: () {
                  counsellorSheet(
                    context,
                    phoneNumber: "${_coursesController.state?.result?.counsellor?.number}",
                    name: "${_coursesController.state?.result?.counsellor?.name}",
                  );
                },
                shortListCallBack: (boolValue) {
                  debugPrint(boolValue.toString());
                  _shortListCourseController
                      .shortlistCourse(
                    courseId: "${course?.id}",
                    status: boolValue,
                  )
                      .then((value) {
                    debugPrint(value['status'].toString());
                    if (value['status'].toString() == "1") {
                      messageScaffold(
                        context: context,
                        content: value['msg'].toString(),
                        messageScaffoldType: MessageScaffoldType.success,
                      );
                      _coursesController.getCoursesApi(offset: '1');
                      return;
                    } else {
                      messageScaffold(
                        context: context,
                        content: value['msg'].toString(),
                        messageScaffoldType: MessageScaffoldType.error,
                      );
                      return;
                    }
                  });
                },
                typeCard: ApplicationStage.course,
              );
            }),
            Obx(() {
              return widget.isLoading.value == true
                  ? const CoursesLoadMoreShimmer()
                  : const SizedBox.shrink();
            }),
          ]
        ],
      ),
    );
  }
}
