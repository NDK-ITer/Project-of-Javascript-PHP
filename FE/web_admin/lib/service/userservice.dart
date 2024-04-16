// ignore_for_file: prefer_interpolation_to_compose_strings, unnecessary_string_interpolations

import 'dart:convert';

import 'package:web_admin/models/user.dart';
import 'package:web_admin/service/api.dart';

class UserRepoService {
  String _url = '${APIService.GetUrl()}/users';

  Future<dynamic> GetAllUser({String jwt = ''}) async {
    var data = await APIService().GetRequest('$_url', APIService.JWT());
    var result = List<User>.from(
        data['data']['users'].map((item) => User.fromJson(item)));

    return result;
  }

  Future<dynamic> CreateUser({required User user, String jwt = ''}) async {
    try {
      final data = await APIService().PostRequest(
          '$_url', jsonEncode(user.toJson()),
          authorization: APIService.JWT());
      // final decodedData = jsonDecode(data);
      return data;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> UpdateUser({required User user, String jwt = ''}) async {
    final data = await APIService().PutRequest(
        '$_url/' + user.id, jsonEncode(user.toJson()),
        authorization: APIService.JWT());
    // final decodedData = jsonDecode(data);
    return data;
  }

  Future<dynamic> DeleteUser({required User User, String jwt = ''}) async {
    final data = await APIService()
        .DeleteRequest('$_url/' + User.id, authorization: APIService.JWT());
    // final decodedData = jsonDecode(data);
    return data;
  }
}
