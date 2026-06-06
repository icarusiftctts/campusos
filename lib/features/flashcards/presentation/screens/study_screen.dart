import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class StudyScreen extends StatelessWidget {
  const StudyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Flashcards'),
        backgroundColor: AppColors.surface,
      ),
      body: const Center(
        child: Text(
          '🧠 Flashcards coming soon',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
