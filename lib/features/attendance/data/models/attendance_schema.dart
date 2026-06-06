import 'package:flutter/foundation.dart';

class AttendanceData {
  final StudentProfile studentProfile;
  final List<CourseRecord> courses;
  final List<TimetableEntry> weeklyTimetable;
  final List<AcademicEvent> academicEvents;
  final Summary summary;

  AttendanceData({
    required this.studentProfile,
    required this.courses,
    required this.weeklyTimetable,
    required this.academicEvents,
    required this.summary,
  });

  factory AttendanceData.fromJson(Map<String, dynamic> json) {
    return AttendanceData(
      studentProfile: StudentProfile.fromJson(json['student_profile']),
      courses: (json['courses'] as List)
          .map((e) => CourseRecord.fromJson(e))
          .toList(),
      weeklyTimetable: (json['weekly_timetable'] as List)
          .map((e) => TimetableEntry.fromJson(e))
          .toList(),
      academicEvents: (json['academic_events'] as List)
          .map((e) => AcademicEvent.fromJson(e))
          .toList(),
      summary: Summary.fromJson(json['summary']),
    );
  }
}

class CourseRecord {
  final String courseCode;
  final String courseName;
  final AttendanceRecord attendanceRecord;
  final DerivedData derived;

  CourseRecord({
    required this.courseCode,
    required this.courseName,
    required this.attendanceRecord,
    required this.derived,
  });

  factory CourseRecord.fromJson(Map<String, dynamic> json) {
    return CourseRecord(
      courseCode: json['course_code'] ?? 'N/A',
      courseName: json['course_name'] ?? 'Unknown Subject',
      attendanceRecord: AttendanceRecord.fromJson(json['attendance_record']),
      derived: DerivedData.fromJson(json['derived']),
    );
  }
}

// Sub-models for AttendanceRecord, DerivedData, TimetableEntry, etc. follow the same pattern...
