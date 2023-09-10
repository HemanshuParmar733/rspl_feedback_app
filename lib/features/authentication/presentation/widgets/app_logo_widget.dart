import 'package:feedback_app/core/extensions/sizedbox_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.comment,
          size: 100,
          color: AppColors.navyBlueColor,
        ),
        10.Vspace,
        Text(
          message,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.navyBlueColor),
        )
      ],
    );
  }
}
