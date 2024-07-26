import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:study_abroad/constants/study_abroad_asset_paths.dart';
import 'package:study_abroad/study_abroad_module/components/unifinder/courses_card.dart';
import 'package:study_abroad/study_abroad_module/controller/application_manager_controller.dart';
import 'package:study_abroad/study_abroad_module/controller/apply_course_controller.dart';
import 'package:study_abroad/study_abroad_module/models/application_manager_model.dart';
import 'package:utilities/components/enums.dart';
import 'package:utilities/components/message_scaffold.dart';

final _applyCoursesController = Get.put(ApplyCourseController());
final _applicationManagerController = Get.put(ApplicationManagerController());

class ShortListed extends StatefulWidget {
  const ShortListed({super.key, required this.shortlistCourses});
  final List<ShortlistedCourses>? shortlistCourses;

  @override
  State<ShortListed> createState() => _ShortListedState();
}

class _ShortListedState extends State<ShortListed> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: MediaQuery.of(context).size.height,
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
      padding: const EdgeInsets.all(10),
      child: widget.shortlistCourses?.isNotEmpty == true
          ? SingleChildScrollView(
              child: Column(
                children: [
                  ...List.generate(widget.shortlistCourses?.length ?? 0, (index) {
                    final courses = widget.shortlistCourses?[index].course;
                    return CoursesCard(
                      courseName: courses?.name,
                      universityName: courses?.university?.name,
                      country: courses?.university?.countries?.name,
                      intakes: courses?.intakes,
                      duration: "${courses?.durationValue} ${courses?.durationUnit}",
                      fees: "${courses?.currency} ${courses?.amount}",
                      applyNowOnTap: () {
                        _applyCoursesController
                            .applyCourse(
                                courseId: "${widget.shortlistCourses?[index].courseId}",
                                universityId: "${courses?.universityId}",
                                id: widget.shortlistCourses?[index].id?.toString() ?? "")
                            .then((value) {
                          if (value['status'].toString() == "1") {
                            messageScaffold(
                              context: context,
                              content: value['message'].toString(),
                              messageScaffoldType: MessageScaffoldType.success,
                            );
                            _applicationManagerController.getApplications();
                            return;
                          } else {
                            messageScaffold(
                              context: context,
                              content: value['message'].toString(),
                              messageScaffoldType: MessageScaffoldType.error,
                            );
                            return;
                          }
                        });
                      },
                      typeCard: ApplicationStage.shortlisted,
                    );
                  })
                ],
              ),
            )
          : Column(
              children: [
                const SizedBox(height: kToolbarHeight + kToolbarHeight),
                Lottie.asset(StudyAbroadAssetPath.noCourseFoundLottie, height: 120),
                const SizedBox(height: 20),
                Text(
                  "No Courses Shortlisted",
                  style: Theme.of(context).textTheme.titleMedium,
                )
              ],
            ),
    );
  }
}
