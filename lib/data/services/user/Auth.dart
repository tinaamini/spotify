import 'package:dio/dio.dart';
import '../../../core/di/di.dart';
import '../../../core/exception/exceptions.dart';
import '../../../core/network/api_client.dart';
import '../../models/user/register_model.dart';
import '../tokenmanager.dart';

class AuthService {
  final ApiClient _apiClient;

  AuthService(this._apiClient);

  Future<bool> registerUser(UserRegister user) async {
    try {
      final response = await _apiClient.post(
        '/users/register',
        data: user.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('ثبت‌نام با موفقیت انجام شد: ${response.data}');
        return true;
      }

      throw DioException(
        response: response,
        requestOptions: response.requestOptions,
      );
    } on DioException catch (e) {
      throw handleDioException(e);
    }
  }


  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final data = {
        'grant_type': 'password',
        'username': email,
        'password': password,
      };
      final response = await _apiClient.post(
        '/users/login',
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );
      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      }

      throw DioException(
        response: response,
        requestOptions: response.requestOptions,
      );
    } on DioException catch (e) {
      throw handleDioException(e);
    }
  }

  Future<Map<String, dynamic>> profileUser(String token) async {
    try {
      final response = await _apiClient.get(
        "/users/me",
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw DioException(
          response: response,
          requestOptions: response.requestOptions,
          error: 'Failed with status code: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw handleDioException(e);
    }
  }
}
