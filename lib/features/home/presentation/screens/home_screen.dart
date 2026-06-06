import 'package:campus_os/features/home/presentation/widgets/academic_hero.dart';
import 'package:campus_os/features/home/presentation/widgets/ai_insights_row.dart';
import 'package:campus_os/features/home/presentation/widgets/essentials_row.dart';
import 'package:campus_os/features/home/presentation/widgets/quick_actions_grid.dart';
import 'package:campus_os/features/home/presentation/widgets/schedule_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Ambient Glows
          Positioned(
            top: -100,
            left: -50,
            child: _AmbientGlow(color: AppColors.primary.withOpacity(0.15)),
          ),
          Positioned(
            top: -100,
            right: -50,
            child: _AmbientGlow(color: AppColors.secondary.withOpacity(0.15)),
          ),

          SafeArea(
            bottom: false,
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // SECTION 1: Greeting Header
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                    child: _buildHeader()
                        .animate()
                        .fadeIn(duration: 400.ms)
                        .slideY(begin: -0.1),
                  ),
                ),

                // SECTION 2: Hero Card
                SliverToBoxAdapter(
                  child: const AcademicHero()
                      .animate()
                      .fadeIn(delay: 200.ms)
                      .slideY(begin: 0.1),
                ),

                // SECTION 3: Quick Actions
                const SliverPadding(
                  padding: EdgeInsets.all(24),
                  sliver: QuickActionsGrid(),
                ),

                // SECTION 4: AI Insights
                SliverToBoxAdapter(
                  child: const AIInsightsRow().animate().fadeIn(delay: 600.ms),
                ),

                // SECTION 5: Schedule
                SliverToBoxAdapter(
                  child:
                      const ScheduleTimeline().animate().fadeIn(delay: 800.ms),
                ),

                // SECTION 6: Essentials
                SliverToBoxAdapter(
                  child: const EssentialsRow().animate().fadeIn(delay: 900.ms),
                ),

                // SECTION 7: Recent Activity
                SliverToBoxAdapter(
                  child:
                      _buildRecentActivity().animate().fadeIn(delay: 1000.ms),
                ),

                const SliverToBoxAdapter(
                  child: SizedBox(height: 120),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good Morning, Praneel',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: -0.5,
              ),
            ),
            Text(
              'CAMPUS OS',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white.withOpacity(0.4),
                letterSpacing: 2,
              ),
            ),
          ],
        ),
        Row(
          children: [
            _CircularGlassButton(icon: Icons.search_rounded),
            const SizedBox(width: 12),
            _CircularGlassButton(
                icon: Icons.notifications_none_rounded, hasBadge: true),
          ],
        )
      ],
    );
  }

  Widget _buildRecentActivity() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Activity',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          const GlassContainer(
            child: ListTile(
              title: Text('Lecture processed',
                  style: TextStyle(color: Colors.white, fontSize: 14)),
              subtitle: Text('2 minutes ago',
                  style: TextStyle(color: Colors.white54, fontSize: 12)),
              leading:
                  Icon(Icons.check_circle, color: AppColors.success, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class _AmbientGlow extends StatelessWidget {
  final Color color;
  const _AmbientGlow({required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: color, blurRadius: 100, spreadRadius: 50)],
      ),
    );
  }
}

class _CircularGlassButton extends StatelessWidget {
  final IconData icon;
  final bool hasBadge;
  const _CircularGlassButton({required this.icon, this.hasBadge = false});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GlassContainer(
          radius: 50,
          child: Container(
            height: 48,
            width: 48,
            alignment: Alignment.center,
            child: Icon(icon, color: Colors.white, size: 22),
          ),
        ),
        if (hasBadge)
          Positioned(
            right: 12,
            top: 12,
            child: Container(
              height: 8,
              width: 8,
              decoration: const BoxDecoration(
                  color: AppColors.error, shape: BoxShape.circle),
            ),
          ),
      ],
    );
  }
}
