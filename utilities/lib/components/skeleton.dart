import 'package:flutter/material.dart';
import 'package:utilities/packages/smooth_rectangular_border.dart';

const Color black04 = Color(0x0A1D1D1D);
final Color whiteBlur = const Color(0xFFD9E7FF).withOpacity(0.3);

class SkeletonWidget extends StatelessWidget {
  final double? height, width;
  final double padding;
  final bool showLight;
  final double borderRadius;

  const SkeletonWidget({
    Key? key,
    this.height,
    this.width,
    this.padding = 8,
    this.showLight = false,
    this.borderRadius = 12,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: showLight ? whiteBlur : black04,
        borderRadius: SmoothBorderRadius.all(
          SmoothRadius(
            cornerRadius: borderRadius,
            cornerSmoothing: 10,
          ),
        ),
      ),
    );
  }
}
