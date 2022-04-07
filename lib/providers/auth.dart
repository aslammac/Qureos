import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum AuthMode { Signup, Login, ForgotPassword }

class AuthProvider extends ChangeNotifier {
  final List<Map<String, String>> _authData = <Map<String, String>>[
    {
      "name": "Aslam",
      "email": "aslammac7@gmail.com",
      "password": "1234",
    }
  ];
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

  Future<void> signin(String email, String password) async {
    print(_authData);
    var elem;
    for (elem in _authData) {
      if (elem["email"] == email && elem["password"] == password) {
        _userName = elem["email"];
        _isAuth = true;
        notifyListeners();
        print("success");

        return;
      }
    }
  }

  Future<bool> signup(Map<String, String> form) async {
    _authData.add({
      "name": form["name"] ?? "",
      "email": form["email"] ?? "",
      "password": form["password"] ?? "",
    });
    notifyListeners();
    return true;
  }
}
