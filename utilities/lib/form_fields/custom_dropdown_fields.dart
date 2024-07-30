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
  });
  final List<DropdownMenuItem<Object>> items;
  final String hintText;
  final String? value;
  final void Function(Object?)? onChanged;
  final String? Function(Object?)? validator;
  static OutlineInputBorder enabledBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: AppColors.alabaster),
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
        border: enabledBorder,
        enabledBorder: enabledBorder,
        focusedBorder: enabledBorder,
        disabledBorder: enabledBorder,
      ),
    );
  }
}
