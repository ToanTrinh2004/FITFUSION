import 'package:flutter/material.dart';
import '../theme/theme.dart';
import '../models/user_info_model.dart';
import '../widgets/tabbar.dart';
import '../widgets/inputfield.dart';

class AimWeightScreen extends StatefulWidget {
  final UserInfoModel userInfo;

  const AimWeightScreen({super.key, required this.userInfo});

  @override
  _AimWeightScreenState createState() => _AimWeightScreenState();
}

class _AimWeightScreenState extends State<AimWeightScreen> {
  late TextEditingController _aimWeightController;
  bool isButtonEnabled = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _aimWeightController = TextEditingController(
      text: widget.userInfo.aimWeight?.toString() ?? widget.userInfo.weight.toString(),
    );
    _aimWeightController.addListener(_updateAimWeight);
  }

  void _updateAimWeight() {
    setState(() {
      double? aimWeight = double.tryParse(_aimWeightController.text);
      double currentWeight = widget.userInfo.weight ?? 0.0;
      String goal = widget.userInfo.goal ?? "";
      errorMessage = null;

      if (aimWeight != null && aimWeight > 0) {
        if (goal == "Giảm cân" && aimWeight >= currentWeight) {
          errorMessage = "Cân nặng mục tiêu đang lớn hơn cân nặng hiện tại";
        } else if (goal == "Tăng cân" && aimWeight <= currentWeight) {
          errorMessage = "Cân nặng mục tiêu đang nhỏ hơn cân nặng hiện tại";
        } else if (goal == "Cải thiện sức khỏe") {
          double bmiMin = 18.5;
          double bmiMax = 24.9;
          if (aimWeight < bmiMin || aimWeight > bmiMax) {
            errorMessage = "Cân nặng mục tiêu không nằm trong vùng BMI bình thường";
          }
        }
        
        isButtonEnabled = errorMessage == null;
        widget.userInfo.aimWeight = aimWeight;
        widget.userInfo.calculateBMIAim();
      } else {
        isButtonEnabled = false;
      }
    });
  }

  @override
  void dispose() {
    _aimWeightController.dispose();
    super.dispose();
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
                        "Cân nặng mục tiêu của bạn là bao nhiêu?",
                        style: AppTextStyles.little_title,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      InputField(label: '', controller: _aimWeightController, width: 100, height: 50, isNumeric: true),
                      if (errorMessage != null) ...[
                        const SizedBox(height: 10),
                        Text(errorMessage!, style: AppTextStyles.textButtonOne),
                      ],
                      SizedBox(height: screenHeight * 0.03),
                      const Text(
                        "Chỉ số BMI mục tiêu của bạn là:",
                        style: AppTextStyles.little_title,
                      ),
                      Text(
                        widget.userInfo.bmiAim.toStringAsFixed(1),
                        style: AppTextStyles.title,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(color: Colors.black26, blurRadius: 5, spreadRadius: 2),
                          ],
                        ),
                        padding: EdgeInsets.all(screenWidth * 0.05),
                        child: Column(
                          children: [
                            Text(
                              widget.userInfo.weightLossPercentage > 0
                                  ? "Giảm ${widget.userInfo.weightLossPercentage.toStringAsFixed(1)}% cân!"
                                  : "Bạn không cần giảm cân!",
                              style: AppTextStyles.title.copyWith(color: AppColors.buttonBg),
                              textAlign: TextAlign.center,
                            ),
                            if (widget.userInfo.weightLossPercentage > 0)
                              Text(
                                "Bạn sẽ giảm ${(widget.userInfo.weight! - widget.userInfo.aimWeight!).toStringAsFixed(1)}kg để đạt được cân nặng mục tiêu.",
                                style: AppTextStyles.little_title,
                                textAlign: TextAlign.center,
                              ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.05),
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
}
