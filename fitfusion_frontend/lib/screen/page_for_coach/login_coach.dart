import 'package:fitfusion_frontend/api/coach/fetch_coach_info.dart';
import 'package:fitfusion_frontend/widgets/tabbar.dart';
import 'package:flutter/material.dart';
import '/theme/theme.dart'; 
import '/widgets/inputfield.dart';
import '/models/coach_model.dart';
import '/api/auth/auth_service.dart'; // Import your API service
import 'package:fitfusion_frontend/models/coach_model.dart';
import './home_coach.dart';

class LoginCoachScreen extends StatefulWidget {
  const LoginCoachScreen({super.key});

  @override
  State<LoginCoachScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginCoachScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _handleLogin() async {
    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    String username = usernameController.text.trim();
    String password = passwordController.text;

    // Step 1: Login and get token
    bool loginSuccess = await AuthService.loginUser(context, username, password,2);

    if (!loginSuccess) {
      Navigator.of(context).pop();
      return;
    }

    // Step 2: Get user info with token
    final coachData = await FetchCoachInfo.getCoachInfo(context);

    Navigator.of(context).pop(); // Close loading

    if (coachData != null) {
      final coachInfo = Coach.fromJson(coachData);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeCoachScreen(coachInfo : coachInfo),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Không thể tải thông tin người dùng.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: appGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AppBarCustom(),
                  const SizedBox(height: 20),
                  Image.asset(
                    'assets/logo.png',
                    width: screenWidth * 0.6,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "TRANG DÀNH CHO HUẤN LUYỆN VIÊN",
                    style: AppTextStyles.little_title.copyWith(fontSize: screenWidth * 0.05)
                  ),
                  const SizedBox(height: 30),

                  InputField(
                    label: "Tên đăng nhập",
                    controller: usernameController,
                  ),
                  const SizedBox(height: 15),
                  InputField(
                    label: "Mật khẩu",
                    isPassword: true,
                    controller: passwordController,
                  ),
                  const SizedBox(height: 30),

                  ElevatedButton(
                    style: ButtonStyles.buttonTwo,
                    onPressed: _handleLogin,
                    child: const Text(
                      "ĐĂNG NHẬP",
                      style: AppTextStyles.textButtonTwo,
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