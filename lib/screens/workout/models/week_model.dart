class Day {
  final String id;
  final String title;

  Day({required this.id, required this.title});

  factory Day.fromMap(String id, Map<String, dynamic> data) {
    return Day(
      id: id,
      title: data['title'] ?? '',
    );
  }
}

class Week {
  final String id;
  final String title;
  final List<Day> days;

  Week({required this.id, required this.title, required this.days});

  factory Week.fromMap(String id, Map<String, dynamic> data, List<Day> days) {
    return Week(
      id: id,
      title: data['title'] ?? '',
      days: days,
    );
  }
}
