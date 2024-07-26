// ignore_for_file: overridden_fields, deprecated_member_use, depend_on_referenced_packages

import 'dart:ui';
import 'package:vector_math/vector_math.dart' as vector;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../components/enums.dart';



class SmoothRectangleBorder extends OutlinedBorder {
  const SmoothRectangleBorder({
    BorderSide side = BorderSide.none,
    this.borderRadius = SmoothBorderRadius.zero,
    this.borderAlign = BorderAlign.inside,
  }) : super(side: side);

  /// The radius for each corner.
  ///
  /// Negative radius values are clamped to 0.0 by [getInnerPath] and
  /// [getOuterPath].
  final SmoothBorderRadius borderRadius;
  final BorderAlign borderAlign;

  @override
  EdgeInsetsGeometry get dimensions {
    switch (borderAlign) {
      case BorderAlign.inside:
        return EdgeInsets.all(side.width);
      case BorderAlign.center:
        return EdgeInsets.all(side.width / 2);
      case BorderAlign.outside:
        return EdgeInsets.zero;
    }
  }

  @override
  ShapeBorder scale(double t) {
    return SmoothRectangleBorder(
      side: side.scale(t),
      borderRadius: borderRadius * t,
    );
  }

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    if (a is SmoothRectangleBorder) {
      return SmoothRectangleBorder(
        side: BorderSide.lerp(a.side, side, t),
        borderRadius: SmoothBorderRadius.lerp(a.borderRadius, borderRadius, t)!,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    if (b is SmoothRectangleBorder) {
      return SmoothRectangleBorder(
        side: BorderSide.lerp(side, b.side, t),
        borderRadius: SmoothBorderRadius.lerp(borderRadius, b.borderRadius, t)!,
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    final innerRect = () {
      switch (borderAlign) {
        case BorderAlign.inside:
          return rect.deflate(side.width);
        case BorderAlign.center:
          return rect.deflate(side.width / 2);
        case BorderAlign.outside:
          return rect;
      }
    }();
    final radius = () {
      switch (borderAlign) {
        case BorderAlign.inside:
          return borderRadius -
              SmoothBorderRadius.all(
                SmoothRadius(
                  cornerRadius: side.width,
                  cornerSmoothing: 1.0,
                ),
              );
        case BorderAlign.center:
          return borderRadius -
              SmoothBorderRadius.all(
                SmoothRadius(
                  cornerRadius: side.width / 2,
                  cornerSmoothing: 1.0,
                ),
              );
        case BorderAlign.outside:
          return borderRadius;
      }
    }();

    if ([radius.bottomLeft, radius.bottomRight, radius.topLeft, radius.topRight]
        .every((x) => x.cornerSmoothing == 0.0)) {
      return Path()..addRRect(radius.resolve(textDirection).toRRect(innerRect));
    }

    return radius.toPath(innerRect);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return _getPath(rect, borderRadius, textDirection: textDirection);
  }

  Path _getPath(
    Rect rect,
    SmoothBorderRadius radius, {
    TextDirection? textDirection,
  }) {
    if ([radius.bottomLeft, radius.bottomRight, radius.topLeft, radius.topRight]
        .every((x) => x.cornerSmoothing == 0.0)) {
      return Path()..addRRect(radius.resolve(textDirection).toRRect(rect));
    }

    return radius.toPath(rect);
  }

  @override
  SmoothRectangleBorder copyWith({
    BorderSide? side,
    SmoothBorderRadius? borderRadius,
    BorderAlign? borderAlign,
  }) {
    return SmoothRectangleBorder(
      side: side ?? this.side,
      borderRadius: borderRadius ?? this.borderRadius,
      borderAlign: borderAlign ?? this.borderAlign,
    );
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    if (rect.isEmpty) return;
    switch (side.style) {
      case BorderStyle.none:
        break;
      case BorderStyle.solid:
        // Since the stroke is painted at the center, we need to adjust the rect
        // according to the [borderAlign].
        final adjustedRect = () {
          switch (borderAlign) {
            case BorderAlign.inside:
              return rect.deflate(side.width / 2);
            case BorderAlign.center:
              return rect;
            case BorderAlign.outside:
              return rect.inflate(side.width / 2);
          }
        }();
        final adjustedBorderRadius = () {
          switch (borderAlign) {
            case BorderAlign.inside:
              return borderRadius -
                  SmoothBorderRadius.all(
                    SmoothRadius(
                      cornerRadius: side.width / 2,
                      cornerSmoothing: 1.0,
                    ),
                  );
            case BorderAlign.center:
              return borderRadius;
            case BorderAlign.outside:
              return borderRadius +
                  SmoothBorderRadius.all(
                    SmoothRadius(
                      cornerRadius: side.width / 2,
                      cornerSmoothing: 1.0,
                    ),
                  );
          }
        }();

        final outerPath = _getPath(
          adjustedRect,
          adjustedBorderRadius,
          textDirection: textDirection,
        );

        canvas.drawPath(
          outerPath,
          side.toPaint(),
        );

        break;
    }
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is SmoothRectangleBorder &&
        other.side == side &&
        other.borderRadius == borderRadius &&
        other.borderAlign == borderAlign;
  }

  @override
  int get hashCode => hashValues(side, borderRadius, borderAlign);

  @override
  String toString() {
    return '${objectRuntimeType(this, 'SmoothRectangleBorder')}($side, $borderRadius, $borderAlign)';
  }
}

class SmoothRadius extends Radius {
  const SmoothRadius({
    required double cornerRadius,
    required this.cornerSmoothing,
  }) : super.circular(cornerRadius);

  final double cornerSmoothing;
  double get cornerRadius => x;

  static const zero = SmoothRadius(
    cornerRadius: 0,
    cornerSmoothing: 0,
  );

  /// Unary negation operator.
  ///
  /// Returns a Radius with the distances negated.
  ///
  /// Radiuses with negative values aren't geometrically meaningful, but could
  /// occur as part of expressions. For example, negating a radius of one pixel
  /// and then adding the result to another radius is equivalent to subtracting
  /// a radius of one pixel from the other.
  @override
  Radius operator -() => SmoothRadius(
        cornerRadius: -cornerRadius,
        cornerSmoothing: cornerSmoothing,
      );

  /// Binary subtraction operator.
  ///
  /// Returns a radius whose [x] value is the left-hand-side operand's [x]
  /// minus the right-hand-side operand's [x] and whose [y] value is the
  /// left-hand-side operand's [y] minus the right-hand-side operand's [y].
  @override
  Radius operator -(Radius other) {
    if (other is SmoothRadius) {
      return SmoothRadius(
        cornerRadius: cornerRadius - other.cornerRadius,
        cornerSmoothing: (cornerSmoothing + other.cornerSmoothing) / 2,
      );
    }
    return SmoothRadius(
      cornerRadius: cornerRadius - other.x,
      cornerSmoothing: cornerSmoothing,
    );
  }

  /// Binary addition operator.
  ///
  /// Returns a radius whose [x] value is the sum of the [x] values of the
  /// two operands, and whose [y] value is the sum of the [y] values of the
  /// two operands.
  @override
  Radius operator +(Radius other) {
    if (other is SmoothRadius) {
      return SmoothRadius(
        cornerRadius: cornerRadius + other.cornerRadius,
        cornerSmoothing: (cornerSmoothing + other.cornerSmoothing) / 2,
      );
    }
    return SmoothRadius(
      cornerRadius: cornerRadius + other.x,
      cornerSmoothing: cornerSmoothing,
    );
  }

  /// Multiplication operator.
  ///
  /// Returns a radius whose coordinates are the coordinates of the
  /// left-hand-side operand (a radius) multiplied by the scalar
  /// right-hand-side operand (a double).
  @override
  SmoothRadius operator *(double operand) => SmoothRadius(
        cornerRadius: cornerRadius * operand,
        cornerSmoothing: cornerSmoothing * operand,
      );

  /// Division operator.
  ///
  /// Returns a radius whose coordinates are the coordinates of the
  /// left-hand-side operand (a radius) divided by the scalar right-hand-side
  /// operand (a double).
  @override
  SmoothRadius operator /(double operand) => SmoothRadius(
        cornerRadius: cornerRadius / operand,
        cornerSmoothing: cornerSmoothing / operand,
      );

  /// Integer (truncating) division operator.
  ///
  /// Returns a radius whose coordinates are the coordinates of the
  /// left-hand-side operand (a radius) divided by the scalar right-hand-side
  /// operand (a double), rounded towards zero.
  @override
  SmoothRadius operator ~/(double operand) => SmoothRadius(
        cornerRadius: (cornerRadius ~/ operand).toDouble(),
        cornerSmoothing: (cornerSmoothing ~/ operand).toDouble(),
      );

  /// Modulo (remainder) operator.
  ///
  /// Returns a radius whose coordinates are the remainder of dividing the
  /// coordinates of the left-hand-side operand (a radius) by the scalar
  /// right-hand-side operand (a double).
  @override
  SmoothRadius operator %(double operand) => SmoothRadius(
        cornerRadius: cornerRadius % operand,
        cornerSmoothing: cornerSmoothing % operand,
      );

  /// Linearly interpolate between two smooth radii.
  ///
  /// If either is null, this function substitutes [SmoothRadius.zero] instead.
  ///
  /// The `t` argument represents position on the timeline, with 0.0 meaning
  /// that the interpolation has not started, returning `a` (or something
  /// equivalent to `a`), 1.0 meaning that the interpolation has finished,
  /// returning `b` (or something equivalent to `b`), and values in between
  /// meaning that the interpolation is at the relevant point on the timeline
  /// between `a` and `b`. The interpolation can be extrapolated beyond 0.0 and
  /// 1.0, so negative values and values greater than 1.0 are valid (and can
  /// easily be generated by curves such as [Curves.elasticInOut]).
  ///
  /// Values for `t` are usually obtained from an [Animation<double>], such as
  /// an [AnimationController].
  static SmoothRadius? lerp(SmoothRadius? a, SmoothRadius? b, double t) {
    if (b == null) {
      if (a == null) {
        return null;
      } else {
        final double k = 1.0 - t;
        return SmoothRadius(
          cornerRadius: a.cornerRadius * k,
          cornerSmoothing: a.cornerSmoothing * k,
        );
      }
    } else {
      if (a == null) {
        return SmoothRadius(
          cornerRadius: b.cornerRadius * t,
          cornerSmoothing: b.cornerSmoothing * t,
        );
      } else {
        return SmoothRadius(
          cornerRadius: lerpDouble(a.cornerRadius, b.cornerRadius, t) ?? 0,
          cornerSmoothing: lerpDouble(a.cornerSmoothing, b.cornerSmoothing, t) ?? 0,
        );
      }
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;

    return other is SmoothRadius &&
        other.cornerRadius == cornerRadius &&
        other.cornerSmoothing == cornerSmoothing;
  }

  @override
  int get hashCode => hashValues(cornerRadius, cornerSmoothing);

  @override
  String toString() {
    return 'SmoothRadius('
        'cornerRadius: ${cornerRadius.toStringAsFixed(2)},'
        'cornerSmoothing: ${cornerSmoothing.toStringAsFixed(2)},'
        ')';
  }
}

class SmoothBorderRadius extends BorderRadius {
  SmoothBorderRadius({
    required double cornerRadius,
    double cornerSmoothing = 1.0,
  }) : this.only(
          topLeft: SmoothRadius(
            cornerRadius: cornerRadius,
            cornerSmoothing: cornerSmoothing,
          ),
          topRight: SmoothRadius(
            cornerRadius: cornerRadius,
            cornerSmoothing: cornerSmoothing,
          ),
          bottomLeft: SmoothRadius(
            cornerRadius: cornerRadius,
            cornerSmoothing: cornerSmoothing,
          ),
          bottomRight: SmoothRadius(
            cornerRadius: cornerRadius,
            cornerSmoothing: cornerSmoothing,
          ),
        );

  /// Creates a border radius where all radii are [radius].

  const SmoothBorderRadius.all(SmoothRadius radius)
      : this.only(
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        );

  /// Creates a vertically symmetric border radius where the top and bottom
  /// sides of the rectangle have the same radii.
  const SmoothBorderRadius.vertical({
    SmoothRadius top = SmoothRadius.zero,
    SmoothRadius bottom = SmoothRadius.zero,
  }) : this.only(
          topLeft: top,
          topRight: top,
          bottomLeft: bottom,
          bottomRight: bottom,
        );

  /// Creates a horizontally symmetrical border radius where the left and right
  /// sides of the rectangle have the same radii.
  const SmoothBorderRadius.horizontal({
    SmoothRadius left = SmoothRadius.zero,
    SmoothRadius right = SmoothRadius.zero,
  }) : this.only(
          topLeft: left,
          topRight: right,
          bottomLeft: left,
          bottomRight: right,
        );

  /// Creates a border radius with only the given non-zero values. The other
  /// corners will be right angles.
  const SmoothBorderRadius.only({
    this.topLeft = SmoothRadius.zero,
    this.topRight = SmoothRadius.zero,
    this.bottomLeft = SmoothRadius.zero,
    this.bottomRight = SmoothRadius.zero,
  }) : super.only(
          topLeft: topLeft,
          bottomRight: topRight,
          topRight: topRight,
          bottomLeft: bottomLeft,
        );

  /// Returns a copy of this BorderRadius with the given fields replaced with
  /// the new values.
  @override
  SmoothBorderRadius copyWith({
    Radius? topLeft,
    Radius? topRight,
    Radius? bottomLeft,
    Radius? bottomRight,
  }) {
    return SmoothBorderRadius.only(
      topLeft: topLeft is SmoothRadius ? topLeft : this.topLeft,
      topRight: topRight is SmoothRadius ? topRight : this.topRight,
      bottomLeft: bottomLeft is SmoothRadius ? bottomLeft : this.bottomLeft,
      bottomRight: bottomRight is SmoothRadius ? bottomRight : this.bottomRight,
    );
  }

  /// A border radius with all zero radii.
  static const SmoothBorderRadius zero = SmoothBorderRadius.all(SmoothRadius.zero);

  /// The top-left [SmoothRadius].
  @override
  final SmoothRadius topLeft;

  /// The top-right [SmoothRadius].
  @override
  final SmoothRadius topRight;

  /// The bottom-left [SmoothRadius].
  @override
  final SmoothRadius bottomLeft;

  /// The bottom-right [SmoothRadius].
  @override
  final SmoothRadius bottomRight;

  /// Creates a [Path] inside the given [Rect].
  Path toPath(Rect rect) {
    final width = rect.width;
    final height = rect.height;

    final result = Path();

    /// Calculating only if values are different
    final processedTopLeft = ProcessedSmoothRadius(
      topLeft,
      width: width,
      height: height,
    );
    final processedBottomLeft = topLeft == bottomLeft
        ? processedTopLeft
        : ProcessedSmoothRadius(
            bottomLeft,
            width: width,
            height: height,
          );
    final processedBottomRight = bottomLeft == bottomRight
        ? processedBottomLeft
        : ProcessedSmoothRadius(
            bottomRight,
            width: width,
            height: height,
          );
    final processedTopRight = topRight == bottomRight
        ? processedBottomRight
        : ProcessedSmoothRadius(
            topRight,
            width: width,
            height: height,
          );

    result
      ..addSmoothTopRight(processedTopRight, rect)
      ..addSmoothBottomRight(processedBottomRight, rect)
      ..addSmoothBottomLeft(processedBottomLeft, rect)
      ..addSmoothTopLeft(processedTopLeft, rect);

    return result.transform(
      Matrix4.translationValues(rect.left, rect.top, 0).storage,
    );
  }

  @override
  BorderRadiusGeometry subtract(BorderRadiusGeometry other) {
    if (other is SmoothBorderRadius) return this - other;
    return super.subtract(other);
  }

  @override
  BorderRadiusGeometry add(BorderRadiusGeometry other) {
    if (other is SmoothBorderRadius) return this + other;
    return super.add(other);
  }

  /// Returns the difference between two [BorderRadius] objects.
  @override
  SmoothBorderRadius operator -(BorderRadius other) {
    if (other is SmoothBorderRadius) {
      return SmoothBorderRadius.only(
        topLeft: (topLeft - other.topLeft) as SmoothRadius,
        topRight: (topRight - other.topRight) as SmoothRadius,
        bottomLeft: (bottomLeft - other.bottomLeft) as SmoothRadius,
        bottomRight: (bottomRight - other.bottomRight) as SmoothRadius,
      );
    }

    return this;
  }

  /// Returns the sum of two [BorderRadius] objects.
  @override
  SmoothBorderRadius operator +(BorderRadius other) {
    if (other is SmoothBorderRadius) {
      return SmoothBorderRadius.only(
        topLeft: (topLeft + other.topLeft) as SmoothRadius,
        topRight: (topRight + other.topRight) as SmoothRadius,
        bottomLeft: (bottomLeft + other.bottomLeft) as SmoothRadius,
        bottomRight: (bottomRight + other.bottomRight) as SmoothRadius,
      );
    }
    return this;
  }

  /// Returns the [BorderRadius] object with each corner negated.
  ///
  /// This is the same as multiplying the object by -1.0.
  @override
  SmoothBorderRadius operator -() {
    return SmoothBorderRadius.only(
      topLeft: (-topLeft) as SmoothRadius,
      topRight: (-topRight) as SmoothRadius,
      bottomLeft: (-bottomLeft) as SmoothRadius,
      bottomRight: (-bottomRight) as SmoothRadius,
    );
  }

  /// Scales each corner of the [BorderRadius] by the given factor.
  @override
  SmoothBorderRadius operator *(double other) {
    return SmoothBorderRadius.only(
      topLeft: topLeft * other,
      topRight: topRight * other,
      bottomLeft: bottomLeft * other,
      bottomRight: bottomRight * other,
    );
  }

  /// Divides each corner of the [BorderRadius] by the given factor.
  @override
  SmoothBorderRadius operator /(double other) {
    return SmoothBorderRadius.only(
      topLeft: topLeft / other,
      topRight: topRight / other,
      bottomLeft: bottomLeft / other,
      bottomRight: bottomRight / other,
    );
  }

  /// Integer divides each corner of the [BorderRadius] by the given factor.
  @override
  SmoothBorderRadius operator ~/(double other) {
    return SmoothBorderRadius.only(
      topLeft: topLeft ~/ other,
      topRight: topRight ~/ other,
      bottomLeft: bottomLeft ~/ other,
      bottomRight: bottomRight ~/ other,
    );
  }

  /// Computes the remainder of each corner by the given factor.
  @override
  SmoothBorderRadius operator %(double other) {
    return SmoothBorderRadius.only(
      topLeft: topLeft % other,
      topRight: topRight % other,
      bottomLeft: bottomLeft % other,
      bottomRight: bottomRight % other,
    );
  }

  /// Linearly interpolate between two [BorderRadius] objects.
  ///
  /// If either is null, this function interpolates from [BorderRadius.zero].
  ///
  /// {@macro dart.ui.shadow.lerp}
  static SmoothBorderRadius? lerp(SmoothBorderRadius? a, SmoothBorderRadius? b, double t) {
    if (a == null && b == null) return null;
    if (a == null) return b! * t;
    if (b == null) return a * (1.0 - t);
    return SmoothBorderRadius.only(
      topLeft: SmoothRadius.lerp(a.topLeft, b.topLeft, t)!,
      topRight: SmoothRadius.lerp(a.topRight, b.topRight, t)!,
      bottomLeft: SmoothRadius.lerp(a.bottomLeft, b.bottomLeft, t)!,
      bottomRight: SmoothRadius.lerp(a.bottomRight, b.bottomRight, t)!,
    );
  }

  @override
  BorderRadius resolve(TextDirection? direction) => BorderRadius.only(
        topLeft: topLeft,
        topRight: topRight,
        bottomLeft: bottomLeft,
        bottomRight: bottomRight,
      );

  @override
  String toString() {
    if (topLeft == topRight && topLeft == bottomRight && topLeft == bottomLeft) {
      final radius = topLeft.toString();
      return 'SmoothBorderRadius${radius.substring(12)}';
    }

    return 'SmoothBorderRadius('
        'topLeft: $topLeft,'
        'topRight: $topRight,'
        'bottomLeft: $bottomLeft,'
        'bottomRight: $bottomRight,'
        ')';
  }
}

// The article from figma's blog
// https://www.figma.com/blog/desperately-seeking-squircles/
//
// The original code
// https://github.com/MartinRGB/Figma_Squircles_Approximation/blob/bf29714aab58c54329f3ca130ffa16d39a2ff08c/js/rounded-corners.js#L64
class ProcessedSmoothRadius {
  const ProcessedSmoothRadius._({
    required this.a,
    required this.b,
    required this.c,
    required this.d,
    required this.p,
    required this.width,
    required this.height,
    required this.radius,
    required this.circularSectionLength,
  });

  factory ProcessedSmoothRadius(
    SmoothRadius radius, {
    required double width,
    required double height,
  }) {
    final cornerSmoothing = radius.cornerSmoothing;
    var cornerRadius = radius.cornerRadius;

    final maxRadius = math.min(width, height) / 2;
    cornerRadius = math.min(cornerRadius, maxRadius);

    // 12.2 from the article
    final p = math.min((1 + cornerSmoothing) * cornerRadius, maxRadius);

    final double angleAlpha, angleBeta;

    if (cornerRadius <= maxRadius / 2) {
      angleBeta = 90 * (1 - cornerSmoothing);
      angleAlpha = 45 * cornerSmoothing;
    } else {
      // When `cornerRadius` is larger and `maxRadius / 2`,
      // these angles also depend on `cornerRadius` and `maxRadius / 2`
      //
      // I did a few tests in Figma and this code generated similar but not identical results
      // `diffRatio` was called `change_percentage` in the orignal code
      final diffRatio = (cornerRadius - maxRadius / 2) / (maxRadius / 2);

      angleBeta = 90 * (1 - cornerSmoothing * (1 - diffRatio));
      angleAlpha = 45 * cornerSmoothing * (1 - diffRatio);
    }

    final angleTheta = (90 - angleBeta) / 2;

    // This was called `h_longest` in the original code
    // In the article this is the distance between 2 control points: P3 and P4
    final p3ToP4Distance = cornerRadius * math.tan(vector.radians(angleTheta / 2));

    // This was called `l` in the original code
    final circularSectionLength =
        math.sin(vector.radians(angleBeta / 2)) * cornerRadius * math.sqrt(2);

    // a, b, c and d are from 11.1 in the article
    final c = p3ToP4Distance * math.cos(vector.radians(angleAlpha));
    final d = c * math.tan(vector.radians(angleAlpha));
    final b = (p - circularSectionLength - c - d) / 3;
    final a = 2 * b;

    return ProcessedSmoothRadius._(
      a: a,
      b: b,
      c: c,
      d: d,
      p: p,
      width: width,
      height: height,
      radius: SmoothRadius(
        cornerRadius: cornerRadius,
        cornerSmoothing: radius.cornerSmoothing,
      ),
      circularSectionLength: circularSectionLength,
    );
  }

  final SmoothRadius radius;
  final double a;
  final double b;
  final double c;
  final double d;
  final double p;
  final double circularSectionLength;
  final double width;
  final double height;
  double get cornerRadius => radius.cornerRadius;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    if (other is SmoothRadius) {
      return other == radius;
    }
    if (other is ProcessedSmoothRadius) {
      return other.radius == radius;
    }

    return false;
  }

  @override
  int get hashCode => radius.hashCode;

  @override
  String toString() {
    return 'ProcessedSmoothRadius('
        'radius: $radius,'
        'a: ${a.toStringAsFixed(2)},'
        'b: ${b.toStringAsFixed(2)},'
        'c: ${c.toStringAsFixed(2)},'
        'd: ${d.toStringAsFixed(2)},'
        'p: ${p.toStringAsFixed(2)},'
        'width: ${width.toStringAsFixed(2)},'
        'height: ${height.toStringAsFixed(2)},'
        ')';
  }
}

extension PathSmoothCornersExtensions on Path {
  void addSmoothTopRight(ProcessedSmoothRadius radius, Rect rect) {
    final width = rect.width;
    final height = rect.height;
    if (radius.radius.cornerRadius > 0) {
      final a = radius.a;
      final b = radius.b;
      final c = radius.c;
      final d = radius.d;
      final p = radius.p;
      this
        ..moveTo(
          math.max(width / 2, width - p),
          0,
        )
        ..cubicTo(
          width - (p - a),
          0,
          width - (p - a - b),
          0,
          width - (p - a - b - c),
          d,
        )
        ..relativeArcToPoint(
          Offset(
            radius.circularSectionLength,
            radius.circularSectionLength,
          ),
          radius: radius.radius,
        )
        ..cubicTo(
          width,
          p - a - b,
          width,
          p - a,
          width,
          math.min(height / 2, p),
        );
    } else {
      this
        ..moveTo(width / 2, 0)
        ..lineTo(width, 0)
        ..lineTo(width, height / 2);
    }
  }

  void addSmoothBottomRight(ProcessedSmoothRadius radius, Rect rect) {
    final width = rect.width;
    final height = rect.height;
    if (radius.radius.cornerRadius > 0) {
      final a = radius.a;
      final b = radius.b;
      final c = radius.c;
      final d = radius.d;
      final p = radius.p;
      this
        ..lineTo(
          width,
          math.max(height / 2, height - p),
        )
        ..cubicTo(
          width,
          height - (p - a),
          width,
          height - (p - a - b),
          width - d,
          height - (p - a - b - c),
        )
        ..relativeArcToPoint(
          Offset(
            -radius.circularSectionLength,
            radius.circularSectionLength,
          ),
          radius: radius.radius,
        )
        ..cubicTo(
          width - (p - a - b),
          height,
          width - (p - a),
          height,
          math.max(width / 2, width - p),
          height,
        );
    } else {
      this
        ..lineTo(width, height)
        ..lineTo(width / 2, height);
    }
  }

  void addSmoothBottomLeft(ProcessedSmoothRadius radius, Rect rect) {
    final width = rect.width;
    final height = rect.height;
    if (radius.radius.cornerRadius > 0) {
      final a = radius.a;
      final b = radius.b;
      final c = radius.c;
      final d = radius.d;
      final p = radius.p;
      this
        ..lineTo(
          math.min(width / 2, p),
          height,
        )
        ..cubicTo(
          p - a,
          height,
          p - a - b,
          height,
          p - a - b - c,
          height - d,
        )
        ..relativeArcToPoint(
          Offset(
            -radius.circularSectionLength,
            -radius.circularSectionLength,
          ),
          radius: radius.radius,
        )
        ..cubicTo(
          0,
          height - (p - a - b),
          0,
          height - (p - a),
          0,
          math.max(height / 2, height - p),
        );
    } else {
      this
        ..lineTo(0, height)
        ..lineTo(0, height / 2);
    }
  }

  void addSmoothTopLeft(ProcessedSmoothRadius radius, Rect rect) {
    final width = rect.width;
    final height = rect.height;
    if (radius.radius.cornerRadius > 0) {
      final a = radius.a;
      final b = radius.b;
      final c = radius.c;
      final d = radius.d;
      final p = radius.p;
      this
        ..lineTo(
          0,
          math.min(height / 2, p),
        )
        ..cubicTo(
          0,
          p - a,
          0,
          p - a - b,
          d,
          p - a - b - c,
        )
        ..relativeArcToPoint(
          Offset(
            radius.circularSectionLength,
            -radius.circularSectionLength,
          ),
          radius: radius.radius,
        )
        ..cubicTo(
          p - a - b,
          0,
          p - a,
          0,
          math.min(width / 2, p),
          0,
        )
        ..close();
    } else {
      this
        ..lineTo(0, 0)
        ..close();
    }
  }
}

class ClipSmoothRect extends StatelessWidget {
  const ClipSmoothRect({
    Key? key,
    required this.child,
    this.radius = SmoothBorderRadius.zero,
    this.clipBehavior = Clip.antiAlias,
  }) : super(key: key);

  final SmoothBorderRadius radius;
  final Clip clipBehavior;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipPath.shape(
      clipBehavior: clipBehavior,
      shape: SmoothRectangleBorder(
        borderRadius: radius,
      ),
      child: child,
    );
  }
}
