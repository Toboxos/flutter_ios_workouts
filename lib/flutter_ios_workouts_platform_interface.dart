import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_ios_workouts_method_channel.dart';

abstract class FlutterIosWorkoutsPlatform extends PlatformInterface {
  /// Constructs a FlutterIosWorkoutsPlatform.
  FlutterIosWorkoutsPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterIosWorkoutsPlatform _instance = MethodChannelFlutterIosWorkouts();

  /// The default instance of [FlutterIosWorkoutsPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterIosWorkouts].
  static FlutterIosWorkoutsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterIosWorkoutsPlatform] when
  /// they register themselves.
  static set instance(FlutterIosWorkoutsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
