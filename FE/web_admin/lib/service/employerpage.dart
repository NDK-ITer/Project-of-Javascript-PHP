// ignore_for_file: prefer_interpolation_to_compose_strings, unnecessary_string_interpolations

import 'dart:convert';

import 'package:web_admin/models/employee.dart';
import 'package:web_admin/models/employer.dart';
import 'package:web_admin/service/api.dart';

class EmployerRepoService {
  String _url = '${APIService.GetUrl()}/employers';

  Future<dynamic> GetAllEmployer({String jwt = ''}) async {
    var data = await APIService().GetRequest('$_url', APIService.JWT());
    var result =
        List<Employer>.from(data.map((item) => Employer.fromJson(item)));
    return result;
  }

  Future<dynamic> CreateEmployer(
      {required Employer employer, String jwt = ''}) async {
    try {
      final data = await APIService().PostRequest(
          '$_url', jsonEncode(employer.toJson()),
          authorization: APIService.JWT());
      // final decodedData = jsonDecode(data);
      return data;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> UpdateEmployer(
      {required Employer employer, String jwt = ''}) async {
    final data = await APIService().PutRequest(
        '$_url/' + employer.id, jsonEncode(employer.toJson()),
        authorization: APIService.JWT());
    // final decodedData = jsonDecode(data);
    return data;
  }

  Future<dynamic> DeleteEmployer(
      {required Employer employer, String jwt = ''}) async {
    final data = await APIService()
        .DeleteRequest('$_url/' + employer.id, authorization: APIService.JWT());
    // final decodedData = jsonDecode(data);
    return data;
  }
}
