// api/coachService.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/coach_model.dart';

class CoachService {
  static const String _baseUrl = 'http://10.0.2.2:3000/api/PT/getAllTrainer';

  static Future<List<Coach>> fetchAllCoaches() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['success'] == true) {
          List<dynamic> coachesJson = jsonData['data'];
          return coachesJson.map((json) => Coach.fromJson(json)).toList();
        } else {
          throw Exception('API success == false');
        }
      } else {
        throw Exception('Failed to load coaches: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching coaches: $e');
    }
  }
}
