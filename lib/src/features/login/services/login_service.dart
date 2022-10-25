import 'package:api_calling_test/src/infra/request.dart';
import 'package:api_calling_test/src/infra/response.dart';

class LoginService {
  Future<Response> login(
      {required String email, required String password}) async {
    final request = Request();
    return await request
        .post(path: 'login', body: {'email': email, 'password': password});
  }
}
