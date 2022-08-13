import 'package:dio/dio.dart';

class Dio_Helper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'http://consultant1.herokuapp.com/api/',
        receiveDataWhenStatusError: true));
  }

  static Future<Response> getData(
      {required String url,
      Map<String, dynamic>? query,
      String? token,
      }) async {
    dio.options.headers = {

      'token': " Bearer $token",

    };

    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
  }) async {
    return await dio.post(url, queryParameters: query, data: data);
  }

  static Future<Response> putData(
      {required String url,
      Map<String, dynamic>? query,
      required Map<String, dynamic> data,
      String? token,
      }) async {
    return await dio.put(url, queryParameters: query, data: data);
  }
}
