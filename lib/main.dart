import 'package:feedback_app/core/constants/string_constants.dart';
import 'package:feedback_app/core/database/shared_pref_storage.dart';
import 'package:feedback_app/core/navigation/router.dart';
import 'package:feedback_app/core/theme/app_theme.dart';
import 'package:feedback_app/features/authentication/auth_dependency_injection.dart';
import 'package:feedback_app/features/feedback/feedback_dependency_injection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await SharedPrefStorage.instance.init();
  await injectDependencies();
  runApp(const MyApp());
}

Future<void> injectDependencies() async {
  await Future.wait([initAuthDependencies(), initFeedbackDependencies()]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.goRouter,
      // routeInformationProvider: AppRouter.goRouter.routeInformationProvider,
      // routeInformationParser: AppRouter.goRouter.routeInformationParser,
      // routerDelegate: AppRouter.goRouter.routerDelegate,
      title: AppConstants.appName,
      theme: customLightTheme(),
      darkTheme: customDarkTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}
