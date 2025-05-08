class UserInfoModel {
  final String fullname;
  String? gender;
  double? height;
  double? weight;
  double? aimWeight;
  int? age;
  double bmi = 0.0;
  double bmiAim = 0.0;
  String? goal;
  double weightLossPercentage = 0.0;
  DateTime? aimDate;
  String? health;
  int? workOutDays;

  UserInfoModel({
    required this.fullname,
    this.gender,
    this.height,
    this.weight,
    this.aimWeight,
    this.age,
    this.goal,
    this.aimDate,
    this.health,
    this.workOutDays
  });

  void calculateBMI() {
    if (height != null && weight != null && height! > 0) {
      bmi = weight! / ((height! / 100) * (height! / 100));
    } else {
      bmi = 0.0;
    }
  }
  
  String get bmiStatus {
    if (bmi < 18.5) {
      return "Gầy";
    } else if ((bmi >= 18.5) && (bmi <= 24.9)) {
      return "Bình thường";
    } else if ((bmi > 24.9) && (bmi <= 29.9)) {
      return "Thừa cân";
    } else if((bmi > 29.9) && (bmi <= 34.9)){
      return "Béo phì";
    } else {
      return "Nguy hiểm";
    }
  }

  void calculateBMIAim() {
    if (height != null && aimWeight != null && height! > 0) {
      bmiAim = aimWeight! / ((height! / 100) * (height! / 100));
    } else {
      bmiAim = 0.0;
    }
  }

  void calculateWeightLossPercentage() {
    if (weight != null && aimWeight != null && weight! > 0) {
      weightLossPercentage = ((weight! - aimWeight!) / weight!) * 100;
    } else {
      weightLossPercentage = 0.0;
    }
  }

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
  return UserInfoModel(
    fullname: json['fullname'],
    gender: json['gender'],
    height: (json['height'] as num?)?.toDouble(),
    weight: (json['weight'] as num?)?.toDouble(),
    aimWeight: (json['aimWeight'] as num?)?.toDouble(),
    age: json['age'] as int?,
    goal: json['goal'],
    aimDate: json['aimDate'] != null ? DateTime.parse(json['aimDate']) : null,
    health: json['health'],
    workOutDays: json['workOutDays'] as int?, // ✅ Add this line
  );
}


  Map<String, dynamic> toJson() {
    return {
      'fullname': fullname,
      'gender': gender,
      'height': height,
      'weight': weight,
      'aimWeight': aimWeight,
      'age': age,
      'goal': goal,
      'weightLossPercentage': weightLossPercentage,
      'aimDate': aimDate?.toIso8601String(),
      'health': health,
    };
  }
}
