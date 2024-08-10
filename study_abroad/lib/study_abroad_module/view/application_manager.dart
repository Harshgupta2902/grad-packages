import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_abroad/study_abroad_module/components/application_manager/applied.dart';
import 'package:study_abroad/study_abroad_module/components/application_manager/shortlisted.dart';
import 'package:study_abroad/study_abroad_module/controller/application_manager_controller.dart';
import 'package:utilities/components/custom_tab_bar.dart';
import 'package:utilities/components/gradding_app_bar.dart';
import 'package:utilities/theme/app_box_decoration.dart';
import 'package:utilities/theme/app_colors.dart';

final _applicationManagerController = Get.put(ApplicationManagerController());

class ApplicationManager extends StatefulWidget {
  const ApplicationManager({super.key, this.tabIndex});
  final int? tabIndex;

  @override
  State<ApplicationManager> createState() => _ApplicationManagerState();
}

class _ApplicationManagerState extends State<ApplicationManager> {
  @override
  void initState() {
    super.initState();
    _applicationManagerController.getApplications();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const GraddingAppBar(
          backButton: true,
        ),
        body: _applicationManagerController.obx(
          (state) {
            return Container(
              width: MediaQuery.of(context).size.width,
              decoration: AppBoxDecoration.getBoxDecoration(borderRadius: 12, showShadow: false),
              padding: const EdgeInsets.symmetric(vertical: 12),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: DefaultTabController(
                initialIndex: widget.tabIndex ?? 0,
                length: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Application Manager",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Add and track all your university applications right here!",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: AppColors.cadetGrey),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const CustomTabBar(
                      borderRadius: 10,
                      tabList: [
                        "Shortlist",
                        "Applied",
                      ],
                      horizontalPadding: 16,
                    ),
                    const SizedBox(height: 10),
                    Flexible(
                      child: TabBarView(
                        children: [
                          ShortListed(shortlistCourses: state?.result?.shortlistedCourses),
                          Applied(appliedCourses: state?.result?.applyCourses),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          onError: (error) => GestureDetector(
            onTap: () => _applicationManagerController.getApplications(),
            child: Center(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Something Went Wrong!",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Try Again!",
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const Icon(
                          Icons.replay,
                          size: 22,
                          color: AppColors.primaryColor,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
