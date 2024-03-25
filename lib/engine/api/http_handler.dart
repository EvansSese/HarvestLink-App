import 'dart:convert';

import 'package:http/http.dart' as http;

class HTTPHandler {
  String baseUrl = 'http://41.215.44.98:8081/api/v1';

  Future<List> getData(String endpoint) async {
    var url = Uri.parse('$baseUrl$endpoint');
    http.Response response = await http.get(url);
    var data = jsonDecode(response.body);
    return data;
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
}
