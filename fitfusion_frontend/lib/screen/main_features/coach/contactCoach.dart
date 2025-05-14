import 'package:fitfusion_frontend/screen/main_features/coach/createRequestScreen.dart';
import 'package:fitfusion_frontend/theme/theme.dart';
import 'package:flutter/material.dart';

class CoachDetailScreen extends StatelessWidget {
  final Map<String, String> coach;

  const CoachDetailScreen({super.key, required this.coach});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text("Thông Tin HLV",
            style: TextStyle(
              fontSize: screenWidth * 0.05, // responsive text size
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            )),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: appGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Container(
              padding: EdgeInsets.all(screenWidth * 0.05),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: screenWidth * 0.15,
                      backgroundColor: Colors.green,
                      child: Icon(Icons.person,
                          size: screenWidth * 0.15, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text("Thông tin cá nhân:", style: AppTextStyles.subtitle),
                  SizedBox(height: screenHeight * 0.01),
                  Text("Họ và Tên : ${coach['name']}",
                      style: AppTextStyles.coach_detail),
                  Text("Giới tính : ${coach['gender']}",
                      style: AppTextStyles.coach_detail),
                  Text("Tuổi : ${coach['age']}",
                      style: AppTextStyles.coach_detail),
                  Text("Lĩnh vực chuyên ngành : ${coach['field']}",
                      style: AppTextStyles.coach_detail),
                  Text("Hoc Phi : ${coach['tuitionFees']}",
                      style: AppTextStyles.coach_detail),
                  SizedBox(height: screenHeight * 0.015),
                  Text(
                    "Mô tả :${coach['introduction']}",
                    style: AppTextStyles.coach_detail,
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.06,
                              vertical: screenHeight * 0.015,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text("Liên Hệ",
                              style: AppTextStyles.textButtonTwo),
                        ),
                        SizedBox(width: screenWidth * 0.05),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CreateRequestScreen(coach: coach),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.textPrimary,
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.06,
                                vertical: screenHeight * 0.015,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text("Thuê HLV",
                                style: AppTextStyles.textButtonOne)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
