import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:guest_dashboard/navigation/guest_go_paths.dart';
import 'package:ielts_dashboard/constants/ielts_assets_path.dart';
import 'package:ielts_dashboard/home_module/components/profile_section_tile.dart';
import 'package:ielts_dashboard/navigation/ielts_go_paths.dart';
import 'package:study_abroad/navigation/study_abroad_go_paths.dart';
import 'package:utilities/common/bottom_sheet/book_session_sheet.dart';
import 'package:utilities/common/bottom_sheet/study_material_sheet.dart';
import 'package:utilities/common/controller/profile_controller.dart';
import 'package:utilities/common/model/profile_model_data.dart';
import 'package:utilities/components/cached_image_network_container.dart';
import 'package:utilities/components/enums.dart';
import 'package:utilities/components/gradding_app_bar.dart';
import 'package:utilities/components/settings_footer.dart';
import 'package:utilities/theme/app_box_decoration.dart';
import 'package:utilities/theme/app_colors.dart';

final _profileController = Get.put(ProfileController());

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _scrollController = DraggableScrollableController();
  var _isScrolledToTop = false;
  int activeIndex = 0;

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (_scrollController.size >= 0.85) {
        setState(() {
          _isScrolledToTop = true;
        });
      } else {
        setState(() {
          _isScrolledToTop = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GraddingAppBar(
          isBlur: !_isScrolledToTop,
          bgColor: _isScrolledToTop == true ? Colors.white : null,
          showActions: true,
          backButton: true),
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.backgroundColor,
      body: _profileController.obx(
        (state) {
          return Stack(
            children: [
              _body(state?.profile),
              DraggableScrollableSheet(
                controller: _scrollController,
                snap: true,
                initialChildSize: 0.7,
                minChildSize: 0.7,
                maxChildSize: 0.90,
                builder: (context, scrollController) {
                  return _popUp(scrollController);
                },
              ),
            ],
          );
        },
      ),
    );
  }

  _body(Profile? state) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 350,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(IeltsAssetPath.morningBg),
        ),
      ),
      child: Column(
        children: [
          if (Platform.isAndroid) const SizedBox(height: kToolbarHeight + 50),
          if (Platform.isIOS) const SizedBox(height: kToolbarHeight + 70),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Investor image
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      IeltsAssetPath.profileCoverBlueBg,
                      alignment: Alignment.center,
                      width: 90,
                      height: 90,
                    ),
                    GestureDetector(
                      onTap: () => studyMaterialSheet(
                        context,
                        extensions: Extensions.image,
                        imageUrl: state?.imageUrl,
                      ),
                      child: Hero(
                        tag: "profile-image",
                        child: Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: CachedImageNetworkContainer(
                            decoration: AppBoxDecoration.getBoxDecoration(
                              borderRadius: 30,
                              color: AppColors.primaryColor,
                            ),
                            url: state?.imageUrl,
                            placeHolder: buildPlaceholder(
                              name: state?.name?[0],
                              context: context,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(width: 16),
                GestureDetector(
                  onTap: () => context.pushNamed(IeltsGoPaths.profile),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.60,
                        child: Text(
                          state?.name ?? "",
                          softWrap: true,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ),
                      if (state?.email?.isEmpty == true) ...[
                        const SizedBox(height: 4),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.60,
                          child: Text(
                            state?.email ?? "",
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
        ],
      ),
    );
  }

  _popUp(ScrollController controller) {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: _isScrolledToTop
            ? null
            : const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
      ),
      child: Column(
        children: [
          //Sheet pill
          const SizedBox(height: 8),

          Align(
            alignment: Alignment.center,
            child: AnimatedContainer(
              duration: const Duration(seconds: 1),
              height: _isScrolledToTop == false ? 6 : 0,
              width: _isScrolledToTop == false ? 42 : 0,
              decoration: const BoxDecoration(
                color: AppColors.stormDust,
                borderRadius: BorderRadius.all(
                  Radius.circular(2),
                ),
              ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              controller: controller,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: _isScrolledToTop == false ? 16 : 0),
                  Padding(
                    padding: const EdgeInsets.only(left: 22),
                    child: Text(
                      "Settings",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: Colors.black, fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // --------------------- Documents Center -------------------------------
                  ProfileSectionTile(
                    onTap: () {
                      debugPrint('Documents Center');
                      context.pushNamed(StudyAbroadGoPaths.documentsCenter);
                    },
                    title: 'Documents Center',
                    subTitle: 'View your Documents Here',
                    iconAssetPath: IeltsAssetPath.documentCenter,
                  ),

                  // --------------------- Course Finder -------------------------------
                  ProfileSectionTile(
                    onTap: () {
                      debugPrint('Course Finder');
                      context.pushNamed(StudyAbroadGoPaths.courseFinder);
                      // messageScaffold(
                      //   content: "Select",
                      //   context: context,
                      //   messageScaffoldType: MessageScaffoldType.warning,
                      // );
                    },
                    title: 'Course Finder',
                    subTitle: 'Find Your Interested Courses',
                    iconAssetPath: IeltsAssetPath.courseFinder,
                  ),

                  // // --------------------- University Finder -------------------------------
                  // ProfileSectionTile(
                  //   onTap: () {
                  //     debugPrint('University Finder');
                  //     context.pushNamed(StudyAbroadGoPaths.universityFinder);
                  //   },
                  //   title: 'University Finder',
                  //   subTitle: 'Find Your Interested University',
                  //   iconAssetPath: IeltsAssetPath.courseProgress,
                  // ),
                  // --------------------- Application Manager -------------------------------
                  ProfileSectionTile(
                    onTap: () {
                      debugPrint('Application Manager');
                      context
                          .pushNamed(StudyAbroadGoPaths.applicationManager, extra: {'tabIndex': 0});
                    },
                    title: 'Application Manager',
                    subTitle: 'Manage Shortlisted Application',
                    iconAssetPath: IeltsAssetPath.application,
                  ),

                  // --------------------- Check Pre Ielts Test Result -------------------------------
                  ProfileSectionTile(
                    onTap: () {
                      debugPrint('Check Pre Ielts Test Result');
                      context.pushNamed(GuestGoPaths.guestResultScreen);
                    },
                    title: 'Check Pre Ielts Test Result',
                    subTitle: 'Check Pre Ielts Test Result',
                    iconAssetPath: IeltsAssetPath.preIeltsTest,
                  ),
                  // --------------------- Profile -------------------------------
                  ProfileSectionTile(
                    onTap: () {
                      debugPrint('Profile');
                      context.pushNamed(IeltsGoPaths.profile);
                    },
                    title: 'Profile',
                    subTitle: 'View and Edit Profile',
                    iconAssetPath: IeltsAssetPath.profile,
                  ),

                  // --------------------- Buy Plans -------------------------------
                  ProfileSectionTile(
                    onTap: () {
                      debugPrint('Buy Plans');
                      context.pushNamed(GuestGoPaths.guestBuyPlans);
                    },
                    title: 'Buy Plans',
                    subTitle: 'Buy Plans',
                    iconAssetPath: IeltsAssetPath.plans,
                  ),

                  // --------------------- Book a Session -------------------------------
                  ProfileSectionTile(
                    onTap: () {
                      debugPrint('Book a Session');
                      bookSessionSheet(context, service: "");
                    },
                    title: 'Book a Session',
                    subTitle: 'Book a Session',
                    iconAssetPath: IeltsAssetPath.bookSession,
                  ),
                  const SizedBox(height: 20),
                  // --------------------- Footer -------------------------------
                  const Footer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
