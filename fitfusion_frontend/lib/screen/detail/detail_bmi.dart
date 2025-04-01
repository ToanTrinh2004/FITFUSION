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
    _weightController = TextEditingController(text: widget.userInfo.weight?.toString() ?? "60");
    _weightController.addListener(_updateBMI);
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
                        "Cân nặng của bạn là bao nhiêu?",
                        style: AppTextStyles.little_title,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 0.03),
                      InputField(label: '', controller: _weightController, width: 100, height: 50, isNumeric: true),
                      SizedBox(height: screenHeight * 0.03),
                      const Text(
                        "Chỉ số BMI của bạn là:",
                        style: AppTextStyles.little_title,
                      ),
                      Text(
                        widget.userInfo.bmi.toStringAsFixed(1),
                        style: AppTextStyles.title
                      ),
                      Text(
                        "Bạn đang ở mức: ${widget.userInfo.bmiStatus}",
                        style: AppTextStyles.subtitle,
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      Image.asset("assets/BMI.png", width: screenWidth * 0.8),
                      SizedBox(height: screenHeight * 0.05),
                      ElevatedButton(
                        style: ButtonStyles.buttonTwo,
                        onPressed: isButtonEnabled
                            ? () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>GoalSelectionScreen(userInfo: widget.userInfo),
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
}
