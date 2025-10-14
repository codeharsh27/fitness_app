import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fitness_app_saas/screens/workout/workout_day_detail/widgets/widgets.dart';

class WorkoutDayDetailScreen extends StatefulWidget {
  final String dayTitle;
  final String daySubtitle;
  final String workoutType; // 'push', 'pull', 'legs'

  const WorkoutDayDetailScreen({
    super.key,
    required this.dayTitle,
    required this.daySubtitle,
    required this.workoutType,
  });

  @override
  State<WorkoutDayDetailScreen> createState() => _WorkoutDayDetailScreenState();
}

class _WorkoutDayDetailScreenState extends State<WorkoutDayDetailScreen> {
  // Exercise data will be loaded based on workoutType
  List<dynamic> exercises = [];
  Map<String, Map<String, double>> weightData = {}; // exerciseName -> {set1, set2}

  @override
  void initState() {
    super.initState();
    _loadExercises();
  }

  void _loadExercises() {
    // Dummy JSON data - in real app, this would be loaded from assets
    String dummyData = _getDummyExerciseData();
    List<dynamic> loadedExercises = json.decode(dummyData);

    setState(() {
      exercises = loadedExercises.where((exercise) =>
        exercise['workoutType'] == widget.workoutType
      ).toList();
    });
  }

  String _getDummyExerciseData() {
    return '''
    [
      {
        "id": "bench_press",
        "name": "Bench Press",
        "mediaType": "video",
        "mediaUrl": "https://example.com/bench_press.mp4",
        "targetMuscle": "Chest",
        "sets": 3,
        "reps": "8-10",
        "description": "The bench press is a compound exercise that targets the chest, shoulders, and triceps. Lie on a bench and lower the barbell to your chest, then press it back up.",
        "musclesWorked": ["Chest", "Shoulders", "Triceps"],
        "workoutType": "push"
      },
      {
        "id": "overhead_press",
        "name": "Overhead Press",
        "mediaType": "gif",
        "mediaUrl": "https://example.com/overhead_press.gif",
        "targetMuscle": "Shoulders",
        "sets": 3,
        "reps": "8-12",
        "description": "Stand with feet shoulder-width apart and press the barbell overhead from shoulder height.",
        "musclesWorked": ["Shoulders", "Triceps", "Core"],
        "workoutType": "push"
      },
      {
        "id": "tricep_dips",
        "name": "Tricep Dips",
        "mediaType": "video",
        "mediaUrl": "https://example.com/tricep_dips.mp4",
        "targetMuscle": "Triceps",
        "sets": 3,
        "reps": "10-12",
        "description": "Using parallel bars, lower your body by bending your elbows, then push back up.",
        "musclesWorked": ["Triceps", "Shoulders", "Chest"],
        "workoutType": "push"
      },
      {
        "id": "pull_ups",
        "name": "Pull-ups",
        "mediaType": "gif",
        "mediaUrl": "https://example.com/pull_ups.gif",
        "targetMuscle": "Back",
        "sets": 3,
        "reps": "6-10",
        "description": "Hang from a bar with an overhand grip and pull your body up until your chin clears the bar.",
        "musclesWorked": ["Back", "Biceps", "Shoulders"],
        "workoutType": "pull"
      },
      {
        "id": "barbell_rows",
        "name": "Barbell Rows",
        "mediaType": "video",
        "mediaUrl": "https://example.com/barbell_rows.mp4",
        "targetMuscle": "Back",
        "sets": 3,
        "reps": "8-10",
        "description": "Bend at the hips and knees, then pull the barbell to your lower chest while keeping your back straight.",
        "musclesWorked": ["Back", "Biceps", "Rear Delts"],
        "workoutType": "pull"
      },
      {
        "id": "bicep_curls",
        "name": "Bicep Curls",
        "mediaType": "gif",
        "mediaUrl": "https://example.com/bicep_curls.gif",
        "targetMuscle": "Biceps",
        "sets": 3,
        "reps": "10-12",
        "description": "Stand with dumbbells in hand and curl the weights up to shoulder height.",
        "musclesWorked": ["Biceps", "Forearms"],
        "workoutType": "pull"
      },
      {
        "id": "squats",
        "name": "Squats",
        "mediaType": "video",
        "mediaUrl": "https://example.com/squats.mp4",
        "targetMuscle": "Quads",
        "sets": 4,
        "reps": "8-10",
        "description": "Stand with feet shoulder-width apart and lower your body as if sitting back into a chair, then stand back up.",
        "musclesWorked": ["Quads", "Glutes", "Hamstrings", "Core"],
        "workoutType": "legs"
      },
      {
        "id": "deadlifts",
        "name": "Deadlifts",
        "mediaType": "gif",
        "mediaUrl": "https://example.com/deadlifts.gif",
        "targetMuscle": "Hamstrings",
        "sets": 3,
        "reps": "6-8",
        "description": "Stand with feet hip-width apart, bend at the hips and knees to grab the bar, then lift it by extending your hips and knees.",
        "musclesWorked": ["Hamstrings", "Glutes", "Back", "Core"],
        "workoutType": "legs"
      }
    ]
    ''';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.dayTitle),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: Column(
          children: [
            // Header section with subtitle
            buildWorkoutDayHeader(widget.dayTitle, widget.daySubtitle),

            // Exercise list
            Expanded(
              child: exercises.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.orange),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: exercises.length,
                    itemBuilder: (context, index) {
                      return buildExerciseCard(exercises[index]);
                    },
                  ),
            ),

            // Progress summary button
            Container(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Navigate to weekly progress screen
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Weekly Progress - Coming Soon!'),
                      backgroundColor: Colors.orange,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  'View Weekly Progress',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
