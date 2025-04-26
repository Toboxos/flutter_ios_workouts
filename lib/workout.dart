part of 'flutter_ios_workouts.dart';

/// Workout class that represents a workout session
class Workout {
  /// Unique identifier for a workout given by the apple health kit
  final String uuid;

  /// Activity type of the workout
  final WorkoutActivityType workoutActivityType;

  /// Stard date and time of the workout
  final DateTime startDateTime;

  /// End date and time of the workout
  final DateTime endDateTime;


  const Workout({
    required this.uuid,
    required this.workoutActivityType,
    required this.startDateTime,
    required this.endDateTime,
  });

  factory Workout.fromMap(Map<Object?, Object?> map) {
    return Workout(
      uuid: map['uuid'] as String,
      workoutActivityType: WorkoutActivityType.fromValue(map['workoutActivityType'] as int),
      startDateTime: DateTime.parse(map['startDateTime'] as String),
      endDateTime: DateTime.parse(map['endDateTime'] as String),
    );
  }

  @override
  String toString() {
    return 'Workout{uuid: $uuid, workoutActivityType: $workoutActivityType, startDateTime: $startDateTime, endDateTime: $endDateTime}';  
  }
}