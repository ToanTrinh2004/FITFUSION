import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/user_info_model.dart';
import '../token_manager.dart';

class UserInfoService {
  static const String _baseUrl = 'http://10.0.2.2:3000/api/user/userinfo/create';

  /// Create user info and send it to the backend API.
  static Future<bool> createUserInfo(UserInfoModel userInfo) async {
    try {
      // Retrieve the token from TokenManager
      final token = TokenManager().token;

      // Check if the token is available
      if (token == null) {
        debugPrint("[DEBUG] ❌ Token missing. User is not authenticated.");
        return false;
      }

      // Prepare headers and body for the request
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final body = jsonEncode(userInfo.toJson());

      // Print the request details for debugging
      debugPrint("[DEBUG] Sending POST request to: $_baseUrl");
      debugPrint("[DEBUG] Headers: $headers");
      debugPrint("[DEBUG] Body: $body");

      // Make the POST request to the backend
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: headers,
        body: body,
      );

      // Log the response status and body
      debugPrint("[DEBUG] Response status: ${response.statusCode}");
      debugPrint("[DEBUG] Response body: ${response.body}");

      // If the response status is 200, return true indicating success
      return response.statusCode == 200 || response.statusCode == 201;

    } catch (e) {
      // Log any errors that occur during the request
      debugPrint("[DEBUG] ❌ Error creating user info: $e");
      return false;
    }
  }
}
