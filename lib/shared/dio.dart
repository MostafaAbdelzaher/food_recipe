import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://yummly2.p.rapidapi.com',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    String? url,
    Map<String, dynamic>? query,
  }) async {
    dio!.options.headers = {
      "X-RapidAPI-Host": "yummly2.p.rapidapi.com",
      "X-RapidAPI-Key": "a175286dddmsh81a35037b2f067fp1622bajsn7a202458daa6"
    };
    return await dio!.get(
      url!,
      queryParameters: query,
    );
  }
}
