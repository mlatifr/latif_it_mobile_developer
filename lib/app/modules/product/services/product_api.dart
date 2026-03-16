import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ProductServices {
  static const _baseUrl = 'https://fakestoreapi.com';

  final Dio dio;

  ProductServices({Dio? dio})
      : dio = dio ?? Dio(BaseOptions(baseUrl: _baseUrl));

  Future getProduct() async {
    final response = await dio.get(
      '/products',
    );
    if (response.data != null) {
      return response.data;
    }
    if (kDebugMode) {
      print(response.data);
    }
    return null;
  }
}
