import 'package:flutter/material.dart';
import '../theme/theme.dart'; // Import theme nếu cần

class AppBarCustom extends StatelessWidget {
  final VoidCallback? onBackPressed;
  final VoidCallback? onMenuPressed;

  const AppBarCustom({
    Key? key,
    this.onBackPressed,
    this.onMenuPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.white,size: 50,),
          onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
        ),
        const Text(
          "FITFUSION",
          style: AppTextStyles.title,
        ),
        IconButton(
          icon: const Icon(Icons.menu, color: Colors.white, size: 50,),
          onPressed: onMenuPressed ?? () {},
        ),
      ],
    );
  }
}
class AppBarCustomHeader extends StatelessWidget {
  final String fullname;
  final VoidCallback? onBackPressed;
  final VoidCallback? onMenuPressed;

  const AppBarCustomHeader({
    super.key,
    required this.fullname,
    this.onBackPressed,
    this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left, color: Colors.white, size: 50),
              onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
            ),
            const Text(
              "FITFUSION",
              style: AppTextStyles.title,
            ),
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.white, size: 50,),
              onPressed: onMenuPressed ?? () {},
            ),
          ],
        ),
        const SizedBox(height: 10), // Thêm khoảng cách giữa Row và Text.rich
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Fit",
                style: AppTextStyles.title.copyWith(
                  shadows: const [
                    Shadow(
                      offset: Offset(1.5, 1.5),
                      blurRadius: 0,
                      color: Color(0xFFB3261E),
                    ),
                  ],
                ),
              ),
              TextSpan(
                text: "AI",
                style: AppTextStyles.title.copyWith(
                  color: const Color(0xFFB3261E),
                  shadows: const [
                    Shadow(
                      offset: Offset(1.5, 1.5),
                      blurRadius: 0,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
