import 'package:dio/dio.dart';
class DioHelper {
  static Dio? dio;
  static Future<void> init() async
  {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true,
      )
    );
  }

  // GetData from url
  static Future<Response?> getNetworkData({required String methodUrl,required dynamic query}) async
  {
      return await dio?.get(methodUrl,queryParameters: query);
  }
}