class Coach {
  final String coachId;
  final String fullName;
  final int age;
  final String gender;
  final String major;
  final int tuitionFees;
  final String introduction;

  Coach({
    required this.coachId,
    required this.fullName,
    required this.age,
    required this.gender,
    required this.major,
    required this.tuitionFees,
    required this.introduction,
  });

  // Parse from JSON
  factory Coach.fromJson(Map<String, dynamic> json) {
    return Coach(
      coachId: json['coachId'] as String,
      fullName: json['fullName'] as String,
      age: json['age'] as int,
      gender: json['gender'] as String,
      major: json['major'] as String,
      tuitionFees: json['tuitionFees'] as int,
      introduction: json['introduction'] as String,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'coachId': coachId,
      'fullName': fullName,
      'age': age,
      'gender': gender,
      'major': major,
      'tuitionFees': tuitionFees,
      'introduction': introduction,
    };
  }
}
