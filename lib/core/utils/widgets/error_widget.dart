import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key, required this.errorMsg});

  final String errorMsg;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Text(
        errorMsg,
        style: const TextStyle(color: AppColors.navyBlueColor),
      ),
    );
  }
}
