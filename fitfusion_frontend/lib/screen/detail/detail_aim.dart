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
                        "Mục tiêu chính về chế độ ăn uống của bạn là gì?",
                        style: AppTextStyles.little_title,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: screenHeight * 0.1),

                      _buildGoalButton("Giảm cân"),
                      _buildGoalButton("Sức khỏe cải thiện"),
                      _buildGoalButton("Tăng cân"),

                      SizedBox(height: screenHeight * 0.05),

                      ElevatedButton(
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
                            : null, // Vô hiệu hóa nếu chưa chọn
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

  Widget _buildGoalButton(String goal) {
    bool isSelected = selectedGoal == goal;
    return GestureDetector(
      onTap: () => _selectGoal(goal),
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
          goal,
          style:  isSelected ? AppTextStyles.textButtonTwo : AppTextStyles.textButtonOne,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
