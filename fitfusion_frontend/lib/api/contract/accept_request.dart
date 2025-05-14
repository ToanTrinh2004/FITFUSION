import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AcceptRequestService {
  static const String _baseUrl = 'http://10.0.2.2:3000/api/contract/accept';

  /// Accepts a request by its ID.
  static Future<bool> acceptRequest(String requestId) async {
    final String url = '$_baseUrl/$requestId';

    try {
      debugPrint("[DEBUG] Sending POST request to: $url");

      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      debugPrint("[DEBUG] Response status: ${response.statusCode}");
      debugPrint("[DEBUG] Response body: ${response.body}");

      if (response.statusCode == 201) {
        return true;
      } else {
        throw Exception('Failed to accept request: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint("[DEBUG] ❌ Error accepting request: $e");
      return false;
    }
  }
}