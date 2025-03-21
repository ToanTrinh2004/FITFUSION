import 'package:fitfusion_frontend/widgets/tabbar.dart';
import 'package:flutter/material.dart';
import '../theme/theme.dart';
import '../widgets/gender.dart';
import 'detail_measure_height.dart';
class GenderSelectionScreen extends StatefulWidget {
  final String fullname;

  const GenderSelectionScreen({super.key, required this.fullname});

  @override
  _GenderSelectionScreenState createState() => _GenderSelectionScreenState();
}

class _GenderSelectionScreenState extends State<GenderSelectionScreen> {
  String selectedGender = '';

  void selectGender(String gender) {
    setState(() {
      selectedGender = gender;
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
            const SizedBox(height: 20,),
            AppBarCustomHeader(fullname: widget.fullname),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 40),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: boxGradient.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                    border:Border.all(color: AppColors.buttonBg)
                  ),
                  child: Column(
                    children: [
                      Padding(padding:EdgeInsets.symmetric(vertical: 10)),
                      const Text("Giới tính của bạn là gì?", style: AppTextStyles.little_title),
                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GenderOptionWidget(
                            gender: "Nam",
                            imagePath: "assets/male.png",
                            isSelected: selectedGender == "Nam",
                            onTap: () => selectGender("Nam"),
                          ),
                          const SizedBox(width: 10),
                          GenderOptionWidget(
                            gender: "Nữ",
                            imagePath: "assets/female.png",
                            isSelected: selectedGender == "Nữ",
                            onTap: () => selectGender("Nữ"),
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:  10), // Cách viền trên dưới 10px
                        child: Text(
                          "Chúng tôi sử dụng giới tính của bạn để thiết kế kế hoạch ăn kiêng tốt nhất cho bạn. Nếu bạn không xác định mình là bất kỳ lựa chọn nào trong số này, vui lòng chọn giới tính gần nhất với hồ sơ nội tiết tố của bạn.",
                          style: AppTextStyles.normal,
                        ),
                      ),


                      const SizedBox(height: 30),

                      ElevatedButton(
                        style: ButtonStyles.buttonTwo,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HeightInputScreen(fullname: '',)), 
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
