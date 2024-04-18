import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:whatjob/baseULR.dart';

class EmployerService {
  static Future<http.Response> getInfo(String? token) async {
    try {
      var response;
      if(BaseURL.serve == 'php') {
         response = await http.get(
          Uri.parse('${BaseURL.baseURL}/api/employers/me'),
          headers: <String, String>{
            'Authorization': 'Bearer $token',
          },
        );
      } else{
         response = await http.get(
          Uri.parse('${BaseURL.baseURL}/api/employer/me'),
          headers: <String, String>{
            'Authorization': 'Bearer $token',
          },
        );
      }
      print(response.body);
      return response;
    } catch (e) {
      print('Failed to get employer. Error: $e');
      throw e;
    }
  }

  static Future<http.Response> updateInfo(
      String? token, Map<String, dynamic> data) async {
    try {
      var response;
      if(BaseURL.serve == 'php'){
        response = await http.put(
            Uri.parse('${BaseURL.baseURL}/api/employers/edit'),
            headers: <String, String>{
              'Authorization': 'Bearer ${token}',
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(data)
        );
      }
      else{
        response = await http.put(
            Uri.parse('${BaseURL.baseURL}/api/employer/edit'),
            headers: <String, String>{
              'Authorization': 'Bearer ${token}',
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(data)
        );
      }
print(response.body);
      return response;
    } catch (e) {
      print('Failed to update employer. Error: $e');
      throw e;
    }
  }
}
