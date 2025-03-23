import 'package:fitfusion_frontend/widgets/tabbar.dart';
import 'package:flutter/material.dart';
import '../theme/theme.dart';

class AgeSelectionScreen extends StatefulWidget {
  final String fullname;

  const AgeSelectionScreen({super.key, required this.fullname});

  @override
  _AgeSelectionScreenState createState() => _AgeSelectionScreenState();
}

class _AgeSelectionScreenState extends State<AgeSelectionScreen> {
  int selectedAge = 24; // Mặc định 24 tuổi

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
                      Padding(padding: const EdgeInsets.symmetric(vertical: 10)),
                      const Text("Bạn bao nhiêu tuổi?", style: AppTextStyles.little_title),

                      SizedBox(height: 20), 

                      Expanded(
                        child: SizedBox(
                          height: 120, 
                          child: ListWheelScrollView.useDelegate(
                            itemExtent: 50, // Khoảng cách giữa các số
                            physics: FixedExtentScrollPhysics(),
                            diameterRatio: 1.3, // Giảm đường kính
                            controller: FixedExtentScrollController(initialItem: 2),
                            onSelectedItemChanged: (index) => setState(() => selectedAge = index + 18),
                            childDelegate: ListWheelChildBuilderDelegate(
                              builder: (context, index) {
                                int age = index + 18;
                                bool isSelected = age == selectedAge;

                                return AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  alignment: Alignment.center,
                                  height: isSelected ? 55 : 45, // Số được chọn to hơn
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
                              childCount: 83, // Giới hạn số tuổi
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 30),

                      ElevatedButton(
                        style: ButtonStyles.buttonTwo,
                        onPressed: () {
                           // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => HeightInputScreen(fullname: '',)), 
                             // );
                             },
                        child: const Text("TIẾP TỤC", style: AppTextStyles.textButtonTwo),
                      ),

                      SizedBox(height: 50),
                    ],
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
