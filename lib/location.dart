part of 'flutter_ios_workouts.dart';

/// Equivalent to CLLocation in iOS
class Location {

  /// The latitude in degrees.
  final double latitude;

  /// The longitude in degrees.
  final double longitude;

  /// The altitude above mean sea level associated with a location, measured in meters.
  final double altitude;

  /// The radius of uncertainty for the location, measured in meters.
  final double horizontalAccuracy;

  /// The validity of the altitude values, and their estimated uncertainty, measured in meters.
  final double verticalAccuracy;

  /// The instantaneous speed of the device, measured in meters per second.
  final double speed;

  /// The accuracy of the speed value, measured in meters per second.
  final double speedAccuracy;

  /// The direction in which the device is traveling, measured in degrees and relative to due north.
  final double course;

  /// The accuracy of the course value, measured in degrees.
  final double courseAccuracy;

  /// The time at which this location was determined.
  final DateTime timestamp;

  const Location({
    required this.latitude,
    required this.longitude,
    required this.altitude,
    required this.horizontalAccuracy,
    required this.verticalAccuracy,
    required this.speed,
    required this.speedAccuracy,
    required this.course,
    required this.courseAccuracy,
    required this.timestamp,
  });

  factory Location.fromMap(Map<Object?, Object?> map) {
    return Location(
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      altitude: map['altitude'] as double,
      horizontalAccuracy: map['horizontalAccuracy'] as double,
      verticalAccuracy: map['verticalAccuracy'] as double,
      speed: map['speed'] as double,
      speedAccuracy: map['speedAccuracy'] as double,
      course: map['course'] as double,
      courseAccuracy: map['courseAccuracy'] as double,
      timestamp: DateTime.parse(map['timestamp'] as String),
    );
  }

  @override
  String toString() {
    return 'Location{latitude: $latitude, longitude: $longitude, altitude: $altitude, horizontalAccuracy: $horizontalAccuracy, verticalAccuracy: $verticalAccuracy, speed: $speed, speedAccuracy: $speedAccuracy, course: $course, courseAccuracy: $courseAccuracy, timestamp: $timestamp}';
  }
}
