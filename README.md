# flutter_ios_workouts
This flutter plugin was created to provide access to the route data of a workout from the Apple Health app on IOs devices.
Currently it offers only a very basic api to access a list of workouts and the route for a given workout (if available).

## Getting Started
To use the plugin just use `import 'package:flutter_ios_workouts/flutter_ios_workouts.dart'`. 
Before any api call is made you must first initialize the plugin once by calling `WorkoutsPlugin.setup()`.

To request authorization for accessing the health data you must call `WorkoutsPlugin.requestAuthorization()`.
This method will return a flag wether authorization is given or not.

After authorization is granted you can call `WorkoutsPlugin.getWorkouts()` to get a list of workouts.
To fetch the recorded rotue data for a given workout you can call `WorkoutsPlugin.getRouteData(workoutId)` where `workoutId` is the unique id of the workout you want to fetch the route data for.


### Project Settings
In order to use the plugin you must configure your ios project settings accordingly.
For that you must add the HealthKit capability to your ios project using xcode.
For more information see [Enable Healthkit](https://developer.apple.com/documentation/healthkit/setting-up-healthkit?changes=_2#Enable-HealthKit).

Additionally you must add the following keys to your `Info.plist` file with a proper description of why you need access to the health data:
```xml
<key>NSHealthShareUsageDescription</key>
<string>We need access to your health data to show your workouts.</string>
```

This plugin is using features which are only available after ios 15.0 so you must configure your project to target an equal or higher ios version.

## Further Development
This plugin is not actively maintained. It was developed for a specific use case and is not intended to be a full-featured plugin yet. However, feel free to fork the project and create pull requests if you want to add more features or fix bugs. You may also leave feature requests in the issues section of the repository but there is no guarantee that they will be implemented.
