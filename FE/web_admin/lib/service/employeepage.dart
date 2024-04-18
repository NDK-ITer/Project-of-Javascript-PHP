// ignore_for_file: prefer_interpolation_to_compose_strings, unnecessary_string_interpolations

import 'dart:convert';

import 'package:web_admin/models/employee.dart';
import 'package:web_admin/service/api.dart';

class EmployeeRepoService {
  String _url = '${APIService.GetUrl()}/employees';

  Future<dynamic> GetAllEmployee({String jwt = ''}) async {
    var data = await APIService().GetRequest('$_url', APIService.JWT());
    var result =
        List<Employee>.from(data.map((item) => Employee.fromJson(item)));

    return result;
  }

  Future<dynamic> CreateEmployee(
      {required Employee employee, String jwt = ''}) async {
    try {
      final data = await APIService().PostRequest(
          '$_url', jsonEncode(employee.toJson()),
          authorization: APIService.JWT());
      // final decodedData = jsonDecode(data);
      return data;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> UpdateEmployee(
      {required Employee employee, String jwt = ''}) async {
    final data = await APIService().PutRequest(
        '$_url/' + employee.id, jsonEncode(employee.toJson()),
        authorization: APIService.JWT());
    // final decodedData = jsonDecode(data);
    return data;
  }

  Future<dynamic> DeleteEmployee(
      {required Employee Employee, String jwt = ''}) async {
    final data = await APIService()
        .DeleteRequest('$_url/' + Employee.id, authorization: APIService.JWT());
    // final decodedData = jsonDecode(data);
    return data;
  }
}
