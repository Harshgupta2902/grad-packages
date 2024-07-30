import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';

typedef OnTap = void Function(String value);

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
    this.suffix,
    this.enabled,
    this.onTap,
    this.readOnly,
    this.keyboardType,
    this.inputFormatter,
    this.initialValue,
    this.maxLines,
    this.title,
    this.fillColor,
    this.showEnabledBorder, this.validationMode,
  });
  final TextEditingController controller;
  final String hintText;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final OnTap? onTap;
  final Widget? suffix;
  final bool? enabled;
  final bool? readOnly;
  final int? maxLines;
  final TextInputType? keyboardType;
  final String? initialValue;
  final String? title;
  final List<TextInputFormatter>? inputFormatter;
  final Color? fillColor;
  final bool? showEnabledBorder;
  final AutovalidateMode? validationMode;


  static OutlineInputBorder focusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: AppColors.paleSky30),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Text(
            title ?? "",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.stormDust),
          ),
          const SizedBox(height: 6),
        ],
        TextFormField(
          inputFormatters: inputFormatter,
          controller: controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          initialValue: initialValue,
          enabled: enabled,
          readOnly: readOnly ?? false,
          keyboardType: keyboardType,
          onTap: () {
            onTap?.call(controller.text);
          },
          cursorColor: AppColors.black,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: showEnabledBorder != null ? FontWeight.w600 : FontWeight.w500,
                color: AppColors.darkJungleGreen,
              ),
          maxLines: maxLines ?? 1,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: maxLines != null ? 4 : 0),
            fillColor: fillColor ?? AppColors.alabaster,
            hintText: hintText,
            suffixIcon: suffix,
            filled: true,
            floatingLabelAlignment: FloatingLabelAlignment.start,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            // border: showEnabledBorder == true ? focusedBorder : null,
            focusedBorder: showEnabledBorder == true ? focusedBorder : null,
            disabledBorder: showEnabledBorder == true ? focusedBorder : null,
          ),
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
          validator: validator,
        ),
      ],
    );
  }
}
