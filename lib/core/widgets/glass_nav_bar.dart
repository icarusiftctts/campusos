import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../theme/app_colors.dart';

class GlassNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const GlassNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100, // Extra height to account for floating center button
      padding: const EdgeInsets.only(bottom: 16),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // The Glass Shell
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(36),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  height: 72,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(36),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.1),
                      width: 0.5,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _NavIcon(
                        index: 0,
                        currentIndex: currentIndex,
                        icon: Icons.calendar_today_rounded,
                        label: 'Schedule',
                        onTap: () => onTap(0),
                      ),
                      _NavIcon(
                        index: 1,
                        currentIndex: currentIndex,
                        icon: Icons.fact_check_rounded,
                        label: 'Check-in',
                        onTap: () => onTap(1),
                      ),
                      const SizedBox(width: 72), // Spacer for Home Button
                      _NavIcon(
                        index: 3,
                        currentIndex: currentIndex,
                        icon: Icons.notifications_none_rounded,
                        label: 'Updates',
                        onTap: () => onTap(3),
                      ),
                      _NavIcon(
                        index: 4,
                        currentIndex: currentIndex,
                        icon: Icons.analytics_outlined,
                        label: 'Stats',
                        onTap: () => onTap(4),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Floating Home Hub
          Positioned(
            bottom: 30,
            child: _HomeActionButton(
              isActive: currentIndex == 2,
              onTap: () => onTap(2),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  final int index;
  final int currentIndex;
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _NavIcon({
    required this.index,
    required this.currentIndex,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool active = index == currentIndex;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: active ? AppColors.secondary : Colors.white.withOpacity(0.6),
            size: 26,
          )
              .animate(target: active ? 1 : 0)
              .scale(
                  begin: const Offset(1, 1),
                  end: const Offset(1.2, 1.2),
                  curve: Curves.elasticOut)
              .tint(color: AppColors.secondary),
          if (active)
            Text(
              label,
              style: const TextStyle(
                  color: AppColors.secondary,
                  fontSize: 10,
                  fontWeight: FontWeight.bold),
            ).animate().fadeIn().scale(begin: const Offset(0.8, 0.8)),
          if (active)
            Container(
              margin: const EdgeInsets.only(top: 4),
              height: 4,
              width: 4,
              decoration: const BoxDecoration(
                  color: AppColors.secondary, shape: BoxShape.circle),
            ).animate().shimmer(color: Colors.white),
        ],
      ),
    );
  }
}

class _HomeActionButton extends StatelessWidget {
  final bool isActive;
  final VoidCallback onTap;

  const _HomeActionButton({required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 68,
        height: 68,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [AppColors.primary, AppColors.secondary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.4),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: const Icon(
          Icons.dashboard_rounded,
          color: Colors.white,
          size: 32,
        ),
      )
          .animate(target: isActive ? 1 : 0)
          .scale(
              begin: const Offset(1, 1),
              end: const Offset(1.15, 1.15),
              curve: Curves.easeOutBack)
          .shimmer(duration: 2.seconds, color: Colors.white24),
    );
  }
}
