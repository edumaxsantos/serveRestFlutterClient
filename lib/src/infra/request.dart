import 'dart:convert';

import 'package:api_calling_test/src/infra/response.dart';
import 'package:http/http.dart' as http;

class Request {
  final String _basicUrl = 'https://serverest.dev/';

  Future<Response> get({required String path}) async {
    var response = await http.get(Uri.parse('$_basicUrl/$path'));
    return Response(
      statusCode: response.statusCode,
      body: jsonDecode(response.body),
    );
  }

  Future<Response> post({required String path, dynamic body}) async {
    var response = await http.post(Uri.parse('$_basicUrl/$path'), body: body);
    return Response(
      statusCode: response.statusCode,
      body: jsonDecode(response.body),
    );
  }
}
