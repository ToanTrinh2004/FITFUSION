import 'package:fitfusion_frontend/widgets/tabbar.dart';
import 'package:flutter/material.dart';
import '../theme/theme.dart';
import 'detail_age.dart';
import '../models/user_info_model.dart';
import '../widgets/inputfield.dart'; // Import InputField

class HeightInputScreen extends StatefulWidget {
  final UserInfoModel userInfo;

  const HeightInputScreen({super.key, required this.userInfo});

  @override
  _HeightInputScreenState createState() => _HeightInputScreenState();
}

class _HeightInputScreenState extends State<HeightInputScreen> {
  final TextEditingController _heightController = TextEditingController();

  @override
  void dispose() {
    _heightController.dispose(); // Giải phóng bộ nhớ
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
            AppBarCustomHeader(fullname: widget.userInfo.fullname), // Sử dụng fullname từ userInfo
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
                        "Chiều cao của bạn là bao nhiêu?",
                        style: AppTextStyles.little_title,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      Image.asset(
                        'assets/measure_height.png',
                        height: screenHeight * 0.35,
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      
                      // Sử dụng InputField thay vì TextField
                      InputField(label: 'Nhập chiều cao (cm)',controller: _heightController,height: 50,width: 150, isNumeric: true,),
                        
                      SizedBox(height: screenHeight * 0.05),
                      ElevatedButton(
                        style: ButtonStyles.buttonTwo,
                        onPressed: () {
                          widget.userInfo.height = double.tryParse(_heightController.text);

                              print("Chiều cao đã nhập: ${widget.userInfo.height}");

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AgeSelectionScreen(userInfo: widget.userInfo),
                            ),
                          );
                        },
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
