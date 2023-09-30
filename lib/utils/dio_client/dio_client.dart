import 'package:dio/dio.dart';
import 'package:chat_pusher_laravel/utils/dio_client/app_interceptors.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  static DioClient? _singlenton;

  static late Dio _dio;

  DioClient._() {
    _dio = createDioClient();
  }

  factory DioClient() {
    return _singlenton ??= DioClient._();
  }

  Dio get instance => _dio;

  Dio createDioClient() {
    final dio = Dio(BaseOptions(
        baseUrl: "http://192.168.1.110:8000",
        receiveTimeout: 15000,
        connectTimeout: 15000,
        sendTimeout: 15000,
        headers: {
          Headers.acceptHeader: 'application/json',
          Headers.contentTypeHeader: 'application/json'
        }));

    dio.interceptors.addAll([
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        compact: true,
        maxWidth: 90
      ),
      AppInterceptors(),
    ]);

    return dio;
  }
}
