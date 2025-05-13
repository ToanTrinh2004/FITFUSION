import 'package:fitfusion_frontend/api/userInfo/post_user.dart';
import 'package:fitfusion_frontend/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:fitfusion_frontend/widgets/tabbar.dart';
import 'package:fitfusion_frontend/models/user_info_model.dart';
import 'package:fitfusion_frontend/theme/theme.dart';

class TotalDetailScreen extends StatelessWidget {
  final UserInfoModel userInfo;

  const TotalDetailScreen({super.key, required this.userInfo});

  String formatDate(DateTime? date) {
    if (date == null) return "Chưa đặt";
    String day = date.day.toString().padLeft(2, '0');
    String month = date.month.toString().padLeft(2, '0');
    String year = date.year.toString();
    return "$day/$month/$year";
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: appGradient),
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.03),
            AppBarCustomHeader(fullname: userInfo.fullname),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.02,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: boxGradient.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.buttonBg),
                  ),
                  padding: EdgeInsets.all(screenWidth * 0.05),
                  child: Column(
                    children: [
                      const Text(
                        "Thông tin cá nhân",
                        style: AppTextStyles.little_title,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: screenHeight * 0.05),
                      _buildInfoRow(
                          "Giới tính", userInfo.gender ?? "Chưa cập nhật"),
                      _buildInfoRow(
                          "Chiều cao",
                          userInfo.height != null
                              ? "${userInfo.height} cm"
                              : "Chưa cập nhật"),
                      _buildInfoRow(
                          "Tuổi",
                          userInfo.age != null
                              ? "${userInfo.age}"
                              : "Chưa cập nhật"),
                      _buildInfoRow(
                          "Cân nặng",
                          userInfo.weight != null
                              ? "${userInfo.weight} kg"
                              : "Chưa cập nhật"),
                      _buildInfoRow(
                          "Mục tiêu", userInfo.goal ?? "Chưa cập nhật"),
                      _buildInfoRow(
                          "Cân nặng mục tiêu",
                          userInfo.aimWeight != null
                              ? "${userInfo.aimWeight} kg"
                              : "Chưa cập nhật"),
                      _buildInfoRow(
                          "Chỉ số BMI",
                          userInfo.bmi > 0
                              ? userInfo.bmi.toStringAsFixed(1)
                              : "Chưa tính"),
                      _buildInfoRow("Trạng thái BMI", userInfo.bmiStatus),
                      _buildInfoRow(
                          "Ngày hoàn thành", formatDate(userInfo.aimDate)),
                      _buildInfoRow("Tình trạng sức khỏe",
                          userInfo.health ?? "Chưa cập nhật"),
                      SizedBox(height: screenHeight * 0.05),
                      ElevatedButton(
                        style: ButtonStyles.buttonTwo,
                        onPressed: () async {
                          bool success =
                              await UserInfoService.createUserInfo(userInfo);
                          if (success) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    HomeScreen(userInfo: userInfo),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Lưu thông tin thất bại")),
                            );
                          }
                        },
                        child: const Text("TIẾP TỤC",
                            style: AppTextStyles.textButtonTwo),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.little_title_1),
          Text(value, style: AppTextStyles.little_title_1),
        ],
      ),
    );
  }
}
