import 'package:feedback_app/core/extensions/sizedbox_extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../theme/app_colors.dart';

Future<void> showLoadingDialog(
    {required BuildContext context,
    required String title,
    required String message}) async {
  Widget progressIndicator = const SizedBox(
      height: 40,
      width: 40,
      child: CircularProgressIndicator(
        strokeWidth: 4,
        color: AppColors.navyBlueColor,
      ));
  Widget loadingText =
      Text(message, style: const TextStyle(color: AppColors.navyBlueColor));

  AlertDialog alert = AlertDialog(
    backgroundColor: AppColors.greyolor,
    title: Text(title),
    content: SizedBox(
        height: 120,
        width: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [progressIndicator, 10.Vspace, loadingText],
        )),
  );

  // show the dialog
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void hideLoadingDialog({required BuildContext context}) {
  context.pop();
}
