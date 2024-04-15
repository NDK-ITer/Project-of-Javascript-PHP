import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:whatjob/baseULR.dart';
import 'package:whatjob/model/post.dart';
import 'package:whatjob/model/raDetail.dart';
import 'package:whatjob/model/role.dart';

class RAService {
  static Future<http.Response> newPost(
      Map<String, dynamic> userData, String token) async {
    try {
      var response;
      if(BaseURL.serve == 'php') {
        response = await http.post(
          Uri.parse('${BaseURL.baseURL}/api/ra'),
          headers: <String, String>{
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(userData),
        );
      } else{
        response = await http.post(
          Uri.parse('${BaseURL.baseURL}/api/ra/upload'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(userData),
        );
      }
      print(response.body);

      if (response.statusCode == 200) {
        print('Upload ra successfully');
        print('Response: ${response.body}');
        return response;
      } else {
        print('Failed to Upload ra. Error: ${response.reasonPhrase}');
        throw Exception('Failed to Upload ra. Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Failed to Upload ra. Error: $e');
      throw e; // Re-throwing the error to propagate it further.
    }
  }

  // static Future<List<dynamic>> fetchPublicItems() async {
  //   final response = await http.get(Uri.parse(
  //       '${BaseURL.baseURL}/api/ra/public/all?limit=10&page=1'));

  //   if (response.statusCode == 200) {
  //     final jsonData = jsonDecode(response.body);
  //     print(jsonData);
  //     return jsonData['data'];

  //   } else {
  //     // Nếu yêu cầu thất bại, ném một ngoại lệ để xử lý sau này
  //     throw Exception('Failed to load items');
  //   }
  // }

  static Future<List<PostClass>> fetchPublicItems({String token = ''}) async {
    var response;
    if(BaseURL.serve == 'php') {
      response = await http.get(
        Uri.parse('${BaseURL.baseURL}/api/ra/public/all'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );
    } else{
      final response =
      await http.get(Uri.parse('${BaseURL.baseURL}/api/ra/public/all'));
    }
    print(response.body);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      List<PostClass> postList = [];

      if (jsonData['state'] == 1) {
        for (var item in jsonData['data']) {
          postList.add(PostClass.fromJson(item));
        }
      }

      return postList;
    } else {
      // If the request fails, throw an exception to handle later

      throw Exception('Failed to load items');
    }
  }

  static Future<http.Response> fetchRADetail(String id, {String? token = ''}) async {
var response;
    if(BaseURL.serve == 'php') {
      response = await http.get(
        Uri.parse('${BaseURL.baseURL}/api/ra/$id'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );
    } else{
      final response =
      await http.get(Uri.parse('${BaseURL.baseURL}/api/ra/public?id=$id'));
    }
    print(response.body);
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load job posting');
    }
  }
}
