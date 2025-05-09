import 'package:flutter/material.dart';
import '/theme/theme.dart';
import 'login_coach.dart';
import 'register_coach.dart';

class IntroCoachApp extends StatelessWidget {
  const IntroCoachApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(                                                                                                
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: appGradient, // Áp dụng gradient từ theme.dart
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Căn giữa theo chiều dọc
          children: [
            // Hình ảnh logo
            Image.asset(
              'assets/logo.png',
              width: 300,
            ),

            Column(
              children: [
                const Text("FITFUSION", style: AppTextStyles.title),
                const SizedBox(height: 8),
                const Text("SỐNG CÂN BẰNG, SỐNG TỐT", style: AppTextStyles.subtitle),
                const SizedBox(height: 15),
                const Text("TRANG DÀNH CHO HUẤN LUYỆN VIÊN", style: AppTextStyles.little_title),
                const SizedBox(height: 40),

                ElevatedButton(
                  style: ButtonStyles.buttonOne,
                  onPressed: () {
                    Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>LoginCoachScreen()), 
                );
                  }, // Xử lý đăng nhập
                  child: const Text("ĐĂNG NHẬP", style: AppTextStyles.textButtonOne),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  style: ButtonStyles.buttonTwo,
                  onPressed: () {
                     Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterCoachScreen()), 
                );
                  }, // Xử lý đăng ký
                  child: const Text("ĐĂNG KÝ", style: AppTextStyles.textButtonTwo),
                ),

                const SizedBox(height: 25),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 
