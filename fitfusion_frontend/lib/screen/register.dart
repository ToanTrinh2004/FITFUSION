import 'package:fitfusion_frontend/widgets/tabbar.dart';
import 'package:flutter/material.dart';
import '../theme/theme.dart';
import '../widgets/inputfield.dart';
import 'detail_gender.dart';

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
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AppBarCustom(),
              const SizedBox(height: 20),

              Image.asset(
                'assets/logo.png',
                width: 200,
              ),
              const SizedBox(height: 10),

              const InputField(label:"Họ và tên"),
              const SizedBox(height: 10),

              const InputField(label:"Tên đăng nhập"),
              const SizedBox(height: 10),

              const InputField(label:"Mật khẩu"),
              const SizedBox(height: 10),

              const InputField(label:"Nhập lại mật khẩu", isPassword: true),
              const SizedBox(height: 20),

              // Nút "ĐĂNG KÝ"
              ElevatedButton(
                style: ButtonStyles.buttonTwo,
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GenderSelectionScreen(fullname: '',)), 
                );
                }, // Xử lý đăng ký
                child: const Text("ĐĂNG KÝ", style: AppTextStyles.textButtonTwo),
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}