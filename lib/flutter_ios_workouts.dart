library;

part 'workout_activity_type.dart';
part 'workout.dart';

class FlutterIosWorkouts {
  Future<String?> getPlatformVersion() {
    return FlutterIosWorkoutsPlatform.instance.getPlatformVersion();
  }
}
