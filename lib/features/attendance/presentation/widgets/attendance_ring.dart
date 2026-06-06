import 'package:flutter/material.dart';

class AttendanceRing extends StatelessWidget {
  final double overallPercentage;
  final int attended;
  final int conducted;

  const AttendanceRing({
    super.key,
    required this.overallPercentage,
    required this.attended,
    required this.conducted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: Colors.white.withOpacity(0.04),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background Glow
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: const Color(0xFF6C63FF).withOpacity(0.2),
                    blurRadius: 40,
                    spreadRadius: 10)
              ],
            ),
          ),
          // Percentage Ring
          SizedBox(
            width: 180,
            height: 180,
            child: CircularProgressIndicator(
              value: overallPercentage / 100,
              strokeWidth: 12,
              backgroundColor: Colors.white.withOpacity(0.05),
              color: const Color(0xFF6C63FF),
              strokeCap: StrokeCap.round,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${overallPercentage.toInt()}%',
                  style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      color: Colors.white)),
              Text('$attended / $conducted',
                  style:
                      const TextStyle(fontSize: 14, color: Color(0xFFA1A1AA))),
              const SizedBox(height: 8),
              _buildStatusChip(),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildStatusChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF22C55E).withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF22C55E).withOpacity(0.3)),
      ),
      child: const Text('SAFE',
          style: TextStyle(
              color: Color(0xFF22C55E),
              fontWeight: FontWeight.bold,
              fontSize: 12)),
    );
  }
}
