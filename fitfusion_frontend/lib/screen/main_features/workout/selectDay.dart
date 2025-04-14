import 'package:fitfusion_frontend/screen/main_features/workOut/listex.dart';
import 'package:flutter/material.dart';
import 'package:fitfusion_frontend/models/user_info_model.dart';
import 'package:fitfusion_frontend/theme/theme.dart';
import 'package:fitfusion_frontend/widgets/tabbar.dart';

class WorkoutDaysSelectionScreen extends StatefulWidget {
  final UserInfoModel userInfo;

  const WorkoutDaysSelectionScreen({super.key, required this.userInfo});

  @override
  State<WorkoutDaysSelectionScreen> createState() =>
      _WorkoutDaysSelectionScreenState();
}

class _WorkoutDaysSelectionScreenState
    extends State<WorkoutDaysSelectionScreen> {
  int selectedDay = 5;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: appGradient),
        child: SafeArea(
          child: Column(
            children: [
              AppBarCustomHeader(fullname: widget.userInfo.fullname),
              const SizedBox(height: 10),
              const Text(
                'Bài tập tại nhà',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Center(
                  child: Container(
                    width: screenWidth * 0.7,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    child: Column(
                      children: [
                        SizedBox(height: screenHeight * 0.05),
                        const Text(
                          "Bạn muốn tập bao nhiêu ngày/tuần",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 150,
                          child: ListWheelScrollView.useDelegate(
                            itemExtent: 50,
                            physics: const FixedExtentScrollPhysics(),
                            diameterRatio: 1.3,
                            controller: FixedExtentScrollController(
                                initialItem: selectedDay - 3),
                            onSelectedItemChanged: (index) {
                              setState(() {
                                selectedDay = index + 3;
                              });
                            },
                            childDelegate: ListWheelChildBuilderDelegate(
                              builder: (context, index) {
                                int day = index + 3;
                                bool isSelected = day == selectedDay;
                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  alignment: Alignment.center,
                                  height: isSelected ? 55 : 45,
                                  decoration: isSelected
                                      ? BoxDecoration(
                                          border: Border.all(
                                              color: Colors.red, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        )
                                      : null,
                                  child: Text(
                                    day.toString(),
                                    style: TextStyle(
                                      fontSize: isSelected ? 24 : 20,
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.white60,
                                    ),
                                  ),
                                );
                              },
                              childCount: 5, // 3 đến 7
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.08),
                        ElevatedButton(
                          style: ButtonStyles.buttonTwo,
                          onPressed: () {
                            widget.userInfo.workOutDays = selectedDay;
                            print(
                                "Ngày tập đã chọn: ${widget.userInfo.workOutDays}");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WorkoutDayDetailScreen(
                                  day: 1,
                                  userInfo: widget.userInfo,
                                ),
                              ),
                            );
                          },
                          child: const Text("TIẾP TỤC",
                              style: AppTextStyles.textButtonTwo),
                        ),
                      ],
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
