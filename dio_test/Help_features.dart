import 'package:dio/dio.dart';

enum DioErrorType  {
    CONNECT_TIMEOUT, // time is finish
    RECIEVE_TIMEOUT,
    RESPONSE,
    CANCEL, // user cancel request by himself
    DEFAULT,
}

final dio = Dio();

// CANCEL

 CancelToken token = CancelToken();

 void f1() {
  dio.get('url1', cancelToken: token);
  dio.get('url2', cancelToken: token);
 }

 void cancelF1() {
  token.cancel('cancelled');
 }

 
