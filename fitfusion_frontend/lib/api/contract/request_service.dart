import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RequestService {
  static const String _baseUrl = 'http://10.0.2.2:3000/api/contract/request';
  // Use 'http://localhost:3000/api/contract/request' for web testing

  /// Creates a request to hire a coach and sends it to the backend API.
  static Future<Map<String, dynamic>> createRequest({
    required String customerId,
    required String coachId,
    required String duration,
    required List<Map<String, String>> schedule,
    required double fee,
  }) async {
    try {
      // Prepare the request body
      final requestBody = {
        'customerId': customerId,
        'coachId': coachId,
        'duration': duration,
        'schedule': schedule,
        'fee': fee,
      };

      // Print the request details for debugging
      debugPrint("[DEBUG] Sending POST request to: $_baseUrl");
      debugPrint("[DEBUG] Body: ${jsonEncode(requestBody)}");

      // Make the POST request to the backend
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      // Log the response status and body
      debugPrint("[DEBUG] Response status: ${response.statusCode}");
      debugPrint("[DEBUG] Response body: ${response.body}");

      // Parse the response body as JSON
      final Map<String, dynamic> responseData = json.decode(response.body);
      
      // Add status code to the response data for easier handling
      responseData['statusCode'] = response.statusCode;
      
      return responseData;
    } catch (e) {
      // Log any errors that occur during the request
      debugPrint("[DEBUG] ❌ Error creating request: $e");
      return {
        'success': false,
        'error': e.toString(),
        'statusCode': 500,
      };
    }
  }
}