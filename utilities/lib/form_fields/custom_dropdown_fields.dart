import 'package:flutter/material.dart';
import 'package:utilities/theme/app_colors.dart';

class CustomDropDownFormField extends StatelessWidget {
  const CustomDropDownFormField({
    super.key,
    this.onChanged,
    required this.items,
    required this.hintText,
    this.validator,
    this.value,
    this.showEnabledBorder = false,
  });
  final List<DropdownMenuItem<Object>> items;
  final String hintText;
  final String? value;
  final void Function(Object?)? onChanged;
  final String? Function(Object?)? validator;
  final bool? showEnabledBorder;

  static OutlineInputBorder focusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: AppColors.paleSky30),
  );

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      items: items,
      onChanged: onChanged,
      validator: validator,
      value: value,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.darkJungleGreen,
          ),
      borderRadius: BorderRadius.circular(12),
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: AppColors.alabaster,
        filled: true,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: showEnabledBorder == true ? focusedBorder : null,
        focusedBorder: showEnabledBorder == true ? focusedBorder : null,
        disabledBorder: showEnabledBorder == true ? focusedBorder : null,
        enabledBorder: showEnabledBorder == true ? focusedBorder : null,
      ),
    );
  }
}
