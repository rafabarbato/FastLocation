import 'package:dio/dio.dart';

class DioConfig {
  static Dio getDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://viacep.com.br/ws/',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    dio.interceptors.add(LogInterceptor(responseBody: true));
    return dio;
  }
}