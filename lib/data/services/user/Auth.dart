import 'package:dio/dio.dart';

import '../../models/user/register.dart';

class AuthService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://your-api-url.com',
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




}