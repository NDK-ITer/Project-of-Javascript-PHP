import 'dart:convert';

import 'package:web_admin/models/role.dart';
import 'package:web_admin/service/api.dart';

class RoleRepoService {
  String _url = '${APIService.GetUrl()}/roles';

  Future<dynamic> GetAllRole({String jwt = ''}) async {
    final data = jsonDecode(await APIService().GetRequest('$_url', jwt));
    var result =
        data['data'].values.map((value) => Role.fromJson(value)).toList();

    return result;
  }
}
