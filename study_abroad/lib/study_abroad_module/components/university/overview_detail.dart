import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:study_abroad/constants/study_abroad_asset_paths.dart';
import 'package:study_abroad/study_abroad_module/models/university_details_model.dart';
import 'package:utilities/common/model/common_model.dart';
import 'package:utilities/theme/app_box_decoration.dart';
import 'package:utilities/theme/app_colors.dart';

class OverViewDetail extends StatelessWidget {
  const OverViewDetail({super.key, this.result});

  final Result? result;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 70),
          Container(
            color: AppColors.white,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                        StudyAbroadAssetPath.crossBgOverview,
                      ),
                    ),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: 4,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        mainAxisExtent: 60,
                        crossAxisSpacing: 12),
                    itemBuilder: (context, index) {
                      final data = [
                        KeyValuePair(
                            key: "University Established", value: result?.overview?.establishment),
                        KeyValuePair(key: "Total students", value: result?.overview?.totalStudents),
                        KeyValuePair(
                            key: "International students", value: result?.overview?.intStudents),
                        KeyValuePair(key: "QS Rankings", value: "#${result?.overview?.qsRanking}"),
                      ];
                      return Column(
                        children: [
                          Text(
                            data[index].value?.toString() ?? "",
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: AppColors.primaryColor, fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            data[index].key,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: AppColors.brightGrey),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                WhyChooseCard(
                  name: result?.name ?? "",
                  whyChooseList: result?.overview?.whyChoose ?? [],
                  services: result?.overview?.services ?? [],
                ),
                const HelpCard()
              ],
            ),
          ),
          const SizedBox(height: kBottomNavigationBarHeight + 30),
        ],
      ),
    );
  }
}

class WhyChooseCard extends StatelessWidget {
  const WhyChooseCard({super.key, required this.name, required this.whyChooseList, this.services});

  final String name;
  final List<WhyChoose> whyChooseList;
  final List<String>? services;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Why Choose $name",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.24,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(StudyAbroadAssetPath.whyChooseBgOverview),
              ),
              color: AppColors.white),
          child: ListView.builder(
            itemCount: whyChooseList.length,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final question = whyChooseList[index].header;
              final answer = whyChooseList[index].content;
              return Container(
                width: MediaQuery.of(context).size.width * 0.7,
                margin: EdgeInsets.only(left: index == 0 ? 12 : 0, right: 16, top: 16, bottom: 26),
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 10,
                        spreadRadius: 0,
                        color: Colors.black12)
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      question.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      answer.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: AppColors.brightGrey),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        ...List.generate(services?.length ?? 0, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.arrow_right, color: AppColors.boulder),
                const SizedBox(width: 4),
                Flexible(child: Text(services?[index] ?? "")),
              ],
            ),
          );
        })
      ],
    );
  }
}

class HelpCard extends StatelessWidget {
  const HelpCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppBoxDecoration.getBorderBoxDecoration(
          color: AppColors.papayaOrange.withOpacity(0.1),
          borderColor: AppColors.papayaOrange,
          borderRadius: 22),
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 26),
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            "How Gradding will help you get into the University",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            itemCount: 6,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisExtent: 100,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (context, index) {
              final data = [
                KeyValuePair(
                    key: "Exceptional Counselling",
                    value: StudyAbroadAssetPath.exceptionalCounselling),
                KeyValuePair(
                    key: "Hand-picked courses", value: StudyAbroadAssetPath.handPickedCourses),
                KeyValuePair(
                    key: "Smooth documentation", value: StudyAbroadAssetPath.smoothDocumentation),
                KeyValuePair(
                    key: "Customized study plans",
                    value: StudyAbroadAssetPath.customizedStudyPlans),
                KeyValuePair(
                    key: "Best Test Preperation", value: StudyAbroadAssetPath.bestTestPrep),
                KeyValuePair(
                    key: "Smooth Visa process", value: StudyAbroadAssetPath.smoothVisaProcess),
              ];
              return Column(
                children: [
                  SvgPicture.asset(data[index].value, height: 50),
                  const SizedBox(height: 4),
                  Text(
                    data[index].key,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  )
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
