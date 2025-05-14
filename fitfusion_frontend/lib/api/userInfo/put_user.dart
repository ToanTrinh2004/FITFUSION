import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/user_info_model.dart';
import '../token_manager.dart';

class UpdateUserInfoService {
  static const String _baseUrl = 'http://10.0.2.2:3000/api/user/userinfo/update';

  /// Update user info and send it to the backend API.
  static Future<bool> updateUserInfo(UserInfoModel userInfo) async {
    try {
      final token = TokenManager().token;

      if (token == null) {
        debugPrint("[DEBUG] ❌ Token missing. User is not authenticated.");
        return false;
      }

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final body = jsonEncode(userInfo.toJson());

      debugPrint("[DEBUG] Sending PUT request to: $_baseUrl");
      debugPrint("[DEBUG] Headers: $headers");
      debugPrint("[DEBUG] Body: $body");

      final response = await http.put(
        Uri.parse(_baseUrl),
        headers: headers,
        body: body,
      );

      debugPrint("[DEBUG] Response status: ${response.statusCode}");
      debugPrint("[DEBUG] Response body: ${response.body}");

      return response.statusCode == 200;
    } catch (e) {
      debugPrint("[DEBUG] ❌ Error updating user info: $e");
      return false;
    }
  }
}
