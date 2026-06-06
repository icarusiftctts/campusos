import 'dart:convert';

import 'package:campus_os/features/flashcards/data/models/flashcard_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

class OnDeviceLlmService {
  static const MethodChannel _channel = MethodChannel('gemma_inference');

  static const String _modelPath =
      '/storage/emulated/0/Download/model/gemma-4-E4B-it.litertlm';

  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;

    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.any,
    );

    if (result == null) {
      throw Exception('No model selected');
    }

    final path = result.files.single.path;

    if (path == null) {
      throw Exception('Selected file has no path');
    }

    print('MODEL PATH: $path');

    await _channel.invokeMethod(
      'initialize',
      {
        'modelPath': path,
      },
    );

    _initialized = true;
  }

  Future<String> prompt(String prompt) async {
    await initialize();

    final response = await _channel.invokeMethod<String>(
      'runInference',
      {
        'prompt': prompt,
      },
    );

    if (response == null || response.trim().isEmpty) {
      throw Exception('Gemma returned empty response');
    }

    return response;
  }

  Future<String> summarizeTranscript(
    String transcript,
  ) async {
    await initialize();

    final summaryPrompt = '''
You are an expert lecture summarizer.

Create concise study notes from the lecture.

Rules:
- Focus only on important concepts.
- Remove filler content.
- Keep definitions.
- Keep formulas if present.
- Use bullet points.
- Maximum 500 words.

Lecture:

$transcript
''';

    return await prompt(summaryPrompt);
  }

  Future<List<Flashcard>> generateFlashcards({
    required String transcript,
    required String deckName,
  }) async {
    await initialize();

    final summary = await summarizeTranscript(transcript);

    final flashcardPrompt = '''
You are an educational assistant.

Create exactly 10 flashcards from the notes below.

Rules:
- Return ONLY valid JSON.
- No markdown.
- No explanations.
- No text before or after JSON.

Format:

[
  {
    "question":"What is X?",
    "answer":"X is ..."
  }
]

Notes:

$summary
''';

    final response = await prompt(flashcardPrompt);

    final cleaned = _extractJsonArray(response);

    final List<dynamic> decoded = jsonDecode(cleaned);

    final flashcards = decoded.map((item) {
      return Flashcard(
        question: item['question']?.toString() ?? '',
        answer: item['answer']?.toString() ?? '',
        deckName: deckName,
        createdAt: DateTime.now(),
      );
    }).toList();

    final box = Hive.box<Flashcard>('flashcards');

    await box.addAll(flashcards);

    return flashcards;
  }

  String _extractJsonArray(String text) {
    final start = text.indexOf('[');
    final end = text.lastIndexOf(']');

    if (start == -1 || end == -1) {
      throw Exception(
        'Gemma did not return valid JSON.\n\nResponse:\n$text',
      );
    }

    return text.substring(
      start,
      end + 1,
    );
  }

  Future<bool> testModel() async {
    try {
      final response = await prompt(
        'What is a binary tree? Answer in one sentence.',
      );

      return response.trim().isNotEmpty;
    } catch (_) {
      return false;
    }
  }
}
