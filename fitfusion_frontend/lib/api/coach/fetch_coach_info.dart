import 'dart:convert';
import 'package:fitfusion_frontend/api/token_manager.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../auth/auth_service.dart'; // Make sure this path is correct

class FetchCoachInfo {
  static const String baseUrl = 'http://10.0.2.2:3000/api/PT';
  
  /// Fetch user info (from /userinfo)
 static Future<Map<String, dynamic>?> getCoachInfo(BuildContext context) async {
  final url = Uri.parse('$baseUrl/getById');

  try {
    final token = TokenManager().token;
    // DEBUG: Print token
    debugPrint('DEBUG: Auth Token = $token');

    if (token == null) {
      throw Exception("Token not found. Please login first.");
    }

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    // DEBUG: Print full response
    debugPrint('DEBUG:CoachInfo Response Code = ${response.statusCode}');
    debugPrint('DEBUG:CoachInfo Response Body = ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // DEBUG: Print parsed data
      debugPrint('DEBUG: Parsed User Info = ${data['data']}');

      return data['data'];
    } else {
      AuthService.showNotification(context, "Không lấy được thông tin người dùng.");
    }
  } catch (e) {
    debugPrint("getUserInfo error: $e");
    AuthService.showNotification(context, "Lỗi khi tải thông tin người dùng.");
  }

  return null;
}


  /// Fetch user account (from /user)
  static Future<Map<String, dynamic>?> getCoachAccount(BuildContext context) async {
    final url = Uri.parse('$baseUrl');

    try {
      final token = AuthService.authToken;
      
      if (token == null) {
        throw Exception("Token not found. Please login first.");
      }

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      debugPrint('UserAccount Response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data'];
      } else {
        AuthService.showNotification(context, "Không lấy được tài khoản người dùng.");
      }
    } catch (e) {
      debugPrint("getUserAccount error: $e");
      AuthService.showNotification(context, "Lỗi khi tải thông tin tài khoản.");
    }
    return null;
  }
}
