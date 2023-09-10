import 'package:feedback_app/core/navigation/route_names.dart';
import 'package:feedback_app/features/authentication/presentation/pages/login_page.dart';
import 'package:feedback_app/features/authentication/presentation/pages/register_page.dart';
import 'package:feedback_app/features/feedback/presentation/pages/create_feedback_page.dart';
import 'package:feedback_app/features/feedback/presentation/pages/feedback_list_page.dart';
import 'package:feedback_app/features/splash/splash_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

/// The route configuration.
class AppRouter {
  static final goRouter = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: RouteNames.splash,
        builder: (BuildContext context, GoRouterState state) {
          return const SplashPage();
        },
        routes: <RouteBase>[
          GoRoute(
            path: RouteNames.createFeedback,
            name: RouteNames.createFeedback,
            builder: (BuildContext context, GoRouterState state) {
              return CreateFeedBackPage();
            },
          ),
          GoRoute(
            path: RouteNames.feedbackList,
            name: RouteNames.feedbackList,
            builder: (BuildContext context, GoRouterState state) {
              return FeedbackListPage();
            },
          ),
          GoRoute(
            path: RouteNames.register,
            name: RouteNames.register,
            builder: (BuildContext context, GoRouterState state) {
              return const RegisterPage();
            },
          ),
          GoRoute(
            path: RouteNames.login,
            name: RouteNames.login,
            builder: (BuildContext context, GoRouterState state) {
              return const LoginPage();
            },
          ),
        ],
      ),
    ],
  );
}
