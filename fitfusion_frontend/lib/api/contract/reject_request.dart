import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RejectRequestService {
  static const String _baseUrl = 'http://10.0.2.2:3000/api/contract/request';

  /// Deletes a request by its ID.
  static Future<bool> rejectRequest(String requestId) async {
    final String url = '$_baseUrl/$requestId';

    try {
      debugPrint("[DEBUG] Sending DELETE request to: $url");

      final response = await http.delete(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      debugPrint("[DEBUG] Response status: ${response.statusCode}");
      debugPrint("[DEBUG] Response body: ${response.body}");

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to reject request: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint("[DEBUG] ❌ Error rejecting request: $e");
      return false;
    }
  }
}