import 'package:custos_task/modules/auth/models/user_model.dart';
import 'package:custos_task/modules/auth/service/auth_service.dart';
import 'package:custos_task/shared/custom_snakbar.dart';
import 'package:custos_task/utils/network/local/secure_storage.dart';
import 'package:custos_task/utils/palette.dart';
import 'package:custos_task/utils/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class AuthProvider with ChangeNotifier {
  final SecureStorageService _secureStorage = SecureStorageService();
  final AuthService _authService = AuthService();
  bool _isAuthenticated = false;
  String _userToken = '';
  bool _isLoadingLogin = false;
  bool _isLoadingRegister = false;

  bool get isLoadingLogin => _isLoadingLogin;
  bool get isLoadingRegister => _isLoadingRegister;


  init()async{
    debugPrint("started init");
   final token = await _secureStorage.getUserToken();
   debugPrint(token.toString());
   if(token !=null){
     router.go('/layout');
     _isAuthenticated = true;
     _userToken = token;
     notifyListeners();
     return;
   }
   router.go('/');
  }
  void _setLoading(bool value,{bool login = true}) {
    if(login) {
      _isLoadingLogin = value;
    }else{
      _isLoadingRegister = value;
    }
    notifyListeners();
  }

  bool get isAuthenticated => _isAuthenticated;

  Future<void> login(String email, String password,
      {required BuildContext context}) async {
    debugPrint(_userToken);
    debugPrint(isAuthenticated.toString());
    _setLoading(true);
    final result = await _authService.login(email, password);
    if (result.containsKey('user-token')) {
      _userToken = result['user-token'];
      _isAuthenticated = true;
      UserModel user = UserModel.fromJson(result);
      await _secureStorage.saveUserToken(_userToken);
      await _secureStorage.saveUser(user);
      var userAfter = await _secureStorage.getUser();
      debugPrint(userAfter.toString());
      _setLoading(false);

      notifyListeners();
    } else {
      // Handle login error
      debugPrint("error is ${result['message'].toString()}");
      _setLoading(false);
      if (context.mounted) {
        showFloatingSnackBar(
          context,
          result['message'],
          Palette.kDangerRedColor,
          textColor: Palette.kOffWhiteColor,
        );
      }
      notifyListeners();
    }
  }

  Future<void> register(String email, String password,{required BuildContext context}) async {
    _setLoading(true,login: false);
    final result = await _authService.register(email, password);
    if (result.containsKey('created')) {
      // Handle successful registration,
      if(context.mounted) {
        await login(email, password, context: context);
      }
      _setLoading(false,login: false);
    } else {
      // Handle registration error
      debugPrint("error is ${result['message'].toString()}");
      _setLoading(false,login: false);
      if (context.mounted) {
        showFloatingSnackBar(
            context, result['message'], Palette.kDangerRedColor,textColor:Palette.kOffWhiteColor);
      }
    }
  }

  Future<void> logout() async {
    _userToken = '';
    _isAuthenticated = false;
    await _authService.logout();
    await _secureStorage.deleteUserToken();
    await _secureStorage.deleteUser();
    notifyListeners();
  }

  static bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(p);

    return regExp.hasMatch(em);
  }
}
