import 'dart:io';

import 'package:campus_os/features/attendance/presentation/widgets/dashboard_content.dart';
import 'package:campus_os/features/attendance/providers/attendance_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AttendanceDashboardPage extends ConsumerWidget {
  const AttendanceDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attendanceState = ref.watch(attendanceStateProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0F1117),
      body: attendanceState.when(
        data: (data) => data == null
            ? _buildEmptyState(context, ref)
            : AttendanceDashboardContent(data: data),
        loading: () => _buildLoadingState(),
        error: (err, stack) => _buildErrorState(err.toString(), ref),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.picture_as_pdf_outlined,
                size: 80, color: Color(0xFF6C63FF)),
            const SizedBox(height: 24),
            const Text(
              "Import your timetable",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              "Upload your academic PDF and we'll organize everything automatically.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFFA1A1AA), fontSize: 14),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => _pickFile(ref),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6C63FF),
                minimumSize: const Size(200, 56),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28)),
              ),
              child: const Text("Upload PDF",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(color: Color(0xFF6C63FF)),
          const SizedBox(height: 24),
          Text("Analyzing your curriculum...",
              style: TextStyle(color: Colors.white.withOpacity(0.7))),
        ],
      ),
    );
  }

  Future<void> _pickFile(WidgetRef ref) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result == null) return;

      final path = result.files.single.path;
      if (path == null) return;

      final file = File(path);
      await ref.read(attendanceStateProvider.notifier).processPdf(file);
    } catch (e) {
      debugPrint('File picker error: $e');
    }
  }

  Widget _buildErrorState(String error, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 48),
          const SizedBox(height: 16),
          Text("Failed to parse PDF", style: TextStyle(color: Colors.white)),
          TextButton(
              onPressed: () => ref.refresh(attendanceStateProvider),
              child: const Text("Try Again")),
        ],
      ),
    );
  }
}
