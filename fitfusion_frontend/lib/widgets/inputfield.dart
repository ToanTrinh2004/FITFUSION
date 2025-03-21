import 'package:flutter/material.dart';
import '../theme/theme.dart';

class InputField extends StatelessWidget {
  final String label;
  final bool isPassword;
  final double? width;
  final double? height;

  const InputField({
    super.key,
    required this.label,
    this.isPassword = false,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.text),
        const SizedBox(height: 5),
        Container(
          width: width ?? 270, // mặc định 270
          height: height ?? 50, // Nếu không nhập, mặc định 50
          decoration: BoxDecoration(
            color: AppColors.background,
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
