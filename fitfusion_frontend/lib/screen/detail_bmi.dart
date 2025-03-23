import 'package:flutter/material.dart';
import '../theme/theme.dart';
import '../widgets/tabbar.dart';

class WeightInputScreen extends StatefulWidget {
  final String fullname;
  final double height; 

  const WeightInputScreen({super.key, required this.fullname, required this.height});

  @override
  _WeightInputScreenState createState() => _WeightInputScreenState();
}

class _WeightInputScreenState extends State<WeightInputScreen> {
  double weight = 60; // Mặc định 60kg
  double bmi = 0;
  String bmiStatus = "";

  void calculateBMI() {
    setState(() {
      bmi = weight / (widget.height * widget.height);
      if (bmi < 18.5) {
        bmiStatus = "Underweight";
      } else if (bmi < 25) {
        bmiStatus = "Normal";
      } else if (bmi < 30) {
        bmiStatus = "Overweight";
      } else if (bmi < 35) {
        bmiStatus = "Obese";
      } else {
        bmiStatus = "Extremely Obese";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: appGradient),
        child: Column(
          children: [
            AppBarCustomHeader(fullname: widget.fullname),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: boxGradient.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.buttonBg),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Cân nặng của bạn là bao nhiêu?", style: AppTextStyles.little_title),
                      
                      SizedBox(height: 20),
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 80,
                            child: TextField(
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
                              onChanged: (value) {
                                setState(() {
                                  weight = double.tryParse(value) ?? 60;
                                  calculateBMI();
                                });
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text("kg", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.red)),
                        ],
                      ),
                      
                      SizedBox(height: 20),
                      
                      const Text("Chỉ số khối cơ thể (BMI) của bạn là", style: TextStyle(fontSize: 18, color: Colors.white)),
                      
                      Text(
                        bmi.toStringAsFixed(1),
                        style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                      
                      Text(
                        "BMI của bạn cho thấy bạn đang $bmiStatus",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      
                      SizedBox(height: 20),
                      
                      Image.asset("assets/BMI.png", width: 300), // Hình ảnh BMI
                      
                      SizedBox(height: 20),
                      
                      ElevatedButton(
                        style: ButtonStyles.buttonTwo,
                        onPressed: () {
                          // Điều hướng sang màn hình tiếp theo
                        },
                        child: const Text("TIẾP TỤC", style: AppTextStyles.textButtonTwo),
                      ),

                      SizedBox(height: 50),
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