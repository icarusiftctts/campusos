import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/models/attendance_schema.dart';
import 'attendance_ring.dart';
import 'insights_card.dart';
import 'subject_attendance_card.dart';

class AttendanceDashboardContent extends StatelessWidget {
  final AttendanceData data;

  const AttendanceDashboardContent({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    // Aggregated Stats
    final totalAttended = data.courses.fold<int>(
        0, (sum, item) => sum + (item.attendance_record.attended ?? 0));
    final totalConducted = data.courses.fold<int>(
        0, (sum, item) => sum + (item.attendance_record.conducted ?? 0));
    final overallPercentage =
        totalConducted == 0 ? 0.0 : (totalAttended / totalConducted) * 100;

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // SECTION 1: Dynamic Header
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 60, 24, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.student_profile.name ?? 'Student',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Safe in ${data.summary.safe_courses_count} subjects",
                  style: GoogleFonts.inter(
                    color: const Color(0xFFA1A1AA),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1),
        ),

        // SECTION 2: Hero Progress Ring
        SliverToBoxAdapter(
          child: AttendanceRing(
            overallPercentage: overallPercentage,
            attended: totalAttended,
            conducted: totalConducted,
          )
              .animate()
              .fadeIn(delay: 200.ms)
              .scale(begin: const Offset(0.95, 0.95)),
        ),

        // SECTION 3: Quick Insights Row
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: SizedBox(
              height: 110,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                  InsightCard(
                      title: "Can Skip",
                      value:
                          "${data.courses.fold<int>(0, (p, c) => p + (c.derived.can_miss_more_classes ?? 0))} Classes",
                      color: const Color(0xFF22C55E)),
                  const SizedBox(width: 12),
                  InsightCard(
                      title: "Upcoming",
                      value:
                          data.summary.next_upcoming_event?.split('-').first ??
                              "No events",
                      color: const Color(0xFF8B5CF6)),
                  const SizedBox(width: 12),
                  InsightCard(
                      title: "Critical",
                      value: "${data.summary.critical_courses_count} Subjects",
                      color: const Color(0xFFEF4444)),
                ],
              ),
            ),
          ).animate().fadeIn(delay: 400.ms),
        ),

        // SECTION 4: Subject List
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final course = data.courses[index];
                final statusColor =
                    _getStatusColor(course.derived.attendance_risk_level);

                return SubjectAttendanceCard(
                  name: course.course_name,
                  code: course.course_code,
                  percentage: course.attendance_record.actual_percentage ?? 0.0,
                  bunks: course.derived.can_miss_more_classes ?? 0,
                  statusColor: statusColor,
                )
                    .animate()
                    .fadeIn(delay: (500 + (index * 100)).ms)
                    .slideY(begin: 0.1);
              },
              childCount: data.courses.length,
            ),
          ),
        ),

        // Bottom Spacer for Floating Nav Bar
        const SliverToBoxAdapter(child: SizedBox(height: 120)),
      ],
    );
  }

  Color _getStatusColor(String? riskLevel) {
    switch (riskLevel?.toLowerCase()) {
      case 'safe':
        return const Color(0xFF22C55E);
      case 'warning':
        return const Color(0xFFF59E0B);
      case 'critical':
        return const Color(0xFFEF4444);
      default:
        return Colors.white24;
    }
  }
}
