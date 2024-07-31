import 'package:custos_task/layout/app_layout_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(routes: [
  GoRoute(path: '/', builder: (context, state) => const AppLayoutScreen()),
]);
