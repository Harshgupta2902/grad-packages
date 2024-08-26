import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:utilities/theme/app_colors.dart';

class ReadMoreText extends StatefulWidget {
  const ReadMoreText({super.key, required this.subtitle});
  final String? subtitle;

  @override
  State<ReadMoreText> createState() => _ReadMoreTextState();
}

class _ReadMoreTextState extends State<ReadMoreText> {
  bool showMore = false;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: widget.subtitle == null
                ? "-"
                : showMore == true
                    ? widget.subtitle
                    : ('${widget.subtitle?.split('').take(80).join('')}...'),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.boulder),
          ),
          TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                setState(() {
                  showMore = !showMore;
                });
              },
            text: showMore ? "Read Less" : "Read More",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.primaryColor,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w600,
                  decorationColor: AppColors.primaryColor,
                ),
          ),
        ],
      ),
    );
  }
}
