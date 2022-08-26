import 'package:dio/dio.dart';

class Dio_Helper {
  static late Dio dio;
  static late Dio dio_notification;

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'http://consultant1.herokuapp.com/api/',
        receiveDataWhenStatusError: true,
    ));
    dio_notification = Dio(BaseOptions(
        baseUrl: 'https://fcm.googleapis.com/fcm/',
        receiveDataWhenStatusError: true,
    ));

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

  static Future<Response> notification({

    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
  }) async {
    dio_notification.options.headers = {
       'Content-Type':'application/json',
      'Authorization':'key=AAAA3U1Y3Xs:APA91bHjjNZp-2TpP41_jiVU1igRawgiyL1PnQLM8q9cYDWjy-NKSHUMSu8Q-qidTAo_rGdtzuuvnXPVVCxYamQpzAYriCyqph4789cOY_OeGSWn0tyO5E6Ni-froCV0RA_Z1vXGGuZV'
    };
    return await dio_notification.post('send', queryParameters: query, data: data);
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
