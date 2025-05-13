import 'total_detail.dart';
import 'package:flutter/material.dart';
import 'package:fitfusion_frontend/models/user_info_model.dart';
import 'package:fitfusion_frontend/theme/theme.dart';
import 'package:fitfusion_frontend/widgets/tabbar.dart';

class HealthScreen extends StatefulWidget {
  final UserInfoModel userInfo;

  const HealthScreen({super.key, required this.userInfo});

  @override
  _HealthScreenState createState() => _HealthScreenState();
}

class _HealthScreenState extends State<HealthScreen> {
  String? selectedHealth;

  void _selectHealth(String health) {
    setState(() {
      selectedHealth = health;
      widget.userInfo.health = health;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(gradient: appGradient),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.02),
                AppBarCustomHeader(fullname: widget.userInfo.fullname),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05,
                    vertical: screenHeight * 0.02,
                  ),
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: screenHeight * 0.7,
                    ),
                    decoration: BoxDecoration(
                      gradient: boxGradient.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.buttonBg),
                    ),
                    padding: EdgeInsets.all(screenWidth * 0.05),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Bạn có tình trạng sức khỏe nào không?",
                          style: AppTextStyles.little_title,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: screenHeight * 0.04),
                        
                        _buildHealthButton("Không có", screenWidth),
                        SizedBox(height: screenHeight * 0.02),
                        _buildHealthButton("Huyết áp cao", screenWidth),
                        SizedBox(height: screenHeight * 0.02),
                        _buildHealthButton("Bệnh tiểu đường", screenWidth),
                        SizedBox(height: screenHeight * 0.02),
                        _buildHealthButton("Cholesterol cao", screenWidth),
                        SizedBox(height: screenHeight * 0.02),
                        _buildHealthButton("Khác", screenWidth),

                        SizedBox(height: screenHeight * 0.05),
                        Padding(
                          padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                          child: ElevatedButton(
                            style: ButtonStyles.buttonTwo.copyWith(
                              minimumSize: MaterialStateProperty.all(
                                Size(screenWidth * 0.7, 50),
                              ),
                            ),
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
                            child: const Text(
                              "TIẾP TỤC", 
                              style: AppTextStyles.textButtonTwo,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHealthButton(String health, double screenWidth) {
    bool isSelected = selectedHealth == health;
    return GestureDetector(
      onTap: () => _selectHealth(health),
      child: Container(
        width: screenWidth * 0.8,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.textSecondary : AppColors.textPrimary,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? AppColors.buttonBg : Colors.transparent,
            width: 2,
          ),
        ),
        child: Text(
          health,
          style: isSelected ? AppTextStyles.textButtonTwo : AppTextStyles.textButtonOne,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}