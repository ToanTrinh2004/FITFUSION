import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/meal_model.dart';

class MealService {
  static const String baseUrl = 'http://10.0.2.2:3000/api/chatbot';

  static Future<WeeklyNutrition> getMealPlan({
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

      print('📤 Request sent: $bmiStatus, allergy: $foodAllergy, favour: $foodFavour');
      print('📥 Response status: ${response.statusCode}');
      print('📥 Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['success'] == true) {
          print('✅ Meal plan fetch successful.');
          return WeeklyNutrition.fromJson(responseData);
        } else {
          throw Exception(responseData['message'] ?? 'Failed to fetch meal plan');
        }
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Error fetching meal plan: $e');
      throw Exception('Error fetching meal plan: ${e.toString()}');
    }
  }
}
