import 'package:flutter/material.dart';
import '../theme/theme.dart'; // Import theme
import '../widgets/widget.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: appGradient,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("FITFUSION", style: AppTextStyles.title),
              const SizedBox(height: 20),

              Image.asset(
                'assets/logo.png',
                width: 250,
              ),
              const SizedBox(height: 30),

              const InputField(label:"Họ và tên"),
              const SizedBox(height: 10),

              const InputField(label:"Tên đăng nhập"),
              const SizedBox(height: 10),

              const InputField(label:"Mật khẩu"),
              const SizedBox(height: 10),

              const InputField(label:"Nhập lại mật khẩu", isPassword: true),
              const SizedBox(height: 30),

              // Nút "ĐĂNG KÝ"
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(200, 50),
                ),
                onPressed: () {}, // Xử lý đăng ký
                child: const Text("ĐĂNG KÝ", style: AppTextStyles.button),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}