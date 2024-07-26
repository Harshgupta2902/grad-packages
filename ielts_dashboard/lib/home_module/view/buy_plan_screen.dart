import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:guest_dashboard/navigation/guest_go_paths.dart';
import 'package:ielts_dashboard/constants/ielts_assets_path.dart';

import 'package:ielts_dashboard/navigation/ielts_go_paths.dart';
import 'package:lottie/lottie.dart';
import 'package:utilities/components/gradding_app_bar.dart';
import 'package:utilities/theme/app_colors.dart';

class NoPlansPurchasedScreen extends StatelessWidget {
  const NoPlansPurchasedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GraddingAppBar(
        backButton: true,
        showActions: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Lottie.asset(
                IeltsAssetPath.noPlans,
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Text(
                "No Plans Purchased",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkJungleGreen,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: kToolbarHeight + kToolbarHeight),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width * 0.6, 60),
                ),
                onPressed: () {
                  context.pushReplacementNamed(GuestGoPaths.guestBuyPlans);
                },
                child: Text(
                  "Buy Plans",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () => context.pushReplacementNamed(IeltsGoPaths.ieltsDashboard),
                child: Text(
                  "Back to Dashboard",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
