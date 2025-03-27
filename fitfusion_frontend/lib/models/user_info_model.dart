class UserInfoModel {
  final String fullname;
  String? gender;
  double? height;
  double? weight;
  int? age;

  UserInfoModel({
    required this.fullname,
    this.gender,
    this.height,
    this.weight,
    this.age,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
      fullname: json['fullname'],
      gender: json['gender'],
      height: (json['height'] as num?)?.toDouble(),
      weight: (json['weight'] as num?)?.toDouble(),
      age: json['age'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullname': fullname,
      'gender': gender,
      'height': height,
      'weight': weight,
      'age': age,
    };
  }
}
