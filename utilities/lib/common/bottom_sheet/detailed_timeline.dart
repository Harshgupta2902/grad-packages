import 'package:flutter/material.dart';
import 'package:study_abroad/study_abroad_module/models/application_manager_model.dart';
import 'package:utilities/packages/another_stepper.dart';
import 'package:utilities/packages/smooth_rectangular_border.dart';
import 'package:utilities/theme/app_colors.dart';

void detailedTimelineSheet(BuildContext context, {required List<Timeline>? timeline}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    constraints: BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height * 0.6,
      minHeight: MediaQuery.of(context).size.height * 0.5,
    ),
    shape: const SmoothRectangleBorder(
      borderRadius: SmoothBorderRadius.vertical(
        top: SmoothRadius(cornerRadius: 16, cornerSmoothing: 1.0),
      ),
    ),
    builder: (BuildContext context) {
      return DetailedTimelineSheet(
        timeline: timeline,
      );
    },
  );
}

class DetailedTimelineSheet extends StatefulWidget {
  const DetailedTimelineSheet({
    super.key,
    this.timeline,
  });
  final List<Timeline>? timeline;
  @override
  DetailedTimelineSheetState createState() => DetailedTimelineSheetState();
}

class DetailedTimelineSheetState extends State<DetailedTimelineSheet> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: AnotherStepper(
        timings: List.generate(widget.timeline?.length ?? 0, (index) {
          return widget.timeline?[index].createdDate;
        }),
        stepperList: List.generate(widget.timeline?.length ?? 0, (index) {
          return StepperData(
            subtitle: StepperText(widget.timeline?[index].name ?? ""),
          );
        }),
        activeBarColor: AppColors.darkMintGreen,
        inActiveBarColor: AppColors.cadetGrey,
        activeIndex: getFirstNullIndex(widget.timeline),
      ),
    );
  }
}

int getFirstNullIndex(List<Timeline>? timing) {
  for (int i = 0; i < (timing?.length ?? 0); i++) {
    if (timing?[i].createdDate == null) {
      return i - 1;
    }
  }
  return -1;
}
