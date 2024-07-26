// import 'dart:ui' show ImageFilter;
// import 'package:flutter/material.dart';
//
// class BlurryContainer extends StatelessWidget {
//   final Widget child;
//   final double? height;
//   final double? width;
//   final double elevation;
//   final double blur;
//   final EdgeInsetsGeometry padding;
//   final Color color;
//   final BorderRadius borderRadius;
//
//   const BlurryContainer({
//     Key? key,
//     required this.child,
//     this.height,
//     this.width,
//     this.blur = 5,
//     this.elevation = 0,
//     this.padding = const EdgeInsets.all(8),
//     this.color = Colors.transparent,
//     this.borderRadius = const BorderRadius.all(Radius.circular(20)),
//   }) : super(key: key);
//
//   const BlurryContainer.square({
//     Key? key,
//     required this.child,
//     double? dimension,
//     this.blur = 5,
//     this.elevation = 0,
//     this.padding = const EdgeInsets.all(8),
//     this.color = Colors.transparent,
//     this.borderRadius = const BorderRadius.all(Radius.circular(20)),
//   })  : width = dimension,
//         height = dimension,
//         super(key: key);
//
//   const BlurryContainer.expand({
//     Key? key,
//     required this.child,
//     this.blur = 5,
//     this.elevation = 0,
//     this.padding = const EdgeInsets.all(8),
//     this.color = Colors.transparent,
//     this.borderRadius = BorderRadius.zero,
//   })  : width = double.infinity,
//         height = double.infinity,
//         super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       elevation: elevation,
//       color: Colors.transparent,
//       borderRadius: borderRadius,
//       child: ClipRRect(
//         borderRadius: borderRadius,
//         child: BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
//           child: Container(
//             height: height,
//             width: width,
//             padding: padding,
//             color: color,
//             child: child,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:utilities/theme/app_colors.dart';

class BlurredContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final Widget child;

  const BlurredContainer({
    super.key,
    this.height,
    this.width,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: AppColors.whiteFrost.withOpacity(0.20),
        borderRadius: BorderRadius.circular(14),
      ),
      child: ClipRRect(
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(14),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            child: child,
          ),
        ),
      ),
    );
  }
}

class BlurryContainer extends StatelessWidget {
  /// The [child] will be shown over blurry container.
  final Widget child;

  /// [height] of blurry container.
  final double? height;

  /// [width] of blurry container.
  final double? width;

  /// [elevation] of blurry container.
  ///
  /// Defaults to `0`.
  final double elevation;

  /// The [blur] will control the amount of [sigmaX] and [sigmaY].
  ///
  /// Defaults to `5`.
  final double blur;

  /// [padding] adds the [EdgeInsetsGeometry] to given [child].
  ///
  /// Defaults to `const EdgeInsets.all(8)`.
  final EdgeInsetsGeometry padding;

  /// Background color of container.
  ///
  /// Defaults to `Colors.transparent`.
  ///
  /// The [color] you define will be shown at `0.5` opacity.
  final Color color;

  /// [borderRadius] of blurry container.
  final BorderRadius borderRadius;

  const BlurryContainer({
    Key? key,
    required this.child,
    this.height,
    this.width,
    this.blur = 5,
    this.elevation = 0,
    this.padding = const EdgeInsets.all(8),
    this.color = Colors.transparent,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
  }) : super(key: key);

  /// Creates a blurry container whose [width] and [height] are equal.
  const BlurryContainer.square({
    Key? key,
    required this.child,
    double? dimension,
    this.blur = 5,
    this.elevation = 0,
    this.padding = const EdgeInsets.all(8),
    this.color = Colors.transparent,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
  })  : width = dimension,
        height = dimension,
        super(key: key);

  /// Creates a blurry container whose [width] and [height] are equal.
  const BlurryContainer.expand({
    Key? key,
    required this.child,
    this.blur = 5,
    this.elevation = 0,
    this.padding = const EdgeInsets.all(8),
    this.color = Colors.transparent,
    this.borderRadius = BorderRadius.zero,
  })  : width = double.infinity,
        height = double.infinity,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      color: Colors.transparent,
      borderRadius: borderRadius,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            height: height,
            width: width,
            padding: padding,
            color: color,
            child: child,
          ),
        ),
      ),
    );
  }
}
