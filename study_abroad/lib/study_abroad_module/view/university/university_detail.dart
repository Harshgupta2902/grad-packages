import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:study_abroad/constants/study_abroad_asset_paths.dart';
import 'package:study_abroad/study_abroad_module/components/university/benefits_card.dart';
import 'package:study_abroad/study_abroad_module/components/university/overview_detail.dart';
import 'package:study_abroad/study_abroad_module/components/university/read_more.dart';
import 'package:study_abroad/study_abroad_module/controller/university_details_controller.dart';
import 'package:study_abroad/study_abroad_module/models/university_details_model.dart';
import 'package:utilities/common/bottom_sheet/book_session_sheet.dart';
import 'package:utilities/common/model/common_model.dart';
import 'package:utilities/components/cached_image_network_container.dart';
import 'package:utilities/components/custom_header_delegate.dart';
import 'package:utilities/components/custom_tab_bar.dart';
import 'package:utilities/components/gradding_app_bar.dart';
import 'package:utilities/packages/smooth_rectangular_border.dart';
import 'package:utilities/theme/app_box_decoration.dart';
import 'package:utilities/theme/app_colors.dart';

final universityDetailsController = Get.put(UniversityDetailsController());

class UniversityDetailsScreen extends StatefulWidget {
  const UniversityDetailsScreen({super.key, required this.city, required this.university});

  final String city;
  final String university;

  @override
  State<UniversityDetailsScreen> createState() => _UniversityDetailsScreenState();
}

class _UniversityDetailsScreenState extends State<UniversityDetailsScreen> {
  @override
  void initState() {
    universityDetailsController.getDetails(city: widget.city, university: widget.university);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GraddingAppBar(
        backButton: true,
        showActions: false,
      ),
      body: universityDetailsController.obx((state) {
        return DefaultTabController(
          length: 7,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      CachedImageNetworkContainer(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.25,
                        url: state?.result?.images?[0],
                        placeHolder: buildPlaceholderSVG(assetPath: StudyAbroadAssetPath.word),
                      ),
                      const SizedBox(height: 16),
                      RichText(
                        text: TextSpan(
                          text: "Study Faster & Better with ",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                          children: [
                            TextSpan(
                              text: state?.result?.name,
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  color: AppColors.primaryColor, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      ReadMoreText(subtitle: state?.result?.description),
                      const SizedBox(height: 16),
                      const BenefitsCard(),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverPersistentHeader(
                  pinned: true,
                  delegate: CustomHeaderDelegate(
                    minExtent: 74,
                    maxExtent: 74,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      child: const CustomTabBar(
                        tabAlignment: TabAlignment.start,
                        isScrollable: true,
                        borderRadius: 8,
                        height: 44,
                        tabList: [
                          "Overview",
                          "Courses & Fees",
                          "Admissions",
                          "Accommodation",
                          "Gallery",
                          "Rankings",
                          "FAQ's",
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TabBarView(
                children: [
                  OverViewDetail(result: state?.result),
                  OverViewDetail(result: state?.result),
                  OverViewDetail(result: state?.result),
                  OverViewDetail(result: state?.result),
                  OverViewDetail(result: state?.result),
                  OverViewDetail(result: state?.result),
                  OverViewDetail(result: state?.result),
                ],
              ),
            ),
          ),
        );
      }),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: GestureDetector(
          onTap: () => bookSessionSheet(context, service: ""),
          child: Container(
            height: 55,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              border: Border.all(color: AppColors.primaryColor),
              borderRadius: SmoothBorderRadius(cornerRadius: 14),
            ),
            child: Center(
              child: Text(
                "Talk to University Experts",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.w600, color: AppColors.white),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
