import 'package:flutter/material.dart';
import 'package:flutter_ios_workouts/flutter_ios_workouts.dart';

import 'workout_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await WorkoutsPlugin.setup();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workouts Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      home: const WorkoutListScreen(),
    );
  }
}
