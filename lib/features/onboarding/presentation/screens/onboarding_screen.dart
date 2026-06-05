import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';
import '../widgets/floating_particles.dart';
import '../widgets/hero_illustrations.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _pages = [
    {
      'title': 'Everything Campus.\nOne App.',
      'desc':
          'Assignments, lectures, attendance, events and career preparation in one intelligent workspace.',
      'hero': const HeroDashboard(),
      'color': AppColors.primary,
    },
    {
      'title': 'Turn Information\nInto Action.',
      'desc':
          'Scan assignments, generate notes, organize deadlines and never miss what matters.',
      'hero': const HeroWorkflow(),
      'color': AppColors.secondary,
    },
    {
      'title': 'Built For Students.\nPowered By AI.',
      'desc':
          'Lecture recordings become notes. Assignments become tasks. Progress becomes measurable.',
      'hero': const HeroDashboard(), // Use HeroConnected in production
      'color': AppColors.success,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background Glow
          AnimatedContainer(
            duration: 800.ms,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(0, -0.5),
                radius: 1.5,
                colors: [
                  _pages[_currentPage]['color'].withOpacity(0.12),
                  AppColors.background,
                ],
              ),
            ),
          ),
          const FloatingParticles(),

          SafeArea(
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: PageView.builder(
                    controller: _controller,
                    onPageChanged: (v) => setState(() => _currentPage = v),
                    itemCount: _pages.length,
                    itemBuilder: (context, i) => _pages[i]['hero'],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: GlassContainer(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _pages[_currentPage]['title'],
                            textAlign: TextAlign.center,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1.1,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _pages[_currentPage]['desc'],
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              color: Colors.white.withOpacity(0.6),
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 32),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(_pages.length, (i) {
                              return AnimatedContainer(
                                duration: 300.ms,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                width: _currentPage == i ? 24 : 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: _currentPage == i
                                      ? AppColors.primary
                                      : Colors.white24,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              );
                            }),
                          ),
                          const SizedBox(height: 32),
                          SizedBox(
                            width: double.infinity,
                            height: 60,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                elevation: 0,
                              ),
                              onPressed: () {
                                if (_currentPage < 2) {
                                  _controller.nextPage(
                                      duration: 500.ms,
                                      curve: Curves.easeOutCubic);
                                } else {
                                  context.go('/login');
                                }
                              },
                              child: Text(
                                _currentPage == 2 ? 'Get Started' : 'Continue',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                          if (_currentPage == 2)
                            TextButton(
                              onPressed: () => context.go('/login'),
                              child: Text('Skip',
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.5))),
                            ),
                        ],
                      ),
                    ),
                  ),
                ).animate().slideY(begin: 0.2, duration: 600.ms),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
