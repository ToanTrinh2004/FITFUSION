import 'detail_aim_date.dart';
import 'package:flutter/material.dart';
import 'package:fitfusion_frontend/widgets/tabbar.dart';
import 'package:fitfusion_frontend/models/user_info_model.dart';
import 'package:fitfusion_frontend/theme/theme.dart';
import 'package:fitfusion_frontend/widgets/inputfield.dart';

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
  String weightChangeMessage = "";
  String weightChangeDetails = "";

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
      double height = widget.userInfo.height ?? 1.7;
      String goal = widget.userInfo.goal ?? "";
      errorMessage = null;

      if (aimWeight != null && aimWeight > 0) {
        if (goal == "Giảm cân" && aimWeight >= currentWeight) {
          errorMessage = "Cân nặng mục tiêu đang lớn hơn cân nặng hiện tại";
        } else if (goal == "Tăng cân") {
          double minGain = 2.0; 
          if (aimWeight <= currentWeight) {
            errorMessage = "Cân nặng mục tiêu đang nhỏ hơn cân nặng hiện tại";
          } else if (aimWeight < currentWeight + minGain) {
            errorMessage = "Bạn nên đặt cân nặng mục tiêu tăng ít nhất ${minGain}kg";
          }
        } else if (goal == "Cải thiện sức khỏe") {
          double bmiMin = 18.5;
          double bmiMax = 24.9;
          double weightMin = bmiMin * (height * height);
          double weightMax = bmiMax * (height * height);
          if (aimWeight < weightMin || aimWeight > weightMax) {
            errorMessage = "Cân nặng mục tiêu không nằm trong vùng BMI bình thường (${weightMin.toStringAsFixed(1)}kg - ${weightMax.toStringAsFixed(1)}kg)";
          }
        }

        isButtonEnabled = errorMessage == null;
        widget.userInfo.aimWeight = aimWeight;
        widget.userInfo.calculateBMIAim();

        _updateWeightChangeMessage(currentWeight, aimWeight);
      } else {
        isButtonEnabled = false;
      }
    });
  }

  void _updateWeightChangeMessage(double currentWeight, double aimWeight) {
    if (currentWeight > 0) {
      widget.userInfo.weightLossPercentage = ((currentWeight - aimWeight) / currentWeight) * 100;
    } else {
      widget.userInfo.weightLossPercentage = 0.0;
    }

    double weightDiff = currentWeight - aimWeight;
    
    String currentBmiStatus = widget.userInfo.bmiStatus;
    
    if (weightDiff > 0) {
      // Cần giảm cân
      if (currentBmiStatus == "Gầy") {
        weightChangeMessage = "Cảnh báo: Bạn đang gầy!";
        weightChangeDetails = "Bạn không nên giảm cân thêm, hãy xem xét việc tăng cân.";
      } else if (currentBmiStatus == "Bình thường") {
        weightChangeMessage = "Giảm ${widget.userInfo.weightLossPercentage.toStringAsFixed(1)}% cân!";
        weightChangeDetails = "Bạn sẽ giảm ${weightDiff.toStringAsFixed(1)}kg để đạt được cân nặng mục tiêu.";
      } else if (currentBmiStatus == "Thừa cân") {
        weightChangeMessage = "Giảm ${widget.userInfo.weightLossPercentage.toStringAsFixed(1)}% cân!";
        weightChangeDetails = "Việc giảm ${weightDiff.toStringAsFixed(1)}kg sẽ giúp bạn đạt BMI lý tưởng hơn.";
      } else if (currentBmiStatus == "Béo phì") {
        weightChangeMessage = "Cần giảm ${widget.userInfo.weightLossPercentage.toStringAsFixed(1)}% cân!";
        weightChangeDetails = "Việc giảm ${weightDiff.toStringAsFixed(1)}kg sẽ cải thiện sức khỏe của bạn đáng kể.";
      } else {
        weightChangeMessage = "Cần giảm ${widget.userInfo.weightLossPercentage.toStringAsFixed(1)}% cân ngay!";
        weightChangeDetails = "Giảm ${weightDiff.toStringAsFixed(1)}kg là cần thiết để bảo vệ sức khỏe của bạn.";
      }
    } else if (weightDiff < 0) {
      // Cần tăng cân
      widget.userInfo.weightLossPercentage = widget.userInfo.weightLossPercentage; // Đổi dấu để biểu thị tăng cân
      if (currentBmiStatus == "Gầy") {
        weightChangeMessage = "Cần tăng ${(widget.userInfo.weightLossPercentage).toStringAsFixed(1)}% cân!";
        weightChangeDetails = "Tăng ${(weightDiff).toStringAsFixed(1)}kg sẽ giúp bạn có sức khỏe tốt hơn.";
      } else if (currentBmiStatus == "Bình thường") {
        weightChangeMessage = "Tăng ${(widget.userInfo.weightLossPercentage).toStringAsFixed(1)}% cân!";
        weightChangeDetails = "Bạn sẽ tăng ${(weightDiff).toStringAsFixed(1)}kg để đạt mục tiêu.";
      } else {
        weightChangeMessage = "Cảnh báo: Không nên tăng cân!";
        weightChangeDetails = "Với BMI hiện tại, bạn không nên tăng thêm ${(weightDiff).toStringAsFixed(1)}kg.";
      }
    } else {
      // Giữ nguyên cân nặng
      weightChangeMessage = "Duy trì cân nặng hiện tại!";
      weightChangeDetails = "Cân nặng mục tiêu của bạn trùng với cân nặng hiện tại.";
      widget.userInfo.weightLossPercentage = 0.0;
    }
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
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(gradient: appGradient),
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.01),
              AppBarCustomHeader(fullname: widget.userInfo.fullname),
              Expanded(
                child: SingleChildScrollView(
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Cân nặng mục tiêu của bạn là bao nhiêu?",
                            style: AppTextStyles.little_title,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          InputField(label: '', controller: _aimWeightController, width: 100, height: 50, isNumeric: true),
                          if (errorMessage != null) ...[
                            SizedBox(height: screenHeight * 0.01),
                            Text(
                              errorMessage!, 
                              style: AppTextStyles.textButtonOne,
                              textAlign: TextAlign.center,
                            ),
                          ],
                          SizedBox(height: screenHeight * 0.03),
                          Text(
                            "Chỉ số BMI mục tiêu của bạn là:",
                            style: AppTextStyles.subtitle.copyWith(
                              fontSize: screenHeight * 0.022,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            widget.userInfo.bmiAim.toStringAsFixed(1),
                            style: TextStyle(
                              fontSize: screenHeight * 0.05,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: const [
                                Shadow(
                                  offset: Offset(-1.5, -1.5),
                                  color: Colors.red,
                                ),
                                Shadow(
                                  offset: Offset(1.5, -1.5),
                                  color: Colors.red,
                                ),
                                Shadow(
                                  offset: Offset(-1.5, 1.5),
                                  color: Colors.red,
                                ),
                                Shadow(
                                  offset: Offset(1.5, 1.5),
                                  color: Colors.red,
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(color: Colors.black26, blurRadius: 5, spreadRadius: 2),
                              ],
                            ),
                            padding: EdgeInsets.all(screenWidth * 0.03),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  weightChangeMessage,
                                  style: AppTextStyles.title.copyWith(color: AppColors.buttonBg, fontSize: screenWidth * 0.05),
                                  textAlign: TextAlign.center,
                                ),
                                if (weightChangeDetails.isNotEmpty)
                                  Text(
                                    weightChangeDetails,
                                    style: AppTextStyles.little_title,
                                    textAlign: TextAlign.center,
                                  ),
                              ],
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.05),
                          ElevatedButton(
                            style: ButtonStyles.buttonTwo,
                            onPressed: isButtonEnabled
                                ? () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AimDateScreen(userInfo: widget.userInfo),
                                      ),
                                    );
                                  }
                                : null,
                            child: const Text("TIẾP TỤC", style: AppTextStyles.textButtonTwo),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}