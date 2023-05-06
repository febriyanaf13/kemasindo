import 'package:get/get.dart';

import '../../../data/api/my_api.dart';

class LoginProvider extends GetConnect {

  // request token
  Future<Response> reqToken(String username, String password) {
    final body = FormData({
      'username': username,
      'password': password,
    });
    return post(Api.token, body);
  }

  //post login
  Future<Response> postLogin(String username, String password, String token) {
    var headers = {
      "Authorization": "Bearer $token",
    };
    final body = FormData({
      'username': username,
      'password': password,
    });
    return post(
      Api.login, body, headers: headers
    );
  }
}
