class Meal {
  final String dishName;
  final List<String> ingredients;
  final String instructions;
  final int calories;
  final Macronutrients macronutrients;
  final String note;

  Meal({
    required this.dishName,
    required this.ingredients,
    required this.instructions,
    required this.calories,
    required this.macronutrients,
    required this.note,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      dishName: json['dishName'],
      ingredients: List<String>.from(json['ingredients']),
      instructions: json['instructions'],
      calories: json['calories'],
      macronutrients: Macronutrients.fromJson(json['macronutrients']),
      note: json['note'],
    );
  }
}

class Macronutrients {
  final int protein;
  final int carbs;
  final int fats;

  Macronutrients({
    required this.protein,
    required this.carbs,
    required this.fats,
  });

  factory Macronutrients.fromJson(Map<String, dynamic> json) {
    return Macronutrients(
      protein: json['protein'],
      carbs: json['carbs'],
      fats: json['fats'],
    );
  }
}

class DailyNutrition {
  final Meal breakfast;
  final Meal lunch;
  final Meal dinner;
  final Macronutrients nutritionSummary;
  final int totalCalories;

  DailyNutrition({
    required this.breakfast,
    required this.lunch,
    required this.dinner,
    required this.nutritionSummary,
    required this.totalCalories,
  });

  factory DailyNutrition.fromJson(Map<String, dynamic> json) {
    return DailyNutrition(
      breakfast: Meal.fromJson(json['breakfast']),
      lunch: Meal.fromJson(json['lunch']),
      dinner: Meal.fromJson(json['dinner']),
      nutritionSummary: Macronutrients.fromJson(json['nutrition']),
      totalCalories: json['nutrition']['calories'],
    );
  }
}
