import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:whatjob/baseULR.dart';

class FieldService {
  static Future<List<dynamic>> fetchFields({String? token = ''}) async {
    try {
      var response;
      if(BaseURL.serve == 'php'){
        response = await http.get(Uri.parse('${BaseURL.baseURL}/api/fields'),headers: <String, String>{
          'Authorization': 'Bearer $token',
        },);
      }
      else{
        response = await http.get(Uri.parse('${BaseURL.baseURL}/api/field'));
      }
      print(response.body);
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
