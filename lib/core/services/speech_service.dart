import 'package:speech_to_text/speech_to_text.dart';

class SpeechService {
  final SpeechToText _speech = SpeechToText();

  String transcript = '';

  Future<bool> initialize() async {
    return await _speech.initialize();
  }

  Future<void> startListening() async {
    transcript = '';

    await _speech.listen(
      onResult: (result) {
        transcript = result.recognizedWords;
      },
      listenMode: ListenMode.dictation,
      partialResults: true,
    );
  }

  Future<String> stopListening() async {
    await _speech.stop();
    return transcript;
  }
}
