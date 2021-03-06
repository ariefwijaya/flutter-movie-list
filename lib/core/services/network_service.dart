import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter_movie_list/config/app_config.dart';
import 'package:flutter_movie_list/core/constant/error_const.dart';
import 'package:flutter_movie_list/core/models/api_model.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

/// Utilization to Connect with Restful API
/// Cache will be implemented here. Default method: `GET`
class NetworkUtils {
  late Dio dio;
  BaseOptions options = new BaseOptions(
    baseUrl: AppConfig.baseUrl,
    connectTimeout: AppConfig.apiConnectTimeout,
    receiveTimeout: AppConfig.apiReceiveTimeout,
    followRedirects: false,
    validateStatus: (status) => status! < 500,
  );
  // Global options
  final optionsCache = CacheOptions(
    store: MemCacheStore(),
    policy: CachePolicy
        .request, // Default. Checks cache freshness, requests otherwise and caches response.
    hitCacheOnErrorExcept: [
      401,
      403
    ], // Optional. Returns a cached response on error if available but for statuses 401 & 403.
    priority: CachePriority
        .normal, // Optional. Default. Allows 3 cache sets and ease cleanup.
    maxStale: const Duration(
        days:
            7), // Very optional. Overrides any HTTP directive to delete entry past this duration.
  );

  NetworkUtils() {
    dio = new Dio(options);
    dio.interceptors.add(DioCacheInterceptor(options: optionsCache));

    if (AppConfig.showLog) {
      dio.interceptors.add(LogInterceptor(
          requestBody: true,
          requestHeader: true,
          error: true,
          request: true,
          responseHeader: true,
          responseBody: true,
          logPrint: (obj) {
            log(obj.toString());
          }));
    }
  }

  ///Usually the authorization token will be added here
  Future<Map<String, String?>> get headerAuth async {
    return {};
  }

  Future<Map<String, dynamic>> get(String pathUrl,
      {Map<String, String?>? headers, Map<String, dynamic>? body}) async {
    Map<String, String?> authHeaders = await headerAuth;
    if (headers != null) authHeaders.addAll(headers);
    try {
      final response = await dio.get(pathUrl,
          queryParameters: body,
          options: optionsCache.toOptions().copyWith(headers: authHeaders));
      return handleResponse(response);
    } on DioError catch (e) {
      throw handleError(e);
    }
  }

  Future<Map<String, dynamic>> post(
    String pathUrl, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    Map<String, String?> authHeaders = await headerAuth;
    authHeaders.addAll({
      HttpHeaders.contentTypeHeader: "application/json",
    });
    if (headers != null) authHeaders.addAll(headers);

    try {
      final response = await dio.post(pathUrl,
          data: body, options: Options(headers: authHeaders));
      return handleResponse(response);
    } on DioError catch (e) {
      throw handleError(e);
    }
  }

  Future<Map<String, dynamic>> delete(String pathUrl,
      {Map<String, String?>? headers, Map<String, dynamic>? body}) async {
    Map<String, String?> authHeaders = await headerAuth;
    authHeaders.addAll({
      HttpHeaders.contentTypeHeader: "application/json",
    });

    if (headers != null) authHeaders.addAll(headers);

    try {
      final response = await dio.delete(pathUrl,
          // queryParameters: body,
          data: body,
          options: Options(
            headers: authHeaders,
          ));
      return handleResponse(response);
    } on DioError catch (e) {
      throw handleError(e);
    }
  }

  Future<Map<String, dynamic>> put(String pathUrl,
      {Map<String, String>? headers,
      Map<String, dynamic>? body,
      encoding}) async {
    Map<String, String?> authHeaders = await headerAuth;
    if (headers != null) authHeaders.addAll(headers);

    try {
      final response = await dio.put(pathUrl,
          data: body, options: Options(headers: authHeaders));
      return handleResponse(response);
    } on DioError catch (e) {
      throw handleError(e);
    }
  }

  ///For Example:
  ///```
  ///   FormData.fromMap({
  ///     "name": "wendux",
  ///     "age": 25,
  ///     "file": await MultipartFile.fromFile("./text.txt",filename: "upload.txt"),
  ///     "files": [
  ///       await MultipartFile.fromFile("./text1.txt", filename: "text1.txt"),
  ///       await MultipartFile.fromFile("./text2.txt", filename: "text2.txt"),
  ///      ]
  ///   });
  /// ```
  Future<Map<String, dynamic>> uploadFiles(String pathUrl,
      {Map<String, String>? headers,
      FormData? body,
      Function(int, int)? onSendProgress}) async {
    Map<String, dynamic> authHeaders = await headerAuth;
    authHeaders.addAll({
      HttpHeaders.contentTypeHeader: "application/json",
    });
    if (headers != null) authHeaders.addAll(headers);
    return await dio
        .post(
      pathUrl,
      data: body,
      options: Options(headers: authHeaders),
      onSendProgress: onSendProgress,
    )
        .then((Response response) {
      return handleResponse(response);
    }).catchError((onError) => throw handleError(onError));
  }

  static Future<MultipartFile> getMultipartFile(imgPath) {
    final mimeTypeData = lookupMimeType(imgPath)!.split('/');
    return MultipartFile.fromFile(imgPath,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
  }

  Map<String, dynamic> handleResponse(Response response) {
    final int statusCode = response.statusCode!;
    if (statusCode == 401 || statusCode == 403) {
      throw CApiResError(errorCode: ErrorConst.API_UNAUTHORIZED);
    } else if (statusCode != 200 && statusCode != 304) {
      throw CApiResError(errorCode: ErrorConst.API_NOT_SUCCESS);
    }
    try {
      return response.data;
    } catch (e) {
      throw CApiResError(
          errorCode: ErrorConst.API_ERROR_DATA, message: e.toString());
    }
  }

  CApiResError handleError(DioError e) {
    if (e.type == DioErrorType.connectTimeout ||
        e.type == DioErrorType.receiveTimeout ||
        e.type == DioErrorType.sendTimeout) {
      return CApiResError(
          errorCode: ErrorConst.API_CONNECTION_TIMEOUT, message: e.message);
    }
    return CApiResError(
        errorCode: ErrorConst.API_UNKNOWN_ERROR, message: e.message);
  }
}
