import 'package:flutter/material.dart';
import 'ui/ui_screens/profile_screens/splash_screen.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: const SplashScreen(),
      title: "Task Manager",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: const TextTheme(
            bodyLarge: TextStyle(
              fontFamily: '',
              fontWeight: FontWeight.w700,
              fontSize: 26,
            ),
            bodyMedium: TextStyle(
              fontFamily: "",
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
            titleLarge: TextStyle(
              fontFamily: "",
              fontWeight: FontWeight.w700,
              fontSize: 15,
              color: Colors.white,
            ),
            titleSmall: TextStyle(
              fontFamily: "",
              fontWeight: FontWeight.normal,
              fontSize: 12,
              color: Colors.white,
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            hintStyle: Theme.of(context).textTheme.bodySmall,
            border: const OutlineInputBorder(borderSide: BorderSide.none),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              backgroundColor: const Color(0xFF0E4DF2),
            ),
          ),),
    );
  }
}
