import 'package:flutter/material.dart';
import '../theme/theme.dart';

class HeaderWidget extends StatelessWidget {
  final String fullname;
  const HeaderWidget({super.key, required this.fullname});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),
        const Text(
          "FITFUSION",
          style: AppTextStyles.title
        ),
        const SizedBox(height: 10),
        Text(
          "Xin chào, $fullname",
          style:AppTextStyles.little_title
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Fit",
                style:  AppTextStyles.title.copyWith(
                   shadows: [
                    Shadow(
                      offset: Offset(1.5, 1.5),
                      blurRadius: 0,
                      color: Color(0xFFB3261E)
                    ),
                  ],
                ),
              ),
              TextSpan(
                text: "AI",
                style: AppTextStyles.title.copyWith(
                   color: Color(0xFFB3261E),
                   shadows: [
                    Shadow(
                      offset: Offset(1.5, 1.5),
                      blurRadius: 0,
                      color: Colors.white
                    ),
                  ],
                 ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
