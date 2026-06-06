import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/attendance_schema.dart';
import '../data/repositories/attendance_repository.dart';

// Assuming geminiModelProvider exists in core services
final geminiModelProvider = Provider((ref) => throw UnimplementedError());

final attendanceRepositoryProvider = Provider((ref) {
  final model = ref.watch(geminiModelProvider);
  return AttendanceRepository(model);
});

final attendanceStateProvider = AsyncNotifierProvider<AttendanceNotifier, AttendanceData?>(() {
  return AttendanceNotifier();
});

class AttendanceNotifier extends AsyncNotifier<AttendanceData?> {
  @override
  Future<AttendanceData?> build() async {
    return null;
  }

  Future<void> processPdf(File file) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(attendanceRepositoryProvider);
      return await repo.parseAcademicPdf(file);
    });
  }
}
