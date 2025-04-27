import 'package:flutter/material.dart';
import 'package:flutter_ios_workouts/flutter_ios_workouts.dart';

import 'workout_icon.dart';
import 'workout_detail_screen.dart';


class WorkoutListScreen extends StatefulWidget {
  const WorkoutListScreen({super.key});

  @override
  State<WorkoutListScreen> createState() => _WorkoutListScreenState();
}

class _WorkoutListScreenState extends State<WorkoutListScreen> {
  bool _authorizationStatus = false;
  List<Workout> _workouts = [];
  
  @override
  void initState() {
    super.initState();
  }

  Future<void> _requestAuthorization() async {
    try {
      final bool result = await WorkoutsPlugin.requestAuthorization();
      setState(() {
        _authorizationStatus = result;
      });
    } catch (e) {
      print(e);
      setState(() {
        _authorizationStatus = false;
      });
    }
  }

  Future<void> _fetchWorkouts() async {
    final workouts = await WorkoutsPlugin.getWorkouts(
      start: DateTime.now().subtract(const Duration(days: 30)),
      end: DateTime.now(),
    );

    if( mounted ) {
      setState(() {
        _workouts = workouts;
      });
    }
  }

  void _navigateToDetail(Workout workout) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WorkoutDetailScreen(workout: workout),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workouts'),
      ),
      body: Column(
        children: [

          // Status and control panel
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("Authorization Status: ${_authorizationStatus ? 'Granted' : 'Not Granted'}"),
                const SizedBox(height: 16.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _requestAuthorization, 
                      icon: const Icon(Icons.security), 
                      label: const Text("Request Authorization"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent,
                      )
                    ),
                    ElevatedButton.icon(
                      onPressed: _fetchWorkouts,
                      icon: const Icon(Icons.refresh),
                      label: const Text("Fetch Workouts"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlueAccent,
                      ) 
                    ),
                  ],
                )
              ],
            ),
          ),

          const Divider(),

          // Workout List Area
          Expanded(
            child: _workouts.isEmpty
              ? const Center(child: Text("No workouts found."))
              : ListView.builder(
                itemCount: _workouts.length,
                itemBuilder: (context, index) {
                  final workout = _workouts[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    elevation: 3,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColorLight,
                        child: Icon(
                          getWorkoutIcon(workout.workoutActivityType),
                          color: Theme.of(context).primaryColorDark,
                        ),
                      ),

                      title: Text(
                        workout.workoutActivityType.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold)
                      ),

                      subtitle: Text(
                        'Date ${workout.startDateTime.toLocal().toString().substring(0, 16)} - ${workout.endDateTime.toLocal().toString().substring(0, 16)}\n'
                      ),

                      isThreeLine: true,
                      onTap: () => _navigateToDetail(workout),
                    ),
                  );
                }
              )
          ),
        ],
      ),
    );   
  }
}
