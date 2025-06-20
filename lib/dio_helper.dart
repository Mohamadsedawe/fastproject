import 'package:dio/dio.dart';
<<<<<<< HEAD
import 'package:workerr/shared_prefrenses_helper.dart';
=======
import 'package:webb/shared_prefrenses_helper.dart';
>>>>>>> b8bd750b1f70ec300368d6a61603b52ee9316bfa

class DioHelper {
  static late Dio dio;
  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: 'http://192.168.189.134:8000/',
          receiveDataWhenStatusError: true),
    );
  }

  static Future<Response> getData(
      {required String url, Map<String, dynamic>? query, String? token}) async {
    dio.options.headers = {
      'Accept-Encoding': 'gzip, deflate, br',
      'User-Agent': 'PostmanRuntime/7.32.3',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': CachHelper.getData(key: 'token') == null
          ? ''
          : '${'Bearer' + ' ' + CachHelper.getData(key: 'token')}',    };
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio.options.headers = {
      'Accept-Encoding': 'gzip, deflate, br',
      'User-Agent': 'PostmanRuntime/7.32.3',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': CachHelper.getData(key: 'token') == null
          ? ''
          : '${'Bearer' + ' ' + CachHelper.getData(key: 'token')}',    };

    return await dio.post(url, queryParameters: query, data: data);
  }

  static Future<Response> updateData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio.options.headers = {
      'Accept': 'application/json',
      'Authorization': CachHelper.getData(key: 'token') == null
          ? ''
          : '${'Bearer' + ' ' + CachHelper.getData(key: 'token')}',    };

    return await dio.put(url, data: data, queryParameters: query);
  }
  static Future<Response> DeleteData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
    Map<String, dynamic>? data,
  }) async {
    dio.options.headers = {
      'Accept-Encoding': 'gzip, deflate, br',
      'User-Agent': 'PostmanRuntime/7.32.3',
      'Content-Type': 'application/json',
      'Accept': 'application/json',

      'Authorization': CachHelper.getData(key: 'token') == null
          ? ''
          : '${'Bearer' + ' ' + CachHelper.getData(key: 'token')}',    };
    return await dio.delete(url, queryParameters: query, data: data);
  }
}
