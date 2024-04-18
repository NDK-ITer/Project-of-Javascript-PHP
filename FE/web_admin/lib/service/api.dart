import 'dart:convert';

import 'package:http/http.dart' as http;

class APIService {
  static const int timeOutDuration = 35;
  static String GetUrl() => 'http://127.0.0.1:8000/api';

  static String JWT() =>
      'eyJ0eXAiOiJKV1QiLCJ0b2tlbl9pZCI6Ijc5MDAxZGYzLTMxYjMtNGI4OS04MWExLTUwOGE2Y2JjOWFkMiIsImFsZyI6IkhTNTEyIn0.eyJpZCI6IjRlYmY3N2U1LWQwYmMtNDRiZi05MjVkLWYzMTIxNzI4OTE4YyIsImVtYWlsIjoiYUBnbWFpbC5jb20iLCJleHAiOjE3MTMyMjAyNjN9.ZFCEdtzIxLnyee4mIhfApe4oFMY_KgmyespC7PvpEcOcJYTCD9jl3qon0pYGG584Ib9KJBs34AjYIXc6c_AbEw';

  Future<dynamic> GetRequest(String url, [String authorization = '']) async {
    var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": 'Bearer $authorization',
    };

    // Gọi API GET
    var uri = Uri.parse(url);
    var response = await http.get(uri, headers: headers);
    // print(response.body);
    return jsonDecode(response.body);
  }

  Future<dynamic> PostRequest(String url, dynamic payloadObj,
      {String authorization = ''}) async {
    // Gọi API POST
    // authorization = '';
    var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': "Bearer $authorization"
    };
    var uri = Uri.parse(url);
    try {
      var response = await http.post(uri, body: payloadObj, headers: headers);
      if (response.body.startsWith('<!DOCTYPE')) {
        return response.body;
      }
      return jsonDecode(response.body);
    } catch (e) {
      //throw e;
      print(e);
      //throw ExceptionHandlers().getExceptionString(e);
    }
  }

  Future<dynamic> PutRequest(String url, dynamic payloadObj,
      {String authorization = ''}) async {
    // Gọi API Put
    // authorization = '';
    var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': "Bearer $authorization"
    };
    var uri = Uri.parse(url);
    try {
      var response = await http.put(uri, headers: headers, body: payloadObj);
      return jsonDecode(response.body);
    } catch (e) {
      //throw e;
      print(e);
    }
  }

  Future<dynamic> DeleteRequest(String url, {String authorization = ''}) async {
    // authorization = '';
    var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': "Bearer $authorization"
    };
    // Gọi API Delete
    var uri = Uri.parse(url);
    try {
      var response = await http.delete(uri, headers: headers);
      return jsonDecode(response.body);
    } catch (e) {
      //throw e;
      print(e);
    }
  }
}
