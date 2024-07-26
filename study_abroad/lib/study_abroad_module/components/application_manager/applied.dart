import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:study_abroad/constants/study_abroad_asset_paths.dart';
import 'package:study_abroad/study_abroad_module/components/application_manager/communications_card.dart';
import 'package:study_abroad/study_abroad_module/controller/get_comments_controller.dart';
import 'package:study_abroad/study_abroad_module/models/application_manager_model.dart';
import 'package:utilities/common/bottom_sheet/detailed_timeline.dart';
import 'package:utilities/packages/smooth_rectangular_border.dart';
import 'package:utilities/theme/app_box_decoration.dart';
import 'package:utilities/theme/app_colors.dart';

final _getCommentsController = Get.put(GetCommentsController());

class Applied extends StatefulWidget {
  const Applied({super.key, required this.appliedCourses});

  final List<ApplyCourses>? appliedCourses;

  @override
  State<Applied> createState() => _AppliedState();
}

class _AppliedState extends State<Applied> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.appliedCourses?.isNotEmpty == true) {
      _getCommentsController.getComments(
        applicationId: "${widget.appliedCourses?[0].card?.applicationId}",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          if (widget.appliedCourses?.isNotEmpty == true)
            SizedBox(
              height: 32,
              child: ListView.separated(
                itemCount: widget.appliedCourses?.length ?? 0,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                      _getCommentsController.getComments(
                          applicationId:
                              "${widget.appliedCourses?[selectedIndex].card?.applicationId}");
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: SmoothBorderRadius(cornerRadius: 4),
                        color: selectedIndex == index
                            ? AppColors.primaryColor.withOpacity(0.1)
                            : Colors.transparent,
                        border: Border.all(
                          color:
                              selectedIndex == index ? AppColors.primaryColor : AppColors.boulder,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                      child: Center(
                        child: Text(
                          widget.appliedCourses?[index].card?.name ?? "",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: AppColors.boulder),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(width: 12),
              ),
            ),
          const SizedBox(height: 10),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
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
            child: widget.appliedCourses?.isNotEmpty == true
                ? Column(
                    children: [
                      getTimeLineTexts(
                          timeLineData: getTimelineStatus(
                              widget.appliedCourses?[selectedIndex].timeline ?? [])),
                      Container(
                        height: 16,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              StudyAbroadAssetPath.stepperBg,
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: SmoothRectangleBorder(
                            borderRadius: SmoothBorderRadius(
                              cornerRadius: 10,
                              cornerSmoothing: 1.0,
                            ),
                          ),
                          side: const BorderSide(
                            color: AppColors.primaryColor,
                            width: 2,
                          ),
                          minimumSize: const Size(double.infinity, 40),
                        ),
                        onPressed: () => detailedTimelineSheet(
                          context,
                          timeline: widget.appliedCourses?[selectedIndex].timeline,
                        ),
                        child: Text(
                          "View Detailed Timeline",
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: AppBoxDecoration.getBoxDecoration(borderRadius: 14),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: AppBoxDecoration.getBoxDecoration(
                                color: AppColors.asparagus.withOpacity(0.1),
                                borderRadius: 6,
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                              child: Text(
                                widget.appliedCourses?[selectedIndex].card?.status ?? "",
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppColors.fernGreen,
                                    ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.appliedCourses?[selectedIndex].card?.name ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.appliedCourses?[selectedIndex].card?.universityName ?? "",
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppColors.boulder,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.appliedCourses?[selectedIndex].card?.date ?? "",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.appliedCourses?[selectedIndex].card?.applicationId
                                      .toString() ??
                                  "",
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppColors.primaryColor, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      _getCommentsController.obx((state) {
                        return CommunicationCard(
                          comments: state,
                          applicationId:
                              "${widget.appliedCourses?[selectedIndex].card?.applicationId}",
                        );
                      })
                    ],
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: kToolbarHeight + kToolbarHeight),
                      Lottie.asset(StudyAbroadAssetPath.noCourseFoundLottie, height: 120),
                      const SizedBox(height: 20),
                      Text(
                        "No Courses Applied",
                        style: Theme.of(context).textTheme.titleMedium,
                      )
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  getTimeLineTexts({required List<String> timeLineData}) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(timeLineData.length, (index) {
        return SizedBox(
          width: MediaQuery.of(context).size.width / 4,
          child: Text(
            timeLineData[index],
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: index == 0 ? AppColors.primaryColor : AppColors.osloGrey,
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        );
      }),
    );
  }
}

List<String> getTimelineStatus(List<Timeline> timeline) {
  String? activeStatus;
  String? previousStatus;
  String? nextStatus;
  String? nextToNextStatus;

  for (int i = 0; i < timeline.length; i++) {
    if (timeline[i].status == "Active") {
      activeStatus = timeline[i].name;
      if (i > 0) {
        previousStatus = timeline[i - 1].name;
      }
      if (i < timeline.length - 1) {
        nextStatus = timeline[i + 1].name;
      }
      if (i < timeline.length - 2) {
        nextToNextStatus = timeline[i + 2].name;
      }
      break;
    }
  }

  if (previousStatus == null) {
    return [activeStatus ?? "", nextStatus ?? "", nextToNextStatus ?? ""];
  } else {
    return [previousStatus, activeStatus ?? "", nextStatus ?? ""];
  }
}
