// lib/main.dart
import 'package:campus_os/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/flashcards/data/models/flashcard_model.dart';
import 'features/lecture/data/models/lecture_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();

  // Register Hive Adapters
  if (!Hive.isAdapterRegistered(0)) Hive.registerAdapter(LectureModelAdapter());
  if (!Hive.isAdapterRegistered(1)) Hive.registerAdapter(FlashcardAdapter());

  // Open Boxes
  await Hive.openBox<LectureModel>('lectures');
  await Hive.openBox<Flashcard>('flashcards');

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Color(0xFF0B1020),
    ),
  );

  runApp(const ProviderScope(child: CampusOS()));
}

class CampusOS extends ConsumerWidget {
  const CampusOS({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Campus OS',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: AppTheme.darkTheme,
      routerConfig: router,
    );
  }
}
