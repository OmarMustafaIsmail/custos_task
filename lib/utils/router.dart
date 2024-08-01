import 'package:custos_task/layout/app_layout_screen.dart';
import 'package:custos_task/modules/auth/provider/auth_provider.dart';
import 'package:custos_task/modules/auth/screens/login_screen.dart';
import 'package:custos_task/modules/auth/screens/register_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final router = GoRouter(
  routes: [
    GoRoute(
        path: '/layout', builder: (context, state) => const AppLayoutScreen()),
    GoRoute(
      path: '/',
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
    final loggingIn = state.uri.path == '/';
    final registering = state.uri.path == '/register';

    if (!isAuthenticated && !registering && !loggingIn) {
      // If the user is not authenticated and is not already on the login page,
      // redirect them to the login page
      return '/';
    }

    if (isAuthenticated && loggingIn) {
      // If the user is authenticated and tries to go to the login page,
      // redirect them to the layout/home page
      return '/layout';
    }

    return null;
  },
);
