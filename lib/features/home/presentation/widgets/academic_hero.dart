import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';

class AcademicHero extends StatelessWidget {
  const AcademicHero({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 30,
            offset: const Offset(0, 15),
          )
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            top: -20,
            child: Icon(Icons.auto_awesome,
                size: 150, color: Colors.white.withOpacity(0.1)),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Today\'s Overview',
                    style: GoogleFonts.inter(
                        color: Colors.white.withOpacity(0.8),
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Text(
                  '3 Active Tasks',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 42,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: -1,
                  ),
                ),
                Text('1 assignment due tomorrow',
                    style: GoogleFonts.inter(
                        color: Colors.white.withOpacity(0.9), fontSize: 14)),
                const Spacer(),
                Row(
                  children: [
                    _buildMiniStat('Attendance', '84%', AppColors.success),
                    const SizedBox(width: 12),
                    _buildMiniStat('Tasks', '5', Colors.white),
                    const SizedBox(width: 12),
                    _buildMiniStat('Streak', '12', AppColors.warning),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniStat(String label, String val, Color color) {
    return Expanded(
      child: GlassContainer(
        opacity: 0.15,
        radius: 16,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            children: [
              Text(val,
                  style: TextStyle(
                      color: color, fontWeight: FontWeight.bold, fontSize: 16)),
              Text(label,
                  style: const TextStyle(color: Colors.white54, fontSize: 10)),
            ],
          ),
        ),
      ),
    );
  }
}
