import 'package:feedback_app/core/constants/string_constants.dart';
import 'package:feedback_app/core/navigation/route_names.dart';
import 'package:feedback_app/features/authentication/auth_dependency_injection.dart';
import 'package:feedback_app/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:feedback_app/features/authentication/presentation/widgets/app_logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/helper/helper_functions.dart';

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
      final bool isLoggedIn = slAuth<AuthCubit>().isUserLoggedIn();
      // executes after build
      Future.delayed(const Duration(milliseconds: 1500)).then((value) {
        if (isLoggedIn) {
          context.pushReplacement(getRoutePath(RouteNames.feedbackList));
        } else {
          context.pushReplacement(getRoutePath(RouteNames.login));
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
