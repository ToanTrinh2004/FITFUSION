import 'package:flutter/material.dart';
import 'package:fitfusion_frontend/theme/theme.dart';
import 'package:fitfusion_frontend/models/meal_model.dart';
import 'package:fitfusion_frontend/api/chatbot/mealsService.dart';
import 'package:fitfusion_frontend/widgets/tabbar.dart';

class NutritionScreen extends StatefulWidget {
  const NutritionScreen({super.key});

  @override
  State<NutritionScreen> createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  int selectedDayIndex = DateTime.now().weekday - 1; // Default to current day
  List<DailyNutrition> mealPlanData = [];
  bool isLoading = true;
  String errorMessage = '';
  
  // User preferences - these could come from user profile
  final String bmiStatus = "normal";
  final String? foodAllergy = "chicken";
  final String? foodFavour = "peanut";
  
  final List<String> weekDays = ["S", "M", "T", "W", "T", "F", "S"];
  final List<String> dayOrder = [
    'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday'
  ];

  @override
  void initState() {
    super.initState();
    _loadNutritionData();
  }

  Future<void> _loadNutritionData() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final WeeklyNutrition weeklyPlan = await MealService.getMealPlan(
        bmiStatus: bmiStatus,
        foodAllergy: foodAllergy,
        foodFavour: foodFavour,
      );

      List<DailyNutrition> dailyData = [];
      
      // Convert map data to ordered list
      for (String day in dayOrder) {
        if (weeklyPlan.data.containsKey(day)) {
          dailyData.add(weeklyPlan.data[day]!);
        }
      }

      setState(() {
        mealPlanData = dailyData;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  void _selectDay(int index) {
    setState(() {
      selectedDayIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: appGradient),
        child: SafeArea(
          child: isLoading 
            ? const Center(child: CircularProgressIndicator())
            : errorMessage.isNotEmpty
              ? Center(child: Text('Error: $errorMessage', style: TextStyle(color: Colors.white)))
              : mealPlanData.isEmpty
                ? Center(child: Text('No meal plan data available', style: TextStyle(color: Colors.white)))
                : RefreshIndicator(
                    onRefresh: _loadNutritionData,
                    child: Column(
                      children: [
                        _buildAppBar(context),
                        _buildWeekSelector(screenWidth, isSmallScreen),
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Column(
                              children: [
                                _buildOverview(screenWidth, isSmallScreen),
                                _buildRefreshButton(screenWidth),
                                _buildMealSection(
                                  title: "Breakfast",
                                  meal: mealPlanData[selectedDayIndex].breakfast,
                                  screenWidth: screenWidth,
                                  isSmallScreen: isSmallScreen,
                                ),
                                _buildMealSection(
                                  title: "Lunch",
                                  meal: mealPlanData[selectedDayIndex].lunch,
                                  screenWidth: screenWidth,
                                  isSmallScreen: isSmallScreen,
                                ),
                                _buildMealSection(
                                  title: "Dinner",
                                  meal: mealPlanData[selectedDayIndex].dinner,
                                  screenWidth: screenWidth,
                                  isSmallScreen: isSmallScreen,
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
  
  Widget _buildRefreshButton(double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: 8),
      child: ElevatedButton.icon(
        onPressed: () {
          setState(() {
            isLoading = true;
          });
          _loadNutritionData();
        },
        icon: const Icon(Icons.refresh, color: Colors.white),
        label: const Text(
          'Làm mới thực đơn',
          style: TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary.withOpacity(0.8),
          minimumSize: Size(double.infinity, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  // App bar with back button and menu
  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppBarCustom(),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              'Chế độ dinh dưỡng',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // Week day selector
  Widget _buildWeekSelector(double screenWidth, bool isSmallScreen) {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));

    return Container(
      width: screenWidth,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white30, width: 1),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(7, (index) {
            bool isSelected = index == selectedDayIndex;
            final day = weekStart.add(Duration(days: index));

            return GestureDetector(
              onTap: () => _selectDay(index),
              child: Container(
                width: screenWidth * 0.13,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                child: Column(
                  children: [
                    Text(weekDays[index], style: AppTextStyles.text),
                    const SizedBox(height: 5),
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: isSelected
                          ? AppColors.textPrimary
                          : AppColors.primaryHalf,
                      child: Text(
                        day.day.toString(),
                        style: TextStyle(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  // Nutrition overview section
  Widget _buildOverview(double screenWidth, bool isSmallScreen) {
    final dailyNutrition = mealPlanData[selectedDayIndex];
    
    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.04),
      child: Container(
        padding: EdgeInsets.all(screenWidth * 0.03),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildInfoBox("${dailyNutrition.totalCalories}", "calo",
                  Colors.red, isSmallScreen),
              SizedBox(width: screenWidth * 0.03),
              _buildInfoBox(
                  "${dailyNutrition.nutrition.protein}g",
                  "protein",
                  Colors.blue,
                  isSmallScreen),
              SizedBox(width: screenWidth * 0.03),
              _buildInfoBox(
                  "${dailyNutrition.nutrition.fats}g",
                  "chất béo",
                  Colors.orange,
                  isSmallScreen),
              SizedBox(width: screenWidth * 0.03),
              _buildInfoBox(
                  "${dailyNutrition.nutrition.carbs}g",
                  "carbs",
                  Colors.green,
                  isSmallScreen),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoBox(String value, String label, Color color, bool isSmallScreen) {
    return Row(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: color.withOpacity(0.2),
          child: Icon(
            _getIconForNutrient(label),
            color: color,
            size: 18,
          ),
        ),
        const SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                )),
            Text(label, style: AppTextStyles.nutrition),
          ],
        ),
      ],
    );
  }

  IconData _getIconForNutrient(String nutrient) {
    switch (nutrient) {
      case "calo":
        return Icons.local_fire_department;
      case "protein":
        return Icons.fitness_center;
      case "chất béo":
        return Icons.opacity;
      case "carbs":
        return Icons.grain;
      default:
        return Icons.info;
    }
  }

  // Meal section
  Widget _buildMealSection({
    required String title,
    required Meal meal,
    required double screenWidth,
    required bool isSmallScreen,
  }) {
    bool hasMealData = meal.dishName.isNotEmpty;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.little_title),

          // Calorie pills
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildPill("${meal.calories} calo"),
                _buildPill("${meal.macronutrients.protein}g protein"),
                _buildPill("${meal.macronutrients.fats}g chất béo"),
                _buildPill("${meal.macronutrients.carbs}g carbs"),
              ],
            ),
          ),

          // Meal content
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(screenWidth * 0.03),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: hasMealData
                ? _buildDetailedMealContent(meal, screenWidth)
                : SizedBox(
                    height: 60,
                    child: Center(
                      child: Text(
                        "Chưa có thông tin bữa ăn",
                        style: AppTextStyles.title1,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildDetailedMealContent(Meal meal, double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(meal.dishName, style: AppTextStyles.subtitle),
        const SizedBox(height: 12),
        
        // Ingredients section
        Text("Nguyên liệu:", style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: AppColors.primary,
        )),
        const SizedBox(height: 4),
        meal.ingredients.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: meal.ingredients
                    .map((ingredient) => Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("• ", style: TextStyle(fontWeight: FontWeight.bold)),
                              Expanded(
                                child: Text(
                                  ingredient,
                                  style: AppTextStyles.normal_nutri,
                                ),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              )
            : Text("No ingredients listed", style: AppTextStyles.normal_nutri),
        
        const SizedBox(height: 12),
        
        // Instructions section
        Text("Chuẩn bị:", style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: AppColors.primary,
        )),
        const SizedBox(height: 4),
        meal.instructions.isNotEmpty
            ? Text(meal.instructions, style: AppTextStyles.normal_nutri)
            : Text("No preparation instructions available", style: AppTextStyles.normal_nutri),
        
        const SizedBox(height: 12),
        
        // Health benefits section
        Text("Lợi ích:", style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: AppColors.primary,
        )),
        const SizedBox(height: 4),
        meal.note.isNotEmpty
            ? Text(meal.note, style: AppTextStyles.normal_nutri)
            : Text("No health benefit information available", style: AppTextStyles.normal_nutri),
        
        const SizedBox(height: 16),
        
        // Nutritional breakdown
        ExpansionTile(
          title: Text(
            "Thông tin dinh dưỡng",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                children: [
                  _buildNutritionRow("Calories", "${meal.calories} kcal"),
                  _buildNutritionRow("Protein", "${meal.macronutrients.protein}g"),
                  _buildNutritionRow("Carbohydrates", "${meal.macronutrients.carbs}g"),
                  _buildNutritionRow("Fats", "${meal.macronutrients.fats}g"),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  Widget _buildNutritionRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 14),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPill(String text) {
    return Container(
      margin: const EdgeInsets.only(top: 4, right: 8, bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(text, style: AppTextStyles.nutrition),
    );
  }
}