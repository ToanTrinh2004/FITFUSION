import 'package:flutter/material.dart';
import '../theme/theme.dart';
import 'package:flutter/services.dart';


class InputField extends StatelessWidget {
  final String label;
  final bool isPassword;
  final double? width;
  final double? height;
  final TextEditingController? controller;
  final bool isNumeric;//dành cho các ô cần nhập số

  const InputField({
    super.key,
    required this.label,
    this.isPassword = false,
    this.width,
    this.height,
    this.controller, // Nhận controller
    this.isNumeric = false, // Mặc định không chặn chữ

  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.text),
        const SizedBox(height: 5),
        Container(
          width: width ?? 270,
          height: height ?? 50,
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            controller: controller,
            keyboardType: isNumeric ? TextInputType.number : TextInputType.text, // Kiểm tra nếu cần nhập số
              inputFormatters: isNumeric
                  ? [FilteringTextInputFormatter.digitsOnly] // chặn chữ khi isNumeric = true
                  : [],
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

