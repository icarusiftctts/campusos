class MockAttendanceData {
  static final devSharmaData = {
    "student_profile": {
      "name": "Dev Sharma",
      "roll_number": "24UCS202",
      "batch": "Y24",
      "semester": "IV (Even 2025-26)",
      "institute_name": "The LNM Institute of Information Technology, Jaipur",
      "department_name": "Computer Science & Engineering",
      "generated_on": "2026-06-06"
    },
    "courses": [
      {
        "course_code": "CS201",
        "course_name": "Data Structures & Algorithms",
        "attendance_record": {
          "conducted": 38,
          "attended": 35,
          "required_percentage": 75.0,
          "actual_percentage": 92.1,
          "status": "Safe"
        },
        "derived": {
          "can_miss_more_classes": 8,
          "must_attend_next_classes": false,
          "attendance_risk_level": "Safe"
        }
      },
      {
        "course_code": "CS207",
        "course_name": "Operating Systems",
        "attendance_record": {
          "conducted": 35,
          "attended": 32,
          "required_percentage": 75.0,
          "actual_percentage": 91.4,
          "status": "Safe"
        },
        "derived": {
          "can_miss_more_classes": 7,
          "must_attend_next_classes": false,
          "attendance_risk_level": "Safe"
        }
      }
      // Add other courses from Page 1/3 here following the same structure
    ],
    "weekly_timetable": [
      {
        "day": "Monday",
        "start_time": "08:00",
        "end_time": "09:00",
        "course_code": "CS201",
        "course_name": "Data Structures & Algorithms",
        "class_type": "Lecture",
        "venue": "Room 201"
      },
      {
        "day": "Monday",
        "start_time": "10:00",
        "end_time": "11:00",
        "course_code": "CS203",
        "course_name": "Comp. Org. & Architecture",
        "class_type": "Lecture",
        "venue": "Room 305"
      }
      // Add other slots from Page 2 here
    ],
    "academic_events": [
      {
        "event_type": "Minor Exam I",
        "course_code": "CS201",
        "course_name": "Data Structures & Algorithms",
        "date": "2026-06-15",
        "description": "Unit 1-2: Arrays, Linked Lists, Stacks & Queues",
        "priority": "High",
        "days_until_event": 9
      },
      {
        "event_type": "Assignment",
        "course_code": "HS201",
        "course_name": "Technical Communication",
        "date": "2026-06-20",
        "description": "Technical Report Writing - Submission Deadline",
        "priority": "Medium",
        "days_until_event": 14
      }
    ],
    "summary": {
      "total_courses": 7,
      "total_credits": 19,
      "safe_courses_count": 7,
      "warning_courses_count": 0,
      "critical_courses_count": 0,
      "next_upcoming_event": "Minor Exam I - CS201",
      "next_class_by_day": {
        "Monday": "08:00 - CS201",
        "Tuesday": "09:00 - CS207"
      }
    }
  };
}
