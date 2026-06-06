class AttendanceData {
  final StudentProfile student_profile;
  final List<CourseRecord> courses;
  final List<dynamic> weekly_timetable;
  final List<dynamic> academic_events;
  final Summary summary;

  AttendanceData({
    required this.student_profile,
    required this.courses,
    required this.weekly_timetable,
    required this.academic_events,
    required this.summary,
  });

  factory AttendanceData.fromJson(Map<String, dynamic> json) {
    return AttendanceData(
      student_profile: StudentProfile.fromJson(json['student_profile'] ?? {}),
      courses: (json['courses'] as List? ?? []).map((e) => CourseRecord.fromJson(e)).toList(),
      weekly_timetable: json['weekly_timetable'] ?? [],
      academic_events: json['academic_events'] ?? [],
      summary: Summary.fromJson(json['summary'] ?? {}),
    );
  }
}

class StudentProfile {
  final String? name;
  final String? rollNumber;

  StudentProfile({this.name, this.rollNumber});

  factory StudentProfile.fromJson(Map<String, dynamic> json) {
    return StudentProfile(
      name: json['name'],
      rollNumber: json['roll_number'],
    );
  }
}

class CourseRecord {
  final String course_code;
  final String course_name;
  final AttendanceRecord attendance_record;
  final DerivedData derived;

  CourseRecord({
    required this.course_code,
    required this.course_name,
    required this.attendance_record,
    required this.derived,
  });

  factory CourseRecord.fromJson(Map<String, dynamic> json) {
    return CourseRecord(
      course_code: json['course_code'] ?? 'N/A',
      course_name: json['course_name'] ?? 'Unknown Subject',
      attendance_record: AttendanceRecord.fromJson(json['attendance_record'] ?? {}),
      derived: DerivedData.fromJson(json['derived'] ?? {}),
    );
  }
}

class AttendanceRecord {
  final int? attended;
  final int? conducted;
  final double? actual_percentage;

  AttendanceRecord({this.attended, this.conducted, this.actual_percentage});

  factory AttendanceRecord.fromJson(Map<String, dynamic> json) {
    return AttendanceRecord(
      attended: json['attended'],
      conducted: json['conducted'],
      actual_percentage: (json['actual_percentage'] as num?)?.toDouble(),
    );
  }
}

class DerivedData {
  final int? can_miss_more_classes;
  final String? attendance_risk_level;

  DerivedData({this.can_miss_more_classes, this.attendance_risk_level});

  factory DerivedData.fromJson(Map<String, dynamic> json) {
    return DerivedData(
      can_miss_more_classes: json['can_miss_more_classes'],
      attendance_risk_level: json['attendance_risk_level'],
    );
  }
}

class Summary {
  final int safe_courses_count;
  final int critical_courses_count;
  final String? next_upcoming_event;

  Summary({
    this.safe_courses_count = 0,
    this.critical_courses_count = 0,
    this.next_upcoming_event,
  });

  factory Summary.fromJson(Map<String, dynamic> json) {
    return Summary(
      safe_courses_count: json['safe_courses_count'] ?? 0,
      critical_courses_count: json['critical_courses_count'] ?? 0,
      next_upcoming_event: json['next_upcoming_event'],
    );
  }
}
