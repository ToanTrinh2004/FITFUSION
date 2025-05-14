import 'package:flutter/material.dart';
import 'package:fitfusion_frontend/models/user_info_model.dart';
import 'package:fitfusion_frontend/widgets/tabbar.dart';
import 'package:fitfusion_frontend/theme/theme.dart';
import 'package:fitfusion_frontend/screen/main_features/workOut/selectDay.dart';
import 'package:fitfusion_frontend/models/workout_model.dart';

class WorkoutScreen extends StatelessWidget {
  final UserInfoModel userInfo;
  
  const WorkoutScreen({super.key, required this.userInfo});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: appGradient,
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AppBarCustom(),
              const SizedBox(height: 30),
              const Text(
                'Bài tập tại nhà',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildInfoBox(context),
                      const SizedBox(height: 30),
                      _buildButton('Các bài tập cơ bản', WorkoutLevel.basic, context),
                      const SizedBox(height: 20),
                      _buildButton('Các bài tập trung bình', WorkoutLevel.intermediate, context),
                      const SizedBox(height: 20),
                      _buildButton('Các bài tập nâng cao', WorkoutLevel.advanced, context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildInfoBox(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Thông tin về các cấp độ tập luyện:',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '• Cơ bản: 4 bài tập mỗi ngày, phù hợp với người mới\n'
            '• Trung bình: 6 bài tập mỗi ngày\n'
            '• Nâng cao: 8 bài tập mỗi ngày',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildButton(String text, WorkoutLevel level, BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WorkoutDaysSelectionScreen(
              userInfo: userInfo,
              level: level, 
            ),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFFB3261E),
        minimumSize: const Size(double.infinity, 100),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 5,
        shadowColor: Colors.black26,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}