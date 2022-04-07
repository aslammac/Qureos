import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum AuthMode { Signup, Login, ForgotPassword }

class AuthProvider extends ChangeNotifier {
  AuthMode _mode = AuthMode.Login;
  String _userName = "";
  String get userName => _userName;
  AuthMode get mode => _mode;
  bool _isAuth = false;
  bool get isAuth => _isAuth;
  set isAuth(bool value) {
    _isAuth = value;
    notifyListeners();
  }

  void changeMode(AuthMode mode) {
    _mode = mode;
    notifyListeners();
  }
}
