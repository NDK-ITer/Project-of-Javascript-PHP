import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:whatjob/baseULR.dart';
import 'package:whatjob/model/employee.dart';

class EmployeeService {
  static Future<http.Response> getInfo(String? token) async {
    try {
      final response = await http.get(
        Uri.parse('${BaseURL.baseURL}/api/employee/me'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );
      return response;
    } catch (e) {
      print('Failed to get employee. Error: $e');
      throw e;
    }
  }

  static Future<http.Response> edit(
      String token, Map<String, dynamic> data) async {
    try {
      final response = await http.put(
        Uri.parse('${BaseURL.baseURL}/api/employee/edit'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        print('Employee edited successfully');
        print('Response: ${response.body}');
      } else {
        print('Failed to edit employee. Error: ${response.reasonPhrase}');
      }
      return response; // Return the response
    } catch (e) {
      print('Failed to edit employee. Error: $e');
      throw e;
    }
  }
}
