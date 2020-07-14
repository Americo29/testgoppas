import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class Response {
  final Map<String, dynamic> services;
  final bool ok;
  final String message;
  final String fieldregister;

  Response({this.services, this.ok, this.message, this.fieldregister});

  Response.fromJson(Map<String, dynamic> json)
      : services = json['services'],
        message = json['message'],
        fieldregister = json['fieldregister'],
        ok = json['ok'];
}

class MyHttpException extends HttpException {
  final int statusCode;
  MyHttpException(this.statusCode, String message) : super(message);
}

class ApiService {
  static const String baseUrl = 'apiprueba.gopass.com.co';
  static ApiService instance;
  factory ApiService() => instance ??= ApiService._internal();
  ApiService._internal();

  Future<Response> getServices() async {
    final url = new Uri.http(baseUrl, "/establishment/getAllEstablishment");
    try {
      final services = await NetworkUtils.get(url);

      // print(services);

      return Response.fromJson({'ok': true, 'services': services});
    } catch (e) {
      return Response.fromJson({'ok': false, 'message': e.toString()});
    }
  }

  Future<Response> getFieldRegister() async {
    final url = new Uri.http(baseUrl, "/client/registre");
    try {
      final fieldRegister = await NetworkUtils.get(url);

      print(fieldRegister);

      return Response.fromJson({
        'ok': true,
        'message': 'field obteined',
        'fieldregister': fieldRegister
      });
    } catch (e) {
      return Response.fromJson({'ok': false, 'message': e.toString()});
    }
  }
}

class NetworkUtils {
  static Future get(Uri url, {Map<String, String> headers}) async {
    final response = await http.get(url, headers: headers);
    final body = response.body;
    final statusCode = response.statusCode;
    if (body == null) {
      print('$statusCode Response body is null');
    }
    final decoded = json.decode(body);
    if (statusCode < 200 || statusCode >= 300) {
      print('$statusCode ${decoded['message']}');
    }
    return decoded;
  }

  static Future post(Uri url,
      {Map<String, String> headers, Map<String, String> body}) {
    return _helper('POST', url, headers: headers, body: body);
  }

  static Future _helper(String method, Uri url,
      {Map<String, String> headers, Map<String, String> body}) async {
    final request = new http.Request(method, url);
    if (body != null) {
      request.bodyFields = body;
    }
    if (headers != null) {
      request.headers.addAll(headers);
    }
    final streamedReponse = await request.send();
    final statusCode = streamedReponse.statusCode;
    final decoded = json.decode(await streamedReponse.stream.bytesToString());
    if (statusCode < 200 || statusCode >= 300) {
      print('$statusCode ${decoded['message']}');
    }
    return decoded;
  }

  static Future put(Uri url, {Map<String, String> headers, body}) {
    return _helper('PUT', url, headers: headers, body: body);
  }
}
