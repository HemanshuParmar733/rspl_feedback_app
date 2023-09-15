import 'package:feedback_app/core/constants/string_constants.dart';
import 'package:feedback_app/features/authentication/presentation/pages/login_page.dart';
import 'package:feedback_app/features/authentication/presentation/widgets/app_logo_widget.dart';
import 'package:feedback_app/features/feedback/presentation/pages/feedback_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/shared_pref_keys.dart';
import '../../core/database/shared_pref_storage.dart';
import '../../core/theme/app_colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: AppColors.navyBlueColor));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final bool isLoggedIn = SharedPrefStorage.instance
              .getBoolData(key: SharedPrefKeys.userLoginKey) ??
          false;
      // executes after build
      Future.delayed(const Duration(milliseconds: 1500)).then((value) {
        if (isLoggedIn) {
          context.pushReplacement(FeedbackListPage.feedbackListRoute);
        } else {
          context.pushReplacement(LoginPage.loginRoute);
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Material(
        child: Center(
      child: AppLogoWidget(
        message: AppConstants.splashScreenTitle,
      ),
    ));
  }
}
