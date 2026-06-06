enum AttendanceStatus { safe, warning, critical }

class Subject {
  final String id;
  final String name;
  final String code;
  final int attended;
  final int conducted;

  Subject({
    required this.id,
    required this.name,
    required this.code,
    required this.attended,
    required this.conducted,
  });

  double get percentage => conducted == 0 ? 0.0 : (attended / conducted) * 100;

  int get safeBunks {
    // Threshold is 75%
    if (percentage < 75) return 0;
    return ((attended - (0.75 * conducted)) / 0.75).floor();
  }

  AttendanceStatus get status {
    if (percentage >= 85) return AttendanceStatus.safe;
    if (percentage >= 75) return AttendanceStatus.warning;
    return AttendanceStatus.critical;
  }
}
