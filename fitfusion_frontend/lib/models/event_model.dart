class Event {
  final String title;
  final String description;
  final DateTime time;
  final String? studentName;

  Event({
    required this.title,
    required this.description,
    required this.time,
    this.studentName,
  });
}