import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:guest_dashboard/constants/guest_asset_paths.dart';
import 'package:guest_dashboard/test_module/model/guest_dashboard_model.dart';
import 'package:guest_dashboard/navigation/guest_go_paths.dart';
import 'package:utilities/packages/smooth_rectangular_border.dart';
import 'package:utilities/theme/app_box_decoration.dart';
import 'package:utilities/theme/app_colors.dart';

class BookSeatCard extends StatelessWidget {
  const BookSeatCard({super.key, this.batch});
  final Batch? batch;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: AppBoxDecoration.getBoxDecoration(color: AppColors.jasmine),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            batch?.title ?? "-",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Text(
            batch?.desc ?? "-",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 18),
          Text(
            "${((batch?.booked ?? 0) * 100).toStringAsFixed(0)}% Seats Booked",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            color: AppColors.balticSea,
            borderRadius: SmoothBorderRadius(
              cornerRadius: 4,
            ),
            backgroundColor: AppColors.tan,
            minHeight: 4,
            value: double.tryParse(batch?.booked?.toString() ?? ""),
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => context.pushNamed(GuestGoPaths.guestBuyPlans),
                child: Container(
                  height: 35,
                  width: MediaQuery.of(context).size.width * 0.65,
                  decoration: AppBoxDecoration.getBoxDecoration(
                    color: AppColors.cadmiumRed.withOpacity(0.1),
                    borderRadius: 6,
                  ),
                  child: Center(
                    child: Text(
                      "Book Your Seat Now",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColors.cadmiumRed,
                          ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                  onTap: () => context.pushNamed(GuestGoPaths.guestBuyPlans),
                  child: SvgPicture.asset(GuestAssetPath.forward)),
            ],
          )
        ],
      ),
    );
  }
}
