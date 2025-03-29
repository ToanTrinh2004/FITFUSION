import 'package:fitfusion_frontend/screen/total_detail.dart';
import 'package:flutter/material.dart';
import '../theme/theme.dart';
import '../models/user_info_model.dart';
import '../widgets/tabbar.dart';

class HealthScreen extends StatefulWidget {
  final UserInfoModel userInfo;

  const HealthScreen({super.key, required this.userInfo});

  @override
  _HealthScreenState createState() => _HealthScreenState();
}

class _HealthScreenState extends State<HealthScreen> {
  String? selectedHealth;

  void _selectHealth(String Health) {
    setState(() {
      selectedHealth = Health;
      widget.userInfo.health = Health;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: appGradient),
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.03),
            AppBarCustomHeader(fullname: widget.userInfo.fullname),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.02,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: boxGradient.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.buttonBg),
                  ),
                  padding: EdgeInsets.all(screenWidth * 0.05),
                  child: Column(
                    children: [
                      const Text(
                        "Bạn có tình trạng sức khỏe nào không?",
                        style: AppTextStyles.little_title,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: screenHeight * 0.05),

                      _buildHealthButton("Không có"),
                      _buildHealthButton("Huyết áp cao"),
                      _buildHealthButton("Bệnh tiểu đường"),
                      _buildHealthButton("Cholesterol cao"),
                      _buildHealthButton("Khác"),

                      SizedBox(height: screenHeight * 0.05),

                      ElevatedButton(
                        style: ButtonStyles.buttonTwo,
                        onPressed: selectedHealth != null
                            ? () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TotalDetailScreen(userInfo: widget.userInfo),
                                  ),
                                );
                              }
                            : null, 
                        child: const Text("TIẾP TỤC", style: AppTextStyles.textButtonTwo),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthButton(String Health) {
    bool isSelected = selectedHealth == Health;
    return GestureDetector(
      onTap: () => _selectHealth(Health),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.textSecondary : AppColors.textPrimary,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.red, width: 2),
        ),
        child: Text(
          Health,
          style: isSelected ? AppTextStyles.textButtonTwo : AppTextStyles.textButtonOne,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
