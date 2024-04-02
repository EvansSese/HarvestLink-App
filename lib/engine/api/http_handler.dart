import 'dart:convert';

import 'package:http/http.dart' as http;

class HTTPHandler {
  String baseUrl = 'http://41.215.44.98:8081/api/v1';

  Future<List> getData(String endpoint) async {
    var url = Uri.parse('$baseUrl$endpoint');
    http.Response response = await http.get(url);
    if (int.parse(response.statusCode.toString()) == 200) {
      var data = jsonDecode(response.body);
      return data;
    }
    return [];
  }

  Future<List> getDataWithBody(
      String endpoint, Map<String, dynamic> body) async {
    var url = Uri.parse('$baseUrl$endpoint');
    var newUrl = url.replace(queryParameters: body);
    http.Response response = await http.get(newUrl);
    if (int.parse(response.statusCode.toString()) == 200) {
      var data = jsonDecode(response.body);
      return data;
    }
    return [];
  }

  Future<int> postData(String endpoint, Map<String, String> body) async {
    var url = Uri.parse('$baseUrl$endpoint');
    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );
    var status = response.statusCode;
    return status;
  }

  Future<List> postDataRes(String endpoint, Map<String, String> body) async {
    var url = Uri.parse('$baseUrl$endpoint');
    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );
    if (int.parse(response.statusCode.toString()) == 200) {
      var res = jsonDecode(response.body);
      return res;
    }
    var res = [];
    return res;
  }

  Future<int> deleteData(String endpoint, Map<String, String> body) async {
    var url = Uri.parse('$baseUrl$endpoint');
    http.Response response = await http.delete(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(body));
    var status = response.statusCode;
    return status;
  }
}
