import 'package:flutter/material.dart';
import '../models/user_info_model.dart';
import '../widgets/tabbar.dart';
import '../theme/theme.dart';
import '../widgets/inputfield.dart';
import 'detail/detail_gender.dart';
import '../api/auth/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    fullnameController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
  
  // Validate input fields
  bool _validateFields() {
    if (fullnameController.text.isEmpty) {
      AuthService.showNotification(context, "Vui lòng nhập họ và tên");
      return false;
    }
    
    if (usernameController.text.isEmpty) {
      AuthService.showNotification(context, "Vui lòng nhập tên đăng nhập");
      return false;
    }
    
    if (passwordController.text.isEmpty) {
      AuthService.showNotification(context, "Vui lòng nhập mật khẩu");
      return false;
    }
    
    if (passwordController.text != confirmPasswordController.text) {
      AuthService.showNotification(context, "Mật khẩu không khớp!");
      return false;
    }
    
    // You can add more validation (password strength, etc.) here
    
    return true;
  }

  // Register user
  Future<void> _registerUser() async {
    // CRITICAL FIX: Early return if validation fails
    if (!_validateFields()) {
      return; // Stop execution if validation fails
    }
    
    setState(() {
      isLoading = true;
    });
    
    try {
      bool success = await AuthService.registerUser(
        context,
        usernameController.text,
        passwordController.text,
        1
      );
      
      if (success && mounted) {
        // Only navigate if registration was successful
        UserInfoModel userInfo = UserInfoModel(fullname: fullnameController.text);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GenderSelectionScreen(userInfo: userInfo),
          ),
        );
      }
    } catch (e) {
      debugPrint("Registration error: $e");
      if (mounted) {
        AuthService.showNotification(context, "Có lỗi xảy ra: $e");
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
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
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AppBarCustom(),
                  const SizedBox(height: 20),
                  Image.asset(
                    'assets/logo.png',
                    width: 200,
                  ),
                  const SizedBox(height: 20),
                  InputField(label: "Họ và tên", controller: fullnameController),
                  const SizedBox(height: 15),
                  InputField(label: "Tên đăng nhập", controller: usernameController),
                  const SizedBox(height: 15),
                  InputField(
                    label: "Mật khẩu",
                    controller: passwordController,
                    isPassword: true
                  ),
                  const SizedBox(height: 15),
                  InputField(
                    label: "Nhập lại mật khẩu",
                    controller: confirmPasswordController,
                    isPassword: true
                  ),
                  const SizedBox(height: 30),
                  isLoading 
                    ? const CircularProgressIndicator(color: Colors.white)
                    : ElevatedButton(
                        style: ButtonStyles.buttonTwo,
                        onPressed: _registerUser,
                        child: const Text(
                          "ĐĂNG KÝ", 
                          style: AppTextStyles.textButtonTwo
                        ),
                      ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Đã có tài khoản? Đăng nhập",
                      style: AppTextStyles.forgotPassword,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}