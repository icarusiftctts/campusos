import 'package:campus_os/features/attendance/presentation/screens/attendance_dashboard_page.dart';
import 'package:campus_os/features/attendance/presentation/screens/attendance_screen.dart';
import 'package:campus_os/features/calendar/presentation/screens/calendar_screen.dart';
import 'package:campus_os/features/expenses/presentation/screens/expenses_screen.dart';
import 'package:campus_os/features/flashcards/presentation/screens/study_screen.dart';
import 'package:campus_os/features/lecture/presentation/screens/recorder_screen.dart';
import 'package:campus_os/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:campus_os/features/ocr/presentation/screens/ocr_screen.dart';
import 'package:campus_os/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:campus_os/features/progress/presentation/screens/stats_screen.dart';
import 'package:campus_os/shared/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/providers/auth_provider.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import 'main_shell.dart';
import 'refresh_stream.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',
    refreshListenable: GoRouterRefreshStream(
      ref.watch(authRepositoryProvider).authStateChanges,
    ),
    redirect: (context, state) {
      if (authState.isLoading) return null;

      final user = authState.value;
      final isLoggingIn = state.matchedLocation == '/login';
      final isOnboarding = state.matchedLocation == '/onboarding';
      final isSplash = state.matchedLocation == '/splash';

      if (user == null) {
        if (isLoggingIn || isOnboarding || isSplash) return null;
        return '/onboarding';
      }

      if (isLoggingIn || isOnboarding || isSplash) {
        return '/home';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (c, s) => SplashScreen(
          onComplete: () {
            final user = ref.read(authStateProvider).value;
            if (user != null) {
              c.go('/home');
            } else {
              c.go('/onboarding');
            }
          },
        ),
      ),
      GoRoute(path: '/onboarding', builder: (c, s) => const OnboardingScreen()),
      GoRoute(path: '/login', builder: (c, s) => const LoginScreen()),

      // MAIN SHELL
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainNavigationShell(navigationShell: navigationShell);
        },
        branches: [
          // Branch 0: Schedule
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/schedule',
                builder: (context, state) => const CalendarScreen(),
              ),
            ],
          ),
          // Branch 1: Check-in
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/check-in',
                builder: (context, state) => const AttendanceDashboardPage(),
              ),
            ],
          ),
          // Branch 2: Home
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          // Branch 3: Updates
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/updates',
                builder: (context, state) => const NotificationsScreen(),
              ),
            ],
          ),
          // Branch 4: Stats
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/stats',
                builder: (context, state) => const StatsScreen(),
              ),
            ],
          ),
        ],
      ),

      // SUB-PAGES (Outside Shell or pushed onto it)
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/recorder',
        builder: (c, s) => const RecorderScreen(),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/ocr',
        builder: (c, s) => const OcrScreen(),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/flashcards',
        builder: (c, s) => const StudyScreen(),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/expenses',
        builder: (c, s) => const ExpensesScreen(),
      ),
    ],
  );
});
