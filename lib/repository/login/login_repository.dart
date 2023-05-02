import 'dart:convert';

import 'package:flutter_mvvm_provider/models/login/login_model.dart';
import 'package:flutter_mvvm_provider/services/api_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

class LoginRepository {
  final ApiService _apiService = GetIt.instance<ApiService>();
  final _secureStorage = const FlutterSecureStorage();

  Future<Response> login(LoginModel model) async {
    final body = {
      'username': model.username,
      'password': model.password,
    };
    final Response response = await _apiService.post('/auth/login', body);

    if (response.isSuccess) {
      final token = response.data['token'];
      await _secureStorage.write(key: 'token', value: token);
    }

    return response;
  }
}
