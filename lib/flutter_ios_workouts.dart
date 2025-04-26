library;

part 'workout_activity_type.dart';
part 'workout.dart';
part 'location.dart';

class FlutterIosWorkouts {
  Future<String?> getPlatformVersion() {
    return FlutterIosWorkoutsPlatform.instance.getPlatformVersion();
  }
}
