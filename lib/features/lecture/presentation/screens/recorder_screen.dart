import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/services/gemini_fallback_service.dart';
import '../../../../core/services/speech_service.dart';
import '../../data/models/lecture_model.dart';

class RecorderScreen extends StatefulWidget {
  const RecorderScreen({super.key});

  @override
  State<RecorderScreen> createState() => _RecorderScreenState();
}

class _RecorderScreenState extends State<RecorderScreen> {
  bool isRecording = false;
  bool isProcessing = false;

  final SpeechService _speechService = SpeechService();

  final GeminiFallbackService _llmService = GeminiFallbackService();
  Duration duration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _speechService.initialize();
  }

  Future<void> _toggleRecording() async {
    if (!isRecording) {
      await _speechService.startListening();

      setState(() {
        isRecording = true;
      });

      return;
    }

    setState(() {
      isRecording = false;
      isProcessing = true;
    });

    try {
      final transcript = await _speechService.stopListening();

      final lecture = LectureModel(
        id: Uuid().v4(),
        title: 'Lecture ${DateTime.now().day}/${DateTime.now().month}',
        rawTranscript: transcript,
        notes: '',
        createdAt: DateTime.now(),
      );

      await Hive.box<LectureModel>(
        'lectures',
      ).add(lecture);

      await _llmService.generateFlashcards(
        transcript: transcript,
        deckName: lecture.title,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Flashcards Generated Successfully',
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error: $e',
          ),
        ),
      );
    }

    setState(() {
      isProcessing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lecture Recorder'),
      ),
      body: Center(
        child: isProcessing
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: _toggleRecording,
                child: Text(
                  isRecording ? 'Stop Recording' : 'Start Recording',
                ),
              ),
      ),
    );
  }
}
