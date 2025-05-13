import 'package:flutter/material.dart';
import 'package:fitfusion_frontend/widgets/tabbar.dart';
import 'package:fitfusion_frontend/models/user_info_model.dart';
import 'package:fitfusion_frontend/theme/theme.dart';
import 'package:fitfusion_frontend/widgets/inputfield.dart'; 
import 'detail_age.dart';

class HeightInputScreen extends StatefulWidget {
  final UserInfoModel userInfo;

  const HeightInputScreen({super.key, required this.userInfo});

  @override
  _HeightInputScreenState createState() => _HeightInputScreenState();
}

class _HeightInputScreenState extends State<HeightInputScreen> {
  final TextEditingController _heightController = TextEditingController();
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _heightController.addListener(_validateInput);
  }

  void _validateInput() {
    setState(() {
      double? height = double.tryParse(_heightController.text);
      isButtonEnabled = height != null && height > 0;
    });
  }

  @override
  void dispose() {
    _heightController.dispose();
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.03),
                AppBarCustomHeader(fullname: widget.userInfo.fullname),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05,
                    vertical: screenHeight * 0.02,
                  ),
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: screenHeight * 0.7, // Đảm bảo container đủ cao
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
                          "Chiều cao của bạn là bao nhiêu?",
                          style: AppTextStyles.little_title,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: screenHeight * 0.03),
                        Image.asset(
                          'assets/measure_height.png',
                          height: screenHeight * 0.5,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(height: screenHeight * 0.03),
                        InputField(
                          label: 'Nhập chiều cao (cm)',
                          controller: _heightController,
                          height: 50,
                          width: 200,
                          isNumeric: true,
                        ),
                        SizedBox(height: screenHeight * 0.05),
                        Padding(
                          padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                          child: ElevatedButton(
                            style: ButtonStyles.buttonTwo,
                            onPressed: isButtonEnabled
                                ? () {
                                    widget.userInfo.height = double.tryParse(_heightController.text);
                                    print("Chiều cao đã nhập: ${widget.userInfo.height}");
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AgeSelectionScreen(userInfo: widget.userInfo),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}