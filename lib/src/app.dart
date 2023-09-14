import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'routes.dart';
import 'providers/user_provider.dart';
import 'views/screens/chat_screen.dart';
import 'views/screens/welcome_screen.dart';
import 'views/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return MaterialApp(
          title: 'MessageMe App',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.appTheme,
          initialRoute: ref.watch(userProvider).getCurrentUser() != null
              ? ChatScreen.screenRoute
              : WelcomeScreen.screenRoute,
          routes: RouteManager.routes,
        );
      },
    );
  }
}