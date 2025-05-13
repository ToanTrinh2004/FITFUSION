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
       // mealPlanData.add(DailyNutrition.empty());
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
    final screenHeight = MediaQuery.of(context).size.height;
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
  Widget _buildWeekSelector(double screenWidth, bool isSmallScreen) {
    List<String> weekDays = ["S", "M", "T", "W", "T", "F", "S"];
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
                  Colors.red, isSmallScreen, 'assets/icons/flame.png'),
              SizedBox(width: screenWidth * 0.03),
              _buildInfoBox(
                  "${dailyNutrition.nutritionSummary.protein}g",
                  "protein",
                  Colors.blue,
                  isSmallScreen,
                  'assets/icons/protein.png'),
              SizedBox(width: screenWidth * 0.03),
              _buildInfoBox(
                  "${dailyNutrition.nutritionSummary.fats}g",
                  "chất béo",
                  Colors.orange,
                  isSmallScreen,
                  'assets/icons/fat.png'),
              SizedBox(width: screenWidth * 0.03),
              _buildInfoBox(
                  "${dailyNutrition.nutritionSummary.carbs}g",
                  "carbs",
                  Colors.green,
                  isSmallScreen,
                  'assets/icons/carbs.png'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoBox(String value, String label, Color color,
      bool isSmallScreen, String iconPath) {
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
      padding:
          EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: 8),
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
                ? _buildMealContent(meal, screenWidth, isSmallScreen)
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
        Text("${meal.dishName}", style: AppTextStyles.subtitle),
        const SizedBox(height: 8),

        // Ingredients
        if (meal.ingredients.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: meal.ingredients
                .map((ingredient) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text("• $ingredient",
                          style: AppTextStyles.normal_nutri),
                    ))
                .toList(),
          ),

        const SizedBox(height: 10),

        // Preparation method
        if (meal.instructions.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Cách chuẩn bị", style: AppTextStyles.little_title_1),
              const SizedBox(height: 4),
              Text(meal.instructions, style: TextStyle(fontSize: 14)),
            ],
          ),

        const SizedBox(height: 10),

        // Health benefits
        if (meal.note.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Lợi ích sức khỏe", style: AppTextStyles.little_title_1),
              const SizedBox(height: 4),
              Text(meal.note, style: AppTextStyles.normal_nutri),
            ],
          ),

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

// Extension to provide an empty DailyNutrition object
extension DailyNutritionExtension on DailyNutrition {
  static DailyNutrition empty() {
    return DailyNutrition(
      breakfast: Meal(
        dishName: '',
        calories: 0,
        ingredients: [],
        instructions: '',
        note: '',
        macronutrients: Macronutrients(protein: 0, fats: 0, carbs: 0),
      ),
      lunch: Meal(
        dishName: '',
        calories: 0,
        ingredients: [],
        instructions: '',
        note: '',
        macronutrients: Macronutrients(protein: 0, fats: 0, carbs: 0),
      ),
      dinner: Meal(
        dishName: '',
        calories: 0,
        ingredients: [],
        instructions: '',
        note: '',
        macronutrients: Macronutrients(protein: 0, fats: 0, carbs: 0),
      ),
      totalCalories: 0,
      nutritionSummary: Macronutrients(protein: 0, fats: 0, carbs: 0),
    );
  }
}