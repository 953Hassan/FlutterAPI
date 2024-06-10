import 'package:logger/logger.dart';

import '../models/user.dart';
import 'http_services.dart';

class AuthService {
  static final AuthService _singleton = AuthService._internal();
  final _httpService = HTTPService();
  final Logger logger = Logger();

  User? user;

  factory AuthService() {
    return _singleton;
  }

  AuthService._internal();

  Future<bool> login(String username, String password) async {
    try {
      var response = await _httpService.post("auth/login", {
        "username": username,
        "password": password,
      });
      if (response?.statusCode == 200 && response?.data != null) {
        user = User.fromJson(response!.data);
        logger.d(user);
        HTTPService().setup(bearerToken: user!.token);
        return true;
      } else {
        logger.e('Failed login: ${response?.statusCode} ${response?.data}');
      }
    } catch (e) {
      logger.e('Login error', e);
    }
    return false;
  }
}
