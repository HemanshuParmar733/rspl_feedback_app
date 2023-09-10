import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.labelText,
    this.obscure,
    this.formatters,
    required this.controller,
    this.validator,
    this.autoValidateMode,
    this.suffixIcon,
  });

  final String labelText;
  final bool? obscure;
  final List<TextInputFormatter>? formatters;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final AutovalidateMode? autoValidateMode;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscure ?? false,
      inputFormatters: formatters,
      controller: controller,
      validator: validator,
      autovalidateMode: autoValidateMode,
      style: const TextStyle(color: AppColors.navyBlueColor),
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        enabledBorder: const OutlineInputBorder(),
        border: const OutlineInputBorder(),
        labelText: labelText,
      ),
    );
  }
}
