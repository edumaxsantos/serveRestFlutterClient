import 'dart:convert';

import 'package:serve_rest_flutter_client/src/infra/response.dart';
import 'package:http/http.dart' as http;

class Request {
  final String _basicUrl = 'http://10.0.2.2:3000'; //'https://serverest.dev/';

  Future<Response> get({required String path}) async {
    var response = await http.get(_uriParse(path));
    return Response(
      statusCode: response.statusCode,
      body: jsonDecode(response.body),
    );
  }

  Future<Response> delete({
    required String path,
    Map<String, String> headers = const {},
  }) async {
    final nHeaders = {...headers};
    nHeaders.putIfAbsent('Content-Type', () => 'application/json');
    final response = await http.delete(_uriParse(path), headers: nHeaders);
    return Response(
      statusCode: response.statusCode,
      body: jsonDecode(response.body),
    );
  }

  Future<Response> post({
    required String path,
    dynamic body,
    Map<String, String> headers = const {},
  }) async {
    final nHeaders = {...headers};
    nHeaders.putIfAbsent('Content-Type', () => 'application/json');
    dynamic response;
    try {
      response = await http.post(_uriParse(path),
          body: jsonEncode(body), headers: nHeaders);
    } catch (e) {
      return Response(statusCode: 500, body: {'message': '$e'});
    }
    return Response(
      statusCode: response.statusCode,
      body: jsonDecode(response.body),
    );
  }

  Future<Response> put({
    required String path,
    dynamic body,
    Map<String, String> headers = const {},
  }) async {
    final nHeaders = {...headers};
    nHeaders.putIfAbsent('Content-Type', () => 'application/json');
    final response = await http.put(
      _uriParse(path),
      body: jsonEncode(body),
      headers: nHeaders,
    );
    return Response(
      statusCode: response.statusCode,
      body: jsonDecode(response.body),
    );
  }

  Uri _uriParse(String path) {
    return Uri.parse('$_basicUrl/$path');
  }
}
