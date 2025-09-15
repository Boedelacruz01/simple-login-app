import 'package:flutter/foundation.dart';
import '../models/user_model.dart';

class LoginViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  User? _user;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  User? get user => _user;

  Future<void> login(String username, String password) async {
    _setLoading(true);
    _clearError();

    try {
      await Future.delayed(const Duration(seconds: 2));

      if (username.toLowerCase() == 'admin' && password == '123456') {
        _user = User(id: 1, username: username, email: '$username@example.com');
      } else if (username.toLowerCase() == 'user' && password == 'password') {
        _user = User(id: 2, username: username, email: '$username@example.com');
      } else {
        throw Exception('Invalid username or password');
      }
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _user = null;
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void logout() {
    _user = null;
    _errorMessage = null;
    notifyListeners();
  }
}
