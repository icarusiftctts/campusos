import 'package:hive/hive.dart';

part 'lecture_model.g.dart';

@HiveType(typeId: 0)
class LectureModel extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  final String rawTranscript;
  @HiveField(3)
  String notes;
  @HiveField(4)
  final DateTime createdAt;

  LectureModel({
    required this.id,
    required this.title,
    required this.rawTranscript,
    required this.notes,
    required this.createdAt,
  });
}
