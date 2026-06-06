import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/gemini_service.dart'; // Existing service
import '../data/models/attendance_schema.dart';
import '../data/repositories/attendance_repository.dart';

final attendanceRepositoryProvider = Provider((ref) {
  final model =
      ref.watch(geminiModelProvider); // Assume this is in your core services
  return AttendanceRepository(model);
});


Future<void> processPdf(File file) async {
  state = const AsyncLoading();
  state = await AsyncValue.guard(() async {
    final repo = ref.read(attendanceRepositoryProvider);
final attendanceStateProvider =
    AsyncNotifierProvider<AttendanceNotifier, AttendanceData?>(() {
  return AttendanceNotifier();
});

class AttendanceNotifier extends AsyncNotifier<AttendanceData?> {
  @override
  Future<AttendanceData?> build() async {
    return null; // Initial state is null (Empty State)
  }
      return await repo.parseAcademicPdf(file);
    });
  }
}
