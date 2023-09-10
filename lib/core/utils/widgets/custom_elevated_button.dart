import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {super.key, required this.onPressed, required this.btnText});

  final VoidCallback onPressed;
  final String btnText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )),
            backgroundColor:
                MaterialStateProperty.all(AppColors.navyBlueColor)),
        child: Text(
          btnText,
          style: TextStyle(color: AppColors.whiteColor),
        ));
  }
}
