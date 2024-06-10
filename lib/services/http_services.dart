import 'package:dio/dio.dart';

const API_BASE_URL = 'https://dummyjson.com/';

class HTTPService {
  static final HTTPService _singleton = HTTPService._internal();
  final Dio _dio = Dio();

  factory HTTPService() {
    return _singleton;
  }

  HTTPService._internal() {
    setup();
  }

  void setup({String? bearerToken}) {
    final headers = {
      "Content-Type": "application/json",
      if (bearerToken != null) "Authorization": "Bearer $bearerToken",
    };
    final options = BaseOptions(
      baseUrl: API_BASE_URL,
      headers: headers,
      validateStatus: (status) {
        return status != null && status < 500;
      },
    );
    _dio.options = options;
  }

  Future<Response?> post(String path, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(path, data: data);
      return response;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Response?> get(String path) async {
    try {
      final response = await _dio.get(path);
      return response;
    } catch (e) {
      print(e);
    }
    return null;
  }
}