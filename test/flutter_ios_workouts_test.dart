import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ios_workouts/flutter_ios_workouts.dart';
import 'package:flutter_ios_workouts/flutter_ios_workouts_platform_interface.dart';
import 'package:flutter_ios_workouts/flutter_ios_workouts_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterIosWorkoutsPlatform
    with MockPlatformInterfaceMixin
    implements FlutterIosWorkoutsPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterIosWorkoutsPlatform initialPlatform = FlutterIosWorkoutsPlatform.instance;

  test('$MethodChannelFlutterIosWorkouts is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterIosWorkouts>());
  });

  test('getPlatformVersion', () async {
    FlutterIosWorkouts flutterIosWorkoutsPlugin = FlutterIosWorkouts();
    MockFlutterIosWorkoutsPlatform fakePlatform = MockFlutterIosWorkoutsPlatform();
    FlutterIosWorkoutsPlatform.instance = fakePlatform;

    expect(await flutterIosWorkoutsPlugin.getPlatformVersion(), '42');
  });
}
