// ignore_for_file: prefer_interpolation_to_compose_strings, unnecessary_string_interpolations

import 'dart:convert';

import 'package:web_admin/models/field.dart';
import 'package:web_admin/service/api.dart';

class FieldRepoService {
  String _url = '${APIService.GetUrl()}/fields';

  Future<List<Field>> GetAllField({String jwt = ''}) async {
    var data = await APIService().GetRequest('$_url', APIService.JWT());
    var result = (data['data']['fields'] as List)
        .map<Field>((item) => Field.fromJson(item))
        .toList();
    return result;
  }

  Future<dynamic> CreateField({required Field field, String jwt = ''}) async {
    try {
      final data = await APIService().PostRequest(
          '$_url', jsonEncode(field.toJson()),
          authorization: APIService.JWT());
      // final decodedData = jsonDecode(data);
      return data;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> UpdateField({required Field field, String jwt = ''}) async {
    final data = await APIService().PutRequest(
        '$_url/' + field.id, jsonEncode(field.toJson()),
        authorization: APIService.JWT());
    // final decodedData = jsonDecode(data);
    return data;
  }

  Future<dynamic> DeleteField({required Field field, String jwt = ''}) async {
    final data = await APIService()
        .DeleteRequest('$_url/' + field.id, authorization: APIService.JWT());
    // final decodedData = jsonDecode(data);
    print(data);
    return data;
  }
}
