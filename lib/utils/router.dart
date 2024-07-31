import 'package:custos_task/layout/app_layout_screen.dart';
import 'package:custos_task/modules/auth/screens/login_screen.dart';
import 'package:custos_task/modules/auth/screens/register_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(routes: [
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
]);
