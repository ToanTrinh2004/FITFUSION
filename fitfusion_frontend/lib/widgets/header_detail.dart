import 'package:flutter/material.dart';
import '../theme/theme.dart';

class HeaderWidget extends StatelessWidget {
  final String fullname;
  const HeaderWidget({super.key, required this.fullname});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30), // Dành chỗ cho status bar
        const Text(
          "FITFUSION",
          style: AppTextStyles.title
        ),
        const SizedBox(height: 10),
        Text(
          "Xin chào, $fullname",
          style:AppTextStyles.little_title
        ),
      ],
    );
  }
}
