import 'package:http/http.dart' as http;

class APIService {
  static const int timeOutDuration = 35;
  static String GetUrl() => 'http://192.168.1.16:7000/api';

  static String JWT() =>
      'eyJ0eXAiOiJKV1QiLCJ0b2tlbl9pZCI6ImYzNjhiYjViLTYyODktNGNjYi04NmJlLWVkNWE0YmU5NjA0MiIsImFsZyI6IkhTNTEyIn0.eyJpZCI6IjRlYmY3N2U1LWQwYmMtNDRiZi05MjVkLWYzMTIxNzI4OTE4YyIsImVtYWlsIjpudWxsLCJleHAiOjE3MTMwODczOTV9.EkmE2kktw0LJ2FBn5atLUjk4bzmYwQzH-XhrmIO6fvZCqZnaFFbQcbFxxd7WEjsKd_CvNrdttlpwhE9SRxoztA';

  Future<dynamic> GetRequest(String url, [String authorization = '']) async {
    var headers = {"Authorization": 'Bearer $authorization'};

    // Gọi API GET
    var uri = Uri.parse(url);
    var response = await http
        .get(uri, headers: headers)
        .timeout(const Duration(seconds: timeOutDuration), onTimeout: () {
      return Future.error("Timeout occurred");
    });

    return response.body;
  }

  Future<dynamic> PostRequest(String url, dynamic payloadObj,
      {String authorization = ''}) async {
    // Gọi API POST
    authorization = '';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $authorization"
    };
    var uri = Uri.parse(url);
    try {
      var response = await http
          .post(uri, headers: headers, body: payloadObj)
          .timeout(const Duration(seconds: timeOutDuration), onTimeout: () {
        return Future.error("Timeout occurred");
      });
      return response.body;
    } catch (e) {
      //throw e;
      print(e);
      //throw ExceptionHandlers().getExceptionString(e);
    }
  }

  Future<dynamic> PutRequest(String url, dynamic payloadObj,
      {String authorization = ''}) async {
    // Gọi API Put
    authorization = '';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': authorization
    };
    var uri = Uri.parse(url);
    try {
      var response = await http
          .put(uri, headers: headers, body: payloadObj)
          .timeout(const Duration(seconds: timeOutDuration), onTimeout: () {
        return Future.error("Timeout occurred");
      });
      return response.body;
    } catch (e) {
      //throw e;
      print(e);
    }
  }

  Future<dynamic> DeleteRequest(String url, {String authorization = ''}) async {
    authorization = '';
    var headers = {'Authorization': authorization};
    // Gọi API Delete
    var uri = Uri.parse(url);
    try {
      var response = await http
          .delete(uri, headers: headers)
          .timeout(const Duration(seconds: timeOutDuration), onTimeout: () {
        return Future.error("Timeout occurred");
      });
      print(response);
      return response.body;
    } catch (e) {
      //throw e;
      print(e);
    }
  }
}
