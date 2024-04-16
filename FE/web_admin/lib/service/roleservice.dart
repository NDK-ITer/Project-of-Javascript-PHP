import 'dart:convert';

import 'package:web_admin/models/role.dart';
import 'package:web_admin/service/api.dart';

class RoleRepoService {
  String _url = '${APIService.GetUrl()}/roles';

  Future<dynamic> GetAllRole({String jwt = ''}) async {
    Map<String, dynamic> data = await APIService().GetRequest('$_url', jwt);
    var result = data['data']
        .entries
        .map((entry) => Role.fromJson(Map<String, dynamic>.from(entry.value)))
        .toList();

    return result;
  }

  Future<dynamic> CreateRole({required Role role, String jwt = ''}) async {
    try {
      final data = await APIService().PostRequest(
          '$_url', jsonEncode(role.toJson()),
          authorization: APIService.JWT());
      // final decodedData = jsonDecode(data);
      return data;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> UpdateRole({required Role role, String jwt = ''}) async {
    final data = await APIService().PutRequest(
        '$_url/' + role.id!, jsonEncode(role.toJson()),
        authorization: APIService.JWT());
    // final decodedData = jsonDecode(data);
    return data;
  }

  Future<dynamic> DeleteRole({required Role role, String jwt = ''}) async {
    final data = await APIService()
        .DeleteRequest('$_url/' + role.id!, authorization: APIService.JWT());
    // final decodedData = jsonDecode(data);
    return data;
  }
}
