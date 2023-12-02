import 'package:flutter/material.dart';

import 'ui/ui_screens/profile_screens/splash_screen.dart';


class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  static GlobalKey<NavigatorState> navigationKey=GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigationKey,
      home: const SplashScreen(),
      title: "Task Manager App",
      theme: ThemeData(
        inputDecorationTheme:const InputDecorationTheme(
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
            disabledBorder: OutlineInputBorder(borderSide: BorderSide.none)
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 32,fontWeight: FontWeight.w600)
        ),
        primaryColor: Colors.green,
        primarySwatch: Colors.green,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12),

          )
        )
      ),
    );
  }
}

