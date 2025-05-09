import 'package:fitfusion_frontend/widgets/tabbar.dart';
import 'package:flutter/material.dart';
import '../theme/theme.dart'; 
import '../widgets/inputfield.dart';
import '../models/user_info_model.dart';
import 'home.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key}); // Đã bỏ tham số userInfo không cần thiết

  // Mock login function that simulates API call
  Future<UserInfoModel?> _mockLogin() async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Return the mock user data
    return UserInfoModel(
      fullname: "Nguyễn Văn A",
      gender: "Nam",
      height: 170.0,
      weight: 68.5,
      aimWeight: 62.0,
      age: 28,
      goal: "Giảm cân",
      aimDate: DateTime.now().add(const Duration(days: 90)),
      health: "Bình thường",
      workOutDays: 4,
    )
      ..calculateBMI()
      ..calculateBMIAim()
      ..calculateWeightLossPercentage();
  }

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
                onPressed: () async {
                  // Show loading indicator
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                  
                  // Call mock login function
                  final loggedInUser = await _mockLogin();
                  
                  // Close loading indicator
                  Navigator.of(context).pop();
                  
                  // Navigate to home screen with user data
                  if (loggedInUser != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(userInfo: loggedInUser),
                      ),
                    );
                  } else {
                    // Show error message if login failed
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Đăng nhập thất bại'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
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