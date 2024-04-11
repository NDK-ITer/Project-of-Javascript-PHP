import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:whatjob/baseULR.dart';

class FieldService {
  static Future<List<dynamic>> fetchFields() async {
    try {
      final response = await http.get(Uri.parse('${BaseURL.baseURL}/api/field'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body)['data']['fields'];
        return jsonData;
      } else {
        throw Exception('Failed to load fields');
      }
    } catch (error) {
      print('Error: $error');
      return [];
    }
  }
}
