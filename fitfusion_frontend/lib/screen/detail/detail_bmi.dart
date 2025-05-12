import 'detail_aim.dart';
import 'package:flutter/material.dart';
import 'package:fitfusion_frontend/models/user_info_model.dart';
import 'package:fitfusion_frontend/theme/theme.dart';
import 'package:fitfusion_frontend/widgets/tabbar.dart';
import 'package:fitfusion_frontend/widgets/inputfield.dart';

class WeightInputScreen extends StatefulWidget {
  final UserInfoModel userInfo;

  const WeightInputScreen({super.key, required this.userInfo});

  @override
  _WeightInputScreenState createState() => _WeightInputScreenState();
}

class _WeightInputScreenState extends State<WeightInputScreen> {
  late TextEditingController _weightController;
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _weightController =
        TextEditingController(text: widget.userInfo.weight?.toString() ?? "60");
    _weightController.addListener(_updateBMI);
    // Calculate initial BMI
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateBMI();
    });
  }

  void _updateBMI() {
    setState(() {
      double? weight = double.tryParse(_weightController.text);
      isButtonEnabled = weight != null && weight > 0;
      widget.userInfo.weight = weight ?? 60;
      widget.userInfo.calculateBMI();
    });
  }

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
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
                          "Cân nặng của bạn là bao nhiêu?",
                          style: AppTextStyles.little_title,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: screenHeight * 0.03),
                        InputField(
                          label: 'Nhập cân nặng (kg)',
                          controller: _weightController,
                          width: screenWidth * 0.5,
                          height: 50,
                          isNumeric: true,
                        ),
                        SizedBox(height: screenHeight * 0.04),
                        const Text(
                          "Chỉ số BMI của bạn là:",
                          style: AppTextStyles.little_title,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Text(
                          widget.userInfo.bmi.toStringAsFixed(1),
                          style: AppTextStyles.title,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Text(
                          "Bạn đang ở mức: ${widget.userInfo.bmiStatus}",
                          style: AppTextStyles.subtitle.copyWith(
                            fontSize: screenHeight * 0.05,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: screenHeight * 0.03),
                        Image.asset(
                          "assets/BMI.png",
                          width: screenWidth * 0.8,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(height: screenHeight * 0.04),
                        Padding(
                          padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                          child: ElevatedButton(
                            style: ButtonStyles.buttonTwo,
                            onPressed: isButtonEnabled
                                ? () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => GoalSelectionScreen(
                                            userInfo: widget.userInfo),
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
}