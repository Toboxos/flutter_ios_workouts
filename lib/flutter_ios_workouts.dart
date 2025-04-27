library;

import 'package:flutter/services.dart';

part 'workout_activity_type.dart';
part 'workout.dart';
part 'location.dart';

/// Main plugin class 
class WorkoutsPlugin {
  static const MethodChannel _channel = MethodChannel("flutter_ios_workouts");

  /// Plugin setup. Must be called before using any other methods.
  static Future<void> setup() async {
    await _channel.invokeMethod("setup");
  }

  /// Request authorization to read workouts and their corresponding routes
  static Future<bool> requestAuthorization() async {
    return await _channel.invokeMethod<bool>("requestAuthorization") ?? false;
  }

  /// Returns a list of workouts from the ios health store
  static Future<List<Workout>> getWorkouts({
    required DateTime start,
    required DateTime end,
  }) async {
    /// swift cannot parse microseconds in time string.
    /// remove here so flutter do not add them in formatted string.
    final startUtc = start.toUtc().subtract(Duration(microseconds: start.microsecond));
    final endUtc = end.toUtc().subtract(Duration(microseconds: end.microsecond));

    final List<dynamic>? results = await _channel.invokeMethod<List<dynamic>>("getWorkouts", {
        "startTime": startUtc.toIso8601String(),
        "endTime": endUtc.toIso8601String(),
    });

    if (results == null) {
      return [];
    }

    return results.map( (dynamic item) => Workout.fromMap(item) ).toList();
  }

  /// For a given workout, returns the route taken during the workout.
  static Future<List<Location>> getWorkoutRoute({required String workoutUuid}) async {
    final List<dynamic>? results = await _channel.invokeMethod<List<dynamic>>('fetchRoute', {
      'uuid': workoutUuid,
    });

    if( results == null ) {
      return [];
    }

    return results.map( (dynamic item) => Location.fromMap(item) ).toList();
  }
}
