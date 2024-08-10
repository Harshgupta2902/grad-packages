import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:study_abroad/constants/study_abroad_asset_paths.dart';
import 'package:study_abroad/navigation/study_abroad_go_paths.dart';
import 'package:study_abroad/study_abroad_module/controller/shortlist_course_controller.dart';
import 'package:study_abroad/study_abroad_module/models/study_abroad_dashboard_model.dart';
import 'package:utilities/common/bottom_sheet/councellor_sheet.dart';
import 'package:utilities/components/enums.dart';
import 'package:utilities/components/message_scaffold.dart';
import 'package:utilities/packages/smooth_rectangular_border.dart';
import 'package:utilities/theme/app_box_decoration.dart';
import 'package:utilities/theme/app_colors.dart';

final _shortListCourseController = Get.put(ShortlistCourseController());

class CoursesViewDetailsCard extends StatefulWidget {
  const CoursesViewDetailsCard({super.key, required this.courses, required this.counsellor});

  final List<Courses>? courses;
  final Counsellor? counsellor;

  @override
  State<CoursesViewDetailsCard> createState() => _CoursesViewDetailsCardState();
}

class _CoursesViewDetailsCardState extends State<CoursesViewDetailsCard> {
  late List<GlobalKey> expansionTileKey;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    expansionTileKey = List.generate(widget.courses?.length ?? 0, (index) => GlobalKey());
  }

  openOrCloseContainer({required int index}) {
    setState(() {
      if (selectedIndex == index) {
        selectedIndex = -1;
      } else {
        selectedIndex = index;
      }
    });
    debugPrint(index.toString());

    final keyContext = expansionTileKey[index].currentContext;
    if (keyContext == null) {
      return;
    }
    Scrollable.ensureVisible(
      keyContext,
      duration: const Duration(milliseconds: 400),
      alignment: 0.6,
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recommended Courses for You",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          ListView.separated(
            itemCount: widget.courses?.length ?? 0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final course = widget.courses?[index];
              return Container(
                padding: const EdgeInsets.all(12),
                decoration: AppBoxDecoration.getBoxDecoration(),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => openOrCloseContainer(index: index),
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          key: expansionTileKey[index],
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    course?.name ?? "-",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    course?.university?.name ?? "-",
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            AnimatedRotation(
                              turns: selectedIndex == index ? 0 : .5,
                              duration: const Duration(milliseconds: 400),
                              child: const Icon(
                                Icons.keyboard_arrow_up_outlined,
                                color: AppColors.aluminium,
                                size: 22,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    AnimatedCrossFade(
                      firstChild: const SizedBox.shrink(),
                      secondChild: Column(
                        children: [
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              SvgPicture.asset(StudyAbroadAssetPath.country),
                              const SizedBox(width: 6),
                              Text(
                                "Country:",
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                course?.university?.countries?.name ?? "-",
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: AppColors.boulder,
                                      fontWeight: FontWeight.w400,
                                    ),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(StudyAbroadAssetPath.intakes),
                              const SizedBox(width: 6),
                              Text(
                                "Intakes:",
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              const SizedBox(width: 10),
                              Flexible(
                                child: Wrap(
                                  spacing: 6,
                                  runSpacing: 6,
                                  children: course?.intakes?.split(", ").map((intake) {
                                        return Container(
                                          decoration: AppBoxDecoration.getBoxDecoration(
                                            color: AppColors.asparagus.withOpacity(0.1),
                                            borderRadius: 6,
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 6, vertical: 3),
                                          child: Text(
                                            intake,
                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                  color: AppColors.fernGreen,
                                                ),
                                          ),
                                        );
                                      }).toList() ??
                                      [],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              SvgPicture.asset(StudyAbroadAssetPath.fees),
                              const SizedBox(width: 6),
                              Text(
                                "Yearly Tuition Fees:",
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "${course?.university?.countries?.symbol} ${course?.amount}",
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: AppColors.boulder,
                                      fontWeight: FontWeight.w400,
                                    ),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              SvgPicture.asset(StudyAbroadAssetPath.duration),
                              const SizedBox(width: 6),
                              Text(
                                "Duration:",
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "${course?.durationValue} ${course?.durationUnit}",
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: AppColors.boulder,
                                      fontWeight: FontWeight.w400,
                                    ),
                              )
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: OutlinedButton(
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
                                    minimumSize: Size(MediaQuery.of(context).size.width, 40),
                                  ),
                                  onPressed: () {
                                    counsellorSheet(
                                      context,
                                      phoneNumber: "${widget.counsellor?.number}",
                                      name: "${widget.counsellor?.name}",
                                    );
                                  },
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Consult Now",
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                              color: AppColors.primaryColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                      const Icon(
                                        Icons.arrow_forward,
                                        color: AppColors.primaryColor,
                                        size: 16,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Shortlist",
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                    Transform.scale(
                                      scale: 0.7,
                                      child: Switch(
                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        activeColor: AppColors.primaryColor,
                                        inactiveTrackColor: AppColors.blueHaze.withOpacity(0.2),
                                        trackOutlineColor:
                                            const MaterialStatePropertyAll(AppColors.blueHaze),
                                        value: false,
                                        onChanged: (boolValue) {
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
                                        thumbColor: const MaterialStatePropertyAll(AppColors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      crossFadeState: selectedIndex == index
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: const Duration(milliseconds: 400),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 12);
            },
          ),
          const SizedBox(height: 12),
          Center(
            child: ElevatedButton(
              onPressed: () => context.pushNamed(StudyAbroadGoPaths.courseFinder),
              child: const Text(
                "View More Courses",
              ),
            ),
          )
        ],
      ),
    );
  }
}
