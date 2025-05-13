import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../token_manager.dart';

class AuthService {
  static const String baseUrl = 'http://10.0.2.2:3000/api/user';
  static String? authToken;

  static void showNotification(BuildContext context, String message, {Color color = Colors.red}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  /// Register user with role
  static Future<bool> registerUser(
    BuildContext context,
    String username,
    String password,
    int role, // 🔁 Added role here
  ) async {
    final url = Uri.parse('$baseUrl/registration');
    try {
      debugPrint('Sending registration request to: $url');
      debugPrint('Request body: ${jsonEncode({
        'username': username,
        'password': password,
        'role': role,
      })}');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
          'role': role,
        }),
      );

      debugPrint('Register response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        showNotification(context, "Đăng ký thành công!", color: Colors.green);

        final responseData = jsonDecode(response.body);
        if (responseData['token'] != null) {
          TokenManager().setToken(responseData['token']);
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
        "Lỗi kết nối: Kiểm tra URL API hoặc kết nối mạng",
      );
    }
    return false;
  }

  /// Login user with role
  static Future<bool> loginUser(
    BuildContext context,
    String username,
    String password,
    int role, // 🔁 Added role here too
  ) async {
    final url = Uri.parse('$baseUrl/login');
    try {
      debugPrint('Sending login request to: $url');
      debugPrint('Request body: ${jsonEncode({
        'username': username,
        'password': password,
        'role': role,
      })}');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
          'role': role,
        }),
      );

      debugPrint('Login response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['token'] != null) {
          TokenManager().setToken(responseData['token']);
        }

        showNotification(context, "Đăng nhập thành công!", color: Colors.green);
        return true;
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        showNotification(context, "Sai tên đăng nhập, mật khẩu hoặc vai trò.");
      } else {
        showNotification(context, "Đăng nhập thất bại: ${response.reasonPhrase}");
      }
    } catch (e) {
      debugPrint("Login error: $e");
      showNotification(
        context,
        "Lỗi kết nối: Kiểm tra URL API hoặc kết nối mạng",
      );
    }
    return false;
  }
}
