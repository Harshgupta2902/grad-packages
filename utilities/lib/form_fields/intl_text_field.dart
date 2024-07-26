import 'package:flutter/material.dart';
import '../packages/intl_form_field/countries.dart';
import '../packages/intl_form_field/intl_field.dart';
import '../packages/intl_form_field/phone_number.dart';
import '../theme/app_box_decoration.dart';
import '../theme/app_colors.dart';
import '../validators/input_formatters.dart';

class IntlTextField extends StatelessWidget {
  const IntlTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.validator,
    this.suffixIcon,
    this.onCountryChanged,
    this.onChanged,
    this.title,
  });

  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final void Function(Country)? onCountryChanged;
  final void Function(PhoneNumber)? onChanged;
  final String? title;

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
        IntlPhoneField(
          controller: controller,
          inputFormatters: [NumberOnlyInputFormatter()],
          dropdownContainerDecoration: AppBoxDecoration.getBoxDecoration(
            borderRadius: 6,
            color: AppColors.whiteSmoke,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: suffixIcon,
          ),
          onCountryChanged: onCountryChanged,
          onChanged: onChanged,
          validator: validator,
        ),
      ],
    );
  }
}
