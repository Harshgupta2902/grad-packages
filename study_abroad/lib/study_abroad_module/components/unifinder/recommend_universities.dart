import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:study_abroad/constants/study_abroad_asset_paths.dart';
import 'package:study_abroad/navigation/study_abroad_go_paths.dart';
import 'package:study_abroad/study_abroad_module/models/study_abroad_dashboard_model.dart';
import 'package:utilities/theme/app_box_decoration.dart';
import 'package:utilities/theme/app_colors.dart';

class RecommendedUniversities extends StatefulWidget {
  const RecommendedUniversities({super.key, required this.university});

  final List<University>? university;

  @override
  State<RecommendedUniversities> createState() => _RecommendedUniversitiesState();
}

class _RecommendedUniversitiesState extends State<RecommendedUniversities> {
  late List<GlobalKey> expansionTileKey;
  int selectedIndex = 0;
  Map<String, String> exams = {};
  Map<String, String> intakes = {};
  @override
  void initState() {
    super.initState();
    expansionTileKey = List.generate(widget.university?.length ?? 0, (index) => GlobalKey());
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
            "Recommended Universities for You",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          ListView.separated(
            itemCount: widget.university?.length ?? 0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final university = widget.university?[index];
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
                              child: Text(
                                university?.name ?? "-",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(fontWeight: FontWeight.w600),
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
                          GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 70,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                            ),
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 4,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final List svg = [
                                StudyAbroadAssetPath.fees,
                                StudyAbroadAssetPath.ranking,
                                StudyAbroadAssetPath.intakes,
                                StudyAbroadAssetPath.intakes,
                              ];
                              final List name = ["FEES (AVG)", "RANKING", "EXAMS", "INTAKE"];
                              final List<String> data = [
                                "${university?.averageInrAmount}",
                                "${university?.qsRanking ?? "-"}",
                                "${university?.tests?.isEmpty == true ? "-" : university?.tests?[0]}",
                                "${university?.intakes?.isEmpty == true ? "-" : university?.intakes?[0]}"
                              ];

                              return Container(
                                decoration: AppBoxDecoration.getBoxDecoration(
                                  color: AppColors.whiteLilac,
                                  showShadow: false,
                                  borderRadius: 8,
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
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                              color: AppColors.primaryColor,
                                            ),
                                      ),
                                    if (index == 2)
                                      _dropdown(
                                        value: exams["${university?.id}"],
                                        hintText: data[index],
                                        data: university?.tests ?? [],
                                        onChanged: (value) {
                                          setState(() {
                                            exams["${university?.id}"] = value ?? "";
                                          });
                                        },
                                        context: context,
                                      ),
                                    if (index == 3)
                                      _dropdown(
                                        value: intakes["${university?.id}"],
                                        hintText: data[index],
                                        data: university?.intakes ?? [],
                                        onChanged: (value) {
                                          setState(() {
                                            intakes["${university?.id}"] = value ?? "";
                                          });
                                        },
                                        context: context,
                                      )
                                  ],
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 12),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              minimumSize: Size(MediaQuery.of(context).size.width, 40),
                              side: const BorderSide(
                                color: AppColors.primaryColor,
                                width: 2,
                              ),
                            ),
                            onPressed: () => context.pushNamed(
                              StudyAbroadGoPaths.universityDetails,
                              extra: {
                                'city': university?.countries?.url,
                                "university": university?.url,
                              },
                            ),
                            child: const Text(
                              "View Details",
                              textAlign: TextAlign.center,
                            ),
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
              onPressed: () => context.pushNamed(StudyAbroadGoPaths.universityFinder),
              child: const Text(
                "View More Universities",
              ),
            ),
          )
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
