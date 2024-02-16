import 'package:dio/dio.dart';
import 'package:dio_interceptor/interceptors/dio_interceptor.dart';
import 'package:dio_interceptor/services/token_service.dart';
import 'package:flutter/foundation.dart';

class ApiService {
  late final Dio _dio;

  ApiService() {
    _dio = Dio();
    _dio.interceptors.add(DioInterceptor());
  }

  static const String _loginUrl =
      'http://restapi.adequateshop.com/api/authaccount/login';
  static const String _dataUrl =
      'http://restapi.adequateshop.com/api/users?page=1';

  Map<String, dynamic> get _loginData => {
        "email": "test@gmail.com",
        "password": "123123",
      };

  Future<void> _saveToken(Map<String, dynamic> data) async {
    final token = data['data']['Token']; //accordig api
    await TokenService.setToken(token);
  }

  String _getResult(Map<String, dynamic> json) {
    debugPrint("data recieved is $json");
    final List<dynamic> list = json['data'];
    return 'Recieved ${list.length} objects';
  }

  Future<bool> dioLogin() async {
    final response = await _dio.post(_loginUrl, data: _loginData);

    if (response.statusCode == 200) {
      await _saveToken(response.data);
      return true;
    }
    return false;
  }

  Future<String?> dioGetData() async {
    try {
      final response = await _dio.get(_dataUrl);

      if (response.statusCode == 200) {
        return _getResult(response.data);
      }
      return response.data as String;
    } on DioException catch (err) {
      return err.response?.data ?? 'Error occurred';
    }
  }
}
