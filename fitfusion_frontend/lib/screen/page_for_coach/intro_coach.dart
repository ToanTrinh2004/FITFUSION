import 'package:flutter/material.dart';
import '/theme/theme.dart';
import 'login_coach.dart';
import 'register_coach.dart';

class IntroCoachApp extends StatelessWidget {
  const IntroCoachApp({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: appGradient,
        ),
        child: SingleChildScrollView(
          child: SizedBox(
            height: screenHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo.png',
                  width: screenWidth * 0.6,
                ),
                SizedBox(height: screenHeight * 0.02),

                Column(
                  children: [
                    Text("FITFUSION", style: AppTextStyles.title.copyWith(
                      fontSize: screenWidth * 0.1)),
                    SizedBox(height: screenHeight * 0.01),
                    Text("SỐNG CÂN BẰNG, SỐNG TỐT", style: AppTextStyles.subtitle.copyWith(
                      fontSize: screenWidth * 0.05)),
                    SizedBox(height: screenHeight * 0.01),
                    const Text("TRANG DÀNH CHO HUẤN LUYỆN VIÊN", style: AppTextStyles.little_title),
                    SizedBox(height: screenHeight * 0.04),

                    // Nút Đăng Nhập
                    SizedBox(
                      width: screenWidth * 0.7,
                      child: ElevatedButton(
                        style: ButtonStyles.buttonOne,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => LoginCoachScreen()),
                          );
                        },
                        child: const Text("ĐĂNG NHẬP", style: AppTextStyles.textButtonOne),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    // Nút Đăng Ký
                    SizedBox(
                      width: screenWidth * 0.7,
                      child: ElevatedButton(
                        style: ButtonStyles.buttonTwo,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => RegisterCoachScreen()),
                          );
                        },
                        child: const Text("ĐĂNG KÝ", style: AppTextStyles.textButtonTwo),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Bạn là người dùng? ", style: AppTextStyles.textButtonTwo),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context); // Quay lại IntroApp
                          },
                          child: Text("Truy cập tại đây", style: AppTextStyles.textButtonOne),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
