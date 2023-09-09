import 'package:flutter_clean_architecture_sample/core/errors/network_exception.dart';
import 'package:flutter_clean_architecture_sample/core/network/i_api_request_manager.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioApiRequestManager extends IApiRequestManager {

  final int _connectionTimeout  = 10000;
  final int _receiveTimeout = 80000;
  late Dio _dio;
  BaseOptions? options;
  String baseUrl;


  DioApiRequestManager({required this.baseUrl}){
    options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: Duration(milliseconds: _connectionTimeout),
      receiveTimeout: Duration(milliseconds: _receiveTimeout),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept-Charset': 'UTF-8',
      }
    );

    _dio = Dio(options);

    setupInterceptors();

  }



  void setupInterceptors(){

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options,RequestInterceptorHandler handler){
          options.headers.addAll(
            //add headers on every requests
            {
              'User-Agent' : 'Mobile'
            }
          );
          return handler.next(options);
        },
        onResponse: (Response response,ResponseInterceptorHandler handler){
          return handler.next(response);
        },
        onError: (DioError error,ErrorInterceptorHandler handler){
          switch(error.type){//todo : add missing cases
            case DioErrorType.connectionTimeout :
              return handler.next(DioError(
                requestOptions: error.requestOptions,
                response: error.response,
                error: 'Check Your Internet'
              ));
            break;
            case DioErrorType.receiveTimeout :
              return handler.next(
                DioError(
                  requestOptions: error.requestOptions,
                  response: error.response,
                  error: 'heck Your Internet'
                )
              );
              break;
            case DioErrorType.badResponse :
              return handler.next(handleBadResponse(error));
              break;
          }
          return handler.next(error);
        }
      )
    );

    _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        compact: true,
        maxWidth: 120));

  }


  DioError handleBadResponse(DioError error){
    //todo : check some custom exceptions and return desire error message
    return error;
  }


  @override
  Future<dynamic> getRequest({required String path, Map<String, dynamic>? params, Map<String, dynamic>? headers})async{
    try{
      final response = await _dio.get(path,queryParameters: params,options: Options(headers: headers));
      return response.data;
    }
    on DioError catch(err){
      throw NetworkException(message: err.message ?? '',code: err.response?.statusCode);
    }

  }


  @override
  Future postRequest({required String path, Map<String, dynamic>? params, Map<String, dynamic>? headers, required body})async{
    try{
      final response = await _dio.post(path,queryParameters: params,data: body,options: Options(headers: headers));
      response.data;
    }
    on DioError catch(err){
      throw NetworkException(message: err.message ?? '',code: err.response?.statusCode);
    }

  }


}