import 'package:custos_task/layout/provider/app_layout_provider.dart';
import 'package:custos_task/modules/auth/provider/auth_provider.dart';
import 'package:custos_task/utils/network/local/cache_manager.dart';
import 'package:custos_task/utils/network/remote/dio_manager.dart';
import 'package:custos_task/utils/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  await DioHelper.init();
  await CacheManager.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppLayoutProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Custos Task',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: router,
      ),
    );
  }
}
