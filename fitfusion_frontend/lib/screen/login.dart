import 'package:fitfusion_frontend/widgets/tabbar.dart';
import 'package:flutter/material.dart';
import '../theme/theme.dart'; 
import '../widgets/inputfield.dart';
import '../models/user_info_model.dart';
import '../api/auth/auth_service.dart'; // Import your API service
import '../api/userInfo/fetch_user.dart'; // Ensure this is where loginUser is
import 'home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
    bool loginSuccess = await AuthService.loginUser(context, username, password);

    if (!loginSuccess) {
      Navigator.of(context).pop();
      return;
    }

    // Step 2: Get user info with token
    final userData = await FetchUser.getUserInfo(context);

    Navigator.of(context).pop(); // Close loading

    if (userData != null) {
      final userInfo = UserInfoModel.fromJson(userData)
        ..calculateBMI()
        ..calculateBMIAim()
        ..calculateWeightLossPercentage();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(userInfo: userInfo),
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

              InputField(
                label: "Tên đăng nhập",
                controller: usernameController,
              ),
              const SizedBox(height: 10),
              InputField(label: "Mật khẩu",
                isPassword: true,
                controller: passwordController,
              ),
              const SizedBox(height: 40),

              ElevatedButton(
                style: ButtonStyles.buttonTwo,
                onPressed: _handleLogin,
                child: const Text(
                  "ĐĂNG NHẬP",
                  style: AppTextStyles.textButtonTwo,
                ),
              ),
              const SizedBox(height: 20),

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