
import 'flutter_ios_workouts_platform_interface.dart';

class FlutterIosWorkouts {
  Future<String?> getPlatformVersion() {
    return FlutterIosWorkoutsPlatform.instance.getPlatformVersion();
  }
}
