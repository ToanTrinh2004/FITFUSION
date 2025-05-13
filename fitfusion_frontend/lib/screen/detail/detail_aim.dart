import 'detail_aim_weight.dart';
import 'package:flutter/material.dart';
import 'package:fitfusion_frontend/widgets/tabbar.dart';
import 'package:fitfusion_frontend/models/user_info_model.dart';
import 'package:fitfusion_frontend/theme/theme.dart';

class GoalSelectionScreen extends StatefulWidget {
  final UserInfoModel userInfo;

  const GoalSelectionScreen({super.key, required this.userInfo});

  @override
  _GoalSelectionScreenState createState() => _GoalSelectionScreenState();
}

class _GoalSelectionScreenState extends State<GoalSelectionScreen> {
  String? selectedGoal;

  void _selectGoal(String goal) {
    setState(() {
      selectedGoal = goal;
      widget.userInfo.goal = goal;
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
                          "Mục tiêu chính về chế độ ăn uống của bạn là gì?",
                          style: AppTextStyles.little_title,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: screenHeight * 0.05),
                        
                        _buildGoalButton("Giảm cân", screenWidth),
                        SizedBox(height: screenHeight * 0.02),
                        _buildGoalButton("Sức khỏe cải thiện", screenWidth),
                        SizedBox(height: screenHeight * 0.02),
                        _buildGoalButton("Tăng cân", screenWidth),

                        SizedBox(height: screenHeight * 0.05),
                        Padding(
                          padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                          child: ElevatedButton(
                            style: ButtonStyles.buttonTwo,
                            onPressed: selectedGoal != null
                                ? () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AimWeightScreen(userInfo: widget.userInfo),
                                      ),
                                    );
                                  }
                                : null,
                            child: const Text("TIẾP TỤC", style: AppTextStyles.textButtonTwo),
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

  Widget _buildGoalButton(String goal, double screenWidth) {
    bool isSelected = selectedGoal == goal;
    return GestureDetector(
      onTap: () => _selectGoal(goal),
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
          goal,
          style: isSelected ? AppTextStyles.textButtonTwo : AppTextStyles.textButtonOne,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}