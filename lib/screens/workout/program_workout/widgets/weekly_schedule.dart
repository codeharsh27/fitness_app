import 'package:flutter/material.dart';
import 'package:fitness_app_saas/screens/workout/workout_day_detail/workout_day_detail_screen.dart';

Widget buildWeeklySchedule(BuildContext context, Color color) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Icon(Icons.calendar_today, color: color, size: 24),
          const SizedBox(width: 12),
          const Text(
            'Weekly Schedule',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
      const SizedBox(height: 16),
      _buildScheduleCard(
        'Day 1',
        'Push Day',
        'Chest, Shoulders, Triceps',
        '45-60 min',
        'push',
        context,
      ),
      _buildScheduleCard(
        'Day 2',
        'Pull Day',
        'Back, Biceps, Rear Delts',
        '45-60 min',
        'pull',
        context,
      ),
      _buildScheduleCard(
        'Day 3',
        'Legs Day',
        'Quads, Hamstrings, Calves',
        '50-65 min',
        'legs',
        context,
      ),
      _buildScheduleCard(
        'Day 4',
        'Push Day',
        'Chest, Shoulders, Triceps',
        '45-60 min',
        'push',
        context,
      ),
      _buildScheduleCard(
        'Day 5',
        'Pull Day',
        'Back, Biceps, Rear Delts',
        '45-60 min',
        'pull',
        context,
      ),
      _buildScheduleCard(
        'Day 6-7',
        'Rest/Optional Cardio',
        'Recovery & Light Activity',
        '20-30 min',
        'rest',
        context,
      ),
    ],
  );
}

Widget _buildScheduleCard(
  String day,
  String title,
  String muscles,
  String duration,
  String workoutType,
  BuildContext context,
) {
  return InkWell(
    onTap: () => _navigateToWorkoutDay(context, workoutType, day, title),
    child: Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: workoutType != 'rest'
            ? Colors.grey.shade800
            : Colors.grey.shade800.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade700, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      day,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                duration,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            muscles,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ],
      ),
    ),
  );
}

void _navigateToWorkoutDay(
  BuildContext context,
  String workoutType,
  String day,
  String title,
) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => WorkoutDayDetailScreen(
        dayTitle: '$day – $title',
        daySubtitle: 'Track your progress and improve every week.',
        workoutType: workoutType,
      ),
    ),
  );
}
