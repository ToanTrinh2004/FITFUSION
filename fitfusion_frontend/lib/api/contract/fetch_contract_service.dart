import 'dart:convert';
import 'package:fitfusion_frontend/api/token_manager.dart';
import 'package:fitfusion_frontend/models/contract_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FetchContractService {
  static const String baseUrl = 'http://10.0.2.2:3000/api/contract/coach';
  static const String userBaseUrl = 'http://10.0.2.2:3000/api/contract/user';

  static Future<List<ContractModel>> fetchContractsByCoachId(String coachId) async {
    final String url = '$baseUrl/$coachId';

    try {
      debugPrint("[DEBUG] Sending GET request to: $url");

      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      debugPrint("[DEBUG] Response status: ${response.statusCode}");
      debugPrint("[DEBUG] Response body: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        
        // Access the 'contracts' array from the response
        final List<dynamic> contractsList = data['contracts'];

        return contractsList.map((item) => ContractModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to fetch contracts: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint("[DEBUG] ❌ Error fetching contracts: $e");
      rethrow;
    }
  }

  static Future<List<ContractModel>> fetchContractsByUserId() async {
    final String url = '$userBaseUrl';
    final  token = TokenManager().token;
    try {
      debugPrint("[DEBUG] Sending GET request to: $url");

      final response = await http.get(
        Uri.parse(url),
       headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token',}
      );

      debugPrint("[DEBUG] Response status: ${response.statusCode}");
      debugPrint("[DEBUG] Response body: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        
        // Access the 'contracts' array from the response
        final List<dynamic> contractsList = data['contracts'];

        return contractsList.map((item) => ContractModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to fetch contracts: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint("[DEBUG] ❌ Error fetching contracts: $e");
      rethrow;
    }
  }
}