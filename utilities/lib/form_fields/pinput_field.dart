import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:utilities/validators/input_formatters.dart';
import '../theme/app_box_decoration.dart';
import '../theme/app_colors.dart';

class PinputField extends StatelessWidget {
  const PinputField({
    super.key,
    required this.controller,
    this.validator,
    this.length,
    this.obscureText,
    this.onChanged,
  });

  final int? length;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool? obscureText;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Pinput(
      androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
      controller: controller,
      keyboardType: TextInputType.number,
      length: length ?? 4,
      pinAnimationType: PinAnimationType.fade,
      validator: validator,
      errorTextStyle: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.cadmiumRed),
      closeKeyboardWhenCompleted: true,
      obscuringCharacter: "*",
      obscureText: obscureText ?? false,
      onChanged: onChanged,
      inputFormatters: [NumberOnlyInputFormatter()],
      defaultPinTheme: PinTheme(
        width: 50,
        height: 50,
        textStyle: Theme.of(context).textTheme.bodyLarge,
        decoration: AppBoxDecoration.getBorderBoxDecoration(
            borderRadius: 10, borderColor: AppColors.blueHaze),
      ),
    );
  }
}
