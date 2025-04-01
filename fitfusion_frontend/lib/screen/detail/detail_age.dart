import 'package:flutter/material.dart';
import 'package:fitfusion_frontend/widgets/tabbar.dart';
import 'package:fitfusion_frontend/models/user_info_model.dart';
import 'package:fitfusion_frontend/theme/theme.dart';
import 'detail_bmi.dart'; 

class AgeSelectionScreen extends StatefulWidget {
  final UserInfoModel userInfo;

  const AgeSelectionScreen({super.key, required this.userInfo});

  @override
  _AgeSelectionScreenState createState() => _AgeSelectionScreenState();
}

class _AgeSelectionScreenState extends State<AgeSelectionScreen> {
  int selectedAge = 24; // Mặc định là 24 tuổi

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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Bạn bao nhiêu tuổi?",
                        style: AppTextStyles.little_title,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: screenHeight * 0.03),

                      Expanded(
                        child: SizedBox(
                          height: 120,
                          child: ListWheelScrollView.useDelegate(
                            itemExtent: 50, 
                            physics: const FixedExtentScrollPhysics(),
                            diameterRatio: 1.3,
                            controller: FixedExtentScrollController(initialItem: selectedAge - 18),
                            onSelectedItemChanged: (index) {
                              setState(() {
                                selectedAge = index + 18;
                              });
                            },
                            childDelegate: ListWheelChildBuilderDelegate(
                              builder: (context, index) {
                                int age = index + 18;
                                bool isSelected = age == selectedAge;

                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  alignment: Alignment.center,
                                  height: isSelected ? 55 : 45,
                                  decoration: isSelected
                                      ? BoxDecoration(
                                          border: Border.all(color: Colors.red, width: 3),
                                          borderRadius: BorderRadius.circular(12),
                                        )
                                      : null,
                                  child: Text(
                                    age.toString(),
                                    style: TextStyle(
                                      fontSize: isSelected ? 26 : 20,
                                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                      color: isSelected ? Colors.white : Colors.white60,
                                    ),
                                  ),
                                );
                              },
                              childCount: 83,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.05),

                      ElevatedButton(
                        style: ButtonStyles.buttonTwo,
                        onPressed: () {
                          widget.userInfo.age = selectedAge; // Lưu tuổi vào userInfo
                          print("Tuổi đã chọn: ${widget.userInfo.age}");

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WeightInputScreen(userInfo: widget.userInfo),
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
