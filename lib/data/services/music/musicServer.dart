import 'dart:io';

import 'package:dio/dio.dart';

import '../../../core/di/di.dart';
import '../../../core/exception/exceptions.dart';
import '../../../core/network/api_client.dart';
import '../../models/music/allMusic.dart';
import '../../models/music/artist.dart';
import '../tokenmanager.dart';

class MusicServer {
  final ApiClient _apiClient;

  MusicServer(this._apiClient);

  Future<List<Music>> getAllMusic({
    int? artistId,
    int skip = 0,
    int limit = 100,
  }) async {
    final token =await getIt<TokenManager>().getToken();
    if (token == null) {
      throw Exception('No token available');
    }
    try {
    final response = await _apiClient.get(
      '/musics',
      queryParameters: {
        if (artistId != null) 'artist_id': artistId,
        'skip': skip,
        'limit': limit,
      },
      headers: {
        'Authorization': 'Bearer $token',
      }, options: null,
    );
    if (response.statusCode == 200) {
      return (response.data as List).map((json) => Music.fromJson(json)).toList();
    } else {
      throw ServerException('پاسخ غیرمنتظره از سرور: ${response.statusCode}');
    }
    } on DioException catch (e) {
      throw handleDioException(e);
    }
  }

  Future<Music> createMusic({
    required String name,
    required int artistId,
    required File audioFile,
    required File coverFile,
  }) async {
    final token =await getIt<TokenManager>().getToken();
    if (token == null) {
      throw Exception('No token available');
    }

    final formData = FormData.fromMap({
      'name': name,
      'artist_id': artistId,
      'audio': await MultipartFile.fromFile(audioFile.path),
      'cover': await MultipartFile.fromFile(coverFile.path),
    });
    try {
    final response = await _apiClient.post(
      '/musics',
      data: formData,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
    if (response.statusCode == 200) {
      print("Upload successful with status 200");
      return Music.fromJson(response.data);
    } else {
      throw ServerException('پاسخ غیرمنتظره از سرور: ${response.statusCode}');
    }
  } on DioException catch (e) {
  throw handleDioException(e);
  }
}
  Future<List<Artist>> getArtists({int skip = 0, int limit = 100}) async {
    final token = await getIt<TokenManager>().getToken();
    if (token == null) {
      throw ValidationException('توکن در دسترس نیست');
    }

    try {
      final response = await _apiClient.get(
        '/artists',
        queryParameters: {
          'skip': skip,
          'limit': limit,
        },
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {

        final List<dynamic> data = response.data;
        return data.map((json) => Artist.fromJson(json)).toList();
      } else {
        throw ServerException('پاسخ غیرمنتظره از سرور: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw handleDioException(e);
    }
  }
  Future<String> likeMusic(int musicId) async {
    final response = await _apiClient.patch('/musics/$musicId/like');
    if (response.statusCode == 200) {
      final data = response.data as Map<String, dynamic>;
      return data['message'] as String;
    } else {
      throw Exception('Failed to like music: ${response.data['detail']}');
    }
  }

  Future<String> unlikeMusic(int musicId) async {
    final response = await _apiClient.patch('/musics/$musicId/unlike');
    if (response.statusCode == 200) {
      final data = response.data as Map<String, dynamic>;
      return data['message'] as String;
    } else {
      throw Exception('Failed to unlike music: ${response.data['detail']}');
    }
  }
  Future<List<Music>> getLikedMusic() async {
    final token = await getIt<TokenManager>().getToken();
    if (token == null) {
      throw Exception('No token available');
    }
    try {
      final response = await _apiClient.get(
        '/musics/liked-music',
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return (response.data as List).map((json) => Music.fromJson(json)).toList();
      } else {
        throw ServerException('پاسخ غیرمنتظره از سرور: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw handleDioException(e);
    }
  }




}