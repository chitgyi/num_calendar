import 'package:flutter/material.dart';
import 'package:num_calendar/src/presentation/navigation/app_router.dart';
import 'package:num_calendar/src/presentation/ui/styles/colors.dart';

class NumCalendarApp extends StatelessWidget {
  const NumCalendarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
        ),
        iconTheme: const IconThemeData(
          color: primaryColor,
        ),
        indicatorColor: indicatorColor,
        scaffoldBackgroundColor: backgroundColor,
        cardTheme: CardTheme(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
          ),
        ),
      ),
    );
  }
}
