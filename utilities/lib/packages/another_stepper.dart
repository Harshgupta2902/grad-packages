import 'package:flutter/material.dart';
import 'package:utilities/theme/app_box_decoration.dart';
import 'package:utilities/theme/app_colors.dart';

class AnotherStepper extends StatelessWidget {
  const AnotherStepper({
    Key? key,
    required this.stepperList,
    this.activeIndex = 0,
    this.activeBarColor = AppColors.darkMintGreen,
    this.inActiveBarColor = AppColors.primaryColor,
    required this.timings,
    this.isError = false,
  }) : super(key: key);

  final List<StepperData> stepperList;
  final int activeIndex;
  final Color activeBarColor;
  final Color inActiveBarColor;
  final List<String?> timings;
  final bool? isError;

  @override
  Widget build(BuildContext context) {
    var crossAxisAlign = CrossAxisAlignment.start;

    final Iterable<int> iterable = Iterable<int>.generate(stepperList.length);
    return Flex(
      crossAxisAlignment: crossAxisAlign,
      direction: Axis.vertical,
      children: iterable.map((index) => _getPreferredStepper(context, index: index)).toList(),
    );
  }

  Widget _getPreferredStepper(BuildContext context, {required int index}) {
    return VerticalStepperItem(
      index: index,
      item: stepperList[index],
      totalLength: stepperList.length,
      activeIndex: activeIndex,
      inActiveBarColor: inActiveBarColor,
      activeBarColor: activeBarColor,
      timings: timings[index],
      isError: index == stepperList.length - 1 ? isError ?? false : false,
    );
  }
}

class StepperData {
  final StepperText? subtitle;
  final Widget? iconWidget;

  StepperData({this.iconWidget, this.subtitle});
}

class StepperText {
  final String text;
  final TextStyle? textStyle;

  StepperText(this.text, {this.textStyle});
}

class VerticalStepperItem extends StatefulWidget {
  const VerticalStepperItem({
    Key? key,
    required this.item,
    required this.index,
    required this.totalLength,
    required this.activeIndex,
    required this.activeBarColor,
    required this.inActiveBarColor,
    required this.timings,
    required this.isError,
  }) : super(key: key);

  final StepperData item;
  final int index;
  final int totalLength;
  final int activeIndex;
  final Color activeBarColor;
  final Color inActiveBarColor;
  final String? timings;
  final bool isError;

  @override
  State<VerticalStepperItem> createState() => _VerticalStepperItemState();
}

class _VerticalStepperItemState extends State<VerticalStepperItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: getChildren(timing: widget.timings),
    );
  }

  List<Widget> getChildren({required String? timing}) {
    return [
      Flexible(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.24,
              decoration: AppBoxDecoration.getBoxDecoration(
                color: widget.isError == true
                    ? AppColors.cadmiumRed.withOpacity(0.1)
                    : timing == null
                        ? AppColors.cadetGrey.withOpacity(0.1)
                        : AppColors.asparagus.withOpacity(0.1),
                borderRadius: 6,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Center(
                child: Text(
                  timing ?? "Pending",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: widget.isError == true
                            ? AppColors.cadmiumRed
                            : timing == null
                                ? AppColors.cadetGrey
                                : AppColors.fernGreen,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: Container(
                      decoration: AppBoxDecoration.getBoxDecoration(
                        color: widget.isError == true
                            ? AppColors.cadmiumRed
                            : widget.index <= widget.activeIndex
                                ? AppColors.darkMintGreen
                                : AppColors.cadetGrey,
                        borderRadius: 30,
                      ),
                      padding: const EdgeInsets.all(2),
                      child: const Icon(
                        Icons.check,
                        size: 14,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 3,
                  height: widget.index == widget.totalLength - 1 ? 0 : 40,
                  decoration: BoxDecoration(
                    color: widget.index < widget.activeIndex
                        ? AppColors.darkMintGreen
                        : AppColors.cadetGrey,
                    borderRadius: BorderRadius.circular(
                      8.0,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(width: 8),
            if (widget.item.subtitle != null) ...[
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    widget.item.subtitle!.text,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: widget.isError == true
                              ? AppColors.cadmiumRed
                              : timing == null
                                  ? AppColors.cadetGrey
                                  : Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    ];
  }
}

class StepperDot extends StatelessWidget {
  const StepperDot({
    Key? key,
    required this.index,
    required this.totalLength,
    required this.activeIndex,
  }) : super(key: key);

  final int index;
  final int totalLength;
  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppBoxDecoration.getBoxDecoration(
        color: index <= activeIndex ? AppColors.darkMintGreen : AppColors.cadetGrey,
        borderRadius: 30,
      ),
      padding: const EdgeInsets.all(2),
      child: const Icon(
        Icons.check,
        size: 14,
        color: AppColors.white,
      ),
    );
  }
}
