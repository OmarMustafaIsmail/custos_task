// providers/auth_provider.dart
import 'package:custos_task/modules/auth/models/user_model.dart';
import 'package:custos_task/modules/auth/service/auth_service.dart';
import 'package:custos_task/utils/network/local/secure_storage.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  final SecureStorageService _secureStorage = SecureStorageService();
  final AuthService _authService = AuthService();
  bool _isAuthenticated = false;
  String _userToken = '';
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool get isAuthenticated => _isAuthenticated;

  Future<void> login(String email, String password) async {
    debugPrint(_userToken);
    debugPrint(isAuthenticated.toString());
    _setLoading(true);

    final result = await _authService.login(email, password);

    if (result.containsKey('user-token')) {
      _userToken = result['user-token'];
      _isAuthenticated = true;
      UserModel user;
      user = UserModel.fromJson(result);
      debugPrint(user.toString());
      await _secureStorage.saveUserToken(_userToken);
      _setLoading(false);
      notifyListeners();
    } else {
      debugPrint(result.toString());
      // Handle login error
    }
  }

  Future<void> register(String email, String password) async {
    _setLoading(true);
    final result = await _authService.register(email, password);
    if (result.containsKey('success')) {
      // Handle successful registration, maybe log in the user
      _setLoading(false);
    } else {
      debugPrint(result.toString());
      // Handle registration error
    }
  }

  Future<void> logout() async {
    _userToken = '';
    _isAuthenticated = false;
    await _secureStorage.deleteUserToken();
    notifyListeners();
  }

  static bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(p);

    return regExp.hasMatch(em);
  }
}
