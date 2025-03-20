import 'package:flutter/material.dart';

/// 🎨 Định nghĩa màu sắc dùng trong app
class AppColors {
  static const Color primary = Color(0xFFB3261E); // Màu chính (đỏ)
  static const Color primaryHalf = Color(0x7FB3261E); // Màu chính mờ (50%)
  static const Color secondary = Color(0xFFD78C88); // Màu phụ
  static const Color background = Color(0xFFFFFFFF); // Màu nền trắng
  static const Color textPrimary = Color(0xFFFFFFFF); // Màu chữ chính (trắng)
  static const Color textSecondary = Color(0xFFB3261E); // Màu chữ phụ (xám)
  static const Color buttonBg = Color(0x7FB3261E); // Nền button đỏ mờ
  static const Color buttonText = Color(0xFFFFFFFF); // Chữ trên button
}

/// 🖋️ Định nghĩa kiểu chữ
class AppTextStyles {
  static const TextStyle title = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w900,
    color: AppColors.textPrimary,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic, // Chữ nghiêng
    color: AppColors.textPrimary,
  );

  static const TextStyle button = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.buttonText,
  );

    static const TextStyle button_intro = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.textSecondary,
  );

  static const TextStyle forgotPassword = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.textSecondary,
    decoration: TextDecoration.underline,
  );
  static const TextStyle text = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
}

/// Gradient nền của app
const LinearGradient appGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [AppColors.primary, AppColors.secondary, AppColors.background],
);
