import 'package:dio/dio.dart';


class AppException implements Exception {
  final String message;
  final int? statusCode;

  AppException(this.message, {this.statusCode});

  @override
  String toString() => message;
}


class ServerException extends AppException {
  ServerException(String message, {int? statusCode})
      : super(message, statusCode: statusCode);
}


class NetworkException extends AppException {
  NetworkException(String message) : super(message);
}


class ValidationException extends AppException {
  ValidationException(String message) : super(message);
}


AppException handleDioException(DioException e) {
  if (e.type == DioExceptionType.connectionTimeout ||
      e.type == DioExceptionType.sendTimeout ||
      e.type == DioExceptionType.receiveTimeout) {
    return NetworkException('اتصال به سرور برقرار نشد (timeout)');
  } else if (e.response != null) {
    final statusCode = e.response?.statusCode;
    final data = e.response?.data;
    String message;

    switch (statusCode) {

      case 400:
        message = data['message'] ?? 'درخواست نامعتبر است';
        break;
      case 401:
        message = data['message'] ?? 'نام کاربری یا رمز عبور اشتباه است';
        break;
      case 403:
        message = data['message'] ?? 'دسترسی غیرمجاز';
        break;
      case 404:
        message = data['message'] ?? 'منبع یافت نشد';
        break;
      case 500:
        message = data['message'] ?? 'خطای سرور داخلی';
        break;
      default:
        message = data['message'] ?? 'خطای ناشناخته سرور: $statusCode';
    }
    return ServerException(message, statusCode: statusCode);
  } else {
    return NetworkException('خطای شبکه: ${e.message}');
  }
}