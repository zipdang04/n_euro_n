import 'package:hive/hive.dart';

part 'exerciseInstance.g.dart';

@HiveType(typeId: 0)
class ExerciseInstance {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String exerciseName;
  @HiveField(2)
  final int score;
  @HiveField(3)
  final DateTime dateTime;
  ExerciseInstance({
    required this.id,
    required this.exerciseName,
    required this.score,
    required this.dateTime,
  });
}