import 'package:flutter/material.dart';

class SubjectAttendanceCard extends StatelessWidget {
  final String name;
  final String code;
  final double percentage;
  final int bunks;
  final Color statusColor;

  const SubjectAttendanceCard({
    super.key,
    required this.name,
    required this.code,
    required this.percentage,
    required this.bunks,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  Text(code,
                      style: const TextStyle(
                          color: Color(0xFFA1A1AA), fontSize: 12)),
                ],
              ),
              Text('${percentage.toStringAsFixed(1)}%',
                  style: TextStyle(
                      color: statusColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w900)),
            ],
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: percentage / 100,
            backgroundColor: Colors.white.withOpacity(0.05),
            color: statusColor,
            borderRadius: BorderRadius.circular(10),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.info_outline, size: 14, color: statusColor),
              const SizedBox(width: 6),
              Text(
                bunks > 0
                    ? "Can miss: $bunks more classes"
                    : "Attend next class",
                style: TextStyle(
                    color: statusColor.withOpacity(0.8), fontSize: 12),
              ),
            ],
          )
        ],
      ),
    );
  }
}
