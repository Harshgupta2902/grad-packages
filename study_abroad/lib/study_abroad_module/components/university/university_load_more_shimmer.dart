import 'package:flutter/material.dart';
import 'package:utilities/components/skeleton.dart';
import 'package:utilities/theme/app_box_decoration.dart';
import 'package:utilities/theme/app_colors.dart';

class UniversityLoadMoreShimmer extends StatelessWidget {
  const UniversityLoadMoreShimmer({super.key});

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
          SkeletonWidget(
            borderRadius: 4,
            height: 16,
            width: MediaQuery.of(context).size.width * 0.7,
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.center,
            child: Wrap(
              runSpacing: 25,
              spacing: 25,
              children: List.generate(4, (index) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.37,
                  decoration: AppBoxDecoration.getBoxDecoration(
                    color: AppColors.whiteLilac,
                    showShadow: false,
                    borderRadius: 7,
                  ),
                  padding: const EdgeInsets.all(10),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SkeletonWidget(height: 12, width: 12, borderRadius: 4),
                          SizedBox(width: 6),
                          SkeletonWidget(height: 12, width: 80, borderRadius: 4),
                        ],
                      ),
                      SizedBox(height: 6),
                      SkeletonWidget(height: 12, width: 80, borderRadius: 4),
                    ],
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SkeletonWidget(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.38,
              ),
              SkeletonWidget(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.38,
              ),
            ],
          )
        ],
      ),
    );
  }
}
