import 'package:flutter/material.dart';
import '../theme/theme.dart';
import 'login.dart';
import 'register.dart';
import 'page_for_coach/intro_coach.dart';
class IntroApp extends StatelessWidget {
  const IntroApp({super.key});
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
              width: 300, // Điều chỉnh kích thước ảnh
            ),

            // Phần chữ và nút bấm
            Column(
              children: [
                const Text("FITFUSION", style: AppTextStyles.title),
                const SizedBox(height: 8),
                const Text("SỐNG CÂN BẰNG, SỐNG TỐT", style: AppTextStyles.subtitle),
                const SizedBox(height: 40),

                // Nút Đăng Nhập
                ElevatedButton(
                  style: ButtonStyles.buttonOne,
                  onPressed: () {
                    Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>LoginScreen()), 
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
                  MaterialPageRoute(builder: (context) => RegisterScreen()), 
                );
                  }, // Xử lý đăng ký
                  child: const Text("ĐĂNG KÝ", style: AppTextStyles.textButtonTwo),
                ),

                const SizedBox(height: 25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Bạn là HLV? ", style:AppTextStyles.textButtonTwo),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (_) => IntroCoachApp()));                       
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
    );
  }
} 
