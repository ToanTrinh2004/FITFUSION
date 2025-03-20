import 'package:flutter/material.dart';
import '../theme/theme.dart'; // Import theme

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: appGradient, // Sử dụng gradient từ theme.dart
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

              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Tên đăng nhập:", style: AppTextStyles.text),
              ),
              const SizedBox(height: 5),
              Container(
                width: 270,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                  ),
                ),
              ),
              const SizedBox(height: 15),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Mật khẩu:", style: AppTextStyles.text),
              ),
              const SizedBox(height: 5),
              Container(
                width: 270,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              //button login
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(270, 50),
                ),
                onPressed: () {}, // Xử lý đăng nhập
                child: const Text("ĐĂNG NHẬP", style: AppTextStyles.buttonregister),
              ),

              const SizedBox(height: 20),

              // "Quên mật khẩu"
              TextButton(
                onPressed: () {}, // Xử lý khi bấm quên mật khẩu
                child: const Text("Forgot your password?", style: AppTextStyles.forgotPassword),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
