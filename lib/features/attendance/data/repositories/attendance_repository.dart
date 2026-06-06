import 'dart:convert';
import 'dart:io';

import 'package:google_generative_ai/google_generative_ai.dart';

import '../models/attendance_schema.dart';

class AttendanceRepository {
  final GenerativeModel _model;

  AttendanceRepository(this._model);

  static const String _systemPrompt = """
  You are an academic document extraction and reasoning engine...
  (Your full system prompt here)
  """;

  Future<AttendanceData> parseAcademicPdf(File pdfFile) async {
    final bytes = await pdfFile.readAsBytes();

    final content = [
      Content.multi([
        TextPart(_systemPrompt),
        DataPart('application/pdf', bytes),
      ])
    ];

    final response = await _model.generateContent(content);
    final text = response.text;

    if (text == null) throw Exception("Empty response from AI");

    // Clean JSON from potential markdown wrappers
    final cleanJson =
        text.replaceAll('```json', '').replaceAll('```', '').trim();

    return AttendanceData.fromJson(jsonDecode(cleanJson));
  }
}
