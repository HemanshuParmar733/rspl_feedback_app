import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget(
      {super.key, required this.height, required this.width});

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          height: height,
          width: width,
          child: const CircularProgressIndicator(
            color: AppColors.navyBlueColor,
            strokeWidth: 4,
          )),
    );
  }
}
