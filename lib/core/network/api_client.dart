import 'package:dio/dio.dart';

import '../../data/services/tokenmanager.dart';
import '../di/di.dart';

class ApiClient {
  final Dio _dio;

  ApiClient()
      : _dio = Dio(
    BaseOptions(
      baseUrl: 'https://app.mond-soft.com/spotify/',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Accept': 'application/json',
      },
    ),
  );

  Future<void> _setAuthHeader() async {
    final token = await getIt<TokenManager>().getToken();
    if (token != null) {
      _dio.options.headers['Authorization'] = 'Bearer $token';
    }
  }
  Future<Response> get(
      String path, {
        Map<String, dynamic>? queryParameters,
        Map<String, String>? headers,
        Options? options,
      }) async {
    try {
      await _setAuthHeader();
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options ?? Options(headers: headers),
      );
      return response;
    } on DioException catch (e) {
      print('DioException in GET: ${e.message}');
      rethrow;
    }
  }


  Future<Response> post(
      String path, {
        dynamic data,
        Options? options,
      }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      print('DioException in POST: ${e.message}');
      rethrow;
    }
  }
  Future<Response> patch(
      String path, {
        Map<String, dynamic>? data,
        Options? options,
      }) async {
    try {
      await _setAuthHeader();
      print('Request headers: ${_dio.options.headers}');
      final response = await _dio.patch(
        path,
        data: data,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      print('DioException in PATCH: ${e.message}');
      rethrow;
    }
  }
}