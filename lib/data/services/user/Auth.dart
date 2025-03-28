import 'package:dio/dio.dart';

import '../../models/user/register_model.dart';

class AuthService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://app.mond-soft.com/spotify/',
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 3),
    ),
  );

  Future<bool> registerUser(UserRegister user) async {
    try {
      final response = await _dio.post(
        '/users/register',
        data: user.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('ثبت‌نام با موفقیت انجام شد: ${response.data}');
        return true;
      } else {
        print('خطا در ثبت‌نام: ${response.statusCode}');
        return false;
      }
    } on DioException catch (e) {
      print('خطای شبکه: ${e.response?.data ?? e.message}');
      return false;
    }
  }


  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final data = {
        'grant_type': 'password',
        'username': email,
        'password': password,
      };
      print('داده‌های ارسالی برای ورود (Form): $data');
      final response = await _dio.post(
        '/users/login',
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );
      print('پاسخ ورود: ${response.data}');
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      if (e.response != null) {
        print('خطای سرور: کد ${e.response?.statusCode}, داده: ${e.response?.data}');
        throw Exception(
            e.response?.data['message'] ?? e.response?.data.toString() ?? 'ورود ناموفق: ${e.response?.statusCode}');
      } else {
        print('خطای شبکه: ${e.message}');
        throw Exception('خطای شبکه: ${e.message}');
      }
    }
  }




}