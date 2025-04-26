import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_ios_workouts_platform_interface.dart';

/// An implementation of [FlutterIosWorkoutsPlatform] that uses method channels.
class MethodChannelFlutterIosWorkouts extends FlutterIosWorkoutsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_ios_workouts');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
