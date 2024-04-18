// ignore_for_file: prefer_interpolation_to_compose_strings, unnecessary_string_interpolations

import 'dart:convert';

import 'package:web_admin/models/ra.dart';
import 'package:web_admin/service/api.dart';

class RaRepoService {
  String _url = '${APIService.GetUrl()}/ra';

  Future<dynamic> GetAllRa({String jwt = ''}) async {
    var data =
        await APIService().GetRequest('$_url?populate=*', APIService.JWT());
    print(data);
    var result = List<Ra>.from(
        data['data']['RecruitmentArticle'].map((item) => Ra.fromJson(item)));
    return result;
  }

  Future<dynamic> CreateRa({required Ra ra, String jwt = ''}) async {
    try {
      final data = await APIService().PostRequest(
          '$_url', jsonEncode(ra.toJson()),
          authorization: APIService.JWT());
      // final decodedData = jsonDecode(data);
      return data;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> UpdateRa({required Ra ra, String jwt = ''}) async {
    final data = await APIService().PutRequest(
        '$_url/' + ra.id!, jsonEncode(ra.toJson()),
        authorization: APIService.JWT());
    // final decodedData = jsonDecode(data);
    return data;
  }

  Future<dynamic> DeleteRa({required Ra Ra, String jwt = ''}) async {
    final data = await APIService()
        .DeleteRequest('$_url/' + Ra.id!, authorization: APIService.JWT());
    // final decodedData = jsonDecode(data);
    return data;
  }
}
