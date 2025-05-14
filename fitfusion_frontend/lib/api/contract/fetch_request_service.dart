import 'dart:convert';
import 'package:fitfusion_frontend/models/training_request_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class FetchRequest {
  static const String _baseUrl = 'http://10.0.2.2:3000/api/contract/requests/coach';

  /// Fetches training requests for a specific coach by their coachId.
  static Future<List<TrainingRequest>> fetchRequestsByCoachId(String coachId) async {
    final String url = '$_baseUrl/$coachId';

    try {
      debugPrint("[DEBUG] Sending GET request to: $url");

      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      debugPrint("[DEBUG] Response status: ${response.statusCode}");
      debugPrint("[DEBUG] Response body: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        // Check if the response contains the 'requests' field
        if (responseData['requests'] is List<dynamic>) {
          return (responseData['requests'] as List<dynamic>)
              .map((data) => TrainingRequest.fromJson(data))
              .toList();
        } else {
          throw Exception("Invalid response format: 'requests' field is missing or not a list.");
        }
      } else {
        throw Exception('Failed to load requests: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint("[DEBUG] ❌ Error fetching requests by coachId: $e");
      rethrow;
    }
  }
}