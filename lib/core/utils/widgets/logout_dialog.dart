import 'package:feedback_app/core/constants/string_constants.dart';
import 'package:feedback_app/features/authentication/auth_dependency_injection.dart';
import 'package:feedback_app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:feedback_app/features/authentication/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../theme/app_colors.dart';

Future<void> showLogoutDialog(BuildContext context) async {
  Widget logOutButton = TextButton(
      onPressed: () {
        slAuth<AuthBloc>().add(const OnLogOutEvent());
        context.pushReplacement(LoginPage.loginRoute);
      },
      child: const Text(AppConstants.logoutTitle,
          style: TextStyle(color: AppColors.redColor)));
  Widget cancelButton = TextButton(
    child: const Text(AppConstants.cancelBtnText,
        style: TextStyle(color: AppColors.navyBlueColor)),
    onPressed: () {
      context.pop();
    },
  );

  AlertDialog alert = AlertDialog(
    title: const Text(AppConstants.logoutTitle),
    content: const Text(AppConstants.logoutContent),
    actions: [logOutButton, cancelButton],
  );

  // show the dialog
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
