import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../widgets/interactive_class_card.dart';

class TodayClassesPage extends StatelessWidget {
  const TodayClassesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Ambient Glow behind the timeline
          Positioned(
            left: 20,
            top: 100,
            bottom: 0,
            child: Container(
              width: 2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.secondary.withOpacity(0.3),
                    AppColors.primary.withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),

          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                expandedHeight: 120,
                backgroundColor: Colors.transparent,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  title: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Today\'s Schedule',
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: Colors.white)),
                      Text('Monday, 12 Sept',
                          style: GoogleFonts.inter(
                              fontSize: 12, color: Colors.white54)),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 100),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    const InteractiveClassCard(
                      time: '08:00',
                      subject: 'Data Structures',
                      room: 'Room 201',
                      isCurrent: false,
                      initialStatus: 'present',
                    ),
                    const InteractiveClassCard(
                      time: '10:00',
                      subject: 'Comp. Org. & Architecture',
                      room: 'Room 305',
                      isCurrent: true, // Glowing state
                    ),
                    const InteractiveClassCard(
                      time: '11:00',
                      subject: 'Discrete Mathematics',
                      room: 'Room 201',
                      isCurrent: false,
                      riskImpact: '74.2% if missed',
                    ),
                    const InteractiveClassCard(
                      time: '14:00',
                      subject: 'Data Structures Lab',
                      room: 'Lab-1',
                      isCurrent: false,
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
