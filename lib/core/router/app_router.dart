import 'package:campus_os/features/lecture/presentation/screens/recorder_screen.dart';
import 'package:campus_os/features/ocr/presentation/screens/ocr_screen.dart';
import 'package:campus_os/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:campus_os/shared/splash_screen.dart';
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
      ref.watch(authRepositoryProvider).authStateChanges,
    ),

    redirect: (context, state) {
      // If we are currently loading the auth state, stay on splash/current screen
      if (authState.isLoading) return null;

      final user = authState.value;
      final isLoggingIn = state.matchedLocation == '/login';
      final isOnboarding = state.matchedLocation == '/onboarding';
      final isSplash = state.matchedLocation == '/splash';

      // Special case for splash: if we just loaded the app, we stay on splash
      // until it completes its own logic, then it triggers onComplete.
      // But GoRouter redirect might kick in.
      // To keep it simple, we allow splash to be a regular route.

      // 1. Not Logged In
      if (user == null) {
        if (isLoggingIn || isOnboarding || isSplash) return null;
        return '/onboarding';
      }

      // 2. Logged In
      if (isLoggingIn || isOnboarding || isSplash) {
        // If we are on splash and logged in, we might want to stay on splash
        // until the model is ready.
        return null;
      }

      // 3. No redirect needed
      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (c, s) => SplashScreen(
          onComplete: () {
            // After splash completes, we force a refresh or redirect
            // For now, simple navigation if possible, but redirect is better
            // Actually, splash will just call this and we can go to /home if logged in
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
      GoRoute(path: '/home', builder: (c, s) => const HomeScreen()),
      GoRoute(path: '/recorder', builder: (c, s) => const RecorderScreen()),
      GoRoute(path: '/ocr', builder: (c, s) => const OcrScreen()),
      // Additional shell branches here...
    ],
  );
});
