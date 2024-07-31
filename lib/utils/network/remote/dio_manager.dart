import 'package:custos_task/utils/network/remote/end_points.dart';
import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData(
      {required url, Map<String, dynamic>? query, String? token}) async {
    dio!.options.headers = {
      'content-type': 'application/json',
      'Authorization': token != null ? "Bearer $token" : ""
    };
    dio!.options.validateStatus = (status) {
      if (status == 401) {
        return true;
      } else {
        return true;
      }
    };

    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> deleteData(
      {required url, Map<String, dynamic>? query, String? token}) async {
    dio!.options.headers = {
      'content-type': 'application/json',
    };
    dio!.options.validateStatus = (status) {
      if (status == 401) {
        return true;
      } else {
        return true;
      }
    };

    return await dio!.delete(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData(
      {required String url,
      Map<String, dynamic>? query,
      var data,
      String lang = 'en',
      String? token,
      String? contentType}) async {
    dio!.options.validateStatus = (status) {
      if (status == 422) {
        return true;
      } else {
        return true;
      }
    };
    dio!.options.headers = {
      'Content-Type': contentType ?? 'application/json',
      'Authorization': token != null ? "Bearer $token" : "",
      'Accept-Encoding': "gzip, deflate, br",
      'Accept': '*/*'
    };

    return dio!.post(
      url,
      queryParameters: query,
      data: data ?? "",
    );
  }
}
