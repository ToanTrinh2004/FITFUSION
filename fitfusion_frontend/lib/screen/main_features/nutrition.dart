import 'package:fitfusion_frontend/widgets/tabbar.dart';
import 'package:flutter/material.dart';
import 'package:fitfusion_frontend/theme/theme.dart';
import 'package:fitfusion_frontend/models/meal_model.dart';
import 'package:fitfusion_frontend/api/chatbot/mealsService.dart'; // Import the new service

class NutritionScreen extends StatefulWidget {
  const NutritionScreen({super.key});

  @override
  State<NutritionScreen> createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  int selectedDayIndex = DateTime.now().weekday - 1; // Default to current day
  List<DailyNutrition> mealPlanData = [];
  late DailyNutrition dailyNutrition;
  bool isLoading = true;
  bool hasError = false;
  String errorMessage = '';

  // User preferences - these could come from user profile
  final String bmiStatus = "normal"; // Replace with actual user data
  final String? foodAllergy = null; // Replace with actual user data
  final String? foodFavour = null; // Replace with actual user data

  @override
  void initState() {
    super.initState();
    _loadNutritionData();
  }

  Future<void> _loadNutritionData() async {
    setState(() {
      isLoading = true;
      hasError = false;
    });

    try {
      // First try to get cached meal plan
      var cachedPlan = await MealService.getCachedMealPlan();
      
      if (cachedPlan != null) {
        // Convert the cached Map to our List structure
        final List<DailyNutrition> loadedPlan = [];
        cachedPlan.forEach((day, nutrition) {
          loadedPlan.add(nutrition);
        });
        mealPlanData = loadedPlan;
      } else {
        // Otherwise fetch from API
        final apiMealPlan = await MealService.fetchAndCacheMealPlan(
          bmiStatus: bmiStatus,
          foodAllergy: foodAllergy,
          foodFavour: foodFavour,
        );
        
        // Convert Map to List for our existing UI structure
        final List<DailyNutrition> loadedPlan = [];
        apiMealPlan.forEach((day, nutrition) {
          loadedPlan.add(nutrition);
        });
        mealPlanData = loadedPlan;
      }

      // Ensure we have 7 days of data, fill with empty data if necessary
      while (mealPlanData.length < 7) {
        //mealPlanData.add(DailyNutrition.empty());
      }
      
      // Limit to exactly 7 days if more data was returned
      if (mealPlanData.length > 7) {
        mealPlanData = mealPlanData.sublist(0, 7);
      }

      // Set the daily nutrition based on selected day
      dailyNutrition = mealPlanData[selectedDayIndex];

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        hasError = true;
        errorMessage = e.toString();
      });
    }
  }

  void _selectDay(int index) {
    setState(() {
      selectedDayIndex = index;
      dailyNutrition = mealPlanData[selectedDayIndex];
    });
  }

  Future<void> _refreshMealPlan() async {
    // Force refresh from API by skipping cache
    setState(() {
      isLoading = true;
      hasError = false;
    });

    try {
      final apiMealPlan = await MealService.getMealPlan(
        bmiStatus: bmiStatus,
        foodAllergy: foodAllergy,
        foodFavour: foodFavour,
      );

      // Convert Map to List for our existing UI structure
      final List<DailyNutrition> loadedPlan = [];
      apiMealPlan.forEach((day, nutrition) {
        loadedPlan.add(nutrition);
      });
      
      mealPlanData = loadedPlan;
      
      // Ensure we have 7 days of data
      while (mealPlanData.length < 7) {
        //mealPlanData.add(DailyNutrition.empty());
      }
      
      // Limit to exactly 7 days
      if (mealPlanData.length > 7) {
        mealPlanData = mealPlanData.sublist(0, 7);
      }

      dailyNutrition = mealPlanData[selectedDayIndex];

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        hasError = true;
        errorMessage = e.toString();
      });
    }
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
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.white))
              : hasError
                  ? _buildErrorView()
                  : RefreshIndicator(
                      onRefresh: _refreshMealPlan,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildAppBar(context),
                          _buildWeekSelector(screenWidth, isSmallScreen),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            child: Text(
                              "Kế hoạch ăn uống",
                              style: AppTextStyles.little_title,
                            ),
                          ),
                          _buildOverview(screenWidth, isSmallScreen),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  _buildMealSection(
                                    title: "Bữa sáng",
                                    meal: dailyNutrition.breakfast,
                                    screenWidth: screenWidth,
                                    isSmallScreen: isSmallScreen,
                                  ),
                                  _buildMealSection(
                                    title: "Bữa trưa",
                                    meal: dailyNutrition.lunch,
                                    screenWidth: screenWidth,
                                    isSmallScreen: isSmallScreen,
                                  ),
                                  _buildMealSection(
                                    title: "Bữa tối",
                                    meal: dailyNutrition.dinner,
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

  Widget _buildErrorView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.white, size: 48),
            const SizedBox(height: 16),
            Text(
              "Không thể tải dữ liệu",
              style: AppTextStyles.little_title,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              errorMessage,
              style: const TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _loadNutritionData,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.primary,
              ),
              child: const Text("Thử lại"),
            ),
          ],
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
        Row(
          children: [
            Expanded(
              child: _buildButton(
                  "Đổi thực đơn với AI", screenWidth, isSmallScreen, () {
                // Add action for changing meal with AI
              }),
            ),
            SizedBox(width: 8),
            Expanded(
              child: _buildButton(
                  "Chỉnh sửa thực đơn", screenWidth, isSmallScreen, () {
                // Add action for editing meal plan
              }),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildButton(String text, double screenWidth, bool isSmallScreen, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
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