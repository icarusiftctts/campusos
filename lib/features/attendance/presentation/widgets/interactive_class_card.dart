import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';

class InteractiveClassCard extends StatefulWidget {
  final String time;
  final String subject;
  final String room;
  final bool isCurrent;
  final String? initialStatus;
  final String? riskImpact;

  const InteractiveClassCard({
    super.key,
    required this.time,
    required this.subject,
    required this.room,
    this.isCurrent = false,
    this.initialStatus,
    this.riskImpact,
  });

  @override
  State<InteractiveClassCard> createState() => _InteractiveClassCardState();
}

class _InteractiveClassCardState extends State<InteractiveClassCard> {
  String? status;

  @override
  void initState() {
    super.initState();
    status = widget.initialStatus;
  }

  void _markAttendance(String newStatus) {
    HapticFeedback.mediumImpact();
    setState(() => status = newStatus);
    // TODO: Update Riverpod / Firestore
  }

  @override
  Widget build(BuildContext context) {
    bool isMarked = status != null;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline Node
          Column(
            children: [
              const SizedBox(height: 12),
              _buildTimelineNode(),
            ],
          ),
          const SizedBox(width: 20),

          // Main Card
          Expanded(
            child: GlassContainer(
              opacity: widget.isCurrent ? 0.12 : 0.06,
              radius: 24,
              child: AnimatedContainer(
                duration: 400.ms,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: _getStatusColor().withOpacity(isMarked ? 0.4 : 0.1),
                    width: isMarked ? 1.5 : 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.time,
                            style: GoogleFonts.inter(
                                color: widget.isCurrent
                                    ? AppColors.secondary
                                    : Colors.white38,
                                fontWeight: FontWeight.bold,
                                fontSize: 12)),
                        if (widget.riskImpact != null && !isMarked)
                          Text(widget.riskImpact!,
                              style: GoogleFonts.inter(
                                  color: AppColors.error,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(widget.subject,
                        style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 17)),
                    Text(widget.room,
                        style: GoogleFonts.inter(
                            color: Colors.white54, fontSize: 13)),

                    const SizedBox(height: 20),

                    // Interaction Layer
                    AnimatedSwitcher(
                      duration: 300.ms,
                      child: isMarked
                          ? _buildVerifiedBadge()
                          : _buildActionButtons(),
                    ),
                  ],
                ),
              ),
            ).animate(target: widget.isCurrent ? 1 : 0).shimmer(
                delay: 2.seconds, duration: 1.5.seconds, color: Colors.white10),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineNode() {
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        color: widget.isCurrent ? AppColors.secondary : AppColors.surface,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white24, width: 2),
        boxShadow: widget.isCurrent
            ? [
                BoxShadow(
                    color: AppColors.secondary.withOpacity(0.5),
                    blurRadius: 10,
                    spreadRadius: 2)
              ]
            : [],
      ),
    )
        .animate(onPlay: (c) => c.repeat())
        .scale(
            begin: const Offset(1, 1),
            end: const Offset(1.2, 1.2),
            duration: 1.seconds,
            curve: Curves.easeInOut)
        .then()
        .scale(begin: const Offset(1.2, 1.2), end: const Offset(1, 1));
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        _ActionButton(
          label: 'PRESENT',
          icon: Icons.check_circle_outline_rounded,
          color: AppColors.success,
          onTap: () => _markAttendance('present'),
        ),
        const SizedBox(width: 12),
        _ActionButton(
          label: 'ABSENT',
          icon: Icons.cancel_outlined,
          color: AppColors.error,
          onTap: () => _markAttendance('absent'),
        ),
      ],
    );
  }

  Widget _buildVerifiedBadge() {
    bool isPresent = status == 'present';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color:
            (isPresent ? AppColors.success : AppColors.error).withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(isPresent ? Icons.verified_rounded : Icons.block_flipped,
              color: isPresent ? AppColors.success : AppColors.error, size: 18),
          const SizedBox(width: 8),
          Text(isPresent ? 'MARKED PRESENT' : 'MARKED ABSENT',
              style: GoogleFonts.plusJakartaSans(
                  color: isPresent ? AppColors.success : AppColors.error,
                  fontWeight: FontWeight.w900,
                  fontSize: 11,
                  letterSpacing: 0.5)),
        ],
      ),
    ).animate().scale(curve: Curves.easeOut);
  }

  Color _getStatusColor() {
    if (status == 'present') return AppColors.success;
    if (status == 'absent') return AppColors.error;
    return Colors.white10;
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: color.withOpacity(0.08),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withOpacity(0.2)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 18),
              const SizedBox(width: 8),
              Text(label,
                  style: GoogleFonts.plusJakartaSans(
                      color: color, fontWeight: FontWeight.w800, fontSize: 11)),
            ],
          ),
        ),
      ),
    );
  }
}
