import 'package:flutter/material.dart';
import '../theme/theme.dart';

class GenderOptionWidget extends StatelessWidget {
  final String gender;
  final String imagePath;
  final bool isSelected;
  final VoidCallback onTap;

  const GenderOptionWidget({
    super.key,
    required this.gender,
    required this.imagePath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? (gender == "Nam" ? Colors.blue : Colors.pink) : Colors.transparent,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Image.asset(imagePath, width: 300),
              const SizedBox(height: 10),
              Text(
                gender,
                style: isSelected ? AppTextStyles.textButtonOne : AppTextStyles.textButtonTwo,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
