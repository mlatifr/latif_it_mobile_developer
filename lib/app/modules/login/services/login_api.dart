import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class UserServices {
  static const _baseUrl = 'https://fakestoreapi.com';

  final Dio dio;

  UserServices({Dio? dio}) : dio = dio ?? Dio(BaseOptions(baseUrl: _baseUrl));

  Future login({
    required String username,
    required String password,
  }) async {
    var token = '';
    final response = await dio.post(
      '/auth/login',
      data: {
        'username': username,
        'password': password,
      },
    );
    if (response.data['token'] != null) {
      token = response.data['token'];
      return token;
    }
    if (kDebugMode) {
      print(response.data);
    }
    return token;
  }
}
