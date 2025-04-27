import 'package:flutter/material.dart';
import 'package:flutter_ios_workouts/flutter_ios_workouts.dart';
import 'package:flutter_ios_workouts_example/workout_icon.dart';

import 'map_widget.dart';

class WorkoutDetailScreen extends StatefulWidget {
  final Workout workout;

  const WorkoutDetailScreen({super.key, required this.workout});

  @override
  State<WorkoutDetailScreen> createState() => _WorkoutDetailScreenState();
}

class _WorkoutDetailScreenState extends State<WorkoutDetailScreen> {
  List<Location> _path = [];
  
  @override
  void initState() {
    super.initState();    

    WorkoutsPlugin.getWorkoutRoute(workoutUuid: widget.workout.uuid).then((path) {
      if( mounted ) {
        setState(() {
          _path = path;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final workout = widget.workout;

    return Scaffold(
      appBar: AppBar(
        title: Text('${workout.workoutActivityType} Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            
            // Header section
            Row(
              children: [
                Icon(getWorkoutIcon(workout.workoutActivityType), size: 40, color: Theme.of(context).primaryColor),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    workout.workoutActivityType.toString(),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),

            const Divider(height: 32),

            // Workout stats section
            _buildDetailRow("UUID", workout.uuid),
            _buildDetailRow('Start Date', workout.startDateTime.toLocal().toString().substring(0, 16)),
            _buildDetailRow('End Date', workout.endDateTime.toLocal().toString().substring(0, 16)),

            const Divider(height: 32),

            MapWidget(path: _path),
          ],
        ),
      )
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
            )
          ),
        ],
      )
    );
  }
}
