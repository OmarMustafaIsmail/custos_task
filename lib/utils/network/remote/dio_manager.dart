import 'package:custos_task/utils/network/remote/end_points.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
    dio!.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        filter: (options, args) {
          // don't print requests with uris containing '/posts'
          if (options.path.contains('/posts')) {
            return false;
          }
          // don't print responses with unit8 list data
          return !args.isResponse || !args.hasUint8ListData;
        }));
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
