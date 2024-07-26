import 'package:flutter/material.dart';
import 'package:utilities/components/skeleton.dart';
import 'package:utilities/theme/app_box_decoration.dart';

class CoursesLoadMoreShimmer extends StatelessWidget {
  const CoursesLoadMoreShimmer({super.key});

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
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SkeletonWidget(borderRadius: 4, height: 16, width: 16),
              const SizedBox(width: 6),
              SkeletonWidget(
                  borderRadius: 4, height: 12, width: MediaQuery.of(context).size.width * 0.2),
              const SizedBox(width: 12),
              SkeletonWidget(
                  borderRadius: 4, height: 12, width: MediaQuery.of(context).size.width * 0.4),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SkeletonWidget(borderRadius: 4, height: 16, width: 16),
              const SizedBox(width: 6),
              SkeletonWidget(
                  borderRadius: 4, height: 12, width: MediaQuery.of(context).size.width * 0.2),
              const SizedBox(width: 12),
              SkeletonWidget(
                  borderRadius: 4, height: 12, width: MediaQuery.of(context).size.width * 0.4),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SkeletonWidget(borderRadius: 4, height: 16, width: 16),
              const SizedBox(width: 6),
              SkeletonWidget(
                borderRadius: 4,
                height: 12,
                width: MediaQuery.of(context).size.width * 0.2,
              ),
              const SizedBox(width: 12),
              const SkeletonWidget(
                borderRadius: 4,
                height: 16,
                width: 50,
              ),
              const SizedBox(width: 12),
              const SkeletonWidget(
                borderRadius: 4,
                height: 16,
                width: 50,
              ),
              const SizedBox(width: 12),
              const SkeletonWidget(
                borderRadius: 4,
                height: 16,
                width: 50,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SkeletonWidget(borderRadius: 4, height: 16, width: 16),
              const SizedBox(width: 6),
              SkeletonWidget(
                  borderRadius: 4, height: 12, width: MediaQuery.of(context).size.width * 0.35),
              const SizedBox(width: 12),
              SkeletonWidget(
                  borderRadius: 4, height: 12, width: MediaQuery.of(context).size.width * 0.2),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SkeletonWidget(borderRadius: 4, height: 16, width: 16),
              const SizedBox(width: 6),
              SkeletonWidget(
                borderRadius: 4,
                height: 12,
                width: MediaQuery.of(context).size.width * 0.2,
              ),
              const SizedBox(width: 10),
              SkeletonWidget(
                borderRadius: 4,
                height: 12,
                width: MediaQuery.of(context).size.width * 0.2,
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SkeletonWidget(borderRadius: 4, height: 12, width: 40),
                  SizedBox(width: 12),
                  SkeletonWidget(borderRadius: 20, height: 14, width: 35),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SkeletonWidget(borderRadius: 4, height: 12, width: 40),
                  SizedBox(width: 12),
                  SkeletonWidget(borderRadius: 20, height: 14, width: 35),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          const SkeletonWidget(
            height: 40,
            width: double.infinity,
          )
        ],
      ),
    );
  }
}
