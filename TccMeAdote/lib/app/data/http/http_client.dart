import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class IHttpClient {
  Future get({required String url});
  Future post({required String url, Map<String, dynamic>? body, required Map<String, String> headers});
  Future delete({required String url, Map<String, String>? headers, required Map<String, Object?> body});
}

class HttpClient implements IHttpClient {

  final client = http.Client();

  @override
  Future get({required String url}) async {
    return await client.get(Uri.parse(url));
  }

  @override
  Future post({required String url, Map<String, String>? headers, dynamic body}) async {
    final response = await client.post(
      Uri.parse(url),
      headers: headers,
      body: body != null ? jsonEncode(body) : null,
    );
    return response;
  }

  @override
  Future delete({required String url, Map<String, String>? headers, dynamic body}) async {
    final response = await client.delete(
      Uri.parse(url),
      headers: headers,
      body: body != null ? jsonEncode(body) : null,
    );
    return response;
  }
}
