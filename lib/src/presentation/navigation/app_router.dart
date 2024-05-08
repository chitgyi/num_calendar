import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:num_calendar/src/presentation/ui/pages/home_page.dart';
import 'package:num_calendar/src/presentation/ui/pages/monthly_page.dart';
import 'package:num_calendar/src/presentation/ui/pages/yearly_page.dart';

final appRouter = GoRouter(
  initialLocation: '/monthly',
  routes: [
    StatefulShellRoute.indexedStack(
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/monthly',
              builder: (context, state) => const MonthlyPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/yearly',
              builder: (context, state) => const YearlyPage(),
            ),
          ],
        )
      ],
      pageBuilder: (context, state, navigationShell) => MaterialPage(
        child: HomePage(navigationShell),
      ),
    ),
  ],
);
