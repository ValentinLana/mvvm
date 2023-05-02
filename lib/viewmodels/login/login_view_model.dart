import 'package:flutter/foundation.dart';
import 'package:flutter_mvvm_provider/models/login/login_model.dart';
import 'package:flutter_mvvm_provider/repository/login/login_repository.dart';

class LoginViewModel extends ChangeNotifier {
  final _repository = LoginRepository();
  bool _isLoading = false;
  bool _isSuccess = false;
  String _errorMessage = '';
  String _username = '';
  String _password = '';

  bool get isLoading => _isLoading;
  bool get isSuccess => _isSuccess;
  String get errorMessage => _errorMessage;

  void onUsernameChanged(String value) {
    _username = value;
  }

  void onPasswordChanged(String value) {
    _password = value;
  }

  Future<void> login() async {
    _isLoading = true;
    notifyListeners();
    try {
      final model = LoginModel(
        username: _username,
        password: _password,
      );
      final response = await _repository.login(model);
      if (response.isSuccess) {
        _isSuccess = true;
        _isLoading = false;
        notifyListeners();
      } else {
        _errorMessage = 'El usuario o la contraseña son incorrectos';
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = 'Hubo un error al iniciar sesión';
      _isLoading = false;
      notifyListeners();
    }
  }
}
