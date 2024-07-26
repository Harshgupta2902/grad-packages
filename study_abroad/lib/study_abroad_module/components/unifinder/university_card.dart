import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:study_abroad/constants/study_abroad_asset_paths.dart';
import 'package:study_abroad/study_abroad_module/models/university_unifinder_model.dart';
import 'package:utilities/packages/smooth_rectangular_border.dart';
import 'package:utilities/theme/app_box_decoration.dart';
import 'package:utilities/theme/app_colors.dart';

typedef ChangeExamCallBack = void Function(String?);
typedef ChangeIntakeCallBack = void Function(String?);
typedef ShortListCallBack = void Function(bool);

class UniversityCard extends StatelessWidget {
  const UniversityCard({
    super.key,
    this.state,
    this.selectedExam,
    this.selectedIntake,
    required this.onChangeExam,
    required this.onChangeIntake,
    required this.currency,
    this.shortlist,
    this.shortListCallBack,
  });
  final University? state;
  final String? selectedExam;
  final String currency;
  final String? selectedIntake;
  final ChangeExamCallBack onChangeExam;
  final ChangeIntakeCallBack onChangeIntake;
  final bool? shortlist;
  final ShortListCallBack? shortListCallBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 22),
      decoration: AppBoxDecoration.getBoxDecoration(borderRadius: 14),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  state?.name ?? "-",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w600, fontSize: 20),
                ),
              ),
              Row(
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
                      trackOutlineColor: const MaterialStatePropertyAll(AppColors.blueHaze),
                      value: shortlist ?? false,
                      onChanged: (value) {
                        shortListCallBack!(value);
                      },
                      thumbColor: const MaterialStatePropertyAll(AppColors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          state?.recommended == 1
              ? Container(
                  decoration: AppBoxDecoration.getBorderBoxDecoration(
                    showShadow: false,
                    borderRadius: 17,
                    borderColor: AppColors.leaf,
                    borderWidth: 0.6,
                  ),
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.leaf,
                        ),
                        padding: const EdgeInsets.all(4),
                        child: Center(
                          child: SvgPicture.asset(StudyAbroadAssetPath.recommended),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "Gradding’s RECOMMENDED",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.leaf,
                            ),
                      )
                    ],
                  ),
                )
              : const SizedBox.shrink(),
          Wrap(
            runSpacing: 10,
            spacing: 15,
            alignment: WrapAlignment.spaceBetween,
            children: List.generate(4, (index) {
              final List svg = [
                StudyAbroadAssetPath.fees,
                StudyAbroadAssetPath.ranking,
                StudyAbroadAssetPath.intakes,
                StudyAbroadAssetPath.intakes,
              ];
              final List name = ["FEES (AVG)", "RANKING", "EXAMS", "INTAKE"];
              final List data = [
                currency == 'local'
                    ? (state?.averageAmount == '0'
                        ? "-"
                        : '${state?.countries?.symbol} ${state?.averageAmount} / Year')
                    : (state?.averageInrAmount == '0' ? "-" : '₹ ${state?.averageInrAmount} / Yr'),
                "${state?.qsRanking ?? "-"}",
                "${state?.tests?.isEmpty == true ? "-" : state?.tests?[0]}",
                "${state?.intakes?.isEmpty == true ? "-" : state?.intakes?[0]}"
              ];

              return Container(
                width: MediaQuery.of(context).size.width * 0.37,
                decoration: AppBoxDecoration.getBoxDecoration(
                  color: AppColors.whiteLilac,
                  showShadow: false,
                  borderRadius: 7,
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(svg[index]),
                        const SizedBox(width: 6),
                        Text(
                          name[index],
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.boulder,
                              ),
                        )
                      ],
                    ),
                    const SizedBox(height: 6),
                    if (index == 0 || index == 1)
                      Text(
                        data[index],
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: AppColors.primaryColor,
                            ),
                      ),
                    if (index == 2)
                      _dropdown(
                        value: selectedExam,
                        hintText: data[index],
                        data: state?.tests ?? [],
                        onChanged: (value) {
                          onChangeExam(value);
                        },
                        context: context,
                      ),
                    if (index == 3)
                      _dropdown(
                        value: selectedIntake,
                        hintText: data[index],
                        data: state?.intakes ?? [],
                        onChanged: (value) {
                          onChangeIntake(value);
                        },
                        context: context,
                      )
                  ],
                ),
              );
            }),
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: ElevatedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(MediaQuery.of(context).size.width * 0.4, 40),
                    shape: SmoothRectangleBorder(
                      borderRadius: SmoothBorderRadius(
                        cornerRadius: 10,
                        cornerSmoothing: 1.0,
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Talk To Counselor",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Flexible(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(MediaQuery.of(context).size.width * 0.4, 40),
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
                  ),
                  onPressed: () {},
                  child: const Text("Apply Now"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _dropdown({
    required String hintText,
    required List<String> data,
    required void Function(String?)? onChanged,
    required BuildContext context,
    required String? value,
  }) {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        isExpanded: true,
        isDense: true,
        borderRadius: BorderRadius.circular(12),
        elevation: 2,
        hint: Text(
          hintText,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.primaryColor,
              ),
        ),
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.primaryColor,
            ),
        icon: const Icon(
          Icons.arrow_drop_down_circle_rounded,
          color: AppColors.primaryColor,
          size: 16,
        ),
        value: value,
        items: List.generate(data.length, (index) {
          return DropdownMenuItem(
            value: data[index],
            child: Text(data[index]),
          );
        }),
        onChanged: onChanged,
      ),
    );
  }
}
