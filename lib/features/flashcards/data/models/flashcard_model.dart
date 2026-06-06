import 'package:hive/hive.dart';

part 'flashcard_model.g.dart';

@HiveType(typeId: 1)
class Flashcard extends HiveObject {
  @HiveField(0)
  final String question;
  @HiveField(1)
  final String answer;
  @HiveField(2)
  final String deckName;
  @HiveField(3)
  final DateTime createdAt;

  Flashcard({
    required this.question,
    required this.answer,
    required this.deckName,
    required this.createdAt,
  });
}
