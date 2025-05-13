import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/meal_model.dart';

class MealService {
  static const String baseUrl = 'http://localhost:3000/api/chatbot';

  /// Fetches meal plans based on user preferences
  /// 
  /// [bmiStatus] - User's BMI status (e.g., "overweight", "normal", "underweight")
  /// [foodAllergy] - Foods the user is allergic to (comma-separated string)
  /// [foodFavour] - User's preferred foods (comma-separated string)
  /// 
  /// Returns a Map with days of the week as keys and DailyNutrition objects as values
  static Future<Map<String, DailyNutrition>> getMealPlan({
    required String bmiStatus,
    String? foodAllergy,
    String? foodFavour,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/meals'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'bmiStatus': bmiStatus,
          'foodAllergy': foodAllergy ?? '',
          'foodFavour': foodFavour ?? '',
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        
        if (responseData['success'] == true) {
          Map<String, DailyNutrition> weeklyPlan = {};
          
          // Parse each day's nutrition data
          responseData['data'].forEach((day, dayData) {
            weeklyPlan[day] = DailyNutrition.fromJson(dayData);
          });
          
          return weeklyPlan;
        } else {
          throw Exception(responseData['message'] ?? 'Failed to fetch meal plan');
        }
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching meal plan: ${e.toString()}');
    }
  }
  
  /// Fetches meal plans and caches them using a provider or local storage
  /// This can be expanded based on your state management approach
  static Future<Map<String, DailyNutrition>> fetchAndCacheMealPlan({
    required String bmiStatus,
    String? foodAllergy,
    String? foodFavour,
  }) async {
    // Get data from API
    final mealPlan = await getMealPlan(
      bmiStatus: bmiStatus, 
      foodAllergy: foodAllergy, 
      foodFavour: foodFavour
    );
    
    // Here you could add code to cache the meal plan data
    // For example, using SharedPreferences:
    // final prefs = await SharedPreferences.getInstance();
    // prefs.setString('cached_meal_plan', jsonEncode(responseData['data']));
    
    return mealPlan;
  }
  
  /// Retrieves cached meal plan if available
  /// Returns null if no cached data is found
  static Future<Map<String, DailyNutrition>?> getCachedMealPlan() async {
    // Implementation depends on your caching mechanism
    // For example, using SharedPreferences:
    
    // final prefs = await SharedPreferences.getInstance();
    // final cachedData = prefs.getString('cached_meal_plan');
    // if (cachedData != null) {
    //   final jsonData = jsonDecode(cachedData);
    //   Map<String, DailyNutrition> weeklyPlan = {};
    //   jsonData.forEach((day, dayData) {
    //     weeklyPlan[day] = DailyNutrition.fromJson(dayData);
    //   });
    //   return weeklyPlan;
    // }
    
    return null; // No cached data
  }
}