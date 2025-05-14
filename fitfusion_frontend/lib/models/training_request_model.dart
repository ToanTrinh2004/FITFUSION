class TrainingRequest {
  final String id;
  final String customerId;
  final String customerName; // New field
  final String coachId;
  final String coachName; // New field
  final String duration;
  final List<Schedule> schedule;
  final double fee;
  final String status;
  final DateTime createdAt;

  TrainingRequest({
    required this.id,
    required this.customerId,
    required this.customerName, // Initialize new field
    required this.coachId,
    required this.coachName, // Initialize new field
    required this.duration,
    required this.schedule,
    required this.fee,
    required this.status,
    required this.createdAt,
  });

  factory TrainingRequest.fromJson(Map<String, dynamic> json) {
    return TrainingRequest(
      id: json['_id'],
      customerId: json['customerId'],
      customerName: json['customerName'] ?? "Unknown Customer", // Parse new field
      coachId: json['coachId'],
      coachName: json['coachName'] ?? "Unknown Coach", // Parse new field
      duration: json['duration'],
      schedule: (json['schedule'] as List)
          .map((s) => Schedule.fromJson(s))
          .toList(),
      fee: json['fee'].toDouble(),
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

class Schedule {
  final String day;
  final String time;

  Schedule({required this.day, required this.time});

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      day: json['day'],
      time: json['time'],
    );
  }
}