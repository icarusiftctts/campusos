import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_colors.dart';

class HeroDashboard extends StatelessWidget {
  const HeroDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Student Avatar Placeholder
          Icon(Icons.person_pin,
                  size: 120, color: Colors.white.withOpacity(0.2))
              .animate()
              .scale(duration: 1.seconds, curve: Curves.easeOutBack),

          // Orbiting elements
          _buildOrbitIcon(
              Icons.auto_graph, AppColors.secondary, const Offset(-100, -80)),
          _buildOrbitIcon(
              Icons.calendar_today, AppColors.primary, const Offset(110, -40)),
          _buildOrbitIcon(
              Icons.description, Colors.white70, const Offset(-80, 80)),
          _buildOrbitIcon(
              Icons.psychology, AppColors.success, const Offset(90, 90)),
        ],
      ),
    );
  }

  Widget _buildOrbitIcon(IconData icon, Color color, Offset offset) {
    return Transform.translate(
      offset: offset,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          shape: BoxShape.circle,
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Icon(icon, color: color, size: 28),
      ).animate(onPlay: (controller) => controller.repeat(reverse: true)).moveY(
          begin: -10, end: 10, duration: 2.seconds, curve: Curves.easeInOut),
    );
  }
}

class HeroWorkflow extends StatelessWidget {
  const HeroWorkflow({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {'icon': Icons.picture_as_pdf, 'label': 'Assignment PDF'},
      {'icon': Icons.bolt, 'label': 'AI Processing'},
      {'icon': Icons.task_alt, 'label': 'Task Generated'},
      {'icon': Icons.event_available, 'label': 'Calendar Updated'},
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(items.length, (i) {
        return Column(
          children: [
            Container(
              width: 220,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surface.withOpacity(0.5),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.secondary.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  Icon(items[i]['icon'] as IconData,
                      color: AppColors.secondary),
                  const SizedBox(width: 12),
                  Text(items[i]['label'] as String,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 13)),
                ],
              ),
            ).animate().fadeIn(delay: (i * 300).ms).slideX(begin: -0.2),
            if (i < items.length - 1)
              Icon(Icons.arrow_downward,
                      color: AppColors.secondary.withOpacity(0.3), size: 20)
                  .animate()
                  .fadeIn(delay: (i * 300 + 150).ms),
          ],
        );
      }),
    );
  }
}
