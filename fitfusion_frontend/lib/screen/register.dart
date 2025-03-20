import 'package:flutter/material.dart';
import '../theme/theme.dart'; // Import theme


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
                width: 200,
              ),
              const SizedBox(height: 30),

              buildInputField("Họ và tên"),
              const SizedBox(height: 10),

              buildInputField("Tên đăng nhập"),
              const SizedBox(height: 10),

              buildInputField("Mật khẩu", ),
              const SizedBox(height: 10),

              buildInputField("Nhập lại mật khẩu", isPassword: true),
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

  Widget buildInputField(String label, {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.subtitle),
        const SizedBox(height: 5),
        Container(
          width: 270,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            obscureText: isPassword,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 15),
            ),
          ),
        ),
      ],
    );
  }
}