import 'package:custos_task/layout/app_layout_screen.dart';
import 'package:custos_task/modules/auth/provider/auth_provider.dart';
import 'package:custos_task/modules/auth/screens/login_screen.dart';
import 'package:custos_task/modules/auth/screens/register_screen.dart';
import 'package:custos_task/modules/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/layout',
      builder: (context, state) => const AppLayoutScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => RegisterScreen(),
    ),
  ],
  redirect: (context, state) {
    final authProvider = context.read<AuthProvider>();
    final isAuthenticated = authProvider.isAuthenticated;
    final isInitialized = authProvider.isInitialized;
    final loggingIn = state.uri.path == '/login';
    final registering = state.uri.path == '/register';

    if (!isInitialized  && !loggingIn && !registering) {
      // Redirect to SplashScreen while initialization is in progress
      return '/';
    }

    if (!isAuthenticated && !registering && !loggingIn) {
      // If the user is not authenticated and is not already on the login or register page,
      // redirect them to the login page
      return '/login';
    }

    if (isAuthenticated && (loggingIn || registering)) {
      // If the user is authenticated and tries to go to the login or register page,
      // redirect them to the layout page
      return '/layout';
    }

    // If none of the above conditions are met, return null to proceed normally
    return null;
  },
);
