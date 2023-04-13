import 'package:dio/dio.dart';
import 'package:payment_app/core/app_constatns.dart';

class ApiServices {
  static Dio dio = Dio(
    BaseOptions(
        baseUrl: ApPConstatns.baseUrl,
        headers: {"Content-Type": "application/json"},
        receiveDataWhenStatusError: true),
  );

  Future<Response> post(
      {required String endPoint, Map<String, dynamic>? data}) async {
    return await dio.post(endPoint, data: data);
  }
}
