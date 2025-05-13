import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatbotService {
  static const String baseUrl = 'http://10.0.2.2:3000/api/chatbot';

  /// Calculate calories from food input
  /// 
  /// [foodString] should be formatted like "rice 100 gram, pork 250 gram"
  /// Returns a Map with nutrition data or throws an exception
  static Future<Map<String, dynamic>> calculateCalories(String foodString) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/caloriesCalculate'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'food': foodString}),
      );

      final responseData = jsonDecode(response.body);
      
      if (response.statusCode == 200 && responseData['success'] == true) {
        return responseData['data'];
      } else {
        throw Exception(responseData['message'] ?? 'Failed to calculate calories');
      }
    } catch (e) {
      rethrow; // Rethrow to let the UI handle it
    }
  }
}