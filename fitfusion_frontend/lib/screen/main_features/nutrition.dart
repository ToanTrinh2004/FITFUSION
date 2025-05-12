import 'package:fitfusion_frontend/widgets/tabbar.dart';
import 'package:flutter/material.dart';
import 'package:fitfusion_frontend/theme/theme.dart';
import 'package:fitfusion_frontend/models/meal_model.dart';
import 'package:fitfusion_frontend/models/meal1_model.dart';

class NutritionScreen extends StatefulWidget {
  const NutritionScreen({super.key});

  @override
  State<NutritionScreen> createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  int selectedDayIndex = 1; // Default to second day (index 1)
  late DailyNutrition dailyNutrition;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNutritionData();
  }

  Future<void> _loadNutritionData() async {
    await Future.delayed(const Duration(milliseconds: 300));
    setState(() {
      dailyNutrition = mockNutritionData[selectedDayIndex];
      isLoading = false;
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
              ? const Center(child: CircularProgressIndicator(color: Colors.white))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAppBar(),
                    _buildWeekSelector(screenWidth),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, right: 16.0, left: 16.0),
                      child: Text("Kế hoạch ăn uống", style: AppTextStyles.little_title),
                    ),
                    _buildOverview(screenWidth),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: _buildMealSections(screenWidth),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  // App bar with back button and menu
  Widget _buildAppBar() {
    return Column(
      children: [
        const AppBarCustom(),
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
      ],
    );
  }

  // Week day selector
  Widget _buildWeekSelector(double screenWidth) {
    List<String> weekDays = ["S", "M", "T", "W", "T", "F", "S"];
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));

    return Container(
      width: screenWidth,
      padding: const EdgeInsets.symmetric(vertical: 4), // Reduced from 8 to 4
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

            return _buildDayButton(index, weekDays[index], day.day.toString(), isSelected, screenWidth);
          }),
        ),
      ),
    );
  }

  Widget _buildDayButton(int index, String weekDay, String dayNumber, bool isSelected, double screenWidth) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDayIndex = index;
          dailyNutrition = mockNutritionData[selectedDayIndex];
        });
      },
      child: Container(
        width: screenWidth * 0.13,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        child: Column(
          children: [
            Text(weekDay, style: AppTextStyles.text),
            CircleAvatar(
              radius: 16, 
              backgroundColor: isSelected ? AppColors.textPrimary : AppColors.primaryHalf,
              child: Text(
                dayNumber,
                style: TextStyle(
                  color: isSelected ? AppColors.primary : AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Nutrition overview section
  Widget _buildOverview(double screenWidth) {
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
            children: _buildNutritionInfoBoxes(screenWidth),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildNutritionInfoBoxes(double screenWidth) {
    final List<Map<String, dynamic>> nutrientData = [
      {"value": "${dailyNutrition.totalCalories}", "label": "calo", "color": Colors.red, "icon": Icons.local_fire_department},
      {"value": "${dailyNutrition.nutritionSummary.protein}g", "label": "protein", "color": Colors.blue, "icon": Icons.fitness_center},
      {"value": "${dailyNutrition.nutritionSummary.fats}g", "label": "chất béo", "color": Colors.orange, "icon": Icons.opacity},
      {"value": "${dailyNutrition.nutritionSummary.carbs}g", "label": "carbs", "color": Colors.green, "icon": Icons.grain},
    ];

    List<Widget> boxes = [];
    for (int i = 0; i < nutrientData.length; i++) {
      if (i > 0) boxes.add(SizedBox(width: screenWidth * 0.03));
      boxes.add(_buildInfoBox(
        nutrientData[i]["value"],
        nutrientData[i]["label"],
        nutrientData[i]["color"],
        nutrientData[i]["icon"],
      ));
    }
    
    return boxes;
  }

  Widget _buildInfoBox(String value, String label, Color color, IconData icon) {
    return Row(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: color.withOpacity(0.2),
          child: Icon(
            icon,
            color: color,
            size: 18,
          ),
        ),
        const SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(label, style: AppTextStyles.nutrition),
          ],
        ),
      ],
    );
  }

  // Build all meal sections
  List<Widget> _buildMealSections(double screenWidth) {
    final List<Map<String, dynamic>> meals = [
      {"title": "Bữa sáng", "meal": dailyNutrition.breakfast},
      {"title": "Bữa trưa", "meal": dailyNutrition.lunch},
      {"title": "Bữa tối", "meal": dailyNutrition.dinner},
    ];

    return meals.map((mealData) => _buildMealSection(
      title: mealData["title"],
      meal: mealData["meal"],
      screenWidth: screenWidth,
    )).toList();
  }

  // Meal section
  Widget _buildMealSection({
    required String title,
    required Meal meal,
    required double screenWidth,
  }) {
    bool hasMealData = meal.dishName.isNotEmpty;
    final isSmallScreen = screenWidth < 360;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.little_title),
          _buildMealNutritionPills(meal),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(screenWidth * 0.03),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: hasMealData
                ? _buildMealContent(meal, screenWidth, isSmallScreen)
                : const SizedBox(
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

  // Nutrition pills for each meal
  Widget _buildMealNutritionPills(Meal meal) {
    final List<String> pillData = [
      "${meal.calories} calo",
      "${meal.macronutrients.protein}g protein",
      "${meal.macronutrients.fats}g chất béo",
      "${meal.macronutrients.carbs}g carbs",
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: pillData.map((text) => _buildPill(text)).toList(),
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

  // Meal content with details
  Widget _buildMealContent(Meal meal, double screenWidth, bool isSmallScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(meal.dishName, style: AppTextStyles.subtitle),
        const SizedBox(height: 8),

        // Ingredients
        if (meal.ingredients.isNotEmpty) _buildIngredientsList(meal.ingredients),

        const SizedBox(height: 10),

        // Preparation method
        if (meal.instructions.isNotEmpty) _buildInstructions(meal.instructions),

        const SizedBox(height: 10),

        // Health benefits
        if (meal.note.isNotEmpty) _buildHealthBenefits(meal.note),

        const SizedBox(height: 12),

        // Action buttons
        _buildActionButtons(screenWidth, isSmallScreen),
      ],
    );
  }

  Widget _buildIngredientsList(List<String> ingredients) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: ingredients
          .map((ingredient) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text("• $ingredient", style: AppTextStyles.normal_nutri),
              ))
          .toList(),
    );
  }

  Widget _buildInstructions(String instructions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Cách chuẩn bị", style: AppTextStyles.little_title_1),
        const SizedBox(height: 4),
        Text(instructions, style: const TextStyle(fontSize: 14)),
      ],
    );
  }

  Widget _buildHealthBenefits(String note) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Lợi ích sức khỏe", style: AppTextStyles.little_title_1),
        const SizedBox(height: 4),
        Text(note, style: AppTextStyles.normal_nutri),
      ],
    );
  }

  Widget _buildActionButtons(double screenWidth, bool isSmallScreen) {
    return Row(
      children: [
        Expanded(
          child: _buildButton("Đổi thực đơn với AI", screenWidth, isSmallScreen),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildButton("Chỉnh sửa thực đơn", screenWidth, isSmallScreen),
        ),
      ],
    );
  }

  Widget _buildButton(String text, double screenWidth, bool isSmallScreen) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textPrimary,
        minimumSize: Size(
          screenWidth * 0.4,
          isSmallScreen ? 36 : 40,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 0,
      ),
      child: Text(
        text,
        style: AppTextStyles.nutrition_but,
        textAlign: TextAlign.center,
      ),
    );
  }
}