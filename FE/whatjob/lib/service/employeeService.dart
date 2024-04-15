import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:whatjob/baseULR.dart';
import 'package:whatjob/model/employee.dart';

class EmployeeService {
  static Future<http.Response> getInfo(String? token) async {
    try {
      var response;
      if(BaseURL.serve == 'php') {
        response = await http.get(
          Uri.parse('${BaseURL.baseURL}/api/employees/me'),
          headers: <String, String>{
            'Authorization': 'Bearer $token',
          },
        );
      } else{
        response = await http.get(
          Uri.parse('${BaseURL.baseURL}/api/employee/me'),
          headers: <String, String>{
            'Authorization': 'Bearer $token',
          },
        );
      }

      print(response.body);
      return response;
    } catch (e) {
      print('Failed to get employee. Error: $e');
      throw e;
    }
  }

  static Future<http.Response> edit(
      String token, Map<String, dynamic> data) async {
    try {

      var response;
      if(BaseURL.serve == 'php') {
        response = await http.put(
          Uri.parse('${BaseURL.baseURL}/api/employees/edit'),
          headers: <String, String>{
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(data),
        );
      } else{
         response = await http.put(
          Uri.parse('${BaseURL.baseURL}/api/employee/edit'),
          headers: <String, String>{
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(data),
        );
      }
      print(response.body);
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
  static Future<http.Response> cvEdit (String token, String cv) async {
    try {var response;

      if(BaseURL.serve == 'php') {
        response = await http.put(
          Uri.parse('${BaseURL.baseURL}/api/employees/edit'),
          headers: <String, String>{
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({'cv': cv}),
        );
      } else{
        response = await http.put(
          Uri.parse('${BaseURL.baseURL}/api/employee/update-cv'),
          headers: <String, String>{
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({'newCV': cv}),
        );
      }
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
