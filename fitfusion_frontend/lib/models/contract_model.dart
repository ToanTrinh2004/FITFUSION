class ContractModel {
  final String id;
  final String customerId;
  final String customerName;
  final String coachId;
  final String coachName;
  final String duration;
  final List<Schedule> schedule;
  final double fee;
  final DateTime createdAt;

  ContractModel({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.coachId,
    required this.coachName,
    required this.duration,
    required this.schedule,
    required this.fee,
    required this.createdAt,
  });

  factory ContractModel.fromJson(Map<String, dynamic> json) {
    return ContractModel(
      id: json['_id'],
      customerId: json['customerId'],
      customerName: json['customerName'] ?? "Unknown Customer",
      coachId: json['coachId'],
      coachName: json['coachName'] ?? "Unknown Coach",
      duration: json['duration'],
      schedule: (json['schedule'] as List)
          .map((s) => Schedule.fromJson(s))
          .toList(),
      fee: json['fee'].toDouble(),
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