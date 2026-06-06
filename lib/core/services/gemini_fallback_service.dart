import 'dart:convert';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:hive/hive.dart';

import '../../features/flashcards/data/models/flashcard_model.dart';

class GeminiFallbackService {
  static const String _apiKey = 'AQ.Ab8RN6JfCPTwh3Bh6jseqrnFUz3b6T7lqrrmwyp6RCAf_Rsm8A';

  late final GenerativeModel _model;

  GeminiFallbackService() {
    _model = GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: _apiKey,
    );
  }

  Future<List<Flashcard>> generateFlashcards({
    required String transcript,
    required String deckName,
  }) async {
    final prompt = '''
You are an educational assistant.

Convert the lecture transcript into exactly 10 flashcards.

Rules:
- Return ONLY JSON.
- No markdown.
- No explanations.
- No text before or after JSON.

Format:

[
  {
    "question":"What is polymorphism?",
    "answer":"Ability of an object to take multiple forms."
  }
]

Lecture:

$transcript
''';

    final response = await _model.generateContent(
      [Content.text(prompt)],
    );

    final text = response.text;

    if (text == null || text.isEmpty) {
      throw Exception('Gemini returned empty response');
    }

    final cleaned = _extractJson(text);

    final List<dynamic> data = jsonDecode(cleaned);

    final flashcards = data.map((item) {
      return Flashcard(
        question: item['question']?.toString() ?? '',
        answer: item['answer']?.toString() ?? '',
        deckName: deckName,
        createdAt: DateTime.now(),
      );
    }).toList();

    await Hive.box<Flashcard>(
      'flashcards',
    ).addAll(flashcards);

    return flashcards;
  }

  String _extractJson(String text) {
    final start = text.indexOf('[');
    final end = text.lastIndexOf(']');

    if (start == -1 || end == -1) {
      throw Exception(
        'Gemini did not return JSON.\n$text',
      );
    }

    return text.substring(start, end + 1);
  }
}
