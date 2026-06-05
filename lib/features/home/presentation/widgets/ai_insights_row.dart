import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';

class AIInsightsRow extends StatelessWidget {
  const AIInsightsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Text('AI Insights',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
        ),
        SizedBox(
          height: 100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            children: [
              _buildInsightCard(
                  'DBMS attendance is at 72%',
                  'Fall risk detected',
                  Icons.warning_amber_rounded,
                  AppColors.warning),
              const SizedBox(width: 16),
              _buildInsightCard(
                  '12 cards ready for review',
                  'Keep the streak alive',
                  Icons.psychology_outlined,
                  AppColors.secondary),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInsightCard(
      String title, String sub, IconData icon, Color color) {
    return GlassContainer(
      child: Container(
        width: 280,
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis),
                  Text(sub,
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.5), fontSize: 11)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
