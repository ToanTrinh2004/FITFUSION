import 'package:fitfusion_frontend/widgets/tabbar.dart';
import 'package:flutter/material.dart';
import '../theme/theme.dart'; 
import '../widgets/inputfield.dart';

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
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AppBarCustom(),
              const SizedBox(height: 20),
              Image.asset(
                'assets/logo.png',
                width: 250,
              ),
              const SizedBox(height: 30),
              const InputField(label: "Tên đăng nhập"),
              const SizedBox(height: 10),
              const InputField(label: "Mật khẩu", isPassword: true),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ButtonStyles.buttonTwo,
                onPressed: () {},
                child: const Text(
                  "ĐĂNG NHẬP",
                  style: AppTextStyles.textButtonTwo,
                ),
              ),
              const SizedBox(height: 20),
              // "Quên mật khẩu"
              Center(
                child: TextButton(
                  onPressed: () {}, 
                  child: const Text(
                    "Forgot your password?",
                    style: AppTextStyles.forgotPassword,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}