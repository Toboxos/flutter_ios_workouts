import Flutter
import UIKit
import HealthKit
import CoreLocation

public class WorkoutsPlugin: NSObject, FlutterPlugin {
  let healthStore = HKHealthStore()

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_ios_workouts", binaryMessenger: registrar.messenger())
    let instance = WorkoutsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "setup":
      setup(result: result)

    case "requestAuthorization":
      requestAuthorization(result: result)
    
    case "getWorkouts":
      getWorkouts(call: call, result: result)

    case "fetchRoute":
      fetchRoute(call: call, result: result)
      
   
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func setup(result: @escaping FlutterResult) {
    guard HKHealthStore.isHealthDataAvailable() else {
      result(FlutterError(code: "HEALTHKIT_UNAVAILABLE", message: "HealthKit is not available on this device", details: nil))
      return
    }

    result(nil)
  }

  private func requestAuthorization(result: @escaping FlutterResult) {
    // todo: Can we somehow handle case user forgot to add healthkit capability?
    healthStore.requestAuthorization(
      toShare: [], 
      read: [HKQuantityType.workoutType(), HKSeriesType.workoutRoute()]) { (success, error) in
      result(success);
    }
  }

  private func getWorkouts(call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard let args = call.arguments as? [String: Any],
          let startTimeString = args["startTime"] as? String,
          let endTimeString = args["endTime"] as? String
    else {
      result(FlutterError(code: "INVALID_ARGUMENTS", message: "Missing or invalid startTime/endTime arguments", details: nil))
      return
    }

    let dateFormatter = ISO8601DateFormatter()
    dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

    guard let startTime = dateFormatter.date(from: startTimeString),
          let endTime = dateFormatter.date(from: endTimeString)
    else {
      result(FlutterError(code: "INVALID_ARGUMENTS", message: "Could not parse ISO8601 date strings", details: nil))
      return
    }

    let sampleType = HKSampleType.workoutType()
    let predicate = HKQuery.predicateForSamples(withStart: startTime, end: endTime, options: [])
    let sortByDate = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)

    let query = HKSampleQuery(sampleType: sampleType, predicate: predicate, limit: Int(HKObjectQueryNoLimit), sortDescriptors: [sortByDate]) { query, results, error in
      if let error = error {
        result(FlutterError(code: "QUERY_ERROR", message: "Error fetching workouts: \(error.localizedDescription)", details: nil))
        return
      }

      guard let samples = results as? [HKWorkout] else {
        result(FlutterError(code: "NO_RESULTS", message: "No workouts found", details: nil))
        return
      }

      let workouts = samples.map { (sample: HKWorkout) in
        return [
          "uuid": sample.uuid.uuidString,
          "workoutActivityType": sample.workoutActivityType.rawValue,
          "startDateTime": dateFormatter.string(from: sample.startDate),
          "endDateTime": dateFormatter.string(from: sample.endDate),
        ] as Dictionary<String, Any>
      }

      result(workouts)
    }

    healthStore.execute(query)
  }

  private func fetchRoute(call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard let args = call.arguments as? [String: Any],
          let uuidString = args["uuid"] as? String else {
      result(FlutterError(code: "INVALID_ARGUMENTS", message: "Missing or invalid uuid argument", details: nil))
      return
    }

    guard let uuid = UUID(uuidString: uuidString) else {
      result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid UUID format", details: nil))
      return
    }
    
    let sampleType = HKSampleType.workoutType()
    let predicate = HKQuery.predicateForObjects(with: [uuid])

    // 1. fetch the workout for the given UUID
    let workoutQuery = HKSampleQuery(sampleType: sampleType, predicate: predicate, limit: 1, sortDescriptors: nil) { query, results, error in
      if let error = error {
        result(FlutterError(code: "QUERY_ERROR", message: "Error fetching workout: \(error.localizedDescription)", details: nil))
        return
      }

      guard let workout = results?.first as? HKWorkout else {
        result(FlutterError(code: "NO_RESULTS", message: "No workout found", details: nil))
        return
      }

      let routeSampleType = HKSeriesType.workoutRoute()
      let routePredicate = HKQuery.predicateForObjects(from: workout)

      // 2. fetch the routes for the workout
      let routeQuery = HKSampleQuery(sampleType: routeSampleType, predicate: routePredicate, limit: Int(HKObjectQueryNoLimit), sortDescriptors: nil) { query, results, error in
        if let error = error {
          result(FlutterError(code: "QUERY_ERROR", message: "Error fetching route: \(error.localizedDescription)", details: nil))
          return
        }

        guard let samples = results as? [HKWorkoutRoute] else {
          result(FlutterError(code: "NO_RESULTS", message: "No route found", details: nil))
          return
        }

        // we need to fetch the location data asynchronously
        Task { [weak self] in
          let totalRoute = await getTotalRoute(routes: samples);
          result(totalRoute)
        }
        
      }
      self.healthStore.execute(routeQuery)
    }
    healthStore.execute(workoutQuery)
  }

  private func getTotalRoute(routes: [HKWorkoutRoute]) async -> [Dictionary<String, Any>] {
    var totalRoute: [Dictionary<String, Any>] = []
    
    for route in routes {
      let routeData: [Dictionary<String, Any>] = await fetchRouteData(route: route)
      totalRoute.append(contentsOf: routeData)
    }

    return totalRoute
  }

  private func fetchRouteData(route: HKWorkoutRoute) async -> [Dictionary<String, Any>] {
    return await withCheckedContinuation { continuation in
      var totalRoute: [Dictionary<String, Any>] = []

      let routeQuery = HKWorkoutRouteQuery(route: route) { query, results, done, error in
        if let error = error {
          continuation.resume(returning: [])
          return
        }

        let samples = results as? [CLLocation] ?? []

        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        totalRoute.append(contentsOf: samples.map { (sample: CLLocation) in
          return [
            "latitude": sample.coordinate.latitude,
            "longitude": sample.coordinate.longitude,
            "altitude": sample.altitude,
            "horizontalAccuracy": sample.horizontalAccuracy,
            "verticalAccuracy": sample.verticalAccuracy,
            "speed": sample.speed,
            "speedAccuracy": sample.speedAccuracy,
            "course": sample.course,
            "courseAccuracy": sample.courseAccuracy,
            "timestamp": dateFormatter.string(from: sample.timestamp),
          ] as Dictionary<String, Any>
        })

        if done {
          continuation.resume(returning: totalRoute)
          return
        }
      }
      healthStore.execute(routeQuery)
    }
  }
}
