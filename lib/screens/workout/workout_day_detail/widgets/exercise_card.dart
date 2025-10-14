import 'package:flutter/material.dart';

Widget buildExerciseCard(dynamic exercise) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.grey.shade700, width: 1),
    ),
    child: Column(
      children: [
        // Exercise preview and info
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Exercise media preview
              Container(
                width: 80,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  exercise['mediaType'] == 'gif' ? Icons.gif : Icons.play_circle,
                  color: Colors.orange,
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              // Exercise details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exercise['name'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      exercise['targetMuscle'],
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.orange,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${exercise['sets']} Sets × ${exercise['reps']} Reps',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
              // View Details button
              TextButton(
                onPressed: () => _showExerciseDetails(exercise),
                child: const Text(
                  'View Details',
                  style: TextStyle(color: Colors.orange),
                ),
              ),
            ],
          ),
        ),

        // Weight tracking section
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade800.withOpacity(0.5),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Weight Tracking',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildWeightInput(
                      'Set 1',
                      exercise['id'],
                      1,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildWeightInput(
                      'Set 2',
                      exercise['id'],
                      2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _buildProgressComparison(exercise['id']),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildWeightInput(String label, String exerciseId, int setNumber) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: Colors.white.withOpacity(0.7),
        ),
      ),
      const SizedBox(height: 4),
      TextField(
        keyboardType: TextInputType.number,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: '0.0 kg',
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
          filled: true,
          fillColor: Colors.grey.shade800,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          suffixText: 'kg',
          suffixStyle: const TextStyle(color: Colors.white),
        ),
        onChanged: (value) {
          double weight = double.tryParse(value) ?? 0.0;
          // Handle weight change - this would be managed by the parent state
          print('Exercise: ${exerciseId}, Set $setNumber: $weight kg');
        },
      ),
    ],
  );
}

Widget _buildProgressComparison(String exerciseId) {
  // This would need to be managed by the parent state with actual weight data
  return const SizedBox.shrink();
}

void _showExerciseDetails(dynamic exercise) {
  // This would need to be implemented by the parent screen
}
