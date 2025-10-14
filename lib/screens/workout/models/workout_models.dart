class Exercise {
  final String name;
  final int order;
  final int sets;
  final String reps;
  final int restSeconds;
  final String imageUrl;
  final String notes;

  Exercise({
    required this.name,
    required this.order,
    required this.sets,
    required this.reps,
    required this.restSeconds,
    required this.imageUrl,
    required this.notes,
  });

  factory Exercise.fromMap(Map<String, dynamic> data) {
    return Exercise(
      name: data['name'] ?? '',
      order: data['order'] ?? 0,
      sets: data['sets'] ?? 0,
      reps: data['reps'] ?? '',
      restSeconds: data['restSeconds'] ?? 0,
      imageUrl: data['imageUrl'] ?? '',
      notes: data['notes'] ?? '',
    );
  }
}
