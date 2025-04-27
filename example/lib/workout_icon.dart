import 'package:flutter/material.dart';
import 'package:flutter_ios_workouts/flutter_ios_workouts.dart';

IconData getWorkoutIcon(WorkoutActivityType activityType) {
  switch (activityType) {
    case WorkoutActivityType.walking:
      return Icons.directions_walk;
    case WorkoutActivityType.running:
      return Icons.directions_run;
    case WorkoutActivityType.hiking:
      return Icons.hiking;
    case WorkoutActivityType.cycling:
      return Icons.directions_bike;
    case WorkoutActivityType.swimming:
      return Icons.pool;
    default:
      return Icons.fitness_center;
  }
}