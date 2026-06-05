import 'package:campus_os/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/providers/auth_provider.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import 'refresh_stream.dart'; // Import the new utility

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/splash',
    // REFRESH LISTEN_ABLE: Forces router to re-run redirect on auth change
    refreshListenable: GoRouterRefreshStream(
        ref.watch(authRepositoryProvider).authStateChanges),

    redirect: (context, state) {
      // If we are currently loading the auth state, stay on splash/current screen
      if (authState.isLoading) return null;

      final user = authState.value;
      final isLoggingIn = state.matchedLocation == '/login';
      final isOnboarding = state.matchedLocation == '/onboarding';
      final isSplash = state.matchedLocation == '/splash';

      // 1. Not Logged In
      if (user == null) {
        if (isLoggingIn || isOnboarding) return null;
        return '/onboarding';
      }

      // 2. Logged In
      if (isLoggingIn || isOnboarding || isSplash) {
        return '/home';
      }

      // 3. No redirect needed
      return null;
    },
    routes: [
      GoRoute(
          path: '/splash',
          builder: (c, s) => const Scaffold(
              backgroundColor: Color(0xFF0B1020),
              body: Center(child: CircularProgressIndicator()))),
      GoRoute(path: '/onboarding', builder: (c, s) => const OnboardingScreen()),
      GoRoute(path: '/login', builder: (c, s) => const LoginScreen()),
      GoRoute(path: '/home', builder: (c, s) => const HomeScreen()),
      // Additional shell branches here...
    ],
  );
});
