import 'package:flutter/material.dart';

class UpcomingAcademicsPage extends StatelessWidget {
  const UpcomingAcademicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1117),
      appBar: AppBar(
          title: const Text('Upcoming Academics'),
          backgroundColor: Colors.transparent),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _AcademicEventCard(
            title: "Minor Exam I",
            subject: "DSA",
            date: "15 June",
            daysLeft: "7 days",
            color: const Color(0xFFF59E0B),
          ),
          _AcademicEventCard(
            title: "Lab Submission",
            subject: "OS",
            date: "18 June",
            daysLeft: "10 days",
            color: const Color(0xFF8B5CF6),
          ),
        ],
      ),
    );
  }
}

class _AcademicEventCard extends StatelessWidget {
  final String title, subject, date, daysLeft;
  final Color color;

  const _AcademicEventCard({
    super.key,
    required this.title,
    required this.subject,
    required this.date,
    required this.daysLeft,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 4,
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(2)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                Text(subject,
                    style: const TextStyle(
                        color: Color(0xFFA1A1AA), fontSize: 12)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(date,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              Text("In $daysLeft",
                  style: TextStyle(color: color, fontSize: 12)),
            ],
          )
        ],
      ),
    );
  }
}
