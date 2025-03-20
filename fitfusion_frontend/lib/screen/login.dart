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
          gradient: appGradient,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
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

              buildInputField("Tên đăng nhập"),
              const SizedBox(height: 10),

              buildInputField("Mật khẩu", ),
              const SizedBox(height: 40),
              

              // Button ĐĂNG NHẬP
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(200, 50),
                  ),
                  onPressed: () {}, // Xử lý đăng nhập
                  child: const Text("ĐĂNG NHẬP", style: AppTextStyles.button),
                ),
              
              const SizedBox(height: 20),

                // "Quên mật khẩu"
                Center(
                  child: TextButton(
                    onPressed: () {}, // Xử lý khi bấm quên mật khẩu
                    child: const Text("Forgot your password?", style: AppTextStyles.forgotPassword),
                  ),
                ),
              ],
            ),
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
            borderRadius: BorderRadius.circular(10),
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
