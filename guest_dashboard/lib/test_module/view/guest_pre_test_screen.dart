import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:guest_dashboard/navigation/guest_go_paths.dart';

import 'package:guest_dashboard/test_module/controller/demo_class_link_controller.dart';
import 'package:utilities/components/gradding_app_bar.dart';
import 'package:utilities/packages/smooth_rectangular_border.dart';
import 'package:utilities/theme/app_box_decoration.dart';
import 'package:utilities/theme/app_colors.dart';

final _demoClassLinkController = Get.put(DemoClassLinkController());

class GuestPreTestScreen extends StatefulWidget {
  const GuestPreTestScreen({super.key});

  @override
  State<GuestPreTestScreen> createState() => _GuestPreTestScreenState();
}

class _GuestPreTestScreenState extends State<GuestPreTestScreen> {
  @override
  void initState() {
    super.initState();
    _demoClassLinkController.demoClassLink();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GraddingAppBar(
        backButton: true,
        showActions: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            RichText(
              text: TextSpan(
                text: "Congratulations! Welcome To ",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                children: [
                  TextSpan(
                    text: "Pre-IELTS Test",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: AppColors.cadmiumRed,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Text(
              "You are just one step away from assessing your current level of english proficiency",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.gunMetal),
            ),
            const SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: AppBoxDecoration.getBoxDecoration(borderRadius: 14, showShadow: false),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Read before you start!",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.gunMetal,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                  ),
                  const SizedBox(height: 12),
                  ...List.generate(4, (index) {
                    final content = [
                      "It consists of 4 sections : Reading, Writing, Listening and Speaking",
                      "All the sections must be attempted in one go to generate results",
                      "Ensure you have proper internet connection",
                      "Keep track of time during each section to ensure completion of all the tasks"
                    ];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.verified,
                            color: AppColors.seaGreen,
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              content[index],
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: AppColors.gunMetal,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          AppColors.swamp,
                          AppColors.atlantis,
                        ],
                      ),
                      borderRadius: SmoothBorderRadius(
                        cornerRadius: 8,
                      ),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: SmoothBorderRadius(
                            cornerRadius: 8,
                          ),
                        ),
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      onPressed: () async {
                        if (_demoClassLinkController.state?.result?.link == null) {
                          await _demoClassLinkController.demoClassLink();
                          Future.delayed(
                            Duration.zero,
                            () => context.pushReplacementNamed(
                              GuestGoPaths.guestTestWebView,
                              extra: {
                                'url': _demoClassLinkController.state?.result?.link,
                                'successUrl': _demoClassLinkController.state?.result?.successUrl,
                              },
                            ),
                          );

                          return;
                        }
                        context.pushReplacementNamed(
                          GuestGoPaths.guestTestWebView,
                          extra: {
                            'url': _demoClassLinkController.state?.result?.link,
                            'successUrl': _demoClassLinkController.state?.result?.successUrl,
                          },
                        );
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Start Now",
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 4),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.white,
                            ),
                            padding: const EdgeInsets.all(2),
                            child: const Icon(
                              Icons.arrow_forward_sharp,
                              color: AppColors.darkMintGreen,
                              size: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
