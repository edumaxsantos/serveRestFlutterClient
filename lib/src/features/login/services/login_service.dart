import 'package:serve_rest_flutter_client/src/infra/request.dart';
import 'package:serve_rest_flutter_client/src/infra/response.dart';

class LoginService {
  Future<Response> login(
      {required String email, required String password}) async {
    final request = Request();
    return await request
        .post(path: 'login', body: {'email': email, 'password': password});
  }
}
