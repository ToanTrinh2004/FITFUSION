import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService {
  // Use a variable for easy changing between emulator/physical device
  static const String baseUrl = 'http://192.168.0.101:3000/api/user'; 
  
  // For storing user token
  static String? authToken;

  /// Utility to show a notification
  static void showNotification(BuildContext context, String message, {Color color = Colors.red}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  /// Register user
  static Future<bool> registerUser(
    BuildContext context, 
    String username, 
    String password,
  ) async {
    final url = Uri.parse('$baseUrl/registration');
    try {
      // Debug the request before sending
      debugPrint('Sending registration request to: $url');
      debugPrint('Request body: ${jsonEncode({
        'username': username, 
        'password': password,
      })}');
      
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username, 
          'password': password,
        }),
      );

      debugPrint('Register response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        showNotification(context, "Đăng ký thành công!", color: Colors.green);
        
        // Store token if returned by the API
        final responseData = jsonDecode(response.body);
        if (responseData['token'] != null) {
          authToken = responseData['token'];
        }
        
        return true;
      } else if (response.statusCode == 409) {
        showNotification(context, "Tên đăng nhập đã tồn tại!");
      } else {
        showNotification(context, "Đăng ký thất bại: ${response.reasonPhrase}");
      }
    } catch (e) {
      debugPrint("Register error: $e");
      showNotification(
        context, 
        "Lỗi kết nối: Kiểm tra URL API hoặc kết nối mạng"
      );
    }
    return false;
  }

  /// Login user
  static Future<bool> loginUser(BuildContext context, String username, String password) async {
    final url = Uri.parse('$baseUrl/login');
    try {
      debugPrint('Sending login request to: $url');
      
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      debugPrint('Login response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['token'] != null) {
          authToken = responseData['token'];
        }
        
        showNotification(context, "Đăng nhập thành công!", color: Colors.green);
        return true;
      } else if (response.statusCode == 401) {
        showNotification(context, "Sai tên đăng nhập hoặc mật khẩu.");
      } else {
        showNotification(context, "Đăng nhập thất bại: ${response.reasonPhrase}");
      }
    } catch (e) {
      debugPrint("Login error: $e");
      showNotification(
        context, 
        "Lỗi kết nối: Kiểm tra URL API hoặc kết nối mạng"
      );
    }
    return false;
  }
}