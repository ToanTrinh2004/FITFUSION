import 'package:flutter/material.dart';
import '../models/user_info_model.dart';
import '../theme/theme.dart';
import '../widgets/tabbar.dart';
import '../widgets/widget_home.dart';
import 'package:fitfusion_frontend/screen/main_features/coach.dart'; 
import 'package:fitfusion_frontend/screen/main_features/calories/calories.dart';
import 'package:fitfusion_frontend/screen/main_features/workout_home.dart';
import 'package:fitfusion_frontend/screen/main_features/nutrition.dart';

class HomeScreen extends StatelessWidget {
  final UserInfoModel userInfo;

  const HomeScreen({super.key, required this.userInfo});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(gradient: appGradient),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.03),
              AppBarCustomHeader(fullname: userInfo.fullname),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      UserImageWidget(userInfo: userInfo, screenWidth: screenWidth, screenHeight: screenHeight),
                      SizedBox(height: screenHeight * 0.02),

                      FeatureButton(
                        title: "HLV Cá nhân",
                        image: "assets/coach.png",
                        gradientColors: [Color(0xFF54CAF7), Colors.white],
                        isTextLeft: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CoachScreen()),
                          );
                        },
                      ),
                      FeatureButton(
                        title: "Tính Calories",
                        image: "assets/calories.png",
                        gradientColors: [Colors.white, Color(0xFFF7C818)],
                        isTextLeft: false,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CaloriesScreen(userInfo: userInfo,)),
                          );
                        },
                      ),
                      FeatureButton(
                        title: "Bài tập tại nhà",
                        image: "assets/workout.png",
                        gradientColors: [Color(0xFF9CB327), Colors.white],
                        isTextLeft: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => WorkoutScreen()),
                          );
                        },
                      ),
                      FeatureButton(
                        title: "Chế độ dinh dưỡng",
                        image: "assets/nutrition.png",
                        gradientColors: [Colors.white, Color(0xFFF48221)],
                        isTextLeft: false,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => NutritionScreen()),
                          );
                        },
                      ),
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
}